<view-payment-monitor>
  <div class="riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{window.languages.ViewPaymentMonitorTitle}</p>
      <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
           class="back-button" role="button" aria-label="{window.languages.Back}"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="payment-monitor-container">

      <div class="payment-monitor-about-container page-title-shadow">
        <p class="payment-monitor-about-text">
          {window.languages.ViewPaymentMonitorAbout}
        </p>
      </div>

      <div class="payment-monitor-cost-container">
        <p class="payment-monitor-cost-text">
          {window.languages.ViewPaymentMonitorCostFirstPart + monitoring_amount +
          window.languages.ViewPaymentMonitorCostSecondPart}
        </p>
        <p class="payment-monitor-cost-offer"
           ontouchend="openPublicOffer(&quot;{monitorOffer}&quot;)">
          {window.languages.ViewPaymentMonitorOffer}
        </p>
      </div>

      <div class="payment-monitor-cards-container">
        <div class="payment-monitor-card" each="{i in accounts}"
             id="{i.card_id}" if="{i.access == 2}">
          <div class="payment-monitor-card-logo-container"
               style="background-image: url({i.image_url})"></div>
          <div class="payment-monitor-card-info-container">
            <p class="payment-monitor-card-info-text-one">{i.description}</p>
            <p class="payment-monitor-card-info-text-three">{i.accno}</p>
          </div>
          <div class="payment-monitor-card-checkbox">
            <input type="checkbox"
                   id="{i.id}"
                   checked="{i.monitoring_token}"
                   onclick="cardCheck(this)"/>
            <label for="{i.id}"></label>
          </div>
          <div class="title-bottom-border">
          </div>
        </div>
      </div>

    </div>
  </div>
  <script>

    var scope = this;
    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;
    var timeOutTimer = 0;
    var counter = 0;
    var pageToReturnIfError = 'view-main-page';
    scope.stepAmount = 0;

    window.saveHistory('view-payment-monitor', opts);

    scope.accounts = localStorage.getItem('click_client_accountInfo') ? JSON.parse(localStorage.getItem('click_client_accountInfo')) : [];
    scope.monitoring_amount = window.amountTransform(
      JSON.parse(localStorage.getItem("click_client_loginInfo")).monitoring_amount);
    if (localStorage.getItem("click_client_agreement")) {
      scope.monitorOffer = 'empty_link';
    } else {
      scope.monitorOffer = '';
    }

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();
      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)';
      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
      }
    };

    openPublicOffer = function (LinkToPublicOffer) {
      console.log("Link to Offer", LinkToPublicOffer);
      window.open(LinkToPublicOffer, '_system', 'location=no');
    };

    findAccount = function (id) {
      result = -1;
      for (var i in scope.accounts) {
        if (scope.accounts[i].id == id) {
          result = scope.accounts[i].id;
          return result;
        }
      }
      return result;
    };

    findAccountToken = function (id) {
      result = '';
      for (var i in scope.accounts) {
        if (scope.accounts[i].id == id) {
          result = scope.accounts[i].monitoring_token;
          return result;
        }
      }
      return result;
    };

    cardCheck = function (checkBox) {
      if (checkBox.checked ) {
        console.log(findAccount(checkBox.id))
        if (findAccount(checkBox.id) == "6870308") {
          turnOnMonitoring(checkBox.id, checkBox);
        }
      } else {
        if (findAccount(checkBox.id) == "6870308") {
          turnOffMonitoring(checkBox.id, checkBox, findAccountToken(checkBox.id));
        }
      }
    };

    turnOnMonitoring = function (id, checkBox) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');

      initResultComponent();
      console.log('calling monitoring.on');
      window.api.call({
        method: 'monitoring.on',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          acc_id: id,
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0) {
            console.log('monitoring.on', result);
            if (result[0][0].check_id === 0) {
              console.log('Clearing timer onSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              updateResultComponent(true, scope.stepAmount, null, 'success', result[0][0].error_note);
            }
            if (result[0][0].check_id > 0) {
              setTimeout(function () {
                checkMonitoringStatus(result[0][0].check_id);
              }, 2000);
            }
          } else {
            if (result[0][0].error < 0) {
              console.log('Clearing timer onUnSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[0][0].error_note);
              checkBox.checked = false;
            }
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, scope.stepAmount, null, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'monitoring.on',
            });
            window.api.forceClose();
            updateResultComponent(true, scope.stepAmount, null, 'waiting', window.languages.WaitingTimeExpiredText);
          }, 30000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });
    };

    turnOffMonitoring = function (id, checkBox, token) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');

      initResultComponent();
      window.api.call({
        method: 'monitoring.off',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          acc_id: id,
          token: token,
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0) {
            console.log('monitoring.on', result);
            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, scope.stepAmount, null, 'success', result[0][0].error_note);
          } else {
            if (result[0][0].error < 0) {
              console.log('Clearing timer onUnSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[0][0].error_note);
              checkBox.checked = true;
            }
          }
          window.api.spinnerOn = false;
        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, scope.stepAmount, null, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'monitoring.on',
            });
            window.api.forceClose();
            updateResultComponent(true, scope.stepAmount, null, 'waiting', window.languages.WaitingTimeExpiredText);
          }, 30000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });
    };

    checkMonitoringStatus = function (check_id) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      window.api.call({
        method: 'monitoring.on.check',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          check_id: check_id
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error === 0) {
            console.log('received_token', result[0][0].token);
            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, scope.stepAmount, null, 'success', window.languages.ComponentSuccessMessage);
          } else {
            if (result[0][0].error < 0) {
              console.log('Clearing timer onUnSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              updateResultComponent(true, scope.stepAmount, null, 'unsuccess', result[0][0].error);
            }
            if (result[0][0].error === 1) {
              counter++;

              if (counter < 5) {
                setTimeout(function () {
                  checkMonitoringStatus(check_id);
                }, 2000);
              } else {
                console.log('Clearing timer onSuccess', timeOutTimer);
                window.clearTimeout(timeOutTimer);
                updateResultComponent(true, scope.stepAmount, null, 'waiting', window.languages.ComponentInProcessingPartOne);
              }
            }
          }
          window.api.spinnerOn = false;
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, scope.stepAmount, null, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      }, 30000);
    };

    // Functions for result component
    {
      updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {
        scope.stepAmount = stepAmount;
        scope.viewPage = viewPage;
        scope.resultText = text;

        if (showResult) {
          window.common.alert.updateView("componentResultId", {
            parent: scope,
            resulttext: scope.resultText,
            viewpage: scope.viewPage,
            step_amount: scope.stepAmount
          });
        } else {
          window.common.alert.hide("componentResultId");
        }
        updateIcon(status, null, null, text, stepAmount, scope.viewPage);
      };

      closeResultComponent = function () {
        window.common.alert.hide("componentResultId");
        scope.update();
      };

      initResultComponent = function () {
        window.common.alert.updateView("componentResultId", {
          parent: scope
        });
        scope.update();
      };
    }

  </script>


</view-payment-monitor>
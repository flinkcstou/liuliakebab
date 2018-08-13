<view-info class="view-info riot-tags-main-container">
  <div class="view-info-title-container">
    <div id="backButtonId" role="button" aria-label="{window.languages.Back}" class="view-info-back-button"
         ontouchstart="onTouchStartBack()"
         ontouchend="onTouchEndBack()">
    </div>
    <div class="border-bottom">
    </div>
  </div>

  <div class="view-info-body-container" id="lastOperationsContainerId" onscroll="lastOperationsContainerScroll()">
    <div class="view-info-head-info-container" style="height: {130 * heightK}px">
      <div class="centering-background-image view-info-left-item"
           style="background-image: url(resources/icons/ViewInfo/mybalance.png);background-size: 50%;">
      </div>

      <div class="info-center-container">
        <div class="horizontal-centering">
          <p class="title-text text-margin">
            {window.languages.ViewInfoBalanceTitle}
          </p>

          <div if="{!modeOfApp.offlineMode}" id="fullCardBalanceContainer" style="overflow: auto;">
            <canvas id="fullScaleCanvas" style="display: none;">
            </canvas>
            <canvas id="fractionalScaleCanvas" style="display: none;">
            </canvas>
            <canvas id="currencyScaleCanvas" style="display: none;">
            </canvas>
            <div class="view-info-card-balance-scale-container" id="fullCardBalanceScaleContainer">
              <p class="view-info-card-balance-sum">
                {(fullBalanceCopy !== null) ? (fullBalanceCopy) : (error_message)}
                <span class="view-info-card-balance-sum-fractional">
                  {(fractionalPart) ? (fractionalPart) : ''}
                </span>

                <span if="{!modeOfApp.offlineMode && fullBalanceCopy !== null}" class="view-info-card-currency">
                  {window.languages.ViewReportServiceCommissionCurrency}
                </span>
              </p>
            </div>
          </div>
          <a if="{modeOfApp.offlineMode}" class="offline-card-balance"
             ontouchstart="offlineBalanceInfoTrue()">Получить баланс</a>
        </div>
      </div>
      <div id="reloadBalanceButtonId" role="button" class="centering-background-image view-info-right-item"
           ontouchstart="reloadBalanceTouchStart()" ontouchend="reloadBalanceTouchEnd()"
           aria-label="Обновить баланс"
           style="background-image: url(resources/icons/ViewInfo/reload.png); background-size:70%;transition: 0.5s; height: 65%;">
      </div>
      <div class="border-bottom">
      </div>
    </div>

    <div id="reportButtonId" role="button" class="view-info-head-info-container" ontouchend="goToReportsTouchEnd()"
         ontouchstart="goToReportsTouchStart()" aria-label="{window.languages.ViewInfoReportsTitle}"
         style="height: {92 * heightK}px">
      <div class="centering-background-image view-info-left-item"
           style="background-image: url(resources/icons/ViewInfo/myreports.png);background-size: 60%;">
      </div>

      <div class="info-center-container">
        <p class="horizontal-centering title-text text-margin" style="font-size:{30*widthK}px">
          {window.languages.ViewInfoReportsTitle}
        </p>
      </div>
      <div class="centering-background-image view-info-right-item"
           style="background-image: url(resources/icons/ViewInfo/open.png); background-size: 20%;"></div>
      <div class="border-bottom">
      </div>
    </div>

    <div class="view-info-operations-title">
      <p class="horizontal-centering title-text text-margin" style="position: relative;margin-left: 5%;">
        {window.languages.ViewInfoLastOperations}
      </p>
    </div>

    <div>
      <div class="info-container" each="{i in lastOperationContainer}" id="{i.payment_id}"
           ontouchstart="onTouchStartOfOperation(this.id)" role="button" aria-label="{i.service_name}"
           onclick="onTouchEndOfOperation(this.id)">
        <div class="centering-background-image view-info-left-item"
             style="background-image: url({i.image}); background-size: 80%;">
        </div>

        <div class="info-center-container">
          <div class="horizontal-centering">
            <p class="title-text text-margin">
              {i.service_name}
            </p>
            <p class="main-text text-margin">
              - {i.amount} {window.languages.Currency}
            </p>
            <p if="{i.comission_amount > 0 && (i.nds == null || i.nds === 0)}"
               class="text-margin title-text">
              {window.languages.Commission}{i.comission_amount}
              {window.languages.Currency}
            </p>
            <p if="{(i.comission_amount == 0 || i.comission_amount == null) && i.nds > 0}"
               class="text-margin title-text">
              {window.languages.Nds}
              {window.calculateNds(window.toInt(i.amount), i.nds)}
              {window.languages.Currency}
            </p>
            <p if="{i.comission_amount > 0 && i.nds > 0}"
               class="text-margin title-text">
              {window.languages.CommissionAndNds}
              {i.comission_amount}
              {window.languages.Currency}
            </p>

            <p class="title-text text-margin">
              {i.cntrg_info_param2}
            </p>
            <p class="title-text text-margin">
              {i.created}
            </p>
          </div>
        </div>

        <div class="centering-background-image view-info-right-item state-image-container"
             style="background-image: url({i.state_image});">
        </div>

        <div class="border-bottom">
        </div>
      </div>
    </div>
  </div>

  <script>

    var scope = this;
    var defaultAccount;
    var goBackTouchStartX, goBackTouchStartY, goBackTouchEndX, goBackTouchEndY;
    var balanceTouchStartX, balanceTouchStartY, balanceTouchEndX, balanceTouchEndY;
    var operationInfoTouchStartY, operationInfoTouchEndY;
    var goToReportsTouchStartX, goToReportsTouchStartY, goToReportsTouchEndX, goToReportsTouchEndY;

    scope.attention = false;
    scope.fullBalance = 0;
    scope.fullBalanceCopy = null;
    scope.fractionalPart = null;
    scope.error_message = null;

    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));
    var objectAccount = {};
    var accountsForBalance = [];
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    if (JSON.parse(localStorage.getItem('click_client_loginInfo'))) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    }
    scope.leftOfOperations = 200 * widthK;
    scope.lastOperationContainer = [];
    scope.pageNumberOptional = 1;
    var canvasFull;
    var contextFull;
    var canvasFractional;
    var contextFractional;
    var canvasCurrency;
    var contextCurrency;
    var timeOutTimerPayment = 0;

    window.saveHistory('view-info', opts);

    for (var j in getAccountsCards) {
      objectAccount.account_id = getAccountsCards[j].id;
      objectAccount.card_num_hash = getAccountsCards[j].card_num_hash;
      objectAccount.card_num_crypted = getAccountsCards[j].card_num_crypted;
      accountsForBalance.push(objectAccount);
      objectAccount = {};
    }


    console.log("GETACCOUNTS", accountsForBalance);

    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }

    scope.on('mount', function () {
      canvasFull = document.getElementById('fullScaleCanvas');
      contextFull = canvasFull.getContext('2d');
      canvasFractional = document.getElementById('fractionalScaleCanvas');
      contextFractional = canvasFractional.getContext('2d');
      canvasCurrency = document.getElementById('currencyScaleCanvas');
      contextCurrency = canvasCurrency.getContext('2d');
      contextFull.font = 67 * widthK + "px SFUIDisplay-Light";
      contextFractional.font = 51 * widthK + "px SFUIDisplay-Light";
      contextCurrency.font = 26 * widthK + "px SFUIDisplay-Light";
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#ffffff");
      var accountsForBalance = [];
      var objectAccount = {};
      if (!modeOfApp.offlineMode) {
        writeBalanceInfo(accountsForBalance);
      }

      if (viewPay.lastOperations) {
        scope.lastOperationContainer = viewPay.lastOperations;
        scope.update();
        console.log("viewPay.lastOperationsContainerId=", viewPay.lastOperationsContainerScrollTop);
        if (viewPay.lastOperationsContainerScrollTop) {

          lastOperationsContainerId.scrollTop = viewPay.lastOperationsContainerScrollTop;
          viewPay = {};
        }
      }
      else
        scope.lastOperationsUpdate();

    });

    reloadBalanceTouchStart = function () {

      reloadBalanceButtonId.style.webkitTransform = 'rotate(90deg)';

      balanceTouchStartX = event.changedTouches[0].pageX;
      balanceTouchStartY = event.changedTouches[0].pageY;
    };

    reloadBalanceTouchEnd = function () {

      setTimeout(function () {
        reloadBalanceButtonId.style.webkitTransform = 'rotate(0deg)'
      }, 500);

      balanceTouchEndX = event.changedTouches[0].pageX;
      balanceTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(balanceTouchStartX - balanceTouchEndX) <= 20 && Math.abs(balanceTouchStartY - balanceTouchEndY) <= 20) {
        writeBalanceInfo(accountsForBalance);
      }
    };

    writeBalanceInfo = function () {
      var j = 0;
      scope.fullBalance = 0;
      scope.fullBalanceCopy = 0;
      scope.fractionalPart = 0;
      window.api.call({
        method: 'get.balance.multiple',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          accounts: accountsForBalance
        },
        //TODO: DO CARDS
        scope: this,
        onSuccess: function (result) {
          scope.fullBalanceCopy = null;
          scope.fullBalance = null;
          if (result[0][0].error == 0) {
            if (result[1]) {

              try {
                for (var i in result[1]) {
                  scope.fullBalance += result[1][i].balance;
                }
                scope.fullBalanceCopy = Math.floor(scope.fullBalance);
                scope.fractionalPart = window.getFractionalPart(scope.fullBalance.toString());

                scope.fullBalanceCopy = scope.fullBalanceCopy.toFixed(0).toString();
                scope.fullBalanceCopy = window.amountTransform(scope.fullBalanceCopy);
                scope.update();
                textWidthFull = contextFull.measureText(scope.fullBalanceCopy + ' ').width;
                textWidthFractional = contextFractional.measureText(scope.fractionalPart).width;
                textWidthCurrency = contextCurrency.measureText(window.languages.ViewReportServiceCommissionCurrency).width;
                totalTextWidth = textWidthFull + textWidthFractional + textWidthCurrency;

                console.log("full card balance container", fullCardBalanceContainer.offsetWidth);
                console.log("full card balance", fullCardBalanceScaleContainer.offsetWidth);

                if (totalTextWidth > fullCardBalanceContainer.offsetWidth) {
                  scaleK = fullCardBalanceContainer.offsetWidth / totalTextWidth;
                  left_d = (scaleK - 1) * totalTextWidth / 2;
                  fullCardBalanceScaleContainer.style.webkitTransform = 'scale(' + scaleK + ')';
                  fullCardBalanceScaleContainer.style.left = left_d + 'px';
                }
              } catch (Error) {

                console.log("VIEW INFO WRITE BALANCE", Error);
              }

              j++;

            }
          }
          else {
            scope.error_message = 'Ошибка';
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      scope.update();
    };

    offlineBalanceInfoTrue = function () {
      event.preventDefault();
      event.stopPropagation();
      modeOfApp.offlineMode.balance = true;

      if (device.platform == "Android") {
        phonedialer.dial(
          "*880*2%23",
          function (err) {
            if (err == "empty") {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: "Unknown phone number"
              });
              scope.update();
            }
            else {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: "Dialer Error:" + err
              });
              scope.update();
            }
          },
          function (success) {
          }
        );
      }
    };

    onTouchStartBack = function () {
      event.preventDefault();
      event.stopPropagation();

      backButtonId.style.webkitTransform = 'scale(0.8)';

      goBackTouchStartX = event.changedTouches[0].pageX;
      goBackTouchStartY = event.changedTouches[0].pageY;

    };

    onTouchEndBack = function () {
      event.preventDefault();
      event.stopPropagation();

      backButtonId.style.webkitTransform = 'scale(1)';

      goBackTouchEndX = event.changedTouches[0].pageX;
      goBackTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackTouchStartX - goBackTouchEndX) <= 20 && Math.abs(goBackTouchStartY - goBackTouchEndY) <= 20) {

        onBackKeyDown();
//        scope.unmount()
      }
    };

    lastOperationsContainerScroll = function () {

      if ((lastOperationsContainerId.scrollHeight - lastOperationsContainerId.scrollTop) <= lastOperationsContainerId.offsetHeight && lastOperationsContainerId.scrollTop != 0) {

        if (scope.lastOperationContainer.length % 15 == 0) {
          scope.pageNumberOptional++;
          lastOperationsUpdate();
        }

      }
    };

    scope.lastOperationsUpdate = lastOperationsUpdate = function () {

      if (!modeOfApp.offlineMode) {
        window.startSpinner();
        window.clearTimeout(timeOutTimerPayment);
        window.api.call({
          method: 'get.payment.list',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            page_number: parseInt(scope.pageNumberOptional)
          },

          scope: this,

          onSuccess: function (result) {

            window.clearTimeout(timeOutTimerPayment);

            if (result[0][0].error == 0) {
              var j = 0;

              for (var i in result[1]) {

                result[1][i].count = j;

                result[1][i].amount = result[1][i].amount.toString();
                result[1][i].amount = window.amountTransform(result[1][i].amount);

                console.log("STATE ", result[1][i].state);

                if (result[1][i].state == -1) {
                  result[1][i].state_image = "resources/icons/ViewReport/report_status_error.png"
                }

                if (result[1][i].state == 1) {
                  result[1][i].state_image = "resources/icons/ViewReport/report_status_processing.png"
                }

                if (result[1][i].state == 2) {
                  result[1][i].state_image = "resources/icons/ViewReport/report_status_ok.png"
                }

                scope.lastOperationContainer.push(result[1][i]);
                console.log('scope.lastOperationContainer', scope.lastOperationContainer);

                j++;
              }

              scope.update()
            }
            else {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: result[0][0].error_note
              });
              scope.update();
            }

          },

          onFail: function (api_status, api_status_message, data) {
            window.clearTimeout(timeOutTimerPayment);
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          },
          onTimeOut: function () {
            timeOutTimerPayment = setTimeout(function () {
              window.writeLog({
                reason: 'Timeout',
                method: 'get.payment.list',
              });
              scope.errorNote = "Сервис временно недоступен";
              scope.stepAmount = 0;
              scope.update();
              window.common.alert.show("componentAlertId", {
                parent: scope,
                errornote: scope.errorNote,
                step_amount: scope.stepAmount
              });
              window.stopSpinner();
            }, 30000);
          },
          onEmergencyStop: function () {
            console.log('Clearing timer emergencyStop', timeOutTimerPayment);
            window.clearTimeout(timeOutTimerPayment);
          }
        }, 30000);
      }

    };

    goToReportsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      reportButtonId.style.backgroundColor = 'rgba(231,231,231,0.8)';

      goToReportsTouchStartX = event.changedTouches[0].pageX;
      goToReportsTouchStartY = event.changedTouches[0].pageY;
    };

    goToReportsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      reportButtonId.style.backgroundColor = 'transparent';

      goToReportsTouchEndX = event.changedTouches[0].pageX;
      goToReportsTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToReportsTouchStartX - goToReportsTouchEndX) <= 20 && Math.abs(goToReportsTouchStartY - goToReportsTouchEndY) <= 20) {

        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*00*3" + "%23",
            function (err) {
              if (err == "empty") {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: "Unknown phone number"
                });
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }

        riotTags.innerHTML = "<view-report>";
        riot.mount('view-report');

        scope.unmount()
      }

    };

    scope.onTouchStartOfOperation = onTouchStartOfOperation = function (paymentId) {
      operationInfoTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfOperation = onTouchEndOfOperation = function (paymentId) {

      document.getElementById(paymentId).style.backgroundColor = 'rgba(231,231,231,0.8)';

      setTimeout(function () {
        document.getElementById(paymentId).style.backgroundColor = 'transparent'
      }, 50);

      operationInfoTouchEndY = event.pageY;

      setTimeout(function () {

        if (Math.abs(operationInfoTouchStartY - operationInfoTouchEndY) < 20) {

          if (modeOfApp.demoVersion) {
            var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';

            window.common.alert.show("componentConfirmId", {
              parent: scope,
              "confirmnote": question,
              "confirmtype": 'local'
            });
            scope.result = function (bool) {
              if (bool) {
                localStorage.clear();
                window.location = 'index.html';
                scope.unmount();
                return
              }
              else {
                window.common.alert.hide("componentConfirmId");
                return
              }
            };
            scope.update();

            return
          }

          for (var i = 0; i < scope.lastOperationContainer.length; i++) {
            if (scope.lastOperationContainer[i].payment_id == paymentId) {
              var servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
              var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));

              if (favoritePaymentsList) {
                for (var j in favoritePaymentsList) {

                  if (favoritePaymentsList[j].params.paymentId && favoritePaymentsList[j].params.paymentId == paymentId) {

                    scope.lastOperationContainer[i].isInFavorites = true;
                    scope.favoriteId = favoritePaymentsList[j].id;
                    break;
                  }
                  scope.lastOperationContainer[i].isInFavorites = false;
                }

              } else {
                scope.lastOperationContainer[i].isInFavorites = false;
              }

              if (servicesMap[scope.lastOperationContainer[i].service_id])
                scope.lastOperationContainer[i].canAddToFavorite = true;
              else
                scope.lastOperationContainer[i].canAddToFavorite = false;

              scope.lastOperationContainer[i].favoriteId = scope.favoriteId;

              viewPay.lastOperationsContainerScrollTop = lastOperationsContainerId.scrollTop;

              viewPay.lastOperations = scope.lastOperationContainer;

              riotTags.innerHTML = "<view-report-service-new>";
              riot.mount("view-report-service-new", scope.lastOperationContainer[i]);

              scope.unmount();
              break;
            }
          }
        }
      }, 100)

    }


  </script>
</view-info>
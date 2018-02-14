<view-info class="view-info riot-tags-main-container">
  <div class="view-info-title-container">
    <div id="backButtonId" role="button" aria-label="{window.languages.Back}" class="view-info-back-button"
         ontouchstart="onTouchStartBack()"
         ontouchend="onTouchEndBack()"></div>
  </div>

  <div class="view-info-balance-container">
    <p class="view-info-balance-label">{window.languages.ViewInfoBalanceTitle}</p>
    <div class="view-info-card-balance-currency-container">
      <div if="{!modeOfApp.offlineMode}" class="view-info-card-balance" id="fullCardBalanceContainer">
        <canvas id="fullScaleCanvas" style="display: none;"></canvas>
        <canvas id="fractionalScaleCanvas" style="display: none;"></canvas>
        <canvas id="currencyScaleCanvas" style="display: none;"></canvas>
        <div class="view-info-card-balance-scale-container" id="fullCardBalanceScaleContainer">
          <p class="view-info-card-balance-sum">{(fullBalanceCopy) ? (fullBalanceCopy) : (error_message)}<span
            class="view-info-card-balance-sum-fractional">{(fractionalPart) ? (fractionalPart) : ''}</span> <span
            if="{!modeOfApp.offlineMode && fullBalanceCopy}" class="view-info-card-currency">{window.languages.ViewReportServiceCommissionCurrency}</span></p>
        </div>
      </div>

      <a if="{modeOfApp.offlineMode}" class="offline-card-balance"
         ontouchstart="offlineBalanceInfoTrue()">Получить баланс</a>
    </div>
    <div class="view-info-bag-icon"></div>
    <div if="{attention && !modeOfflineMode.check}" class="view-info-attention-icon"></div>
    <div id="reloadBalanceButtonId" role="button" aria-label="{window.languages.ViewInfoAriaLabelReloadAmount}"
         if="{!modeOfflineMode.check}" class="view-info-reload-icon"
         ontouchstart="reloadBalanceTouchStart()" ontouchend="reloadBalanceTouchEnd()"></div>
  </div>

  <div class="view-info-my-finance-container" style="display: none">
    <div class="view-info-my-finance-icon"></div>
    <div class="view-info-open-icon"></div>
    <p class="view-info-my-finance-title">{window.languages.ViewInfoMyFinanceTitle}</p>
  </div>

  <div id="reportButtonId" role="button" aria-label="{window.languages.ViewInfoReportsTitle}"
       class="view-info-reports-container" ontouchend="goToReportsTouchEnd()"
       ontouchstart="goToReportsTouchStart()">
    <div class="view-info-reports-icon"></div>
    <div class="view-info-open-icon"></div>
    <p class="view-info-reports-title">{window.languages.ViewInfoReportsTitle}</p>
  </div>

  <div class="view-info-operations-title">
    <p class="view-info-operations-label">{window.languages.ViewInfoLastOperations}</p>
  </div>

  <div class="view-info-operations-container">
    <div class="view-info-operation-container" each="{i in lastOperationContainer}" id="{i.payment_id}"
         ontouchstart="onTouchStartOfOperation(this.id)" role="button" aria-label="{i.service_name}"
         onclick="onTouchEndOfOperation(this.id)"
         style="top:{leftOfOperations*i.count + 50 * widthK}px;">

      <div class="view-info-operations-icon" style="background-image: url({i.image})">

        <div class="view-info-operation-info-container">
          <p class="view-info-operation-info-name">{i.service_name}</p>
          <p class="view-info-operation-info-balance"> - {i.amount}</p>
          <p class="view-info-operation-info-balance">{}</p>
          <p class="view-info-operation-info-number">{i.cntrg_info_param2}</p>
          <p class="view-info-operation-info-date">{i.created}</p>

          <div class="view-info-state-image" style="background-image: url({i.state_image})"></div>
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
    var canvasFull;
    var contextFull;
    var canvasFractional;
    var contextFractional;
    var canvasCurrency;
    var contextCurrency;


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
        StatusBar.backgroundColorByHexString("#e5e5e5");
      var accountsForBalance = [];
      var objectAccount = {};
      if (!modeOfApp.offlineMode) {
        writeBalanceInfo(accountsForBalance);
      }

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
        return
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

    if (!modeOfApp.offlineMode)
      window.api.call({
        method: 'get.payment.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            var j = 0;
//          if (device.platform != 'BrowserStand') {
//            window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
//
//              for (var i in result[1]) {
//
//
//                if (result[1][i].state == 0) {
//                  result[1][i].count = j;
//
//                  result[1][i].amount = result[1][i].amount.toString();
//
//                  if (result[1][i].amount.length == 7) {
//                    result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
//                      result[1][i].amount.substring(1, 4) + ' ' + result[1][i].amount.substring(4, result[1][i].amount.length)
//
//                  }
//
//                  if (result[1][i].amount.length == 6) {
//                    result[1][i].amount = result[1][i].amount.substring(0, 3) + ' ' +
//                      result[1][i].amount.substring(3, result[1][i].amount.length)
//
//                  }
//
//                  if (result[1][i].amount.length == 5) {
//                    result[1][i].amount = result[1][i].amount.substring(0, 2) + ' ' +
//                      result[1][i].amount.substring(2, result[1][i].amount.length)
//
//                  }
//
//                  if (result[1][i].amount.length == 4) {
//                    result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
//                      result[1][i].amount.substring(1, result[1][i].amount.length)
//
//                  }
//
//                  var icon = result[1][i].image;
//                  var filename = icon.substr(icon.lastIndexOf('/') + 1);
//
//                  var newIcon = checkImageURL;
//                  newIcon('www/resources/icons/ViewPay/service/', filename, 'image', icon, result[1][i], function (object) {
//                    scope.lastOperationContainer.push(object);
////                    if (result[1].length == scope.lastOperationContainer.length) {
////                      console.log("save into localstorage");
////                      localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
////                      localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
////                    }
//                  });
//
//                  j++;
//                }
//
//              }
//            }, onErrorLoadFs);
//          } else {
            for (var i in result[1]) {

              result[1][i].count = j;

              result[1][i].amount = result[1][i].amount.toString();
              result[1][i].amount = window.amountTransform(result[1][i].amount);

              console.log("STATE ", result[1][i].state)

              if (result[1][i].state == -1) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_error.png"
              }

              if (result[1][i].state == 1) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_processing.png"
              }

              if (result[1][i].state == 2) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_ok.png"
              }

              scope.lastOperationContainer.push(result[1][i])

              j++;

            }
//          }
            console.log('scope.lastOperationContainer', scope.lastOperationContainer)
            scope.update()
//            console.log('scope.lastOperationContainer', scope.lastOperationContainer);
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
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });


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
      }, 300);

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
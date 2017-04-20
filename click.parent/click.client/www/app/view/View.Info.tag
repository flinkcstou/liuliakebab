<view-info class="view-info">
  <div class="view-info-title-container">
    <div class="view-info-back-button" ontouchstart="onTouchEndBack()"></div>
  </div>

  <div class="view-info-balance-container">
    <p class="view-info-balance-label">{window.languages.ViewInfoBalanceTitle}</p>
    <div class="view-info-card-balance-currency-container">
      <div if="{!modeOfflineMode.check}" class="view-info-card-balance">
        <p class="view-info-card-balance-sum">{fullBalanceCopy}</p>
        <p if=" {!modeOfflineMode.check}" class="view-info-card-currency">сум</p>
      </div>

      <a if="{modeOfApp.offlineMode}" class="offline-card-balance"
         ontouchstart="offlineBalanceInfoTrue()">Получить баланс</a>
    </div>
    <div class="view-info-bag-icon"></div>
    <div if="{attention && !modeOfflineMode.check}" class="view-info-attention-icon"></div>
    <div if="{!modeOfflineMode.check}" class="view-info-reload-icon" ontouchend="reloadBalanceTouchEnd()"></div>
  </div>

  <div class="view-info-my-finance-container" style="display: none">
    <div class="view-info-my-finance-icon"></div>
    <div class="view-info-open-icon"></div>
    <p class="view-info-my-finance-title">{window.languages.ViewInfoMyFinanceTitle}</p>
  </div>

  <div class="view-info-reports-container" ontouchend="goToReports()">
    <div class="view-info-reports-icon"></div>
    <div class="view-info-open-icon"></div>
    <p class="view-info-reports-title">{window.languages.ViewInfoReportsTitle}</p>
  </div>

  <div class="view-info-operations-title">
    <p class="view-info-operations-label">{window.languages.ViewInfoLastOperations}</p>
  </div>

  <div class="view-info-operations-container">

    <div class="view-info-operations-icon" each="{i in lastOperationContainer}"
         style="left:{leftOfOperations*i.count + 50}px; background-image: url({i.image})">

      <div class="view-info-operation-info-container">
        <p class="view-info-operation-info-name">{i.service_name}</p>
        <p class="view-info-operation-info-balance">{i.amount}</p>
        <p class="view-info-operation-info-balance">{}</p>
        <p class="view-info-operation-info-number">{i.cntrg_info_param2}</p>
        <p class="view-info-operation-info-date">{i.created}</p>
      </div>

    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    var defaultAccount;
    scope.attention = false;
    scope.fullBalance = 0;
    scope.fullBalanceCopy = 0;

    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));

    if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    //    console.log('getAccountsCards', getAccountsCards)
    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#e5e5e5");

      if (!modeOfApp.offlineMode) {
        writeBalance();
      }
    })

    reloadBalanceTouchEnd = function () {
      writeBalance();
    }

    writeBalance = function () {
      var j = 0;
      scope.fullBalance = 0;
      scope.fullBalanceCopy = 0;
      for (var i = 0; i < getAccountsCards.length; i++) {
        window.api.call({
          method: 'get.balance',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: getAccountsCards[i].id,
            card_num_hash: getAccountsCards[i].card_num_hash,
            card_num_crypted: getAccountsCards[i].card_num_crypted
          },
          //TODO: DO CARDS
          scope: this,
          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              if (result[1][0]) {
//                console.log('getAccountsCards[j].currency_name', getAccountsCards[j].currency_name)
//                console.log('defaultAccount.currency', defaultAccount.currency)
                try {
                  if (getAccountsCards[j].currency_name.trim() == defaultAccount.currency.trim()) {
                    scope.fullBalance = parseInt(scope.fullBalance);
                    scope.fullBalance += result[1][0].balance;
                    scope.fullBalanceCopy = scope.fullBalance;

                    scope.fullBalanceCopy = scope.fullBalanceCopy.toFixed(0).toString();
                    scope.fullBalanceCopy = window.amountTransform(scope.fullBalanceCopy);

                    riot.update(scope.fullBalanceCopy);
                  }
                  else
                    scope.attention = true;
                } catch (Error) {

                  console.log("VIEW INFO WRITE BALANCE", Error);
                }

                j++;

              }
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;
              scope.showError = true;
              riot.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }

      riot.update(scope.fullBalanceCopy);
    }

    offlineBalanceInfoTrue = function () {
      event.preventDefault()
      event.stopPropagation();
      modeOfApp.offlineMode.balance = true;

      if (device.platform == "Android") {
        phonedialer.dial(
          "*880*3%23",
          function (err) {
            if (err == "empty") {
              scope.clickPinError = false;
              scope.errorNote = "Unknown phone number";
              scope.showError = true;
              riot.update();
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = "Dialer Error:" + err;
              scope.showError = true;
              riot.update();
            }
          },
          function (success) {
          }
        );
        return
      }
    }


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-info') {
      history.arrayOfHistory.push(
        {
          "view": 'view-info',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.leftOfOperations = 470 * widthK;
    scope.lastOperationContainer = [];

    onTouchEndBack = function () {
      event.preventDefault();
      event.stopPropagation();

      this.riotTags.innerHTML = '<view-main-page>';
      riot.mount('view-main-page');

    }

    if (!modeOfApp.offlineMode)
      window.api.call({
        method: 'get.payment.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
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
              if (result[1][i].state == 0) {
                result[1][i].count = j;

                result[1][i].amount = result[1][i].amount.toString();
                result[1][i].amount = window.amountTransform(result[1][i].amount);

                scope.lastOperationContainer.push(result[1][i])

                j++;
              }
            }
//          }
//                    console.log('scope.lastOperationContainer', scope.lastOperationContainer)
            riot.update(scope.lastOperationContainer)
//            console.log('scope.lastOperationContainer', scope.lastOperationContainer);
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            riot.update();
          }

        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    goToReports = function () {
      event.preventDefault();
      event.stopPropagation();

      if (modeOfApp.offlineMode) {
        phonedialer.dial(
          "*880*00*3" + "%23",
          function (err) {
            if (err == "empty") {
              scope.clickPinError = false;
              scope.errorNote = ("Unknown phone number");
              scope.showError = true;
              riot.update();
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

    }
  </script>
</view-info>
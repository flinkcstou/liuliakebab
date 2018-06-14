window.viewMainPage = {};
viewMainPage.myCards = false;
viewMainPage.addFirstCardBool = false;

window.onBackParams = {};
onBackParams.opts = null;

window.viewMyCards = {};
viewMyCards.check = false;
viewMyCards.chosenCardId = '';


window.viewAuthorization = {};
viewAuthorization.check = false;
viewAuthorization.fingerPrintErrorCount = 0;

window.isConnected = false;
window.numberOfAttemps = 0;
window.scannerCanBeAsked = true;

window.common = {};
window.common.alert = {
  ids: [
    "componentAlertId", //component-alert
    "componentConfirmId", //component-confirm
    "componentInProcessingId", //component-in-processing
    "componentResultId", //component-result
    "componentSuccessId", //component-success
    "componentUnsuccessId", //component-unsuccess
    "componentGeneratedQrId" //component-generated-qr
  ],
  priorities: {
    "componentAlertId": 4,
    "componentConfirmId": 6,
    "componentInProcessingId": 2,
    "componentResultId": 1,
    "componentSuccessId": 3,
    "componentUnsuccessId": 3,
    "componentGeneratedQrId": 3
  },
  tags: {
    "componentAlertId": "component-alert",
    "componentConfirmId": "component-confirm",
    "componentInProcessingId": "component-in-processing",
    "componentResultId": "component-result",
    "componentSuccessId": "component-success",
    "componentUnsuccessId": "component-unsuccess",
    "componentGeneratedQrId": "component-generated-qr"
  },
  scopes: {},
  hide: function (id) {

    console.log(id);

    try {

      if (!window.common.alert.scopes[id]) return;
      window.common.alert.scopes[id].unmount();
      delete window.common.alert.scopes[id];
    } catch (error) {

      console.error(error);
    }
  },
  updateView: function (id, params) {

    if (!window.common.alert.isShown(id)) {
      window.common.alert.show(id, params);
      return;
    }

    for (var i in window.common.alert.scopes) {

      if (i === id) {
        for (var j in params) {
          window.common.alert.scopes[i].opts[j] = params[j];
          console.log("Param", j, "value", params[j]);
        }
        console.log("Setted opts", window.common.alert.scopes[i].opts);
        window.common.alert.scopes[i].update();
        return;
      }
    }
  },
  compare2Ids: function (id1, id2) {

    console.log(id1, id2);

    if (!window.common.alert.priorities[id1]) return undefined;
    if (!window.common.alert.priorities[id2]) return undefined;

    if (window.common.alert.priorities[id1] > window.common.alert.priorities[id2]) return 1;
    if (window.common.alert.priorities[id1] < window.common.alert.priorities[id2]) return -1;
    if (window.common.alert.priorities[id1] === window.common.alert.priorities[id2]) return 0;
  },
  show: function (id, params) {

    window.clearTimers();

    console.log(id, params);

    if (!window.common.alert.priorities[id]) return;

    // if (window.fingerPrint.fingerPrintInitialize) return;

    var show = true;

    try {
      window.stopSpinner();
      window.stopLoaderDots();
      window.blurFields();

    } catch (error) {

      console.error(error);
    }

    for (var i = 0; i < window.common.alert.ids.length; i++) {

      var element = window.common.alert.ids[i];

      if (!window.common.alert.isShown(element)) {

        // console.log("Is Not Shown", element);
        continue;
      }

      if (id !== element && window.common.alert.compare2Ids(id, element) >= 0) {

        window.common.alert.hide(element);
      }

      if (window.common.alert.compare2Ids(id, element) < 0) {

        show = false;
      }
    }

    if (show) {

      try {

        alertTags.innerHTML = "<" + window.common.alert.tags[id] + ">";
        window.common.alert.scopes[id] = riot.mount(window.common.alert.tags[id], params)[0];
      } catch (error) {

        console.error(error);
      }
    }
  },
  isShown: function (id) {

    // console.log(id);
    //
    // console.log("IS SHOWN FUNC ELEMENT", id, window[id]);
    if (!window[id]) {
      return false;
    }

    // console.log("IS SHOWN FUNC ELEMENT SCOPE", id, window.common.alert.scopes[id]);

    if (!window.common.alert.scopes[id]) {
      return false;
    }

    try {

      // console.log("IS SHOWN FUNC ELEMENT SCOPE", id, window[id], window[id].style.display);

      if (window[id].style.display !== "none") {
        return true;
      }
    } catch (error) {

      console.error(error);
    }

    return false;
  },

  anyOpen: function () {
    for (var i = 0; i < window.common.alert.ids.length; i++) {

      var element = window.common.alert.ids[i];

      if (window.common.alert.isShown(element)) {

        console.log("Is Shown", element);
        return true;
      }

    }
    return false;
  }
};

window.lastSocketMethodToSend;

window.viewRegistrationDevice = {};

window.viewSms = {};


window.history = {};
history.arrayOfHistory = [];
sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


window.viewRegistrationClient = {};


window.componentKeyboard = {};

window.firstMount = {};

window.viewPay = {};
window.inPlacePay = {};
inPlacePay.latitude = 0;
inPlacePay.longitude = 0;

window.viewServicePage = {};
viewServicePage.amountText = '';
viewServicePage.amountWithoutSpace = '';

window.viewServicePinCards = {};
viewServicePinCards.friendHelpPaymentMode = false;
viewServicePinCards.chosenFriendForHelp = null;

window.viewPayConfirm = {};

window.viewMyCardList = {};

viewMyCardList.myCardListBoolean = false;

window.viewTransfer = {};
viewTransfer.check = false;
viewTransfer.phoneNumber = '';
viewTransfer.cardNumber = '';
viewTransfer.type = 2;

window.viewTransferStepTwo = {};
viewTransferStepTwo.sum = '';
viewTransferStepTwo.sumWithoutSpace = '';

window.viewTransferStepThree = {};
window.viewTransferStepFour = {};

window.viewTransferThree = {};
viewTransferThree.check = false;

window.modeOfflineMode = {};
modeOfflineMode.check = false;
modeOfflineMode.balance = false;

window.standCheckRegistration = false;

checkPhoneForTransfer = true;
checkCardForTransfer = false;

window.componentMenu = {};
componentMenu.checkOpen = false;

window.modeOfApp = {};
modeOfApp.onlineMode = true;
modeOfApp.offlineMode = false;
modeOfApp.demoVersion = false;

window.componentDeleteCard = {};

window.invoiceActions = {};
invoiceActions.ACCEPT = 1;
invoiceActions.DECLINE = 2;

window.input_codes = {};
input_codes.BACKSPACE_CODE = 8;
input_codes.NEXT = 9;
input_codes.ENTER = 13;

window.componentMenu = {};
componentMenu.check = false;

window.componentReportFilter = {};
componentReportFilter.today = 1;
componentReportFilter.yesterday = 2;
componentReportFilter.currentWeek = 3;
componentReportFilter.pastWeek = 4;
componentReportFilter.currentMonth = 5;
componentReportFilter.pastMonth = 6;

window.qrScaner = {};

window.checkShowingComponent = null;

window.pickContactFromNativeChecker = false;

window.News = {};
window.News.newsCounter = 0;

window.fingerPrint = {};
window.fingerPrint.check = false;
window.fingerPrint.fingerPrintInitialize = false;

window.bottomButtomBottom = 0;

window.componentClickPassHelp = {};
componentClickPassHelp.checkOpen = false;

window.componentClickPassCards = {};
componentClickPassCards.checkOpen = false;

window.representDotedDate = function (left, middle, right) {

  return dateAddZero(left) + "." + dateAddZero(middle) + "." + dateAddZero(right);
};

window.representDashedDate = function (left, middle, right) {

  return dateAddZero(left) + "-" + dateAddZero(middle) + "-" + dateAddZero(right);
};

window.dateAddZero = function (date) {

  date = date.toString();

  if (date.length == 1) {

    date = "0" + date;
  }

  return date;
};

window.deleteLeadingZeros = function (amount) {
  if (typeof amount === 'string') {
    amount = amount.replace(/^0+/, '');
    console.log('amount without leading zeros', amount);
  }
  return amount;
};

window.amountTransform = function (amount) {
  if (amount) {
    amount = amount.toString()
  } else {
    return amount
  }
  if (amount.length == 1 && amount == 0) {
    return amount.toString();
  }

  amount = amount.replace(new RegExp('[^0-9.]', 'g'), '');
  var newAmount = '';

  if (amount.indexOf('.') >= 0) {
    newAmount = amount;
    console.log("Amount contains dot");
  }
  else {
    var j = 0;
    for (var i = amount.length - 1; i >= 0; i--) {
      j++;
      newAmount += amount[i];
      if (j % 3 == 0 && i != 0) {
        newAmount += ' ';
      }
    }
  }
  return newAmount.split("").reverse().join("");
}

window.getFractionalPart = function (amount) {
  var fractionalPartResult = '';
  if (amount !== undefined && amount.indexOf('.') >= 0) {
    fractionalPartResult = amount.slice(amount.indexOf('.'), amount.length);
  }
  if (fractionalPartResult.length > 3) {
    fractionalPartResult = fractionalPartResult.slice(0, 3);
  }
  if (fractionalPartResult === '00') {
    fractionalPartResult = '';
  }
  return fractionalPartResult;
};


window.inputVerification = {};

window.inputVerification.phoneDelTransform = function (i, amount) {

  if (amount) {
    amount = amount.toString();
    amount = amount.replace(new RegExp('[^0-9]', 'g'), '');
    // console.log("i=", i, ",amount=", amount);
    var newAmount = '';
    if (i == 4)
      newAmount = amount.slice(0, 2) + ' ' + amount.slice(3);
    else if (i == 3 || i == 2)
      newAmount = amount.slice(0, 1) + amount.slice(2, 3) + ' ' + amount.slice(3);
    else if (i == 1)
      newAmount = amount.slice(1, 3) + ' ' + amount.slice(3);
  }
  return newAmount;
}

window.inputVerification.phoneEnterTransform = function (i, val, amount) {

  // console.log("i=", i, ",val=", val, ",amount=", amount);
  if (amount) {
    amount = amount.toString();
    amount = amount.replace(new RegExp('[^0-9]', 'g'), '');
    var newAmount = '';
    if (i == 2)
      newAmount = amount.slice(0, 2) + ' ' + val + amount.slice(2);
    else if (i == 1)
      newAmount = amount.slice(0, 1) + val + ' ' + amount.slice(1);
    else if (i == 0)
      newAmount = val + amount.slice(0, 1) + ' ' + amount.slice(1);
  } else {
    newAmount = val;
  }
  return newAmount;
}

window.inputVerification.spaceDeleter = function (data) {
  data = data.toString()
  data = data.replace(new RegExp('[^0-9]', 'g'), '');
  return data.split(",").join();
}

window.inputVerification.telVerification = function (phoneNumber) {
  phoneNumber = phoneNumber.toString()

  phoneNumber = phoneNumber.replace(new RegExp('[^0-9]', 'g'), '');

  if (phoneNumber.length > 9) {
    phoneNumber = phoneNumber.substring(phoneNumber.length - 9, phoneNumber.length)
  }
  return phoneNumber.split(",").join();
}

window.inputVerification.telVerificationWithSpace = function (phoneNumber) {
  phoneNumber = phoneNumber.toString()

  phoneNumber = phoneNumber.replace(new RegExp('[^0-9]', 'g'), '');

  var newNumber = '';

  if (phoneNumber.length > 10) {
    phoneNumber = phoneNumber.substring(phoneNumber.length - 10, phoneNumber.length)
  }
  newNumber = phoneNumber.slice(0, 2) + ' ' + phoneNumber.slice(2);
  return newNumber;
}

window.inputVerification.telLengthVerification = function (phoneNumber, length) {
  phoneNumber = phoneNumber.toString()
  phoneNumber = phoneNumber.replace(new RegExp('[^0-9]', 'g'), '');
  phoneNumber = phoneNumber.split(",").join();
  return phoneNumber.length > length ? phoneNumber.substring(phoneNumber.length - length, phoneNumber.length) : phoneNumber;
}

window.inputVerification.dateVerification = function (date) {
  date = date.toString()

  date = date.replace(new RegExp('[^0-9]', 'g'), '');
  console.log(date)
  if (date) {
    if (date.length == 1)
      return date;
    if (date.length == 2)
      return date + '/';
    if (date.length == 3)
      return date.substring(0, 2) + '/' + date.substring(2, 3)
    if (date.length == 4)
      return date.substring(0, 2) + '/' + date.substring(2, 4)
  }
  else {
    return date
  }
}

window.inputVerification.cardVerification = function (card) {
  card = card.toString()

  card = card.replace(new RegExp('[^0-9]', 'g'), '');
  card = card.split(",").join();

  var newCard = ''
  var j = 0;
  for (var i = 0; i < card.length; i++) {
    j++;
    newCard += card[i]
    if (j % 4 == 0 && i < 15) {
      newCard += ' ';
    }
  }
  return newCard
};

window.pushNotificationSaveTokenToServer = function (token) {

  var phoneNumber = localStorage.getItem("click_client_phoneNumber");
  var tokenOfApp = localStorage.getItem("click_client_token");
  var signString = hex_md5(phoneNumber.substring(0, 5) + token + phoneNumber.substring(phoneNumber.length - 4, phoneNumber.length))

  console.log('token', token);
  window.api.call({
    method: 'push.register.token',
    input: {
      phone_num: phoneNumber,
      token: token,
      sign_string: signString,
      device_vendor: device.manufacturer,
      device_model: device.model

    },

    scope: this,

    onSuccess: function (result) {
      if (result[0][0].error == 0) {
        localStorage.setItem('push_registered', token);

        window.FirebasePlugin.logEvent("Registration", {
          token: token,
          item_id: phoneNumber
        });

        window.FirebasePlugin.subscribe("news");

        window.FirebasePlugin.logEvent("subscribe", {
          topic: "news"
        });
      }
    },

    onFail: function (api_status, api_status_message, data) {
      console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
      console.error(data);
    }
  });
};

window.pushNotificationInitialize = function () {
  if (device.platform != 'BrowserStand')
    window.FirebasePlugin.getToken(function (token) {
      // save this server-side and use it to push notifications to this device

      if (!token || typeof token == "undefined") {

        window.FirebasePlugin.onTokenRefresh(function (token) {

          window.pushNotificationSaveTokenToServer(token);
        }, function (error) {
          console.error(error);
        });
      } else {

        window.pushNotificationSaveTokenToServer(token);
      }

    }, function (error) {
      console.error(error);
    });
};

window.pushNotificationActions = {

  getInvoiceFunction: function (invoiceId) {

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;

    window.api.call({
      method: 'invoice.list',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber
      },
      scope: this,
      onSuccess: function (result) {
        if (result[0][0].error == 0) {
          if (result[1]) {
            if (result[1][0]) {
              console.log('invoice', result[1])

              var invoice = {};
              for (var i = 0; i < result[1].length; i++) {

                if (invoiceId == result[1][i].invoice_id) {

                  invoice = result[1][i];

                  var params;

                  if (invoice.is_p2p) {

                    params = {

                      phoneNumber: invoice.parameter,
                      amount: invoice.amount,
                      invoiceId: invoice.invoice_id,
                      time: invoice.time,
                      date: invoice.date
                    };

                    history.arrayOfHistory.push({view: "view-transfer-detail"});
                    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
                    riotTags.innerHTML = "<view-transfer-detail>";
                    riot.mount('view-transfer-detail', params);
                  } else {

                    params = {

                      amount: invoice.amount,
                      invoiceId: invoice.invoice_id,
                      phoneNumber: invoice.merchant_phone,
                      accountNumber: invoice.parameter,
                      serviceName: invoice.service_name
                    };

                    history.arrayOfHistory.push({view: "view-payment-detail"});
                    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
                    riotTags.innerHTML = "<view-payment-detail>";
                    riot.mount('view-payment-detail', params);
                  }

                  return;
                }
              }

            }
            else {

            }
          }
        }
        else {
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//            scope.showError = true;
//            riot.update();
        }
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });
  },
  getPaymentList: function (paymentId) {

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;

    scope.paymentsMap = {};
    scope.paymentDates = [];
    scope.paymentsList = [];
    window.api.call({
      method: 'get.payment.list',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber
      },
      scope: this,

      onSuccess: function (result) {
        console.log(result)
        console.log(result[0][0])
        if (result[0][0].error == 0) {
          console.log('PAYMENTLIST=', result[1]);
          for (var i in result[1]) {

            if (result[1][i].payment_id == paymentId) {

              console.log("service report for=", result[1][i]);
              riotTags.innerHTML = "<view-report-service-new>";
              riot.mount("view-report-service-new", result[1][i]);
              return;
            }
          }
        }
        else {

        }

      },
      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });
  },

  getNewsFunction: function (newsId) {
    window.News.newsCounter = 0;

    sessionStorage.setItem("push_news", true)

    console.log('running news')

    riotTags.innerHTML = "<view-main-page>";
    riot.mount("view-main-page", {view: "news", news_id: newsId});
  },

  refreshCardCarousel: function (cardId) {

    var view = history.arrayOfHistory[history.arrayOfHistory.length - 1].view;

    if (view == "view-main-page" || view == "view-my-cards") {

      onComponentCreated();
    } else {

      riotTags.innerHTML = "<view-my-cards>";
      riot.mount("view-my-cards", [cardId]);
    }
  },
  retrievePushNotification: function () {

    var notification = sessionStorage.getItem("push_notification")
    notification = JSON.parse(notification);

    if (notification) {
      window.pushNotificationActions[notification.action](notification.params);
    }

    sessionStorage.removeItem('push_notification');
  }
};

window.updateBalanceGlobalFunction = function () {

  if (localStorage.getItem('click_client_cards')) {
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_cards'))
    var arrayOfCard = JSON.parse(localStorage.getItem('click_client_cards'))
    var phoneNumber = JSON.parse(localStorage.getItem('click_client_phoneNumber'))
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    if (loginInfo)
      var sessionKey = loginInfo.session_key;
  }

  console.log("JSON.parse(localStorage.getItem('click_client_cards'))", JSON.parse(localStorage.getItem('click_client_cards')))


  console.log('getAccountsCards', getAccountsCards)

  for (var i in getAccountsCards) {
    window.api.call({
      method: 'get.balance',
      stopSpinner: false,
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
            try {
              if (arrayOfCard[result[1][0].account_id])
                arrayOfCard[result[1][0].account_id].salaryOriginal = result[1][0].balance.toFixed(0);


              result[1][0].balance = result[1][0].balance.toFixed(0).toString();

              if (result[1][0].balance != 0)
                result[1][0].balance = window.amountTransform(result[1][0].balance.toString());


              arrayOfCard[result[1][0].account_id].salary = result[1][0].balance;
              localStorage.setItem('click_client_cards', JSON.stringify(arrayOfCard));


              riot.update()

            }
            catch (error) {
              console.log(error)
            }
          }
        }

      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });
  }
};

window.updateBalanceGlobalFunction2 = function (scope, arrayOfCard) {

  var objectAccount = {};
  var accountsForBalance = [];

  if (localStorage.getItem('click_client_cards')) {
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_cards'));
    // var arrayOfCard = JSON.parse(localStorage.getItem('click_client_cards'));
    var phoneNumber = JSON.parse(localStorage.getItem('click_client_phoneNumber'));
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    if (loginInfo)
      var sessionKey = loginInfo.session_key;
  }

  // console.log("JSON.parse(localStorage.getItem('click_client_cards'))", JSON.parse(localStorage.getItem('click_client_cards')))


  for (var j in getAccountsCards) {
    objectAccount.account_id = getAccountsCards[j].id;
    objectAccount.card_num_hash = getAccountsCards[j].card_num_hash;
    objectAccount.card_num_crypted = getAccountsCards[j].card_num_crypted;
    accountsForBalance.push(objectAccount);
    objectAccount = {};
  }

  console.log('getAccountsCards', getAccountsCards);
  window.api.call({
    method: 'get.balance.multiple',
    stopSpinner: false,
    input: {
      session_key: sessionKey,
      phone_num: phoneNumber,
      accounts: accountsForBalance
    },
    scope: this,
    onSuccess: function (result) {
      if (result[0][0].error == 0) {
        if (result[1]) {
          try {

            var balances = {};
            for (var i in result[1]) {
              balances[result[1][i].account_id] = result[1][i];
            }

            for (var i in arrayOfCard) {
              if (balances[i]) {
                arrayOfCard[balances[i].account_id].salaryOriginal = balances[i].balance.toFixed(0);
                balances[i].balance_fractional = window.getFractionalPart(balances[i].balance.toString());
                balances[i].balance = Math.floor(balances[i].balance).toFixed(0).toString();

                if (balances[i].balance !== 0)
                  balances[i].balance = window.amountTransform(balances[i].balance.toString());

                arrayOfCard[balances[i].account_id].salary = balances[i].balance;
                arrayOfCard[balances[i].account_id].salary_fractional = balances[i].balance_fractional;
              } else {
                arrayOfCard[i].salary = null;
                arrayOfCard[i].salary_fractional = '';
                arrayOfCard[i].error_message = window.languages.ComponentCardCarouselBalanceError;
              }
            }
            scope.cardsArray = arrayOfCard;
            localStorage.setItem('click_client_cards', JSON.stringify(arrayOfCard));
            scope.update();

          } catch (Error) {
            console.log("Error on parse result fro get.balance.multiple", Error);
          }
        }
      }
      else {
        for (var i in arrayOfCard) {
          arrayOfCard[i].salary = null;
          arrayOfCard[i].error_message = window.languages.ComponentCardCarouselBalanceError;
        }

        localStorage.setItem('click_client_cards', JSON.stringify(arrayOfCard));
      }
    },
    onFail: function (api_status, api_status_message, data) {
      console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
      console.error(data);
    }
  });
};

window.getAccount = function (checkSessionKey, firstEnter, firstPinInputValue) {

  if (checkSessionKey) {
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;
  }

  if (history.arrayOfHistory.length < 2) {
    localStorage.setItem('onResume', false)
  }

  if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = info.session_key;

    if (firstEnter) {
      var lengthOfPin = firstPinInputValue.length;
      var compareLength = window.inputVerification.spaceDeleter(firstPinInputValue);
      console.log("First enter in account");
    }

    if (firstEnter && (lengthOfPin != compareLength.length || lengthOfPin != 5)) {
      riotTags.innerHTML = "<view-pin-code>";
      riot.mount('view-pin-code', ['view-authorization']);
    }
    else if (!localStorage.getItem("click_client_accountInfo")) {
      console.log("FIRST ENTER OR REGISTRATION fingerprint init ");
      fingerPrintInit();
      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
    }
    else {
      console.log("GET ACCOUNT last else ");
      setTimeout(function () {
        var onResume = localStorage.getItem('onResume') ? JSON.parse(localStorage.getItem('onResume')) : false;
        var sessionBroken = localStorage.getItem('session_broken') ? JSON.parse(localStorage.getItem('session_broken')) : false;
        var pushNews = sessionStorage.getItem('push_news') ? JSON.parse(sessionStorage.getItem('push_news')) : false;
        var settingsBlock = localStorage.getItem('settings_block') ? JSON.parse(localStorage.getItem('settings_block')) : false;

        console.log("onResume=", onResume);
        console.log("sessionBroken=", sessionBroken);
        console.log("pushNews=", pushNews);
        console.log("settingsBlock=", settingsBlock);

        if (!onResume && !sessionBroken && !pushNews) {
          this.riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
        }
        else {
          if (settingsBlock || sessionBroken || pushNews) {
            if (history.arrayOfHistory && history.arrayOfHistory[history.arrayOfHistory.length - 1]) {

              if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-news') {
                this.riotTags.innerHTML = "<view-main-page>";
                riot.mount("view-main-page");
              }
              else {
                window.stopSpinner();
                this.riotTags.innerHTML = "<" + history.arrayOfHistory[history.arrayOfHistory.length - 1].view + ">";
                riot.mount(history.arrayOfHistory[history.arrayOfHistory.length - 1].view, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
              }

              if (device.platform != 'BrowserStand')
                StatusBar.backgroundColorByHexString("#ffffff");

              if (settingsBlock) {
                localStorage.setItem('onResume', false);
              }
              else {
                if (sessionBroken) {
                  localStorage.setItem('session_broken', false);
                }
                else {
                  if (pushNews) {
                    sessionStorage.setItem("push_news", false)
                  }
                }
              }
              return

            }
          }
          else {
            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
          }

        }
      }, 0);
    }

    //get list of issuers and bank codes
    {
      if (!localStorage.getItem("click_client_issuer_list") || info.update_issuer_list) {
        if (modeOfApp.onlineMode) {
          window.api.call({
            method: 'issuer.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                scope.issuerList = [];
                for (var i in result[1][0]) {
                  scope.issuerList.push(result[1][0][i]);
                }
                localStorage.setItem('click_client_issuer_list', JSON.stringify(scope.issuerList));
              } else {
                scope.errorNote = result[0][0].error_note;
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote,
                  pathtosettings: scope.pathToSettings,
                  permissionerror: scope.permissionError,
                });
                scope.update();
              }
            },
            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        }
      }
    }

    if ((!localStorage.getItem("click_client_payCategoryList") || info.update_categories) && modeOfApp.onlineMode) {

      var categoryList = [];
      var categoryNamesMap = {};
      window.api.call({
        method: 'get.service.category.list',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0]) {
              if (device.platform != 'BrowserStand') {
                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                  var j = -1;

                  for (var i in result[1]) {
                    categoryNamesMap[result[1][i].id] = {
                      "name": result[1][i].name,
                      "icon": result[1][i].icon
                    };
                    j++;
                    categoryList.push(result[1][i]);

                    var icon = result[1][i].icon;
                    var filename = icon.substr(icon.lastIndexOf('/') + 1);

                    var newIconBool = checkImageURL;
                    newIconBool('www/resources/icons/ViewPay/', 'ViewPay', filename, icon, j, function (bool, index, fileName) {

                      if (bool) {
                        categoryList[index]['icon'] = cordova.file.dataDirectory + fileName;
                      } else {
                        categoryList[index]['icon'] = 'resources/icons/ViewPay/' + fileName;
                      }

                      if (result[1].length == categoryList.length) {
                        localStorage.setItem('click_client_payCategoryList', JSON.stringify(categoryList));
                        localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(categoryNamesMap));
                      }
                    });
                  }
                }, onErrorLoadFs);
              }
              else {
                for (var i in result[1]) {

                  categoryList.push(result[1][i]);
                  categoryNamesMap[result[1][i].id] = {
                    "name": result[1][i].name,
                    "icon": result[1][i].icon
                  };
                }
                localStorage.setItem('click_client_payCategoryList', JSON.stringify(categoryList));
                localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(categoryNamesMap));
              }
            }

          scope.id = 0;

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }
    /*
     * Убрана проверка, так как по требованию в онлайн режиме всегда производится вызов сервисов.
     * */

    var serviceList = [];
    var servicesMapByCategory = {};
    var servicesMap = {};
    var serviceNamesMap = {};

    if ((!(localStorage.getItem("click_client_payServiceList") && localStorage.getItem("click_client_servicesMapByCategory")
      && localStorage.getItem("click_client_servicesMap")) || info.update_services) && modeOfApp.onlineMode) {

      var operatorKey = phoneNumber.substr(3, 2);
      window.api.call({
        method: 'get.service.list',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0]) {
              var firstService;

              for (var i in result[1]) {
                if (result[1][i].is_visible == 1) {

                  serviceNamesMap[result[1][i].id] = result[1][i].name;
                  serviceList.push(result[1][i]);

                  if (!servicesMapByCategory[result[1][i].category_id]) {
                    servicesMapByCategory[result[1][i].category_id] = [];
                    if (result[1][i].category_id === 1 && (result[1][i].id === window.mOperators[operatorKey])) {
                      localStorage.setItem('myNumberOperatorId', result[1][i].id);

                      var myNumberObject = {};
                      myNumberObject.name = 'Мой номер';
                      myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                      myNumberObject.id = 'mynumber' + result[1][i].id;
                      servicesMapByCategory[result[1][i].category_id].push(myNumberObject);

                    } else if (result[1][i].category_id === 1) {
                      firstService = result[1][i];
                    }
                    servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                  }
                  else {
                    if (result[1][i].category_id === 1 && (result[1][i].id === window.mOperators[operatorKey])) {
                      localStorage.setItem('myNumberOperatorId', result[1][i].id);

                      var myNumberObject = {};
                      myNumberObject.name = 'Мой номер';
                      myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                      myNumberObject.id = 'mynumber' + result[1][i].id;
                      servicesMapByCategory[result[1][i].category_id][0] = myNumberObject;
                      servicesMapByCategory[result[1][i].category_id].push(firstService);
                    }
                    servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                  }

                  if (!servicesMap[result[1][i].id + '']) {
                    servicesMap[result[1][i].id + ''] = [];
                    servicesMap[result[1][i].id + ''].push(result[1][i]);
                  }
                  else {
                    servicesMap[result[1][i].id + ''].push(result[1][i]);
                  }
                }
              }
              localStorage.setItem('click_client_payServiceList', JSON.stringify(serviceList));
              localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(serviceNamesMap));
              localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(servicesMapByCategory));
              localStorage.setItem('click_client_servicesMap', JSON.stringify(servicesMap));


              {
                window.api.call({
                  method: 'get.wishlist',
                  input: {
                    session_key: sessionKey,
                    phone_num: phoneNumber,
                    type: 1
                  },
                  scope: this,
                  onSuccess: function (result) {

                    if (result[0][0].error == 0) {
                      if (result[1].length != 0) {
                        var favoritePaymentsList = [];
                        var favoritePaymentsListForApi = [];
                        for (var j in result[1]) {
                          var fav = JSON.parse(result[1][j].body);
                          if (servicesMap[fav.service.id]) {
                            fav.service.image = servicesMap[fav.service.id][0].image;
                            favoritePaymentsList.push(fav);
                          }
                        }
                        for (var i in favoritePaymentsList)
                          favoritePaymentsListForApi.push({
                            "id": favoritePaymentsList[i].id,
                            "type": 1,
                            "body": JSON.stringify(favoritePaymentsList[i])
                          })

                        localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));
                        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
                        console.log("favs processed", favoritePaymentsList);
                        if (document.getElementById("componentServiceCarouselNew")) {
                          var serviceCarouselTag = document.getElementById("componentServiceCarouselNew");
                          if (serviceCarouselTag._tag) {
                            serviceCarouselTag._tag.updateWishList();
                          }
                        }
                      }
                    }
                    else {
                      window.common.alert.show("componentAlertId", {
                        parent: scope,
                        clickpinerror: false,
                        errornote: result[0][0].error_note
                      });
                      console.log(result[0][0].error_note);
                    }
                  },
                  onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                  }
                });
              }

              serviceImagesCaching();
            }
          servicesParamsInit();
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    serviceImagesCaching = function () {
      if (device.platform != 'BrowserStand') {
        window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
          var j = -1, counter = 0;

          for (var i in serviceList) {
            j++;

            var icon = serviceList[i].image;
            var filename = icon.substr(icon.lastIndexOf('/') + 1);

            var newIconBool = checkImageURL;
            newIconBool('www/resources/icons/ViewPay/', 'ViewPay', filename, icon, j, function (bool, index, fileName) {

              if (bool) {
                counter++;
                serviceList[index].image = cordova.file.dataDirectory + fileName;
                servicesMap[serviceList[index].id + ''][0].image = cordova.file.dataDirectory + fileName;

                for (var k = 0; k < servicesMapByCategory[serviceList[index].category_id].length; k++) {
                  if (servicesMapByCategory[serviceList[index].category_id][k].id != ('mynumber' + localStorage.getItem('myNumberOperatorId')) &&
                    servicesMapByCategory[serviceList[index].category_id][k].id == serviceList[index].id) {
                    servicesMapByCategory[serviceList[index].category_id][k].image = cordova.file.dataDirectory + fileName;
                  }
                }

                if (counter == serviceList.length) {
                  localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(servicesMapByCategory));
                  localStorage.setItem('click_client_servicesMap', JSON.stringify(servicesMap));
                }
              }
            });
          }

        }, onErrorLoadFs);
      }
    }


    servicesParamsInit = function () {
      var servicesParams = [];
      var servicesParamsMapOne = {};
      var servicesParamsMapTwo = {};
      var servicesParamsMapThree = {};
      var servicesParamsMapFour = {};
      var servicesParamsMapFive = {};
      var servicesParamsMapSix = {};
      window.api.call({
        method: 'get.service.parameters.list',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1])
              for (var i in result[1]) {
                if (!servicesParamsMapOne[result[1][i].service_id]) {
                  servicesParamsMapOne[result[1][i].service_id] = [];
                  servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
                }
                else
                  servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);


              }
            if (result[2])
              for (var i in result[2]) {
                if (!servicesParamsMapTwo[result[2][i].service_id]) {
                  servicesParamsMapTwo[result[2][i].service_id] = [];
                  servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
                }
                else
                  servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);

              }
            if (result[3])
              for (var i in result[3]) {
                if (!servicesParamsMapThree[result[3][i].service_id]) {
                  servicesParamsMapThree[result[3][i].service_id] = [];
                  servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
                }
                else
                  servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);

              }
            if (result[4])
              for (var i in result[4]) {
                if (!servicesParamsMapFour[result[4][i].service_id]) {
                  servicesParamsMapFour[result[4][i].service_id] = [];
                  servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                }
                else
                  servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
              }
            if (result[5])
              for (var i in result[5]) {
                if (!servicesParamsMapFive[result[5][i].service_id]) {
                  servicesParamsMapFive[result[5][i].service_id] = [];
                  servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                }
                else
                  servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
              }
            if (result[6])
              for (var i in result[6]) {
                if (!servicesParamsMapSix[result[6][i].service_id]) {
                  servicesParamsMapSix[result[6][i].service_id] = [];
                  servicesParamsMapSix[result[6][i].service_id].push(result[6][i]);
                }
                else
                  servicesParamsMapSix[result[6][i].service_id].push(result[6][i]);
              }
            localStorage.setItem('click_client_servicesParams', JSON.stringify(result));
            localStorage.setItem('click_client_servicesParamsMapOne', JSON.stringify(servicesParamsMapOne));
            localStorage.setItem('click_client_servicesParamsMapTwo', JSON.stringify(servicesParamsMapTwo));
            localStorage.setItem('click_client_servicesParamsMapThree', JSON.stringify(servicesParamsMapThree));
            localStorage.setItem('click_client_servicesParamsMapFour', JSON.stringify(servicesParamsMapFour));
            localStorage.setItem('click_client_servicesParamsMapFive', JSON.stringify(servicesParamsMapFive));
            localStorage.setItem('click_client_servicesParamsMapSix', JSON.stringify(servicesParamsMapSix));
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };


  }

  window.stopSpinner();
};

window.fingerPrintInit = function () {
  console.log("G.O. fingerprint INIT");
  if (localStorage.getItem('settings_finger_print') !== null) {
    if (device.platform == 'Android') {

      function isAvailableSuccess(result) {
        console.log("FingerprintAuth available: " + JSON.stringify(result));
        if (result.isAvailable) {
          window.fingerPrint.check = true;
          localStorage.setItem('settings_finger_print_enrolled', true);


          onConfirm = function (index) {
            if (index == 1) {
              localStorage.setItem('settings_finger_print', true)

            }
            else {
              localStorage.setItem('settings_finger_print', false)
            }
          };

          navigator.notification.confirm(
            'Хотите использовать сканер отпечатка пальца для входа в CLICK?',  // message
            onConfirm,              // callback to invoke with index of button pressed
            'Устройство поддерживает технологию Fingerprint',            // title
            ['Да', 'Нет']          // buttonLabels
          );

        }
        else {
          window.fingerPrint.check = false;
          localStorage.setItem('settings_finger_print', false);
          riot.update();
        }
      }

      function isAvailableError(message) {
        console.log("isAvailableError(): " + message);
        localStorage.setItem('settings_finger_print_enrolled', false);
        localStorage.setItem('settings_finger_print', false);
        window.fingerPrint.check = false;
        riot.update();
      }

      FingerprintAuth.isAvailable(isAvailableSuccess, isAvailableError);

    }
    else if (device.platform == 'iOS') {

      function successCallback(success) {
        window.fingerPrint.check = true;
        localStorage.setItem('settings_finger_print_enrolled', true)
        console.log('success', success)

        onConfirm = function (index) {
          if (index == 1) {
            localStorage.setItem('settings_finger_print', true)
          }
          else {
            localStorage.setItem('settings_finger_print', false)
          }
        }

        var availableTech = 'Устройство поддерживает технологию TouchID';
        if (device.model == 'iPhone10,3' || device.model == 'iPhone10,6') {
          availableTech = 'Устройство поддерживает технологию FaceID';
        }

        navigator.notification.confirm(
          'Хотите использовать её для входа в CLICK?',  // message
          onConfirm,              // callback to invoke with index of button pressed
          availableTech,            // title
          ['Да', 'Нет']          // buttonLabels
        );

      }

      function notSupportedCallback(error) {
        console.log('error', error)
        window.fingerPrint.check = false;
        localStorage.setItem('settings_finger_print_enrolled', false)
      }

      window.plugins.touchid.isAvailable(successCallback, notSupportedCallback);

    }
  }
};

window.fingerPrintCheck = function () {
  console.log("G.O. fingerprint check");
  if (localStorage.getItem('settings_finger_print') !== null) {
    if (device.platform == 'Android') {

      function isAvailableSuccess(result) {
        console.log("FingerprintAuth available: " + JSON.stringify(result));
        if (result.isAvailable) {
          window.fingerPrint.check = true;
          localStorage.setItem('settings_finger_print_enrolled', true);
          localStorage.setItem('settings_finger_print', true);

        }
        else {
          window.fingerPrint.check = false;
          localStorage.setItem('settings_finger_print', false);
          riot.update();
        }
      }

      function isAvailableError(message) {
        console.log("isAvailableError(): " + message);
        localStorage.setItem('settings_finger_print_enrolled', false);
        localStorage.setItem('settings_finger_print', false);
        window.fingerPrint.check = false;
        riot.update();
      }

      FingerprintAuth.isAvailable(isAvailableSuccess, isAvailableError);
    }
  }
};

window.fingerPrintAsk = function (fingerprintIconId) {
  console.log("G.O. fingerprint ASK");

  if (localStorage.getItem('settings_finger_print') !== null) {

    window.fingerPrint.fingerPrintInitialize = true;

    if (device.platform == 'Android') {

      window.fingerPrint.check = true;
      localStorage.setItem('settings_finger_print_enrolled', true);

      if (!sessionStorage.getItem("push_news") || JSON.parse(sessionStorage.getItem("push_news")) !== true) {
        var encryptConfig = {
          clientId: "myAppName",
          clientSecret: "currentUser",
          password: "currentUser",
          token: "currentUser",
          locale: "ru",
          disableBackup: true,
//              userAuthRequired: false,
          dialogHint: "Повторите попытку",
          dialogTitle: "Сканирование для CLICK"

        }; // See config object for required parameters


        if (JSON.parse(localStorage.getItem("settings_finger_print")) === true && localStorage.getItem('click_client_pin')) {

          FingerprintAuth.start(encryptConfig, encryptSuccessCallback, encryptErrorCallback);
        }

      }


      function encryptSuccessCallback(result) {
        console.log("encrypt success, change gif to CHECK");
        if (document.getElementById(fingerprintIconId))
          document.getElementById(fingerprintIconId).style.backgroundImage = "url(resources/gifs/auth/check.gif?p" + new Date().getTime() + ")";

        setTimeout(function () {
          window.fingerPrint.fingerPrintInitialize = false;
          if (document.getElementById(fingerprintIconId))
            document.getElementById(fingerprintIconId).style.backgroundImage = "url(resources/gifs/auth/success.gif?p" + new Date().getTime() + ")";

          setTimeout(function () {

            pin = localStorage.getItem('click_client_pin');
            checkConnection(enter, noInternetFingerPrint);

          }, 1000);
        }, 1000);
      }

      function encryptErrorCallback(error) {
        console.log("encrypt error, change gif to CHECK");

        fingerPrintStop();

        if (document.getElementById(fingerprintIconId))
          document.getElementById(fingerprintIconId).style.backgroundImage = "url(resources/gifs/auth/check.gif?p" + new Date().getTime() + ")";

        setTimeout(function () {
          window.fingerPrint.fingerPrintInitialize = false;
          if (document.getElementById(fingerprintIconId))
            document.getElementById(fingerprintIconId).style.backgroundImage = "url(resources/gifs/auth/error1.png)";

          viewAuthorization.fingerPrintErrorCount++;
          console.log("viewAuthorization.fingerPrintErrorCount =", viewAuthorization.fingerPrintErrorCount);
          // if (viewAuthorization.fingerPrintErrorCount % 2 == 0 || viewAuthorization.fingerPrintErrorCount == 5) {
          console.log("Sending error app.login");
          checkConnection(enterFalse, noInternetFingerPrint);
          // } else {
          //
          //   setTimeout(function () {
          //
          //     fingerPrintAsk('fingerPrintIconId');
          //
          //     if (document.getElementById('fingerPrintIconId'))
          //       document.getElementById('fingerPrintIconId').style.backgroundImage = "url(resources/gifs/auth/wait.gif?p" + new Date().getTime() + ")";
          //   }, 1000);
          //
          // }

          window.fingerPrint.fingerPrintInitialize = false;
          console.log("FingerprintAuth Error: " + error);

        }, 1000);

      }

    }
    else if (device.platform == 'iOS') {

      window.fingerPrint.check = true;
      localStorage.setItem('settings_finger_print_enrolled', true);

      if (!sessionStorage.getItem("push_news") || JSON.parse(sessionStorage.getItem("push_news")) !== true) {

        if (JSON.parse(localStorage.getItem("settings_finger_print")) === true && localStorage.getItem('click_client_pin')) {
          var text = 'Приложите палец для сканирования';
          window.plugins.touchid.verifyFingerprint(text, successCallbackOfAuth, failureCallbackOfAuth);
        }

      }


      function successCallbackOfAuth(success) {
        window.fingerPrint.fingerPrintInitialize = false;

        console.log('SUCCIESS FINGER PRINT')
        pin = localStorage.getItem('click_client_pin');
        enter();
      }

      function failureCallbackOfAuth(error) {
        window.fingerPrint.fingerPrintInitialize = false;

        window.scannerCanBeAsked = false;

        console.log('FAIL FINGER PRINT')
      }
    }
  }
};

window.fingerPrintStop = function () {
  if (localStorage.getItem('settings_finger_print') !== null) {

    if (device.platform == 'Android') {

      FingerprintAuth.stop(function () {
        console.log("closed");
      }, function () {
        console.log("error in close");
      });
    }
  }
};

window.clearTimers = function () {
  var id = window.setTimeout(function () {
  }, 0);
  var maxInterval = id - 10;
  while (id > maxInterval) {
    window.clearTimeout(id);
    id--;
  }
};


window.startSpinner = function () {
  if (device.platform != 'BrowserStand') {
    var options = {dimBackground: true};

    SpinnerPlugin.activityStart(languages.Downloading, options, function () {
      console.log("Started");
    }, function () {
      console.log("closed");
    });
  }
};


window.stopSpinner = function () {
  if (device.platform !== 'BrowserStand') {
    console.log("Spinner Stop");
    SpinnerPlugin.activityStop();
  }
};

window.startLoaderDots = function () {
  console.log("start loader dots");
  if (document.getElementById("loaderDots"))
    document.getElementById("loaderDots").style.display = 'block';
};

window.startPaginationLoaderDots = function () {
  console.log("start pagination loader dots");
  if (document.getElementById("loaderDots")) {
    document.getElementById("loaderDots").classList.add("loader-dots-pagination");
    document.getElementById("loaderDots").style.display = 'block';
  }
};

window.stopLoaderDots = function () {
  console.log("stop loader dots");
  if (document.getElementById("loaderDots")) {
    document.getElementById("loaderDots").style.display = 'none';
    document.getElementById("loaderDots").classList.remove("loader-dots-pagination");
  }
};

window.blurFields = function () {
  try {
    if ('activeElement' in document) {
      var activeObj = document.activeElement;
      if (activeObj.tagName.toLowerCase() == "input")
        console.log("bluring element ", activeObj.blur());
      else
        console.log("not bluring ", activeObj, activeObj.tagName);
    }
    else {
      console.log("Your browser does not support the activeElement property!");
    }
    return;
  } catch (e) {
  }
};


window.saveHistory = function (viewName, viewOpts) {
  // console.log("SAVE HISTORY ", viewName, viewOpts);
  history.arrayOfHistory = JSON.parse(sessionStorage.getItem('history'));
  if (history.arrayOfHistory.length != 0 && history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== viewName) {
    history.arrayOfHistory.push(
      {
        "view": viewName,
        "params": viewOpts
      }
    );
    window.savePageLogs(viewName);
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
  }


  console.error('WINDOW.SAVE HISTORY');
};

window.savePageLogs = function (viewName) {
  pageLogs = JSON.parse(sessionStorage.getItem('page_logs'));
  if (pageLogs) {
    if (pageLogs.length !== 0) {
      for (var k in pageLogs) {
        if (pageLogs[k] && pageLogs[k].view === viewName) {
          pageLogs.splice(k, 1);
        }
      }
      pageLogs.push(
        {
          view: viewName,
          logs: []
        }
      );
    }
  } else {
    pageLogs = [{
      view: viewName,
      logs: []
    }];
  }
  sessionStorage.setItem('page_logs', JSON.stringify(pageLogs))
};

window.getPosition = function (el) {
  var xPos = 0;
  var yPos = 0;

  while (el) {
    if (el.tagName == "BODY") {
      // deal with browser quirks with body/window/document and page scroll
      var xScroll = el.scrollLeft || document.documentElement.scrollLeft;
      var yScroll = el.scrollTop || document.documentElement.scrollTop;

      xPos += (el.offsetLeft - xScroll + el.clientLeft);
      yPos += (el.offsetTop - yScroll + el.clientTop);
    } else {
      // for all other non-BODY elements
      xPos += (el.offsetLeft - el.scrollLeft + el.clientLeft);
      yPos += (el.offsetTop - el.scrollTop + el.clientTop);
    }

    el = el.offsetParent;
  }
  return {
    x: xPos,
    y: yPos
  };
};

window.sendToLog = function (data) {
  params = {
    method: 'report.issue',
    input: data,
    onSuccess: function (result) {
      if (result[0][0].error === 0) {
        if (result[1][0]) {
          saved_log_id = result[1][0].report_id;
          console.log('id of saved log:', saved_log_id);
          deleteLog(saved_log_id);
          //clearing sessionStorage and etc
        }
      }
      else {
        console.log('something gone wrong:', result);
        //to do something else
      }
    },
    onFail: function (api_status, api_status_message, data) {
      console.log('cannot save logs to server');
      console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
      console.error(data);
    },
  }
  window.api.send(params);
};

var fileData = [], log;

window.replaceErrors = function (key, value) {
  if (value instanceof Error) {
    var error = {};

    Object.getOwnPropertyNames(value).forEach(function (key) {
      error[key] = value[key];
    });

    return error;
  }

  return value;
};

window.writeLog = function (logToSave) {

  phoneNumber = localStorage.getItem('click_client_phoneNumber');
  sign_time = (new Date()).getTime();
  report_id = 'id' + sign_time + Math.random().toString(16).slice(2);
  sign_string = hex_md5(sign_time + report_id + 'x-report');
  console.log('sign_string before send', sign_string);
  log = {
    phone_num: phoneNumber,
    report_id: report_id,
    report_data: logToSave,
    sign_time: sign_time,
    sign_string: sign_string,
  };
  console.log('log before read', log);
  if (device.platform !== 'BrowserStand') {
    readFromFile('log.txt', function (data) {
      if (data) {
        console.log("READ FILE BEFORE = ", JSON.parse(data));
        fileData = JSON.parse(data);
        fileData.push(log);
        writeToFile('log.txt');
        console.log('fileData before sending log', fileData);
        window.sendToLog(log);
      }
    });
  } else {
    window.sendToLog(log);
  }
};

function deleteLog(id) {
  if (device.platform !== 'BrowserStand') {
    readFromFile('log.txt', function (data) {
      if (data) {
        console.log("READ FILE BEFORE = ", JSON.parse(data));
        fileData = JSON.parse(data);
        for (log_i in fileData) {
          if (fileData[log_i] && fileData[log_i].report_id === id) {
            fileData.splice(log_i, 1);
          }
        }
        writeToFile('log.txt');
      }
    });
  }
}

function writeToFile(fileName) {


  var data = JSON.stringify(fileData, null, '\t');
  window.resolveLocalFileSystemURL(cordova.file.dataDirectory, function (directoryEntry) {
    directoryEntry.getFile(fileName, {create: true}, function (fileEntry) {
      fileEntry.createWriter(function (fileWriter) {
        fileWriter.onwriteend = function (e) {
          // for real-world usage, you might consider passing a success callback
          console.log('Write of file "' + fileName + '"" completed.');
          readFromFile('log.txt', function (data) {
            console.log("RESULT OF READ FILE = ", data);
          });
        };

        fileWriter.onerror = function (e) {
          // you could hook this up with our global error handler, or pass in an error callback
          console.log('Write failed: ' + e.toString());
        };

        var blob = new Blob([data], {type: 'text/plain'});

        fileWriter.write(blob);
      }, errorHandler.bind(null, fileName));
    }, errorHandler.bind(null, fileName));
  }, errorHandler.bind(null, fileName));
}

function readFromFile(fileName, cb) {
  var pathToFile = cordova.file.dataDirectory + fileName;
  window.resolveLocalFileSystemURL(pathToFile, function (fileEntry) {
    fileEntry.file(function (file) {
      var reader = new FileReader();

      reader.onloadend = function (e) {
        cb(this.result);
      };

      reader.readAsText(file);
    }, errorHandler.bind(null, fileName));
  }, errorHandler.bind(null, fileName));
}

var errorHandler = function (fileName, e) {
  var msg = '';

  switch (e.code) {
    case FileError.QUOTA_EXCEEDED_ERR:
      msg = 'Storage quota exceeded';
      break;
    case FileError.NOT_FOUND_ERR:
      msg = 'File not found';
      writeToFile('log.txt');
      break;
    case FileError.SECURITY_ERR:
      msg = 'Security error';
      break;
    case FileError.INVALID_MODIFICATION_ERR:
      msg = 'Invalid modification';
      break;
    case FileError.INVALID_STATE_ERR:
      msg = 'Invalid state';
      break;
    default:
      msg = 'Unknown error';
      break;
  }

  console.log('Error (' + fileName + '): ' + msg);
}

function dec2hex(s) {
  return (s < 15.5 ? '0' : '') + Math.round(s).toString(16);
}
function hex2dec(s) {
  return parseInt(s, 16);
}

function clearLoaderOnIconLoad(id) {
  if (document.getElementById(id)) {
    setTimeout(function () {
      document.getElementById(id).style.backgroundImage = 'none';
    }, 0);
  }
}


function base32tohex(base32) {
  var base32chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567";
  var bits = "";
  var hex = "";

  for (var i = 0; i < base32.length; i++) {
    var val = base32chars.indexOf(base32.charAt(i).toUpperCase());
    bits += leftpad(val.toString(2), 5, '0');
  }

  for (var i = 0; i + 4 <= bits.length; i += 4) {
    var chunk = bits.substr(i, 4);
    hex = hex + parseInt(chunk, 2).toString(16);
  }
  return hex;
}
function checkConnection(onAvailable, onNotAvailable) {
  var networkState = navigator.connection.type;

  if (device.platform !== 'BrowserStand') {
    if (Connection.NONE === networkState) {
      console.log('internet connection is not available');
      onNotAvailable();
    } else {
      console.log('internet connection is available');
      onAvailable();
    }
  } else {
    console.log('internet connection is available');
    onAvailable();
  }
}

function leftpad(str, len, pad) {
  if (len + 1 >= str.length) {
    str = Array(len + 1 - str.length).join(pad) + str;
  }
  return str;
}

function updateOtp(deviceId, otpTime) {
  var base = base32.encode(deviceId);
  var key = base32tohex(base);
  var epoch = Math.round(otpTime / 1000);
  var time = leftpad(dec2hex(Math.floor(epoch / 30)), 16, '0');

  var shaObj = new jsSHA("SHA-1", "HEX");
  shaObj.setHMACKey(key, "HEX");
  shaObj.update(time);
  var hmac = shaObj.getHMAC("HEX");

  if (hmac == 'KEY MUST BE IN BYTE INCREMENTS') {
    console.log(hmac);
  } else {
    var offset = hex2dec(hmac.substring(hmac.length - 1));
  }

  var otp = (hex2dec(hmac.substr(offset * 2, 8)) & hex2dec('7fffffff')) + '';
  otp = (otp).substr(otp.length - 6, 6);
  return otp;
}

function codeCheckLuna(number) {
  var sum = 0;
  for (var i = 0; i < number.length; i++) {
    var digit = parseInt(number.substring(i, (i + 1)));
    if ((i % 2) == 0) {
      digit = digit * 2;
      if (digit > 9) {
        digit = (digit / 10) + (digit % 10);
      }
    }
    sum += digit;
  }

  var mod = parseInt(sum % 10);
  return ((mod == 0) ? 0 : 10 - mod);
}

function getLuhnRemainder(value) {
  const CHARCODE_0 = '0'.charCodeAt(0);
  const MAPPING_EVEN = [0, 2, 4, 6, 8, 1, 3, 5, 7, 9];

  var length = value.length;
  var accumulator = 0;
  var bit = 0;

  while (length-- > 0) {
    accumulator += (bit ^= 1) ? value.charCodeAt(length) -
      CHARCODE_0 : MAPPING_EVEN[value.charCodeAt(length) - CHARCODE_0];
  }
  return accumulator % 10;
}

function generateLuhn(value) {
  return ((10 - getLuhnRemainder(value + '0')) % 10).toString();
}

function noInternetFingerPrint() {

  fingerPrintStop();

  if (device.platform === 'Android')
    showConfirmComponent("Интернет-соединение отсутствует.\nПерейти в офлайн режим ?", 'internet');
  else {
    showAlertComponent("Интернет-соединение отсутствует. Проверьте подключение.");
  }
}

function enterFalse() {
  enter(false);
}

function qrCodeScanner(scope) {
  cordova.plugins.barcodeScanner.scan(
    function (result) {
      console.log('QR RESULT', result)

      qrScaner.qrInited = false;
      console.log("qrInited success false");

      var string = result.text;
      if (string.indexOf('click.uz') != -1) {

        string = string.split('?')[1]
        string = string.split('&')
        var id = '';
        var rkId = '';
        var rkAmount = '';
        var rkOrder = '';
        for (var i in string) {
          if (string[i].split('=')[0] == 'id') {
            id = string[i].split('=')[1];
            console.log('ID', id)
          }
        }

        if (!id) {
          console.log('string', string)
          try {
            var decodeString = atob(string)
          }
          catch (e) {
            console.log(e)
          }
          console.log("DECODED STRING", decodeString)
          var splitedArray = decodeString.split('&');
          for (var j in splitedArray) {
            if (splitedArray[j].split("=")[0] == 'id')
              id = splitedArray[j].split("=")[1]

            if (splitedArray[j].split("=")[0] == 'amount')
              rkAmount = splitedArray[j].split("=")[1]

            if (splitedArray[j].split("=")[0] == 'order_id')
              rkOrder = splitedArray[j].split("=")[1]
          }

          console.log('id', id)
          console.log('rkAmount', rkAmount)
          console.log('rkOrder', rkOrder)
        }
      } else if (string.indexOf('jowi') != -1) {
        var jowi_id = string.split("jowi:")[1];
      }
      if (id || jowi_id) {
        if (modeOfApp.offlineMode) {
          if (jowi_id) {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: window.languages.QrJowiOfflineConstraintText
            });
          }
          else {
            riotTags.innerHTML = "<view-qr>";
            riot.mount('view-qr', {
              "id": id,
              "image": "resources/icons/ViewPay/logo_indoor.png"
            });
          }
        }
        else {
          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var sessionKey = info.session_key;
          var input = {
            phone_num: phoneNumber,
            session_key: sessionKey
          }
          if (id) {
            input.service_id = id;
          } else if (jowi_id) {
            input.jowi_id = jowi_id;
          }
          console.log("input=", input);

          window.startSpinner();

          window.api.call({
            method: 'get.indoor.service',
            input: input,

            scope: this,

            onSuccess: function (result) {
              window.clearTimeout(timeOutTimerThree);
              if (result[0][0].error == 0) {
                if (result[1] && result[1][0]) {

                  result[1][0].fromQrScan = true;

                  if (id) {
                    if (rkAmount) {
                      result[1][0].rk_amount = rkAmount
                    }
                    if (rkOrder) {
                      result[1][0].rk_order = rkOrder
                    }
                    riotTags.innerHTML = "<view-qr>";
                    riot.mount('view-qr', result[1][0]);
                  } else if (jowi_id) {

                    result[1][0].jowi_id = jowi_id;

                    riotTags.innerHTML = "<view-qr-info>";
                    riot.mount('view-qr-info', result[1][0]);
                  }

                }
              }
              else {
//                          if (result[0][0].error == -202) {
//                            if (result[0][0].error_url) {
//
//                              window.checkShowingComponent = scope;
//                              scope.update();
//                              iFrameExternalUrlId.src = result[0][0].error_url;
//                              return
//                            }
//                          }

                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote
                });
                scope.update();
              }
            },

            onFail: function (api_status, api_status_message, data) {
              window.clearTimeout(timeOutTimerThree);
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            },
            onTimeOut: function () {
              timeOutTimerThree = setTimeout(function () {
                window.stopSpinner();
              }, 15000);
              console.log('creating timeOut', timeOutTimerThree);
            },
            onEmergencyStop: function () {
              console.log('Clearing timer emergencyStop', timeOutTimerThree);
              window.clearTimeout(timeOutTimerThree);
            }
          }, 15000);
        }
      }

    },
    function (error) {

      qrScaner.qrInited = false;
      console.log("qrInited error false");

      scope.clickPinError = false;
      scope.errorNote = "Отсутствует доступ";

      window.common.alert.show("componentAlertId", {
        parent: scope,
        clickpinerror: scope.clickPinError,
        errornote: scope.errorNote
      });
      scope.update();
    },
    {
      preferFrontCamera: false, // iOS and Android
      showFlipCameraButton: false, // iOS and Android
      showTorchButton: true, // iOS and Android
      torchOn: false, // Android, launch with the torch switched on (if available)
      prompt: window.languages.ViewQrLabelOnScanner, // Android
      resultDisplayDuration: 500, // Android, display scanned text for X ms. 0 suppresses it entirely, default 1500
      formats: "QR_CODE", // default: all but PDF_417 and RSS_EXPANDED
      orientation: "portrait", // Android only (portrait|landscape), default unset so it rotates with the device
      disableAnimations: true, // iOS
      disableSuccessBeep: false // iOS
    }
  );
}

function compareImages(url_a, url_b) {
  var a = new Image(),
    b = new Image();
  a.src = url_a;
  b.src = url_b;

  // might need to wait until a and b have actually loaded, ignoring this for now
  var a_base64 = getBase64Image(a),
    b_base64 = getBase64Image(b);

  if (a_base64 === b_base64) {
    // they are identical
    console.log('images are identical');
  }
  else {
    // you can probably guess what this means
    console.log('images are not identical');
  }

}

function getBase64Image(img) {
  // Create an empty canvas element
  var canvas = document.createElement("canvas");
  canvas.width = img.width;
  canvas.height = img.height;

  // Copy the image contents to the canvas
  var ctx = canvas.getContext("2d");
  ctx.drawImage(img, 0, 0);

  // Get the data-URL formatted image
  // Firefox supports PNG and JPEG. You could check img.src to
  // guess the original format, but be aware the using "image/jpg"
  // will re-encode the image.
  var dataURL = canvas.toDataURL("image/png");

  return dataURL.replace(/^data:image\/(png|jpg);base64,/, "");
}

function addPaymentToFavorites(params, service, ussdQuery, scope) {
  var favoritePaymentsList, favoritePaymentsListForApi;
  var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
  var phoneNumber = localStorage.getItem('click_client_phoneNumber');
  if (loginInfo)
    var sessionKey = loginInfo.session_key;

  var id = Math.floor((Math.random() * 1000000) + 1);

  favoritePaymentsList = localStorage.getItem('favoritePaymentsList') ? JSON.parse(localStorage.getItem('favoritePaymentsList')) : [];
  favoritePaymentsListForApi = localStorage.getItem('favoritePaymentsListForApi') ? JSON.parse(localStorage.getItem('favoritePaymentsListForApi')) : [];


  if (favoritePaymentsListForApi.length != favoritePaymentsList.length) {
    favoritePaymentsListForApi = [];
    for (var i in favoritePaymentsList) {
      if (favoritePaymentsList[i].params.transactionId)
        favoritePaymentsList[i].params.transactionId = null;
      console.log("fav transaction id=", favoritePaymentsList[i].params.transactionId);
      favoritePaymentsListForApi.push({
        "id": favoritePaymentsList[i].id,
        "type": 1,
        "body": JSON.stringify(favoritePaymentsList[i])
      })
    }
  }

  var newfavorite = {
    "params": params,
    "service": service,
    "ussd": ussdQuery,
    "id": id
  };

  favoritePaymentsList.push(newfavorite);
  favoritePaymentsListForApi.push({
    "id": id,
    "type": 1,
    "body": JSON.stringify(newfavorite)
  });

  localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
  localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));


  window.api.call({
    method: 'add.favourite',
    input: {
      session_key: sessionKey,
      phone_num: phoneNumber,
      wishlist_data: favoritePaymentsListForApi
    },

    scope: this,

    onSuccess: function (result) {

      if (result[0][0].error == 0) {

        console.log("SUCCESSFULLY ADDED")

      }
      else {

        window.common.alert.show("componentAlertId", {
          parent: scope,
          errornote: result[0][0].error_note
        });

        scope.update();
        console.log(result[0][0].error_note);
      }
    },

    onFail: function (api_status, api_status_message, data) {
      console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
      console.error(data);
    }
  });
}

function editFavoritePayment(params, favoriteId, scope) {

  var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
  var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));
  var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
  var phoneNumber = localStorage.getItem('click_client_phoneNumber');
  if (loginInfo)
    var sessionKey = loginInfo.session_key;

  for (var i in favoritePaymentsList) {
    if (favoritePaymentsList[i].id == favoriteId) {
      favoritePaymentsList[i].params = params;

      var editedfavorite = {
        "id": favoritePaymentsList[i].id,
        "type": 1,
        "body": JSON.stringify(favoritePaymentsList[i])
      };

      for (var j in favoritePaymentsListForApi) {
        if (favoritePaymentsListForApi[i].id == favoriteId) {
          favoritePaymentsListForApi[i] = editedfavorite;
          break;
        }
      }

      window.api.call({
        method: 'update.favourite',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          wishlist_data: editedfavorite
        },

        scope: this,

        onSuccess: function (result) {

          if (result[0][0].error == 0) {

            console.log("SUCCESSFULLY edited")

          }
          else {

            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: result[0][0].error_note
            });

            scope.update();
            console.log(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));

      break;

    }
  }
}

function openPayServiceById(id, opts) {
  var servicesMap = scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);

  console.log("openPayServiceById method");
  if (servicesMap[id] && servicesMap[id][0]) {
    console.log("form type=", servicesMap[id][0].form_type, servicesMap[id][0]);
    switch (servicesMap[id][0].form_type) {
      case 1: {
        riotTags.innerHTML = "<view-formtype-one>";
        riot.mount("view-formtype-one", opts);
        break;
      }
      case 2: {
        riotTags.innerHTML = "<view-formtype-two>";
        riot.mount("view-formtype-two", opts);
        break;
      }
      case 3: {
        riotTags.innerHTML = "<view-formtype-three>";
        riot.mount("view-formtype-three", opts);
        break;
      }
      case 4: {
        riotTags.innerHTML = "<view-formtype-four>";
        riot.mount("view-formtype-four", opts);
        break;
      }
      case 5: {
        riotTags.innerHTML = "<view-formtype-five>";
        riot.mount("view-formtype-five", opts);
        break;
      }
      case 6: {
        riotTags.innerHTML = "<view-formtype-six>";
        riot.mount("view-formtype-six", opts);
        break;
      }
      case 7: {
        riotTags.innerHTML = "<view-formtype-seven>";
        riot.mount("view-formtype-seven", opts);
        break;
      }
      default: {
        riotTags.innerHTML = "<view-service-page-new>";
        riot.mount("view-service-page-new", opts);
        break;
      }
    }
  }
  else if (id.indexOf('mynumber') != -1) {
    console.log("my number mode");
    riotTags.innerHTML = "<view-formtype-mynumber>";
    riot.mount("view-formtype-mynumber", opts);
  }
  else {
    console.log(" else mode");
    riotTags.innerHTML = "<view-service-page-new>";
    riot.mount("view-service-page-new", opts);

  }
}

function colorFieldGlobal(fieldId, fieldTitleId) {
  window[fieldId].style.borderBottom = 3 * widthK + 'px solid #01cfff';
  window[fieldTitleId].style.color = '#01cfff';
}

function blurFieldGlobal(fieldId, fieldTitleId) {
  window[fieldId].style.borderBottom = 3 * widthK + 'px solid lightgrey';
  window[fieldTitleId].style.color = 'gray';
}

function focusFieldGlobal(fieldId) {
  if (window[fieldId]) {
    if (device.platform == 'iOS') {
      window[fieldId].autofocus;
      window[fieldId].focus();
    } else {
      setTimeout(function () {
        window[fieldId].focus();
      }, 0);
    }
  }
}
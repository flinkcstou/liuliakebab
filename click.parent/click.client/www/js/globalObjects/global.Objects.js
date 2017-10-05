window.viewMainPage = {};
viewMainPage.myCards = false;

window.onBackParams = {};
onBackParams.opts = null;


window.viewMyCards = {};
viewMyCards.check = false;
viewMyCards.chosenCardId = '';


window.viewAuthorization = {};
viewAuthorization.check = false;

window.isConnected = false;

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

window.componentMenu = {};
componentMenu.check = false;

window.componentReportFilter = {};
componentReportFilter.today = 1;
componentReportFilter.yesterday = 2;
componentReportFilter.currentWeek = 3;
componentReportFilter.pastWeek = 4;
componentReportFilter.currentMonth = 5;
componentReportFilter.pastMonth = 6;

window.checkShowingComponent = null;

window.pickContactFromNativeChecker = false;

window.News = {};
window.News.newsCounter = 0;

window.fingerPrint = {};
window.fingerPrint.check = false;
window.fingerPrint.fingerPrintInitialize = false;


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

window.amountTransform = function (amount) {
  if (amount) {
    amount = amount.toString()
  } else {
    return amount
  }
  if (amount.length == 1 && amount == 0) {
    return '';
  }

  amount = amount.replace(new RegExp('[^0-9.]', 'g'), '');
  var newAmount = '';

  if (amount.includes('.')) {
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
    riot.mount("view-main-page", {view: "news"});
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
}

/////////


window.getAccount = function (checkSessionKey, firstEnter) {

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
      var lengthOfPin = firstPinInputId.value.length;
      var compareLength = window.inputVerification.spaceDeleter(firstPinInputId.value);
      console.log("First enter in account");
    }

    if (firstEnter && (lengthOfPin != compareLength.length || lengthOfPin != 5)) {
      riotTags.innerHTML = "<view-pin-code>";
      riot.mount('view-pin-code', ['view-authorization']);
    }
    else if (!localStorage.getItem("click_client_accountInfo")) {
      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');
      //riot.unmount()
    }
    else {
      if (!JSON.parse(localStorage.getItem('onResume')) && !JSON.parse(localStorage.getItem('session_broken')) && !JSON.parse(sessionStorage.getItem("push_news"))) {
        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
      }
      else {
        if (localStorage.getItem('settings_block') || localStorage.getItem('session_broken') || sessionStorage.getItem("push_news")) {
          if (JSON.parse(localStorage.getItem('settings_block')) === true || JSON.parse(localStorage.getItem('session_broken')) === true || JSON.parse(sessionStorage.getItem("push_news")) === true) {
            if (history.arrayOfHistory) {
              if (history.arrayOfHistory[history.arrayOfHistory.length - 1]) {
                if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view == 'view-news') {
                  this.riotTags.innerHTML = "<view-main-page>";
                  riot.mount("view-main-page");
                }
                else {
                  this.riotTags.innerHTML = "<" + history.arrayOfHistory[history.arrayOfHistory.length - 1].view + ">";
                  riot.mount(history.arrayOfHistory[history.arrayOfHistory.length - 1].view, history.arrayOfHistory[history.arrayOfHistory.length - 1].params);
                }

                if (device.platform != 'BrowserStand')
                  StatusBar.backgroundColorByHexString("#00a8f1");

                if (JSON.parse(localStorage.getItem('settings_block')) === true) {
                  localStorage.setItem('onResume', false);
                }
                else {
                  if (JSON.parse(localStorage.getItem('session_broken')) === true) {
                    localStorage.setItem('session_broken', false);
                  }
                  else {
                    if (JSON.parse(sessionStorage.getItem("push_news")) === true) {
                      sessionStorage.setItem("push_news", false)
                    }
                  }
                }
                return
              }
            }
          }
          else {
            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
          }
        }
        else {
          this.riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
        }
      }
    }

    if ((!localStorage.getItem("click_client_payCategoryList") || info.update_categories) && modeOfApp.onlineMode) {

      var categoryList = [];
      var categoryNamesMap = {};
      window.api.call({
        method: 'get.service.category.list',
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

  if (device.platform != 'BrowserStand') {
    console.log("Spinner Stop View Authorization");
    SpinnerPlugin.activityStop();
  }
}


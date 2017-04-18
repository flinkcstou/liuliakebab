window.viewMainPage = {};
viewMainPage.myCards = false;


window.viewMyCards = {};
viewMyCards.check = false;
viewMyCards.chosenCardId = '';


window.viewAuthorization = {};
viewAuthorization.check = false;

window.isConnected = true;

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

window.pickContactFromNativeChecker = false;

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
  if (amount.length == 1 && amount == 0) {
    return '';
  }


  amount = amount.replace(new RegExp('[^0-9]', 'g'), '');
  var j = 0;
  var newAmount = '';
  for (var i = amount.length - 1; i >= 0; i--) {
    j++;
    newAmount += amount[i];
    if (j % 3 == 0 && i != 0) {
      newAmount += ' ';
    }
  }

  return newAmount.split("").reverse().join("");
}

window.inputVerification = {};

window.inputVerification.spaceDeleter = function (data) {

  data = data.replace(new RegExp('[^0-9]', 'g'), '');
  return data.split(",").join();
}

window.inputVerification.telVerification = function (phoneNumber) {

  phoneNumber = phoneNumber.replace(new RegExp('[^0-9]', 'g'), '');
  return phoneNumber.split(",").join();
}

window.inputVerification.dateVerification = function (date) {

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
}

window.pushNotificationInitialize = function () {
  if (device.platform != 'BrowserStand')
    window.FirebasePlugin.getToken(function (token) {
      // save this server-side and use it to push notifications to this device


      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var tokenOfApp = localStorage.getItem("click_client_token");
      var signString = hex_md5(phoneNumber.substring(0, 5) + token + phoneNumber.substring(phoneNumber.length - 4, phoneNumber.length))

      console.log('token', token)
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
            console.log("PUSH", result);
            localStorage.setItem('push_registered', token)
          }
          else
            alert(result[0][0].error_note);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
      console.log('TOKEN PUSH', token)
      console.log(token);
    }, function (error) {
      console.error(error);
    });
}

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

              console.log("Invoice", invoice);
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
              riotTags.innerHTML = "<view-report-service>";
              riot.mount("view-report-service", result[1][i]);
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

    var notification = sessionStorage.getItem("notification")
    notification = JSON.parse(notification);

    if (notification) {

      window.pushNotificationActions[notification.action](params);
    }
  }
};


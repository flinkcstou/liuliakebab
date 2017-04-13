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

window.componentMenu = {}
componentMenu.checkOpen = false;

window.modeOfApp = {};
modeOfApp.onlineMode = true;
modeOfApp.offlineMode = false;

window.componentDeleteCard = {};

window.invoiceActions = {};
invoiceActions.ACCEPT = 1;
invoiceActions.DECLINE = 2;

window.input_codes = {};
input_codes.BACKSPACE_CODE = 8

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


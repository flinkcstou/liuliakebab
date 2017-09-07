<view-qr-pay-confirm class="view-pay-confirm riot-tags-main-container">

  <div class="qr-pay-page-title" style="border-style: none;">
    <p class="qr-servicepage-title">{titleName}</p>
    <p class="qr-servicepage-category-field">{categoryName}</p>
    <div ontouchend="goToBack()"
         class="qr-servicepage-button-back">
    </div>
    <div type="button" class="qr-servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="qr-payconfirm-body-container">
    <div class="qr-payconfirm-data-container">
      <div style="display: none" class="qr-payconfirm-phone-field" if="{formType!=2}">
        <p class="qr-payconfirm-text-field">{firstFieldTitle}</p>
        <p class="qr-payconfirm-phone-input">{firstFieldText}</p>
      </div>
      <div class="qr-payconfirm-field">
        <p class="qr-payconfirm-text-field">{window.languages.ViewPayConfirmAmountOfPay}</p>
        <p class="qr-payconfirm-phone-input">{amountTextCopy} {currency}</p>
      </div>
      <div class="qr-payconfirm-field">
        <p class="qr-payconfirm-text-field">{window.languages.ViewPayConfirmCategory}</p>
        <p class="qr-payconfirm-phone-input" style="text-decoration: underline">
          {categoryName}</p>
      </div>
      <div class="qr-payconfirm-card-field" if="{cardOrFriendBool}">
        <div class="qr-payconfirm-card-info-container">
          <p class="qr-payconfirm-text-one">{window.languages.ViewPayConfirmPayFromCard}</p>
          <p class="qr-payconfirm-text-two">{cardName}</p>
          <p class="qr-payconfirm-detail-text">{numberPartOne} **** {numberPartTwo}</p>
          <p class="qr-payconfirm-detail-text">{window.languages.ViewPayConfirmAvailable}:{salary} {currency}</p>
        </div>
        <div class="qr-payconfirm-card-logo-container"
             style="background-image: url({url})">
        </div>
      </div>
      <div class="qr-payconfirm-card-field" if="{!cardOrFriendBool}">
        <div class="qr-payconfirm-card-info-container">
          <p class="qr-payconfirm-text-one">{window.languages.ViewPayConfirmFriendHelp}</p>
          <p class="qr-payconfirm-text-two">{friendName}</p>
          <p class="qr-payconfirm-detail-text">+{friendNumber}</p>
        </div>
        <div class="qr-payconfirm-chosen-friend-photo" style="background-image: url({friendPhoto})">
          {friendFirstLetterOfName}
        </div>
      </div>

    </div>
    <div class="qr-payconfirm-bottom-container">
      <button id="qrPayButtonId" class="qr-payconfirm-button-enter" ontouchstart="payServiceStart()"
              ontouchend="payServiceEnd()">
        {window.languages.ViewPayConfirmPay}
      </button>
    </div>
  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{operationMessage}"
                     viewpage="{viewPage}" step_amount="{3}"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{window.languages.ComponentUnsuccessMessagePart3ForPay}"
                       step_amount="{0}"></component-unsuccess>

  <component-in-processing id="componentInProcessingId"
                           operationmessagepartone="{window.languages.ComponentInProcessingPartOneForPay}"
                           operationmessageparttwo="{window.languages.ComponentInProcessingPartTwo}"
                           step_amount="{3}"></component-in-processing>


  <script>

    console.log('OPTS QR CONFIRM', opts)
    var scope = this;
    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    }

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-qr-pay-confirm') {
      history.arrayOfHistory.push(
        {
          "view": 'view-qr-pay-confirm',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    this.viewPage = 'view-main-page';

    this.on('mount', function () {

    });


    var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    scope.cardOrFriendBool = opts[0];
    scope.titleName = opts[2].name
    scope.serviceIcon = opts[2].image
    scope.categoryName = opts[2].name

    scope.update()
    console.log(opts[0])
    //
    //    if (scope.isInFavorites)
    //      this.viewPage = 'view-main-page';
    //    else this.viewPage = 'view-pay';
    scope.amountTextCopy = window.amountTransform(opts[2].qrSum);

    if (scope.cardOrFriendBool) {
      var chosenCardId = opts[1];
      if (cardsArray[chosenCardId]) {
        scope.cardName = cardsArray[chosenCardId].name;
        scope.numberPartOne = cardsArray[chosenCardId].numberPartOne;
        scope.numberPartTwo = cardsArray[chosenCardId].numberPartTwo;
        scope.salary = cardsArray[chosenCardId].salary;
        scope.currency = cardsArray[chosenCardId].currency;
        scope.url = cardsArray[chosenCardId].url;
      }
    }
    else {
      var friendForHelp = opts[1];
      scope.friendName = friendForHelp.name;
      scope.friendNumber = friendForHelp.number;
      scope.friendFirstLetterOfName = friendForHelp.firstLetterOfName;
      scope.friendPhoto = friendForHelp.photo;

    }
    scope.update();


    if (scope.cardOrFriendBool) {
      var chosenCardId = opts[1];
      if (cardsArray[chosenCardId]) {
        scope.cardName = cardsArray[chosenCardId].name;
        scope.numberPartOne = cardsArray[chosenCardId].numberPartOne;
        scope.numberPartTwo = cardsArray[chosenCardId].numberPartTwo;
        scope.salary = cardsArray[chosenCardId].salary;
        scope.currency = cardsArray[chosenCardId].currency;
        scope.url = cardsArray[chosenCardId].url;
      }
    }
    else {
      if (viewServicePinCards.friendHelpPaymentMode) {

        scope.friendHelpBool = true;
        if (viewServicePinCards.chosenFriendForHelp) {
          scope.firstLetterOfName = viewServicePinCards.chosenFriendForHelp.firstLetterOfName;
          scope.fName = viewServicePinCards.chosenFriendForHelp.name;
          scope.phoneNumber = viewServicePinCards.chosenFriendForHelp.number;
          scope.photo = viewServicePinCards.chosenFriendForHelp.photo;
        }
        scope.update();
      } else {

        scope.friendHelpBool = false;
      }

    }
    scope.update();

    var qrPayButtonStartX, qrPayButtonEndX, qrPayButtonStartY,
      qrPayButtonEndY;

    payServiceStart = function () {

      qrPayButtonStartX = event.changedTouches[0].pageX;
      qrPayButtonStartY = event.changedTouches[0].pageY;

      qrPayButtonId.style.webkitTransform = 'scale(0.8)'
    }

    payServiceEnd = function () {

      qrPayButtonEndX = event.changedTouches[0].pageX;
      qrPayButtonEndY = event.changedTouches[0].pageY;

      qrPayButtonId.style.webkitTransform = 'scale(1)'

      if (Math.abs(qrPayButtonStartX - qrPayButtonEndX) <= 20 && Math.abs(qrPayButtonStartY - qrPayButtonEndY) <= 20) {

        var date = parseInt(Date.now() / 1000);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        var serviceId = opts[2].id;
        var amount = opts[2].qrSum;
        var transactionId = opts[2].transactionId;
        var accountId;
        var friendPhone;

        // friend help or own payment
        if (scope.cardOrFriendBool) {
          accountId = chosenCardId;
          friendPhone = 0;
          scope.operationMessage = window.languages.ComponentSuccessMessageForPay;
        }
        else {
          accountId = 0;
          friendPhone = scope.friendNumber;
          scope.operationMessage = window.languages.ComponentSuccessMessageForPayFriendHelp;
        }
        console.log("accountId", accountId);
        console.log("friendPhone", friendPhone);
        var payment_data = {"transaction_id": transactionId, "is_indoor": 1}

        var inputObject = {};
        if (opts[2].rk_order) {

          payment_data.value = opts[2].rk_order;
        }

        inputObject = {
          session_key: sessionKey,
          phone_num: phoneNumber,
          service_id: Number(serviceId),
          account_id: Number(accountId),
          amount: Number(amount),
          payment_data: payment_data,
          datetime: date,
          friend_phone: friendPhone
        };

        if (device.platform != 'BrowserStand') {
          var options = {dimBackground: true};

          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
            console.log("Started");
          }, function () {
            console.log("closed");
          });
        }

        console.log("inputObject", inputObject)

        var answerFromServer = false;

        window.api.call({
          method: 'app.payment',
          input: inputObject,

          scope: this,

          onSuccess: function (result) {

            answerFromServer = true;

            console.log('RESULT QR QR', result)

            if (result[0][0].error == 0) {
              if (result[1])
                if (!result[1][0].payment_id && result[1][0].invoice_id) {
                  console.log("result of APP.PAYMENT 1", result);
                  viewServicePage.phoneText = null;
                  viewServicePage.amountText = null;

                  scope.operationMessage = 'Оплата QR прошла успешно'
                  viewServicePinCards.friendHelpPaymentMode = false;

                  scope.update();
                  componentSuccessId.style.display = 'block';
                } else if (result[1][0].payment_id && !result[1][0].invoice_id) {

                  if (device.platform != 'BrowserStand') {
                    var options = {dimBackground: true};

                    SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                      console.log("Started");
                    }, function () {
                      console.log("closed");
                    });
                  }

                  setTimeout(function () {
                    checkQrPaymentStatus(result[1][0].payment_id);
                  }, 2000);

                }
            }
            else {
              console.log("result of APP.PAYMENT 3", result);
              scope.update();
              componentUnsuccessId.style.display = 'block';
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });

        setTimeout(function () {
          if (!answerFromServer) {
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            return
          }
        }, 20000)
      }

    }

    var qrCounter = 0;
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    function checkQrPaymentStatus(payment_id) {

      console.log("check transfer status");

      window.api.call({
        method: 'get.payment',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          payment_id: payment_id
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0 && result[1][0]) {


            if (result[1][0].state == -1) {

              if (device.platform != 'BrowserStand') {
                SpinnerPlugin.activityStop();
              }
              componentUnsuccessId.style.display = 'block';
              riot.update()


            } else if (result[1][0].state == 2) {

              if (device.platform != 'BrowserStand') {
                SpinnerPlugin.activityStop();
              }

              window.updateBalanceGlobalFunction();
              console.log("result of APP.PAYMENT 1", result);
              viewServicePage.phoneText = null;
              viewServicePage.amountText = null;

              scope.operationMessage = 'Оплата QR прошла успешно'
              viewServicePinCards.friendHelpPaymentMode = false;

              scope.update();
              componentSuccessId.style.display = 'block';


            } else if (result[1][0].state == 1) {

              qrCounter++;

              if (qrCounter < 5) {

                setTimeout(function () {
                  checkQrPaymentStatus(result[1][0].payment_id);
                }, 2000);

              } else {

                if (device.platform != 'BrowserStand') {
                  SpinnerPlugin.activityStop();
                }

                componentInProcessingId.style.display = 'block';
              }

            }
            window.api.spinnerOn = false;

          }
          else {
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            componentUnsuccessId.style.display = 'block';
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


  </script>
</view-qr-pay-confirm>

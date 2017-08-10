<view-pay-confirm-new class="view-pay-confirm riot-tags-main-container">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts.mode!='ADDAUTOPAY', autopay-method-page-title:opts.mode=='ADDAUTOPAY'}">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div id="payconfirmButtonId" ontouchend="goToBack()" ontouchstart="onTouchStartOfBack()"
         class="{servicepage-button-back:opts.mode!='ADDAUTOPAY', autopay-method-back-button:opts.mode=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="payconfirm-body-container">
    <div class="payconfirm-data-container">
      <div class="payconfirm-phone-field" if="{formType!=2}">
        <p class="payconfirm-text-field">{firstFieldTitle}</p>
        <p class="payconfirm-phone-input">{firstFieldText}</p>
      </div>
      <div class="payconfirm-amount-field">
        <p class="payconfirm-amount-text-field">{window.languages.ViewPayConfirmAmountOfPay}</p>
        <p class="payconfirm-amount-value">{amountTextCopy} {currency}</p>
        <p if="{opts.tax}" class="payconfirm-amount-tax-field">{window.languages.ViewServicePageAmountTaxText}
          {opts.tax}
          {window.languages.Currency}</p>

        <p if="{opts.cost > 1}" class="payconfirm-amount-count-field">{opts.lang_amount_title}:
          {window.amountTransform(opts.amountWithoutSpace)}</p>
      </div>
      <div class="payconfirm-field">
        <p class="payconfirm-text-field">{(opts.mode=='ADDAUTOPAY')?
          (window.languages.ViewAutoPayConditionFieldText):(window.languages.ViewPayConfirmCategory)}</p>
        <p class="{payconfirm-category-input:opts.mode!='ADDAUTOPAY',payconfirm-phone-input:opts.mode=='ADDAUTOPAY'}">
          {(opts.mode=='ADDAUTOPAY')?
          (autoPayConditionText):(categoryName)}</p>
      </div>
      <div class="payconfirm-card-field" if="{cardOrFriendBool}">
        <div class="payconfirm-card-info-container">
          <p class="payconfirm-text-one">{window.languages.ViewPayConfirmPayFromCard}</p>
          <p class="payconfirm-text-two">{cardName}</p>
          <p class="payconfirm-detail-text">{numberPartOne} **** {numberPartTwo}</p>
          <p class="payconfirm-detail-text">{window.languages.ViewPayConfirmAvailable}:{salary} {currency}</p>
        </div>
        <div class="payconfirm-card-logo-container"
             style="background-image: url({url})">
        </div>
      </div>
      <div class="payconfirm-card-field" if="{!cardOrFriendBool}">
        <div class="payconfirm-card-info-container">
          <p class="payconfirm-text-one">{window.languages.ViewPayConfirmFriendHelp}</p>
          <p class="payconfirm-text-two">{friendName}</p>
          <p class="payconfirm-detail-text">+{friendNumber}</p>
        </div>
        <div class="payconfirm-chosen-friend-photo" style="background-image: url({friendPhoto})">
          {friendFirstLetterOfName}
        </div>
      </div>

    </div>
    <div class="payconfirm-bottom-container">
      <div class="payconfirm-action-autopay-container" if="{opts.mode!='ADDAUTOPAY'}">
        <div
          class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-favorite-center:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-one" if="{!isInFavorites}"
               style="background-image: url('resources/icons/ViewService/addfavorite.png');"
               ontouchstart="onTouchStartOfFavorite()"
               ontouchend="addToFavoritesinPayConfirm()"></div>
          <div class="payconfirm-action-text" ontouchstart="onTouchStartOfFavorite()"
               ontouchend="addToFavoritesinPayConfirm()" if="{!isInFavorites}">
            {window.languages.ViewPayConfirmAddToFavorites}
          </div>
          <div class="payconfirm-action-icon-one" if="{isInFavorites}"
               style="background-image: url('resources/icons/ViewService/addedfavorite.png');"
               ontouchstart="onTouchStartOfFavorite()" ontouchend="removeFromFavorites()"></div>
          <div class="payconfirm-action-text" ontouchstart="onTouchStartOfFavorite()" ontouchend="removeFromFavorites()"
               if="{isInFavorites}">
            {window.languages.ViewPayConfirmRemoveFromFavorites}
          </div>
        </div>
        <div id="addToAutoPayContainerId"
             class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-autopay-none:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-two"
               style="background-image: url('resources/icons/ViewService/addautopay.png');"
               ontouchstart="onTouchStartOfAutoPay()" ontouchend="addToAutoPay()"></div>
          <div class="payconfirm-action-text" ontouchstart="onTouchStartOfAutoPay()" ontouchend="addToAutoPay()">
            {window.languages.ViewPayConfirmAddToAutoPay}
          </div>
        </div>
      </div>
      <button id="autoPayButtonId"
              class="{payconfirm-button-enter:opts.mode!='ADDAUTOPAY', autopay-button:opts.mode=='ADDAUTOPAY'}"
              ontouchend="onTouchEndOfEnterPay()" ontouchstart="onTouchStartOfEnterPay()" if="{!autoPayDelete}">
        {(opts.mode=='ADDAUTOPAY')? window.languages.ViewAutoPayCreateButtonText : window.languages.ViewPayConfirmPay}
      </button>
      <button id="deleteAutoPayButtonId" class="payconfirm-button-delete" ontouchend="deleteAutoPay()"
              ontouchstart="onTouchStartOfAutoPay()"
              if="{autoPayDelete && opts.mode=='ADDAUTOPAY'}">
        {window.languages.ViewAutoPayDeleteButtonText}
      </button>

    </div>
  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{operationMessage}"
                     goback="{goBack}"
                     viewpage="{viewPage}" step_amount="{stepAmount}"></component-success>
  <component-unsuccess id="componentUnsuccessId" viewpage="{viewPage}" step_amount="{stepErrorAmount}" goback="{goBack}"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{errorMessageFromPayment}"></component-unsuccess>

  <component-in-processing id="componentInProcessingId" viewpage="{viewPage}"
                           operationmessagepartone="{window.languages.ComponentInProcessingPartOneForPay}"
                           operationmessageparttwo="{window.languages.ComponentInProcessingPartTwo}"></component-in-processing>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>


  <script>

    console.log("OPTS PAYCONFIRM NEW", opts)

    var scope = this;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pay-confirm-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-pay-confirm-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var backStartY, backStartX, backEndY, backEndX;

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      payconfirmButtonId.style.webkitTransform = 'scale(0.7)'

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    goToBack = function () {
      event.stopPropagation();

      payconfirmButtonId.style.webkitTransform = 'scale(1)'

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        onBackKeyDown(opts);
        scope.unmount()
      }
    };


    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    var serviceId = localStorage.getItem('chosenServiceId');
    if (localStorage.getItem('settings_block_payAndTransfer'))
      var payTransferBlocked = JSON.parse(localStorage.getItem('settings_block_payAndTransfer'));
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    scope.isInFavorites = opts.isInFavorites;

    console.log('isInFavorites', opts.isInFavorites)
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.fieldArray = scope.servicesParamsMapOne[opts.chosenServiceId];

    if (opts.mode == 'ADDAUTOPAY') {
      scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
      if (scope.autoPayData.fromView == 'AFTERCREATION') {
        opts.mode = 'USUAL';
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        scope.update();
      } else {
        scope.autoPayTypeText = scope.autoPayData.title;
        scope.autoPayConditionText = scope.autoPayData.condition_text;
        scope.autoPayDelete = !scope.autoPayData.isNew;
        console.log("autoPayData=", scope.autoPayData);
      }
    }
    scope.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.cardOrFriendBool = opts.payByCard;
    scope.errorMessageFromPayment = '';

    scope.stepAmount = 3;
    scope.stepErrorAmount = 3;

    this.formType = opts.formtype;
    this.firstFieldId = opts.firstFieldId;

    this.firstFieldTitle = opts.firstFieldTitle;
    console.log("firstFieldTitle pay confirm=", this.firstFieldTitle);


    if (opts.firstFieldId == '1') {
//      console.log("TEL LENGTH VERIFICATION=", inputVerification.telLengthVerification(opts[0][2].firstFieldText, window.languages.PhoneNumberLength));
      opts.firstFieldText = inputVerification.telLengthVerification(opts.firstFieldText, window.languages.PhoneNumberLength);

      this.firstFieldText = "+" + window.languages.CodeOfCountry + opts.firstFieldText;
      var firstFieldtext = "+" + window.languages.CodeOfCountry + opts.firstFieldText;
      console.log("text=", firstFieldtext)
    }
    else {
      this.firstFieldText = opts.firstFieldText;
      var firstFieldtext = opts.firstFieldText;
      console.log("text in else=", firstFieldtext)
    }

    this.cardTypeId = opts.cardTypeId;

    this.amountText = opts.amountText;
    scope.amountTextCopy = opts.amountText;
    console.log(opts.amountText, " amounts ", this.amountText, opts.cost);

    try {
      if (opts.cost) {
        scope.amountTextCopy = window.amountTransform(window.inputVerification.spaceDeleter(opts.amountText) * opts.cost);
      }
      else {
        scope.amountTextCopy = window.amountTransform(opts.amountText);
      }
    }
    catch (e) {
      scope.amountTextCopy = opts.amountText;
    }

    scope.update(scope.amountTextCopy)

    console.log("AMOUNT", this.amountText, " scope.amountTextCopy", scope.amountTextCopy)


    //    riot.update()

    if (scope.cardOrFriendBool) {
      var chosenCardId = opts.chosenCardId;

      if (cardsArray[chosenCardId]) {
        scope.cardName = cardsArray[chosenCardId].name;
        scope.numberPartOne = cardsArray[chosenCardId].numberPartOne;
        scope.numberPartTwo = cardsArray[chosenCardId].numberPartTwo;
        scope.salary = cardsArray[chosenCardId].salary;
        scope.currency = cardsArray[chosenCardId].currency;
        scope.url = cardsArray[chosenCardId].url;
        scope.update();
      }
    }
    else {
      var friendForHelp = opts.chosenFriendForHelp;
      scope.friendName = friendForHelp.name;
      scope.friendNumber = friendForHelp.number;
      scope.friendFirstLetterOfName = friendForHelp.firstLetterOfName;
      scope.friendPhoto = friendForHelp.photo;
      for (var i in cardsArray) {
        if (cardsArray[i].default_account) {
          scope.currency = cardsArray[i].currency;
          break;
        }
      }

//      this.on('mount', function () {
//        addToAutoPayContainerId.style.display = 'none';
//      });
    }
    scope.update();


    console.log("CONFIRMED=", sessionStorage.getItem('payTransferConfirmed'))
    console.log("BLOCKED=", payTransferBlocked)

    if (payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) === true) {
      console.log("payTransferConfirmed=", sessionStorage.getItem('payTransferConfirmed'))
      payService();
      sessionStorage.setItem('payTransferConfirmed', null);
    }

    var favoriteStartY, favoriteStartX, favoriteEndY, favoriteEndX;

    scope.onTouchStartOfFavorite = onTouchStartOfFavorite = function () {
      event.stopPropagation();
      favoriteStartY = event.changedTouches[0].pageY;
      favoriteStartX = event.changedTouches[0].pageX;
    };


    addToFavoritesinPayConfirm = function () {
      event.stopPropagation();

      favoriteEndY = event.changedTouches[0].pageY;
      favoriteEndX = event.changedTouches[0].pageX;

      if (Math.abs(favoriteStartY - favoriteEndY) <= 20 && Math.abs(favoriteStartX - favoriteEndX) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;
          scope.update();

          return
        }
        scope.isInFavorites = true;
        scope.update(scope.isInFavorites);
        opts.isInFavorites = true;
        opts.favoriteName = scope.service.name;
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        var favoritePaymentsList;

        if (!localStorage.getItem('favoritePaymentsList')) {
          favoritePaymentsList = [];

          favoritePaymentsList.push({
            "params": opts,
            "service": scope.service,
            "ussd": scope.fieldArray[0].ussd_query
          });
          console.log("favoritePaymentsList=", favoritePaymentsList);

          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
        } else {
          favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
          favoritePaymentsList.push({
            "params": opts,
            "service": scope.service,
            "ussd": scope.fieldArray[0].ussd_query
          });
          console.log("favoritePaymentsList=", favoritePaymentsList);
          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
        }
      }

    };

    removeFromFavorites = function () {
      event.stopPropagation();

      favoriteEndY = event.changedTouches[0].pageY;
      favoriteEndX = event.changedTouches[0].pageX;

      if (Math.abs(favoriteStartY - favoriteEndY) <= 20 && Math.abs(favoriteStartX - favoriteEndX) <= 20) {
        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        console.log(favoritePaymentsList);
        for (var i in favoritePaymentsList) {

          console.log(favoritePaymentsList[i].service.id, opts.chosenServiceId)

          if (favoritePaymentsList[i].service.id == opts.chosenServiceId) {
            console.log("i=", i);
            favoritePaymentsList.splice(i, 1);
            console.log(favoritePaymentsList);
            scope.isInFavorites = false;
            opts.isInFavorites = false;
            onBackParams.opts = JSON.parse(JSON.stringify(opts));
            scope.update(scope.isInFavorites);
          }
        }

        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      }
    };

    var enterPayStartY, enterPayStartX, enterPayEndY, enterPayEndX;

    scope.onTouchStartOfEnterPay = onTouchStartOfEnterPay = function () {
      event.stopPropagation();

      autoPayButtonId.style.webkitTransform = 'scale(0.8)'

      enterPayStartY = event.changedTouches[0].pageY;
      enterPayStartX = event.changedTouches[0].pageX;
    };

    var date, sessionKey, phoneNumber, serviceId, amount, accountId, friendPhone, payment_data;

    scope.onTouchEndOfEnterPay = onTouchEndOfEnterPay = function () {
      event.stopPropagation();

      autoPayButtonId.style.webkitTransform = 'scale(1)'

      enterPayEndY = event.changedTouches[0].pageY;
      enterPayEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterPayStartY - enterPayEndY) <= 20 && Math.abs(enterPayStartX - enterPayEndX) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;
//        confirm(question)
//        scope.confirmShowBool = true;
//        scope.confirmNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//        };
          scope.update();
          return
        }

        console.log("777", sessionStorage.getItem('payTransferConfirmed'));

        if (opts.mode != 'ADDAUTOPAY' && payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) != true) {
          console.log("888");
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-pay-confirm']);
          return
        }
        payService();
      }
    }

    payService = function () {

      date = parseInt(Date.now() / 1000);
      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      phoneNumber = localStorage.getItem('click_client_phoneNumber');
      serviceId = opts.chosenServiceId;
      amount = inputVerification.spaceDeleter(opts.amountText.toString());

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

      scope.update();
      console.log("accountId", accountId);
      console.log("friendPhone", friendPhone);

      if (opts.formtype == 1) {
        payment_data = {
          "param": opts.firstFieldId,
          "value": inputVerification.spaceDeleter(firstFieldtext),
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("payment_data 111");
        // opts.mode != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }
      else if (opts.formtype == 2) {
        payment_data = {
          "pin_param": opts.cardTypeId,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("payment_data 222");
        //opts.mode != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }
      else if (opts.formtype == 3) {
        payment_data = {
          "param": opts.firstFieldId,
          "value": inputVerification.spaceDeleter(firstFieldtext),
          "communal_param": opts.communalParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("payment_data 333");
        // opts.mode != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);

      }
      else if (opts.formtype == 4) {
        payment_data = {
          "param": opts.firstFieldId,
          "value": inputVerification.spaceDeleter(firstFieldtext),
          "internet_package_param": opts.internetPackageParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("payment_data 444");
//          opts.mode != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }

      console.log("payTransferBlocked=", payTransferBlocked);
      console.log("payment_data=", payment_data);

      if (opts.mode != 'ADDAUTOPAY') {

        paymentFunction(payment_data);

      } else {
        createAutoPay(payment_data);
      }

    };

    var statusCheckCounter = 0;


    function paymentFunction(payment_data) {

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      var answerFromServer = false;


      if (opts.optionAttribute && opts.optionValue) {
        payment_data[opts.optionAttribute] = opts.optionValue;
      }

      window.api.call({
        method: 'app.payment',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          service_id: Number(serviceId),
          account_id: Number(accountId),
          amount: Number(amount),
          payment_data: payment_data,
          datetime: date,
          friend_phone: friendPhone
        },

        scope: this,

        onSuccess: function (result) {
          answerFromServer = true;
          if (result[0][0].error == 0) {
            if (result[1]) {
              console.log("result of APP.PAYMENT 1", result);
              if (result[1][0].payment_id && !result[1][0].invoice_id) {
                console.log("Payment id");

                if (device.platform != 'BrowserStand') {
                  var options = {dimBackground: true};

                  SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                    console.log("Started");
                  }, function () {
                    console.log("closed");
                  });
                }

                setTimeout(function () {
                  checkPaymentStatus(result[1][0].payment_id);
                }, 2000);

              }
              else if (result[1][0].invoice_id && !result[1][0].payment_id) {
                console.log("Invoice id");

                viewServicePinCards.friendHelpPaymentMode = false;
                viewServicePinCards.chosenFriendForHelp = null;

                componentSuccessId.style.display = 'block';
              }
            }
          }
          else {
            scope.errorMessageFromPayment = result[0][0].error_note;
            scope.update();
            console.log("result of APP.PAYMENT 3", result);
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

    function checkPaymentStatus(payment_id) {

      console.log("check payment status");

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

            console.log("result of get.payment success=", result);
            if (result[1][0].state == -1) {
              scope.stepErrorAmount = 2;
              scope.errorMessageFromPayment = result[1][0].error;
              scope.update();
              console.log("state=-1 error,view=", scope.viewPage, ",step=", scope.stepErrorAmount);
              if (device.platform != 'BrowserStand') {
                SpinnerPlugin.activityStop();
              }
              componentUnsuccessId.style.display = 'block';


            } else if (result[1][0].state == 2) {
              window.updateBalanceGlobalFunction();

              viewServicePinCards.friendHelpPaymentMode = false;
              viewServicePinCards.chosenFriendForHelp = null;
              scope.stepAmount = (scope.isInFavorites || opts.mode == 'POPULAR') ? 3 : scope.stepAmount;
              this.operationMessage = window.languages.ComponentSuccessMessageForPay;
              scope.update();
              console.log("state=2 success,view=", scope.viewPage, ",step=", scope.stepAmount);
              if (device.platform != 'BrowserStand') {
                SpinnerPlugin.activityStop();
              }
              componentSuccessId.style.display = 'block';


            } else if (result[1][0].state == 1) {

              statusCheckCounter++;

              if (statusCheckCounter < 5) {

                if (device.platform != 'BrowserStand') {
                  var options = {dimBackground: true};

                  SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                    console.log("Started");
                  }, function () {
                    console.log("closed");
                  });
                }

                setTimeout(function () {
                  checkPaymentStatus(result[1][0].payment_id);
                }, 2000);

              } else {
                if (device.platform != 'BrowserStand') {
                  SpinnerPlugin.activityStop();
                }

                viewServicePinCards.friendHelpPaymentMode = false;
                viewServicePinCards.chosenFriendForHelp = null;

                scope.stepAmount = (scope.isInFavorites || opts.mode == 'POPULAR') ? 3 : scope.stepAmount;
                scope.update();
                console.log("state=1 waiting,view=", scope.viewPage, ",step=", scope.stepAmount);
                componentInProcessingId.style.display = 'block';
              }

            }

          }
          else {
            console.log("result of GET.PAYMENT in else", result);
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

    function createAutoPay(payment_data) {
      scope.operationMessage = window.languages.ViewAutoPayCreatedSuccessTextOne + "\"" + scope.autoPayData.name + "\"" + window.languages.ViewAutoPayCreatedSuccessTextTwo;
      if (scope.autoPayData && scope.autoPayData.fromView == 'PAYCONFIRM') {
        scope.viewPage = 'view-pay-confirm-new';
        scope.stepAmount = scope.servicesMap[scope.autoPayData.service_id][0].autopay_available ? ((scope.autoPayData.autopay_type == 2) ? 3 : 4) : 3;
        scope.stepErrorAmount = 1;
        scope.goBack = true;

      } else {
        scope.viewPage = 'view-auto-pay-new';
        scope.stepAmount = 5;
        scope.stepErrorAmount = 2;
        scope.goBack = true;
      }

      scope.update();
      console.log("in create autopay func", scope.autoPayData);
      if (scope.autoPayData) {
        if (scope.autoPayData.autopay_type == 2) {
          console.log(Number(amount));
          window.api.call({
            method: 'autopay.add.by.event',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              service_id: Number(serviceId),
              account_id: Number(accountId),
              amount: amount,
              cntrg_phone_num: inputVerification.spaceDeleter(scope.autoPayData.cntrg_phone_num),
              step: scope.autoPayData.step,
              title: scope.autoPayData.name
            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                console.log("result of autopay.add.by.event", result);
//                  scope.autoPayDelete = true;
//                  scope.update(scope.autoPayDelete);

                if (scope.autoPayData.fromView == 'PAYCONFIRM')
                  scope.autoPayData.fromView = 'AFTERCREATION';

                scope.autoPayData.isNew = false;
                localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                componentSuccessId.style.display = 'block';

              }
              else {
                //if (scope.autoPayData.fromView == 'PAYCONFIRM')
                //scope.autoPayData.fromView = 'AFTERCREATION';
//                  scope.autoPayData.isNew = false;
                //localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                console.log("result of autopay.add.by.event", result);
                scope.errorMessageFromPayment = result[0][0].error_note;
                scope.update();
                componentUnsuccessId.style.display = 'block';
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        } else if (scope.autoPayData.autopay_type == 1) {

          window.api.call({
            method: 'autopay.add.by.schedule',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              type: scope.autoPayData.type,
              service_id: Number(serviceId),
              account_id: Number(accountId),
              amount: Number(amount),
              payment_data: payment_data,
              paytime: scope.autoPayData.paytime,
              week_day: scope.autoPayData.week_day ? scope.autoPayData.week_day : null,
              month_day: scope.autoPayData.month_day ? scope.autoPayData.month_day : null,
              title: scope.autoPayData.name
            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                console.log("result of autopay.add.by.schedule", result);
//                  localStorage.setItem('autoPayData', null);
                if (scope.autoPayData.fromView == 'PAYCONFIRM')
                  scope.autoPayData.fromView = 'AFTERCREATION';
                scope.autoPayData.isNew = false;
                localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                componentSuccessId.style.display = 'block';

              }
              else {
//                if (scope.autoPayData.fromView == 'PAYCONFIRM')
//                  scope.autoPayData.fromView = 'AFTERCREATION';
////                  scope.autoPayData.isNew = false;
//                localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                console.log("result of autopay.add.by.schedule", result);
                scope.errorMessageFromPayment = result[0][0].error_note;
                scope.update();
                componentUnsuccessId.style.display = 'block';
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

    var autoPayStartY, autoPayStartX, autoPayEndY, autoPayEndX;

    scope.onTouchStartOfAutoPay = onTouchStartOfAutoPay = function () {
      event.stopPropagation();

//      if(deleteAutoPayButtonId)
//      deleteAutoPayButtonId.style.webkitTransform = 'scale(0.8)'

      autoPayStartY = event.changedTouches[0].pageY;
      autoPayStartX = event.changedTouches[0].pageX;
    };

    deleteAutoPay = function () {
      event.stopPropagation();

//      deleteAutoPayButtonId.style.webkitTransform = 'scale(1)'

      autoPayEndY = event.changedTouches[0].pageY;
      autoPayEndX = event.changedTouches[0].pageX;

      if (Math.abs(autoPayStartY - autoPayEndY) <= 20 && Math.abs(autoPayStartX - autoPayEndX) <= 20) {
        console.log("delete autopay =", scope.autoPayData);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        window.api.call({
          method: 'autopay.delete',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            autopay_id: scope.autoPayData.id,
            autopay_type: scope.autoPayData.autopay_type
          },

          scope: this,

          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              console.log("result of autopay.delete", result);
              localStorage.setItem('autoPayData', null);

              viewServicePinCards.friendHelpPaymentMode = false;
              viewServicePinCards.chosenFriendForHelp = null;

              scope.operationMessage = window.languages.ViewAutoPayDeletedSuccessText;
              scope.viewPage = 'view-auto-pay-new';
              scope.stepAmount = 1;
              scope.update();
              componentSuccessId.style.display = 'block';
            }
            else {
              console.log("result of autopay.delete", result);
              componentUnsuccessId.style.display = 'block';
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    };

    addToAutoPay = function () {
      event.stopPropagation();

      autoPayEndY = event.changedTouches[0].pageY;
      autoPayEndX = event.changedTouches[0].pageX;

      if (Math.abs(autoPayStartY - autoPayEndY) <= 20 && Math.abs(autoPayStartX - autoPayEndX) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;
          scope.update();

          return
        }

        opts.mode = 'ADDAUTOPAY';
        scope.autoPayData = {};
        opts.id = opts.chosenServiceId;
        scope.autoPayData.service_id = opts.chosenServiceId;
        scope.autoPayData.fromView = 'PAYCONFIRM';
        scope.autoPayData.isNew = true;

        event.preventDefault();
        event.stopPropagation();
        if (scope.servicesMap[scope.autoPayData.service_id][0].autopay_available) {
          localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
          onBackParams.opts = JSON.parse(JSON.stringify(opts));
          riotTags.innerHTML = "<view-autopay-method-new>";
          riot.mount("view-autopay-method-new", opts);
          scope.unmount()
        } else {
          scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
          scope.autoPayData.autopay_type = 1;
          localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
          onBackParams.opts = JSON.parse(JSON.stringify(opts));
          riotTags.innerHTML = "<view-autopay-schedule-method-new>";
          riot.mount("view-autopay-schedule-method-new", opts);
          scope.unmount()
        }
      }

    }


  </script>
</view-pay-confirm-new>

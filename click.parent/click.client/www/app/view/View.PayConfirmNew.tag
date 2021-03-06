<view-pay-confirm-new class="view-pay-confirm riot-tags-main-container">

  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div id="payconfirmButtonId" role="button" aria-label="{window.languages.Back}" ontouchend="goToBack()"
         ontouchstart="onTouchStartOfBack()"
         class="servicepage-button-back">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
    <div class="title-bottom-border">
    </div>
  </div>

  <div class="payconfirm-body-container">
    <div>
      <div class="payment-detail-payment-container" if="{formType!=2}">
        <div class="payment-detail-payment-include-container">
          <p class="title-text text-margin">
            {firstFieldTitle}</p>
          <p class="main-text text-margin">
            {firstFieldText}</p>
        </div>
      </div>
    </div>
    <div class="payment-detail-payment-container">
      <div class="payment-detail-payment-include-container">
        <p class="title-text text-margin">
          {window.languages.ViewPayConfirmAmountOfPay}</p>
        <p class="main-text text-margin">{amountTextCopy} {currency}</p>
        <p if="{opts.commissionPercent > 0 && (opts.nds==null || opts.nds==0)}"
           class="servicepage-amount-tax-text-field">
          {window.languages.PlusCommission}
          {window.calculateCommission(parseInt(opts.amountWithoutSpace), opts.commissionPercent)}
          {window.languages.Currency}
        </p>
        <p if="{(opts.commissionPercent == 0 || opts.commissionPercent == null)&& opts.nds > 0}"
           class="servicepage-amount-tax-text-field">
          {window.languages.PlusNds}
          {window.calculateCommission(parseInt(opts.amountWithoutSpace), opts.nds)}
          {window.languages.Currency}
        </p>
        <p if="{opts.commissionPercent > 0 && opts.nds > 0}"
           class="servicepage-amount-tax-text-field">
          {window.languages.PlusCommissionAndNds}
          {window.calculateCommissionAndNds(parseInt(opts.amountWithoutSpace), opts.commissionPercent, opts.nds)}
          {window.languages.Currency}
        </p>


        <p if="{opts.cost > 1}" class="title-text text-margin">{opts.lang_amount_title}:
          {window.amountTransform(opts.amountWithoutSpace)}</p>
        <p if="{opts.toEnrollment}" class="title-text text-margin">
          <b>{window.languages.ViewServiceToEnrollment}</b>
          <b style="color: rgb(142,184,81);">{opts.toEnrollment} {opts.currency=="000"?"UZS":"USD"}</b>
        </p>
      </div>
    </div>
    <div class="payment-detail-payment-container">
      <div class="payment-detail-payment-include-container">
        <p class="title-text text-margin">{(opts.mode=='ADDAUTOPAY')?
          (window.languages.ViewAutoPayConditionFieldText):(window.languages.ViewPayConfirmCategory)}</p>
        <p class="main-text text-margin">
          {(opts.mode=='ADDAUTOPAY')?
          (autoPayConditionText):(categoryName)}</p>
      </div>
    </div>
    <div class="payment-detail-payment-container" if="{cardOrFriendBool}">
      <div class="payment-detail-payment-include-container">
        <p class="title-text text-margin">
          {window.languages.ViewPayConfirmPayFromCard}</p>
        <p class="main-text text-margin">{cardName}</p>
        <p class="title-text text-margin">{numberPartOne} **** {numberPartTwo}</p>
        <p class="title-text text-margin">
          {window.languages.ViewPayConfirmAvailable}:{salary} {currency}</p>
        <div class="payconfirm-card-logo-container"
             style="background-image: url({url})">
        </div>
      </div>
    </div>
    <div class="payment-detail-payment-container" if="{!cardOrFriendBool}">
      <div class="payment-detail-payment-include-container">
        <p class="title-text text-margin">{window.languages.ViewPayConfirmFriendHelp}</p>
        <p class="main-text text-margin">{friendName}</p>
        <p class="title-text text-margin">+{friendNumber.substring(0, 3) + ' ' +
          inputVerification.telVerificationWithSpace(friendNumber.substring(3, friendNumber.length))}</p>
        <div class="payconfirm-chosen-friend-photo" style="background-image: url({friendPhoto})">
          {friendFirstLetterOfName}
        </div>
      </div>
    </div>
    <div class="payconfirm-bottom-container">
      <div class="payconfirm-action-autopay-container" if="{opts.mode!='ADDAUTOPAY'}">
        <div
          class="{payconfirm-action-containter: cardOrFriendBool && !isQrNotary, payconfirm-action-containter-favorite-center: isQrNotary || !cardOrFriendBool}">
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
             if="{!isQrNotary}"
             class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-autopay-none:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-two"
               style="background-image: url('resources/icons/ViewService/addautopay.png');"
               ontouchstart="onTouchStartOfAutoPay()" ontouchend="addToAutoPay()"></div>
          <div class="payconfirm-action-text" ontouchstart="onTouchStartOfAutoPay()" ontouchend="addToAutoPay()">
            {window.languages.ViewPayConfirmAddToAutoPay}
          </div>

        </div>
      </div>
    </div>
    <button id="autoPayButtonId"
            class="payconfirm-button-enter"
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

  <script>

    console.log("OPTS PAYCONFIRM NEW", opts);

    var scope = this;
    var favoriteStartY, favoriteStartX, favoriteEndY, favoriteEndX;
    var enterPayStartY, enterPayStartX, enterPayEndY, enterPayEndX;
    var backStartY, backStartX, backEndY, backEndX;
    var date, sessionKey, phoneNumber, amount, accountId, friendPhone, payment_data;
    var timeOutTimer = 0;

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ?
      (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);

    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ?
      (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);

    if (localStorage.getItem('settings_block_payAndTransfer'))
      var payTransferBlocked = JSON.parse(localStorage.getItem('settings_block_payAndTransfer'));


    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ?
      (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.fieldArray = scope.servicesParamsMapOne[opts.chosenServiceId];

    var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    var serviceId = localStorage.getItem('chosenServiceId');
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    scope.isInFavorites = opts.isInFavorites;

    scope.isQrNotary = opts.is_qr_notary;

    window.saveHistory('view-pay-confirm-new', opts);

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      payconfirmButtonId.style.webkitTransform = 'scale(0.7)';

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    scope.goToBack = goToBack = function () {
      event.stopPropagation();

      payconfirmButtonId.style.webkitTransform = 'scale(1)';

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
      }
    }
    scope.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.cardOrFriendBool = opts.payByCard;


    scope.stepAmount = 3;
    scope.stepErrorAmount = 3;
    scope.errorCode = 0;

    var pageToReturnIfError = 'view-main-page';
    var getPaymentSuccessStep = scope.service.additional_information_type == 0 ? 3 : 4,
      getPaymentErrorStep = scope.service.additional_information_type == 0 ? 2 : 3,
      appPaymentErrorStep = 3;


    this.formType = opts.formtype;
    this.firstFieldId = opts.firstFieldId;

    this.firstFieldTitle = opts.firstFieldTitle;


    if (opts.firstFieldId == '1') {

      opts.firstFieldText = inputVerification.telLengthVerification(opts.firstFieldText, window.languages.PhoneNumberLength);
      this.firstFieldText = "+" + window.languages.CodeOfCountry + ' ' + inputVerification.telVerificationWithSpace(opts.firstFieldText);
      var firstFieldtext = "+" + window.languages.CodeOfCountry + opts.firstFieldText;

    } else if (opts.firstFieldId == '65536' || opts.firstFieldId == '128') {

      opts.firstFieldText = inputVerification.telLengthVerification(opts.firstFieldText, window.languages.PhoneNumberLength);
      this.firstFieldText = "+" + window.languages.CodeOfCountry + ' ' + inputVerification.telVerificationWithSpace(opts.firstFieldText);
      var firstFieldtext = inputVerification.spaceDeleter(opts.firstFieldText);

    }
    else if (opts.chosenPrefixId && opts.chosenPrefixName) {

      this.firstFieldText = opts.chosenPrefixName + opts.firstFieldText;
      var firstFieldtext = opts.chosenPrefixName + opts.firstFieldText;


    } else {
      this.firstFieldText = opts.firstFieldText;
      var firstFieldtext = opts.firstFieldText;

    }

    this.cardTypeId = opts.cardTypeId;
    this.amountText = opts.amountText;
    scope.amountTextCopy = opts.amountText;


    try {
      if (opts.cost > 1) {
        scope.fullAmount = (opts.amountText * opts.cost);
        scope.intPartAmount = Math.floor(scope.fullAmount).toFixed(0).toString();
        scope.fracPartAmount = window.getFractionalPart(scope.fullAmount.toString());
        scope.amountTextCopy = window.amountTransform(window.inputVerification.spaceDeleter(scope.intPartAmount)) + scope.fracPartAmount;
      }
      else {
        scope.intPartAmount = Math.floor(opts.amountText.toString().replace(/\s/g, '')).toFixed(0).toString();
        scope.fracPartAmount = window.getFractionalPart(opts.amountText.toString());
        scope.amountTextCopy = window.amountTransform(window.inputVerification.spaceDeleter(scope.intPartAmount)) + scope.fracPartAmount;
      }
    }
    catch (e) {
      console.error(e);
      scope.amountTextCopy = opts.amountText;
    }
    scope.update(scope.amountTextCopy);

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

    }
    scope.update();


    scope.onTouchStartOfFavorite = onTouchStartOfFavorite = function () {
      event.stopPropagation();
      favoriteStartY = event.changedTouches[0].pageY;
      favoriteStartX = event.changedTouches[0].pageX;
    };


    updateResultComponent = function (showResult, stepAmount, viewPage, status, text) {

      if (showResult) {
        window.common.alert.updateView("componentResultId", {
          parent: scope,
          resulttext: text,
          viewpage: viewPage,
          step_amount: stepAmount
        });
      } else {
        window.common.alert.hide("componentResultId");
      }
      updateIcon(status, null, null, text, stepAmount, viewPage);
    };

    closeResultComponent = function () {

      window.common.alert.hide("componentResultId");
      riot.update();
    };

    initResultComponent = function () {

      window.common.alert.updateView("componentResultId", {
        parent: scope

      });
      riot.update();
    };

    addToFavoritesinPayConfirm = function () {
      event.stopPropagation();

      favoriteEndY = event.changedTouches[0].pageY;
      favoriteEndX = event.changedTouches[0].pageX;

      if (Math.abs(favoriteStartY - favoriteEndY) <= 20 && Math.abs(favoriteStartX - favoriteEndX) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();
          return
        }

        scope.isInFavorites = true;
        scope.update(scope.isInFavorites);
        opts.isInFavorites = true;
        opts.favoriteName = scope.service.name;
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');

        var id = Math.floor((Math.random() * 1000000) + 1);
        opts.favoriteId = id;
        opts.transactionId = null;
        var favoritePaymentsList = localStorage.getItem('favoritePaymentsList') ? JSON.parse(localStorage.getItem('favoritePaymentsList')) : [];
        var favoritePaymentsListForApi = localStorage.getItem('favoritePaymentsListForApi') ? JSON.parse(localStorage.getItem('favoritePaymentsListForApi')) : [];

        if (favoritePaymentsListForApi.length !== favoritePaymentsList.length) {
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

        console.log("CONSOLE LOG OPTS PAYMENT", opts)

        var newFavorite = {
          "params": opts,
          "service": scope.service,
          "ussd": scope.fieldArray[0].ussd_query,
          "id": id
        };
        favoritePaymentsList.push(newFavorite);

        favoritePaymentsListForApi.push({
          "id": id,
          "type": 1,
          "body": JSON.stringify(newFavorite)
        });


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

        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
        localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));

      }

    };

    removeFromFavorites = function () {
      event.stopPropagation();

      favoriteEndY = event.changedTouches[0].pageY;
      favoriteEndX = event.changedTouches[0].pageX;

      if (Math.abs(favoriteStartY - favoriteEndY) <= 20 && Math.abs(favoriteStartX - favoriteEndX) <= 20) {

        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');

        for (var i in favoritePaymentsList) {


          if (favoritePaymentsList[i].id == opts.favoriteId) {

            favoritePaymentsList.splice(i, 1);
            scope.isInFavorites = false;
            opts.isInFavorites = false;
            onBackParams.opts = JSON.parse(JSON.stringify(opts));
            scope.update(scope.isInFavorites);

            for (var j in favoritePaymentsListForApi)
              if (favoritePaymentsListForApi[j].id == opts.favoriteId) {
                favoritePaymentsListForApi.splice(j, 1);
                break;
              }

            window.api.call({
              method: 'delete.favourite',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                wishlist_data: [{"id": opts.favoriteId, "type": 1}]
              },

              scope: this,

              onSuccess: function (result) {

                if (result[0][0].error == 0) {

                  console.log("SUCCESSFULLY deleted")

                }
                else {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: false,
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
    };

    scope.onTouchStartOfEnterPay = onTouchStartOfEnterPay = function () {
      event.stopPropagation();

      autoPayButtonId.style.webkitTransform = 'scale(0.8)';

      enterPayStartY = event.changedTouches[0].pageY;
      enterPayStartX = event.changedTouches[0].pageX;
    };


    scope.onTouchEndOfEnterPay = onTouchEndOfEnterPay = function () {
      event.stopPropagation();

      autoPayButtonId.style.webkitTransform = 'scale(1)';

      enterPayEndY = event.changedTouches[0].pageY;
      enterPayEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterPayStartY - enterPayEndY) <= 20 && Math.abs(enterPayStartX - enterPayEndX) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();
          return
        }

        if (opts.mode != 'ADDAUTOPAY' && payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) != true) {
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-pay-confirm']);
          scope.unmount();
          return
        }
        payService();
      }
    };


    payService = function () {

      date = parseInt(Date.now() / 1000);
      if (!opts.transactionId)
        opts.transactionId = parseInt(Date.now() / 1000);
      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      phoneNumber = localStorage.getItem('click_client_phoneNumber');
      serviceId = opts.chosenServiceId;
      fracAmount = window.getFractionalPart(opts.amountText.toString());
      intAmount = Math.floor(opts.amountText.toString().replace(' ', '').toString()).toFixed(0).toString();
      amount = inputVerification.spaceDeleter(intAmount) + fracAmount;

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

      if (opts.formtype == 1) {
        payment_data = {
          "param": opts.firstFieldId,
          "value": firstFieldtext,
          "transaction_id": opts.transactionId
        };
      }
      else if (opts.formtype == 2) {
        payment_data = {
          "pin_param": opts.cardTypeId,
          "transaction_id": opts.transactionId
        };
      }
      else if (opts.formtype == 3 || opts.formtype == 5 || opts.formtype == 6) {
        payment_data = {
          "param": opts.firstFieldId,
          "value": firstFieldtext,
          "communal_param": opts.communalParam,
          "transaction_id": opts.transactionId
        };

        if (opts.formtype == 5) {

          getPaymentSuccessStep++;
          getPaymentErrorStep++;
          appPaymentErrorStep++;

          console.log("STEPS CHANGED", getPaymentSuccessStep, getPaymentErrorStep)
        }

      }
      else if (opts.formtype == 4) {
        payment_data = {
          "param": opts.firstFieldId,
          "value": firstFieldtext,
          "internet_package_param": opts.internetPackageParam,
          "transaction_id": opts.transactionId
        };
      } else if (opts.formtype == 7) {
        payment_data = {
          "value": opts.firstFieldText,
          "secondary_value": opts.secondFieldValue,
          "transaction_id": opts.transactionId
        };
      }

      if (opts.mode != 'ADDAUTOPAY') {
        paymentFunction(payment_data);
      } else {
        createAutoPay(payment_data);
      }

    };

    var statusCheckCounter = 0;

    function paymentFunction(payment_data) {

      if (opts.optionAttribute && opts.optionValue) {
        payment_data[opts.optionAttribute] = opts.optionValue;
      }
      if (opts.paymentDataAttributes) {
        for (var i in opts.paymentDataAttributes) {
         if(opts.paymentDataAttributes[i]) payment_data[opts.paymentDataAttributes[i].attribute] = opts.paymentDataAttributes[i].value;
        }
      }

      console.log("Payment data", payment_data);

      initResultComponent();
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

          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1][0].payment_id && !result[1][0].invoice_id) {
                setTimeout(function () {
                  checkPaymentStatus(result[1][0].payment_id);
                }, 2000);
              }
              else if (result[1][0].invoice_id && !result[1][0].payment_id) {
                console.log('Clearing timer onSuccess', timeOutTimer);
                window.clearTimeout(timeOutTimer);
                viewServicePinCards.friendHelpPaymentMode = false;
                viewServicePinCards.chosenFriendForHelp = null;
                updateResultComponent(true, getPaymentSuccessStep, null, 'success', result[0][0].error_note);
              }
            }
          }
          else {
            console.log('Clearing timer onSuccess ERROR', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, appPaymentErrorStep, null, 'unsuccess', result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', api_status_message);

          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'app.payment',
            });
            updateResultComponent(true, null, pageToReturnIfError, 'waiting', window.languages.WaitingTimeExpiredText);
          }, 30000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });
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
            if (result[1][0].state == -1) {
              console.log('Clearing timer onFail', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              updateResultComponent(true, getPaymentErrorStep, null, 'unsuccess', result[1][0].error);

            } else if (result[1][0].state == 2) {
              console.log('Clearing timer onSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              window.updateBalanceGlobalFunction();

              viewServicePinCards.friendHelpPaymentMode = false;
              viewServicePinCards.chosenFriendForHelp = null;

              if (result[1][0].qr_image) {
                closeResultComponent();
                scope.update();
                window.common.alert.show("componentGeneratedQrId", {
                  parent: scope,
                  qr_image: result[1][0].qr_image,
                  qr_header: result[1][0].qr_header,
                  qr_footer: result[1][0].qr_footer,
                  viewpage: scope.viewPage,
                  step_amount: scope.stepAmount
                });
                qrFooterTextId.innerHTML = result[1][0].qr_footer;
              } else {
                updateResultComponent(true, getPaymentSuccessStep, null, 'success', window.languages.ComponentSuccessMessageForPay);
              }

            } else if (result[1][0].state == 1) {
              statusCheckCounter++;
              if (statusCheckCounter < 5 && window.common.alert.isShown("componentResultId")) {
                setTimeout(function () {
                  checkPaymentStatus(result[1][0].payment_id);
                }, 2000);
              } else {
                console.log('Clearing timer onSuccess', timeOutTimer);
                window.clearTimeout(timeOutTimer);
                viewServicePinCards.friendHelpPaymentMode = false;
                viewServicePinCards.chosenFriendForHelp = null;
                updateResultComponent(true, getPaymentSuccessStep, null, 'waiting', window.languages.ComponentInProcessingPartOneForPay);
              }
            }
            window.api.spinnerOn = false;

          }
          else {
            console.log('Clearing timer onSuccess', timeOutTimer);
            window.clearTimeout(timeOutTimer);
            updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', result[1][0].error);

          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          updateResultComponent(true, null, pageToReturnIfError, 'unsuccess', api_status_message);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
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

      window.startSpinner();

      if (scope.autoPayData) {
        if (scope.autoPayData.autopay_type == 2) {

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

                if (scope.autoPayData.fromView == 'PAYCONFIRM')
                  scope.autoPayData.fromView = 'AFTERCREATION';

                scope.autoPayData.isNew = false;
                localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                window.common.alert.show("componentSuccessId", {
                  parent: scope,
                  operationmessage: scope.operationMessage,
                  goback: scope.goBack,
                  viewpage: scope.viewPage,
                  step_amount: scope.stepAmount
                });


              }
              else {
                scope.errorMessageFromPayment = result[0][0].error_note;
                scope.update();
                window.common.alert.show("componentUnsuccessId", {
                  parent: scope,
                  viewpage: scope.viewPage,
                  step_amount: scope.stepErrorAmount,
                  goback: scope.goBack,
                  operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
                  operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
                  operationmessagepartthree: scope.errorMessageFromPayment
                });
              }
            },

            onFail: function (api_status, api_status_message, data) {

              window.common.alert.show("componentUnsuccessId", {
                parent: scope,
                viewpage: scope.viewPage,
                step_amount: scope.stepErrorAmount,
                goback: scope.goBack,
                operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
                operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
                operationmessagepartthree: scope.errorMessageFromPayment
              });

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

                if (scope.autoPayData.fromView == 'PAYCONFIRM')
                  scope.autoPayData.fromView = 'AFTERCREATION';
                scope.autoPayData.isNew = false;
                localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                window.common.alert.show("componentSuccessId", {
                  parent: scope,
                  operationmessage: scope.operationMessage,
                  goback: scope.goBack,
                  viewpage: scope.viewPage,
                  step_amount: scope.stepAmount
                });

              }
              else {

                scope.errorMessageFromPayment = result[0][0].error_note;
                scope.update();

                window.common.alert.show("componentUnsuccessId", {
                  parent: scope,
                  viewpage: scope.viewPage,
                  step_amount: scope.stepErrorAmount,
                  goback: scope.goBack,
                  operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
                  operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
                  operationmessagepartthree: scope.errorMessageFromPayment
                });
              }
            },

            onFail: function (api_status, api_status_message, data) {
              window.common.alert.show("componentUnsuccessId", {
                parent: scope,
                viewpage: scope.viewPage,
                step_amount: scope.stepErrorAmount,
                goback: scope.goBack,
                operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
                operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
                operationmessagepartthree: scope.errorMessageFromPayment
              });
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

      autoPayStartY = event.changedTouches[0].pageY;
      autoPayStartX = event.changedTouches[0].pageX;
    };


    deleteAutoPay = function () {
      event.stopPropagation();

//      deleteAutoPayButtonId.style.webkitTransform = 'scale(1)'

      autoPayEndY = event.changedTouches[0].pageY;
      autoPayEndX = event.changedTouches[0].pageX;

      if (Math.abs(autoPayStartY - autoPayEndY) <= 20 && Math.abs(autoPayStartX - autoPayEndX) <= 20) {

        if (device.platform != 'BrowserStand') {
          var options = {dimBackground: true};

          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
            console.log("Spinner start in pay confirm");
          }, function () {
            console.log("Spinner stop in pay confirm");
          });
        }

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
              localStorage.setItem('autoPayData', null);

              viewServicePinCards.friendHelpPaymentMode = false;
              viewServicePinCards.chosenFriendForHelp = null;

              scope.operationMessage = window.languages.ViewAutoPayDeletedSuccessText;
              scope.viewPage = 'view-auto-pay-new';
              scope.stepAmount = 1;
              scope.update();

              window.common.alert.show("componentSuccessId", {
                parent: scope,
                operationmessage: scope.operationMessage,
                goback: scope.goBack,
                viewpage: scope.viewPage,
                step_amount: scope.stepAmount
              });
            }
            else {
              window.common.alert.show("componentUnsuccessId", {
                parent: scope,
                viewpage: scope.viewPage,
                step_amount: scope.stepErrorAmount,
                goback: scope.goBack,
                operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
                operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
                operationmessagepartthree: scope.errorMessageFromPayment
              });
            }
          },

          onFail: function (api_status, api_status_message, data) {
            window.common.alert.show("componentUnsuccessId", {
              parent: scope,
              viewpage: scope.viewPage,
              step_amount: scope.stepErrorAmount,
              goback: scope.goBack,
              operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
              operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
              operationmessagepartthree: scope.errorMessageFromPayment
            });
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
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
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

    if (payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) === true) {
      payService();
      sessionStorage.setItem('payTransferConfirmed', null);
    }


  </script>
</view-pay-confirm-new>

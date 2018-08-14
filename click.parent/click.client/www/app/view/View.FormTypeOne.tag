<view-formtype-one class="riot-tags-main-container">

  <div id="servicePageId" class="view-common-page">

    <div class="pay-page-title page-title-shadow" style="border-style: none;">
      <p class="servicepage-title">
        {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
        {titleName}</p>
      <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
        (window.languages.ViewAutoPayMethodSchedulerText):(categoryName)}</p>
      <div id="servicePageBackButtonId" role="button" aria-label="{window.languages.Back}"
           ontouchend="onTouchEndOfBack()"
           ontouchstart="onTouchStartOfBack()"
           class="servicepage-button-back">
      </div>
      <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
           style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="servicepage-body-container">

      <div id="autopayField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
        <p id="autoPayNameTitle" class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="checkFieldsToActivateNext()"
               onfocus="colorFieldGlobal('autopayField','autoPayNameTitle')"
               onblur="blurFieldGlobal('autopayField','autoPayNameTitle')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="checkFieldsToActivateNext()" onfocus="colorFieldGlobal('favoriteField','favoriteNameTitle')"
               onblur="blurFieldGlobal('favoriteField','favoriteNameTitle')"/>
      </div>

      <div class="servicepage-fields-dropdown" if="{dropDownOn}" ontouchend="openFirstFieldDropDown()"
           id="firstFieldChoiceId">
        <p class="servicepage-dropdown-text-field">{chosenFieldName}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <div class="servicepage-first-field" id="firstField"
           hidden="{modeOfApp.offlineMode && opts.chosenServiceId == 'mynumber'}">
        <p id="firstFieldTitle" class="servicepage-text-field">{chosenFieldName}</p>
        <p class="servicepage-number-first-part" if="{phoneFieldBool}">+{window.languages.CodeOfCountry}</p>

        <div class="servicepage-prefix-dropdown" if="{!phoneFieldBool && hasPrefixes}"
             ontouchend="openPrefixesDropDown()"
             id="prefixChoiceId">
          <p class="servicepage-prefix-dropdown-text-field">{chosenPrefixTitle}</p>
          <div class="servicepage-prefix-dropdown-icon"></div>
        </div>

        <input class="{servicepage-number-input-part: phoneFieldBool || hasPrefixes, servicepage-number-input-part-two: !phoneFieldBool && isNumber && !hasPrefixes,
                           servicepage-number-input-part-three: !phoneFieldBool && !isNumber && !hasPrefixes}"
               type="{inputType}"
               id="firstFieldInput"
               onfocus="colorFieldGlobal('firstField','firstFieldTitle')"
               onblur="blurFieldGlobal('firstField','firstFieldTitle')"
               value="{defaultNumber || opts.first_field_value}"
               oninput="telVerificationOnInput()"
               onpaste="telVerificationOnPaste()"
               onkeyup="telPayVerificationKeyUp()"
               onkeydown="telPayVerificationKeyDown(this)"/>
        <div class="servicepage-phone-icon" role="button" aria-label="{window.languages.ChooseFromContacts}"
             if="{phoneFieldBool}" ontouchstart="onTouchStartOfSearchContact()"
             ontouchend="onTouchEndOfSearchContact()"></div>
      </div>

      <div class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
           id="amountField">
        <p id="amountFieldTitle" class="servicepage-text-field">{amountFieldTitle}</p>
        <input class="servicepage-amount-input" type="tel" value="{defaultAmount}" maxlength="10"
               id="amount"
               readonly="{!service['amount_editable']}"
               pattern="[0-9]"
               placeholder="{placeHolderText}"
               onfocus="colorFieldGlobal('amountField','amountFieldTitle')"
               onblur="blurFieldGlobal('amountField','amountFieldTitle')"
               onmouseup="eraseAmountDefault()" oninput="amountOnInput()"/>
        <div if="{!modeOfApp.offlineMode && service['amount_editable'] && calcOn}" class="servicepage-amount-icon"
             ontouchstart="onTouchStartOfAmountCalculator()" role="button"
             aria-label="{window.languages.ViewServicePageVoiceOverOpenCalculator}"
             ontouchend="onTouchEndOfAmountCalculator()"></div>

        <p if="{showErrorOfLimit}" id="placeHolderSumId" class="servicepage-limit-title">{placeHolderText}</p>
      </div>


      <button id="enterButtonId" style="bottom: {window.bottomButtonBottom}"
              class="{servicepage-button-enter-enabled: enterButtonEnabled,servicepage-button-enter-disabled:!enterButtonEnabled}"
              ontouchstart="onTouchStartOfEnter()"
              ontouchend="onTouchEndOfEnter()">
        {enterButton ? (modeOfApp.offlineMode ?window.languages.ViewServicePagePayLabel:
        window.languages.ViewServicePageEnterLabel):window.languages.ViewServicePageSaveLabel}
      </button>

      <div style="position: relative; left: 10%; top: 2%;">
        <p if="{service.commission_percent>0 && (service.nds==null || service.nds==0)}"
           class="servicepage-amount-tax-text-field">
          {window.languages.PlusCommission}
          {(toEnrollment == 0 && service.category_id == 16) ? 0 : window.calculateCommission(amountForPayTransaction,
          service.commission_percent)}
          {window.languages.Currency}
        </p>
        <p if="{(service.commission_percent==null || service.commission_percent==0) && service.nds>0}"
           class="servicepage-amount-tax-text-field">
          {window.languages.PlusNds}
          {(toEnrollment == 0 && service.category_id == 16) ? 0 : window.calculateCommission(amountForPayTransaction,
          service.nds)}
          {window.languages.Currency}
        </p>
        <p if="{service.commission_percent>0 && service.nds>0}"
           class="servicepage-amount-tax-text-field">
          {window.languages.PlusCommissionAndNds}
          {(toEnrollment == 0 && service.category_id == 16) ? 0 :
          window.calculateCommissionAndNds(amountForPayTransaction,
          service.commission_percent,
          service.nds)}
          {window.languages.Currency}
        </p>
        <p if="{service.category_id == 16 ||
        (service.currency != null && service.rate != null && service.low_ratio != null
         && service.rate != 0 && service.low_ratio != 0)}"
           class="servicepage-amount-tax-text-field" style="bottom:-90%;">
          <b>
            {window.languages.ViewServiceToEnrollment}
          </b>
          <b style="color: rgb(142,184,81);">{toEnrollment} {(service.currency == "000" || service.currency == null) ?
            "UZS" :
            "USD"}</b>
        </p>
        <p if="{service.category_id == 16}" class="title-text text-margin public-offer">
          {window.languages.PublicOfferConfirm}
          <a href="https://m.click.uz/static/bank/native_pay_offer/np_public_offer.pdf ">
            {window.languages.PublicOffer}
          </a>
        </p>
      </div>

    </div>

    <div hidden="{!showComponent}" id="blockAmountCalculatorId" class="component-calc">
      <div id="rightButton" type="button" role="button" aria-label="{window.languages.Close}"
           class="component-banklist-close-button" ontouchstart="closeCalculatorTouchStart()"
           ontouchend="closeCalculatorTouchEnd()"></div>
      <div class="component-calc-name-title">{window.languages.ViewAmountCalculatorNameTitle}</div>

      <div class="component-calc-fields-container">

        <div class="component-calc-first-field">
          <p class="component-calc-first-field-text">{window.languages.ViewAmountCalculatorTextOne}</p>
          <input id="amountCalcInputId" class="component-calc-first-field-input-part" type="tel" autofocus="true"
                 maxlength="19" onkeyup="convertAmount()"/>
        </div>

        <p class="component-calc-currency-text">{window.languages.ViewAmountCalculatorTextTwo} {currencyRate} сум</p>
        <div id="convertedAmountFieldId" class="component-calc-second-field">
          <p class="component-calc-second-field-text">{window.languages.ViewAmountCalculatorTextThree}</p>
          <p class="component-calc-second-field-input-part">{convertedAmount} сум</p>
        </div>

        <div class="component-calc-buttons-container">
          <div class="component-calc-button component-calc-cancel-button"
               ontouchstart="closeAmountComponentTouchStart()"
               ontouchend="closeAmountComponentTouchEnd()">
            <p class="component-calc-button-label component-calc-cancel-button-label">
              {window.languages.ViewAmountCalculatorCancelText}</p>
          </div>
          <div id="acceptConvertedBtnId" class="component-calc-button" ontouchstart="acceptConvertedAmountTouchStart()"
               ontouchend="acceptConvertedAmountTouchEnd()">
            <p class="component-calc-button-label">{window.languages.ViewAmountCalculatorAcceptText}</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <component-dropdown></component-dropdown>

  <script>


    window.checkShowingComponent = null;
    var scope = this;
    var backStartY, backStartX, backEndY, backEndX;
    var cursorPositionSelectionStart, cursorPositionSelectionEnd, oldValueOfNumber;
    var searchContactStartY, searchContactStartX, searchContactEndY, searchContactEndX;
    var amountCalcStartY, amountCalcStartX, amountCalcEndY, amountCalcEndX;
    var closeIconStartY, closeIconStartX, closeIconEndY, closeIconEndX;
    var closeStartY, closeStartX, closeEndY, closeEndX;
    var acceptStartY, acceptStartX, acceptEndY, acceptEndX;
    var servicePageTouchStartY, servicePageTouchEndY, servicePageTouchStartX, servicePageTouchEndX;
    var enterStartY, enterStartX, enterEndY, enterEndX;
    var contactStopChanging = false;
    scope.showErrorOfLimit = false;
    var onPaste = false;
    var amountFormatted = false;

    scope.tax = 0;
    scope.toEnrollment = 0;
    scope.taxText = window.languages.PlusCommission;
    scope.selectedId = '';
    var options = {
      symbol: "",
      decimal: ".",
      thousand: " ",
      precision: 0,
      format: {
        pos: "%v",
        zero: ""
      }
    };

    var options_for_calc = {
      symbol: "",
      decimal: ".",
      thousand: " ",
      precision: 0,
      format: {
        pos: "%v",
        zero: "0"
      }
    };

    console.log("opts in FormTypeOne", opts);

    window.saveHistory('view-formtype-one', opts);

    if (opts.id) {
      opts.chosenServiceId = opts.id;
    }

    if (opts.categoryId == '16') {
      scope.isInternationalPay = true;
    }

    if (opts.amountText) {
      scope.amountForPayTransaction = opts.amountWithoutSpace;
      opts.amountText = !opts.amountText ? 0 : window.amountTransform(opts.amountText.toString());
      scope.commissionPercent = opts.commissionPercent ? opts.commissionPercent : 0;
      scope.nds = opts.nds ? opts.nds : 0;
      scope.toEnrollment = opts.toEnrollment ? opts.toEnrollment : 0;
      scope.update();
    }

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.servicesParamsMapTwo = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"))) : (offlineServicesParamsMapTwo);
    scope.servicesParamsMapThree = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) : (offlineServicesParamsMapThree);
    scope.servicesParamsMapFour = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"))) : (offlineServicesParamsMapFour);
    scope.servicesParamsMapFive = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"))) : (offlineServicesParamsMapFive);
    scope.servicesParamsMapSix = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapSix"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapSix"))) : (offlineServicesParamsMapSix);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    onBackParams.opts = JSON.parse(JSON.stringify(opts));
    scope.enterButton = opts.mode == 'ADDFAVORITE' ? false : true;
    scope.enterButtonEnabled = false;
    scope.showConfirm = false;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    if (loginInfo)
      var sessionKey = loginInfo.session_key;

    scope.update(scope.categoryNamesMap);


    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      servicePageBackButtonId.style.webkitTransform = 'scale(0.7)';

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfBack = onTouchEndOfBack = function () {
      event.stopPropagation();

      servicePageBackButtonId.style.webkitTransform = 'scale(1)';

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        window.viewServicePinCards = {};
        event.preventDefault();
        event.stopPropagation();
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        onBackKeyDown();
        scope.unmount()
      }
    };

    checkFieldsToActivateNext = function (from) {

      console.log("CHECK fields");

      if (!scope.service['amount_editable']) return;

      if (amountForPayTransaction < scope.service.min_pay_limit) {

        if (from == 'sum' && amount.value.length != 0) {
          scope.showErrorOfLimit = true;
          amountField.style.borderBottom = 3 * widthK + 'px solid red';
          amountFieldTitle.style.color = 'red';
          scope.update();
          placeHolderSumId.style.color = 'red';
        }
        scope.enterButtonEnabled = false;
        scope.update();
        return;
      }
      else if (from == 'sum' && amountField.length >= 1) {
        amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        amountFieldTitle.style.color = '#01cfff';
        scope.showErrorOfLimit = false;
        scope.update()
      }
      if (amountForPayTransaction > scope.service.max_pay_limit) {
        if (from == 'sum' && amount.value.length != 0) {
          scope.showErrorOfLimit = true;
          amountField.style.borderBottom = 3 * widthK + 'px solid red';
          amountFieldTitle.style.color = 'red';
          scope.update();
          placeHolderSumId.style.color = 'red';
        }
        scope.toEnrollment = 0;
        scope.enterButtonEnabled = false;
        scope.update();
        return;
      }
      else if (from == 'sum') {
        amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        amountFieldTitle.style.color = '#01cfff';
        scope.showErrorOfLimit = false;
        scope.update()
      }


      if (opts.mode == 'ADDAUTOPAY' && this.autoPayNameInput && this.autoPayNameInput.value.length < 1) {
        console.log("Введите название автоплатежа");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      if (opts.mode == 'ADDFAVORITE' && this.favoriteNameInput && this.favoriteNameInput.value.length < 1) {
        console.log("Введите название избранного платежа");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      if (this.firstFieldInput) {

        if (scope.phoneFieldBool && firstFieldInput && opts.chosenServiceId != "mynumber") {

          if (firstFieldInput.value.length < 10) {

            scope.enterButtonEnabled = false;
            scope.update(scope.enterButtonEnabled);
            return;
          }

        } else if (firstFieldInput && firstFieldInput.value.length == 0 && opts.chosenServiceId != "mynumber") {
          console.log("Нет значения первого поля");
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        }
      }


      if (amountForPayTransaction < scope.service.min_pay_limit) {
        console.log("amount=", amountForPayTransaction);
        console.log(scope.service.lang_min_amount);
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }
      if (amountForPayTransaction > scope.service.max_pay_limit) {
        console.log(scope.service.lang_max_amount);
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      scope.enterButtonEnabled = true;
      scope.update(scope.enterButtonEnabled);


    };

    telPayVerificationKeyDown = function (input) {

      if (scope.phoneFieldBool)
        if (input.value.length >= 10 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {

          contactStopChanging = true;
        }
        else {
          contactStopChanging = false;
        }
    };

    telVerificationOnPaste = function () {
      onPaste = true;
    };

    telVerificationOnInput = function () {
      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT && onPaste) {
        if (firstFieldInput.type != 'text' && scope.phoneFieldBool)
          firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(firstFieldInput.value))

        onPaste = false;
      }
    };

    telPayVerificationKeyUp = function () {

      if (contactStopChanging) {
        firstFieldInput.value = event.target.value.substring(0, event.target.value.length - 1);
      }

      cursorPositionSelectionStart = firstFieldInput.selectionStart;
      cursorPositionSelectionEnd = firstFieldInput.selectionEnd;
      oldValueOfNumber = firstFieldInput.value;

      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        if (firstFieldInput.type != 'text' && scope.phoneFieldBool)
          firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(firstFieldInput.value));

        if (!onPaste) {
          firstFieldInput.selectionStart = cursorPositionSelectionStart;
          firstFieldInput.selectionEnd = cursorPositionSelectionEnd;
        }

        if (oldValueOfNumber != firstFieldInput.value && cursorPositionSelectionStart == 3)
          firstFieldInput.selectionStart = cursorPositionSelectionStart + 1;

      }

      checkFieldsToActivateNext();
    };


    this.on('mount', function () {

      focusFieldAfterTourClosed();

      if (opts && opts.number) {
        firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.number));
        scope.update();
      }

      if (opts.amountWithoutSpace && opts.amountWithoutSpace.length > 0) {
        amount.value = opts.amountText;
        checkFirst = true;
        amountForPayTransaction = opts.amountWithoutSpace;
      }
      else {
        checkFieldsToActivateNext();
      }
    });

    scope.focusFieldAfterTourClosed = focusFieldAfterTourClosed = function () {

      if (opts.mode != 'ADDAUTOPAY' && opts.mode != 'ADDFAVORITE') {

        focusFieldGlobal('firstFieldInput');

      } else if (opts.mode == 'ADDAUTOPAY') {

        focusFieldGlobal('autoPayNameInput');

      } else if (opts.mode == 'ADDFAVORITE') {

        focusFieldGlobal('favoriteNameInput');

      }
      scope.update()
    };

    scope.onTouchStartOfSearchContact = onTouchStartOfSearchContact = function () {
      event.stopPropagation();
      searchContactStartY = event.changedTouches[0].pageY;
      searchContactStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfSearchContact = onTouchEndOfSearchContact = function () {
      event.stopPropagation();

      searchContactEndY = event.changedTouches[0].pageY;
      searchContactEndX = event.changedTouches[0].pageX;

      if (Math.abs(searchContactStartY - searchContactEndY) <= 20 && Math.abs(searchContactStartX - searchContactEndX) <= 20) {
        window.pickContactFromNativeChecker = true;
        var maskOne = /[0-9]/g;
        try {
          window.plugins.PickContact.chooseContact(function (contactInfo) {
            setTimeout(function () {
              var phoneNumber
              if (device.platform == 'iOS')
                phoneNumber = contactInfo.phoneNr;

              if (device.platform == 'Android') {
                phoneNumber = contactInfo.nameFormated
              }
              var digits = phoneNumber.match(maskOne);
              var phone = '';
              for (var i in digits) {
                phone += digits[i]
              }
              firstFieldInput.value = inputVerification.telVerificationWithSpace(phone.substring(phone.length - 9, phone.length));
              checkFieldsToActivateNext();
            }, 0);
          }, function (error) {
            console.log('error', error)
          });
        }
        catch (e) {
          console.log(e)
        }
      }
    };

    scope.onTouchStartOfAmountCalculator = onTouchStartOfAmountCalculator = function () {
      event.stopPropagation();
      amountCalcStartY = event.changedTouches[0].pageY;
      amountCalcStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfAmountCalculator = onTouchEndOfAmountCalculator = function () {
      event.stopPropagation();

      amountCalcEndY = event.changedTouches[0].pageY;
      amountCalcEndX = event.changedTouches[0].pageX;

      if (Math.abs(amountCalcStartY - amountCalcEndY) <= 20 && Math.abs(amountCalcStartX - amountCalcEndX) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';

          scope.confirmNote = question;
          scope.confirmType = 'local';

          window.common.alert.show("componentConfirmId", {
            parent: scope,
            "confirmnote": scope.confirmNote,
            "confirmtype": scope.confirmType
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

        window.api.call({
          method: 'rate.convert',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            amount: 1
          },

          scope: this,

          onSuccess: function (result) {
            console.log('rate.convert', result);
            if (result[0][0].error == 0) {

              scope.currencyRate = result[1][0].current_rate;
              scope.update(scope.currencyRate);
            }
            else {
              scope.errorNote = result[0][0].error_note;

              window.common.alert.show("componentAlertId", {
                parent: scope,
                errornote: scope.errorNote
              });

              scope.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: api_status_message
            });
          }
        });

        window.blurFields();

        scope.showComponent = true;
        window.checkShowingComponent = scope;
        amountCalcInputId.focus();
        scope.update();
      }
    };

    scope.closeCalculatorTouchStart = closeCalculatorTouchStart = function () {
      event.stopPropagation();
      closeIconStartY = event.changedTouches[0].pageY;
      closeIconStartX = event.changedTouches[0].pageX;
    };

    scope.closeCalculatorTouchEnd = closeCalculatorTouchEnd = function () {
      event.stopPropagation();

      closeIconEndY = event.changedTouches[0].pageY;
      closeIconEndX = event.changedTouches[0].pageX;

      if (Math.abs(closeIconStartY - closeIconEndY) <= 20 && Math.abs(closeIconStartX - closeIconEndX) <= 20) {
        scope.showComponent = false;
        window.checkShowingComponent = null;
        scope.update();
      }
    };

    scope.closeAmountComponentTouchStart = closeAmountComponentTouchStart = function () {
      event.stopPropagation();
      closeStartY = event.changedTouches[0].pageY;
      closeStartX = event.changedTouches[0].pageX;
    };

    scope.closeAmountComponentTouchEnd = closeAmountComponentTouchEnd = function () {
      event.stopPropagation();

      closeEndY = event.changedTouches[0].pageY;
      closeEndX = event.changedTouches[0].pageX;

      if (Math.abs(closeStartY - closeEndY) <= 20 && Math.abs(closeStartX - closeEndX) <= 20) {
        scope.showComponent = false;
        window.checkShowingComponent = null;
        scope.update();
      }
    };

    convertAmount = function () {

      event.stopPropagation();
      event.preventDefault();

      var converted;
      scope.convertedAmount = 0;

      var amountInput = accounting.formatMoney(amountCalcInputId.value, options);

      console.log("amountInput =", amountInput);

      var selectionStart = amountCalcInputId.selectionStart,
        notVerifiedValue = amountCalcInputId.value,
        delta;

      delta = notVerifiedValue.length - amountInput.length;

      console.log("selectionStart 1=", JSON.stringify(selectionStart));
      console.log("notVerifiedValue =", notVerifiedValue);
      console.log("delta =", delta);

      selectionStart = selectionStart - delta;
      selectionStart = (selectionStart < 0) ? (0) : (selectionStart);

      console.log("selectionStart 2=", JSON.stringify(selectionStart));

      amountCalcInputId.value = amountInput;

      setTimeout(function () {
          amountCalcInputId.selectionStart = selectionStart;
          amountCalcInputId.selectionEnd = selectionStart;
        }, 0
      );
      scope.convertedAmount = Math.ceil(accounting.unformat(amountCalcInputId.value) * scope.currencyRate);
      converted = accounting.formatMoney(scope.convertedAmount.toString(), options_for_calc);

      if (scope.convertedAmount > scope.service.max_pay_limit) {
        convertedAmountFieldId.style.borderBottomColor = 'red';
        acceptConvertedBtnId.style.pointerEvents = 'none';
        scope.convertedAmount = converted;
        scope.update(scope.convertedAmount);
      } else {
        convertedAmountFieldId.style.borderBottomColor = '#01cfff';
        acceptConvertedBtnId.style.pointerEvents = 'auto';
        scope.convertedAmount = converted;
        scope.update(scope.convertedAmount);
      }
    };

    scope.acceptConvertedAmountTouchStart = acceptConvertedAmountTouchStart = function () {
      event.stopPropagation();
      acceptStartY = event.changedTouches[0].pageY;
      acceptStartX = event.changedTouches[0].pageX;
    };

    scope.acceptConvertedAmountTouchEnd = acceptConvertedAmountTouchEnd = function () {
      event.stopPropagation();

      acceptEndY = event.changedTouches[0].pageY;
      acceptEndX = event.changedTouches[0].pageX;

      if (Math.abs(acceptStartY - acceptEndY) <= 20 && Math.abs(acceptStartX - acceptEndX) <= 20) {
        convertAmount();
        amount.value = scope.convertedAmount;


        if (amount.value.match(maskTwo) != null && amount.value.match(maskTwo).length != null) {

          amount.value = amount.value.substring(0, amount.value.match(maskTwo).length);

          amountForPayTransaction = amount.value.substring(0, amount.value.match(maskTwo).length);
          amountForPayTransaction = amountForPayTransaction.replace(new RegExp(' ', 'g'), '');

          amount.value = window.amountTransform(amountForPayTransaction);
          checkFirst = true;
        }

        opts.amountText = amount.value;
        opts.amountWithoutSpace = amountForPayTransaction;
        scope.showComponent = false;
        window.checkShowingComponent = null;
        scope.update();
        checkFieldsToActivateNext();
      }
    };


    if (scope.servicesMap[opts.chosenServiceId]) {
      scope.service = scope.servicesMap[opts.chosenServiceId][0];
      console.log("SERVICE", scope.service);

      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;
      scope.commissionPercent = scope.service.commission_percent;
      scope.low_ratio = scope.service.low_ratio;
      scope.rate = scope.service.rate;
      scope.nds = scope.service.nds;
      scope.currency = scope.service.currency;
      opts.currency = scope.service.currency;

      if (parseInt(opts.amountWithoutSpace) >= 1000) {
        opts.commissionPercent = scope.commissionPercent;
        opts.nds = scope.nds;
        scope.toEnrollment = window.calculateEnrollment(parseInt(opts.amountWithoutSpace), scope.service.rate, scope.service.low_ratio);
        opts.toEnrollment = scope.toEnrollment;
        scope.amountForPayTransaction = parseInt(opts.amountWithoutSpace);
      } else {
        scope.toEnrollment = 0;
      }
      scope.update();
    }

    //Editing amount input for non editable situations

    if (!scope.service['amount_editable'] && scope.service['amount_value']) {
      scope.defaultAmount = window.amountTransform(scope.service['amount_value']);
      opts.amountText = scope.service['amount_value'];
      if (scope.service['amount_information_text']) {
        scope.showErrorOfLimit = true;
        scope.placeHolderText = scope.service['amount_information_text']
      }
      scope.enterButtonEnabled = true;
      scope.update();
    }

    scope.fieldArray = scope.servicesParamsMapOne[opts.chosenServiceId];
    console.log('field array filled:', JSON.stringify(scope.fieldArray));
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;

    var maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      amountForPayTransaction = 0,
      checkFirst = false;

    console.log("Yahoo1 formType=", scope.formType);

    if (scope.fieldArray) {
      scope.dropDownOn = scope.fieldArray.length > 1;
      scope.chosenFieldName = opts.firstFieldTitle ? opts.firstFieldTitle : scope.fieldArray[0].title;
      scope.chosenFieldParamId = opts.firstFieldId ? opts.firstFieldId : scope.fieldArray[0].parameter_id;
      opts.first_field_value = opts.firstFieldText ? opts.firstFieldText : null;
      scope.amountFieldTitle = scope.service.lang_amount_title;
      console.log("PARAMETER ID ", scope.fieldArray[0].parameter_id, scope.fieldArray[0]);
      scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1" || scope.fieldArray[0].parameter_id == "65536" || scope.fieldArray[0].parameter_id == "128";
      scope.calcOn = scope.service.show_calc == 1;

      if (scope.phoneFieldBool) {
        scope.defaultNumber = !opts.firstFieldText ? null : inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.firstFieldText));
        console.log("PHONE FIELD", scope.defaultNumber);
      }
      scope.inputMaxLength = scope.fieldArray[0].max_len;
      scope.hasPrefixes = false;
      scope.prefixesArray = [];

      if (scope.servicesParamsMapSix[opts.chosenServiceId]) {

        for (var i in scope.servicesParamsMapSix[opts.chosenServiceId]) {
          if (scope.servicesParamsMapSix[opts.chosenServiceId][i].parent_param_id == scope.chosenFieldParamId)
            scope.prefixesArray.push(scope.servicesParamsMapSix[opts.chosenServiceId][i]);
        }
        if (scope.prefixesArray.length > 0) {

          scope.hasPrefixes = true;

          for (var i = 0; i < scope.prefixesArray.length; i++) {
            if (opts.firstFieldText && opts.firstFieldText.indexOf(scope.prefixesArray[i].title) >= 0) {
              var pref = scope.prefixesArray[i].title;
              scope.chosenPrefixTitle = scope.prefixesArray[i].title;
              scope.chosenPrefixId = scope.prefixesArray[i].title;
              scope.chosenPrefixName = scope.prefixesArray[i].name;
              scope.defaultNumber = opts.firstFieldText.substring(opts.firstFieldText.indexOf(pref) + pref.length, opts.firstFieldText.length);
              break;
            }
          }

          if (scope.chosenPrefixTitle == null || scope.chosenPrefixTitle == undefined) {
            scope.chosenPrefixTitle = opts.chosenPrefixTitle ? opts.chosenPrefixTitle : scope.prefixesArray[0].title;
            scope.chosenPrefixId = opts.chosenPrefixId ? opts.chosenPrefixId : scope.prefixesArray[0].option_id;
            scope.chosenPrefixName = opts.chosenPrefixName ? opts.chosenPrefixName : scope.prefixesArray[0].name;
          }
          console.log(scope.chosenPrefixTitle);
        }
      }

//          console.log("Yahoooo_2", scope.fieldArray, scope.fieldArray[i], scope.fieldArray[i].input_type);

      if (opts.amountText) {
        scope.defaultAmount = window.amountTransform(opts.amountText);
        amountForPayTransaction = inputVerification.spaceDeleter(opts.amountText)
      }


      if (!scope.placeHolderText)
        scope.placeHolderText = "от " + window.amountTransform(scope.service.min_pay_limit) + " " + scope.service.lang_amount_currency + " до " + window.amountTransform(scope.service.max_pay_limit) + " " + scope.service.lang_amount_currency

      scope.update();
      scope.inputMaxLength = scope.fieldArray[0].max_len;

      if (scope.dropDownOn) {
        scope.chosenFieldParamId = opts.firstFieldId ? opts.firstFieldId : scope.fieldArray[0].parameter_id;
//          scope.oldFieldParamId = scope.fieldArray[1].parameter_id;
      }

      if (scope.fieldArray[0].input_type == '1' && modeOfApp.onlineMode) {
        scope.inputType = 'tel';
        scope.isNumber = true;
      }
      else if (scope.fieldArray[0].input_type == '2' && modeOfApp.onlineMode) {
        scope.inputType = 'text';
        scope.isNumber = false;
      }
      else if (modeOfApp.offlineMode) {
        scope.inputType = 'tel';
        scope.isNumber = true;
      }
      scope.amountLength = ("" + scope.service.max_pay_limit).length;
    }

    checkFieldsToActivateNext();


    scope.openDropdownComponent = openDropdownComponent = function () {

      dropdownBackPageId.style.webkitTransition = '0.3s';
      servicePageId.style.webkitTransition = '0.3s';
      servicePageId.style.zIndex = '0';
      servicePageId.style.opacity = '0.1';
      dropdownId.style.webkitTransition = '0.3s';
      dropdownId.style.transform = "translate3d(0, 0, 0)";
      dropdownId.style.webkitTransform = "translate3d(0, 0, 0)";
      dropdownBackPageId.style.opacity = '1';
      setTimeout(function () {
        window.blurFields();
      }, 200);

    };

    scope.processDropdown = processDropdown = function (id, title) {
      console.log("id got from dropdown =", id, title);
      switch (scope.dropDownType) {
        case "firstField": {
          chooseFirstField(id);
          break;
        }
        case "prefixes": {
          choosePrefix(id);
          break;
        }
      }
    };

    openFirstFieldDropDown = function () {

      console.log("open drop down", scope.fieldArray, scope.chosenFieldParamId);
      scope.dropDownType = "firstField";
      updateDropdownList(scope.fieldArray, "parameter_id", scope.chosenFieldParamId, "title", "servicePageId");
      openDropdownComponent();
    };


    openPrefixesDropDown = function () {

      console.log("open prefixes drop down", scope.prefixesArray, scope.chosenPrefixId);
      scope.dropDownType = "prefixes";
      updateDropdownList(scope.prefixesArray, "option_id", scope.chosenPrefixId, "name", "servicePageId");
      openDropdownComponent();

    };

    chooseFirstField = function (id) {

      for (var i = 0; i < scope.fieldArray.length; i++) {

//        console.log("Yahoo2", id, scope.fieldArray, scope.fieldArray[i], scope.fieldArray[i].parameter_id);
        if (scope.fieldArray[i].parameter_id == id) {
          scope.chosenFieldName = scope.fieldArray[i].title;
          scope.chosenFieldPlaceholder = scope.fieldArray[i].placeholder;
          console.log("PARAMETER ID ", scope.fieldArray[i].parameter_id);
          scope.phoneFieldBool = scope.fieldArray[i].parameter_id == "1" || scope.fieldArray[0].parameter_id == "65536" || scope.fieldArray[0].parameter_id == "128";
          scope.inputMaxLength = scope.fieldArray[i].max_len;


//          console.log("Yahoooo_2", scope.fieldArray, scope.fieldArray[i], scope.fieldArray[i].input_type);

          if (scope.fieldArray[i].input_type == '1' && modeOfApp.onlineMode) {
            scope.inputType = 'tel';
            scope.isNumber = true;
          }
          else if (scope.fieldArray[i].input_type == '2' && modeOfApp.onlineMode) {
            scope.inputType = 'text';
            scope.isNumber = false;
          }
          else if (modeOfApp.offlineMode) {
            scope.inputType = 'tel';
            scope.isNumber = true;
          }
          scope.oldFieldParamId = scope.chosenFieldParamId;
          scope.chosenFieldParamId = id;
          firstFieldInput.value = '';
          scope.chosenPrefixTitle = null;
          scope.chosenPrefixId = null;
          scope.chosenPrefixName = null;

          if (scope.servicesParamsMapSix[opts.chosenServiceId]) {
            scope.hasPrefixes = false;
            scope.prefixesArray = [];
            for (var i in scope.servicesParamsMapSix[opts.chosenServiceId]) {
              if (scope.servicesParamsMapSix[opts.chosenServiceId][i].parent_param_id == scope.chosenFieldParamId)
                scope.prefixesArray.push(scope.servicesParamsMapSix[opts.chosenServiceId][i]);
            }
            if (scope.prefixesArray.length > 0) {
              scope.hasPrefixes = true;
              scope.chosenPrefixTitle = scope.prefixesArray[0].title;
              scope.chosenPrefixId = scope.prefixesArray[0].option_id;
              scope.chosenPrefixName = scope.prefixesArray[0].name;
              console.log("scope.hasPrefixes", scope.hasPrefixes);
            }
          }

          scope.update();
          break;
        }
      }

    };

    choosePrefix = function (id) {

      for (var i = 0; i < scope.prefixesArray.length; i++) {

        if (scope.prefixesArray[i].option_id == id) {
          scope.chosenPrefixTitle = scope.prefixesArray[i].title;
          scope.chosenPrefixName = scope.prefixesArray[i].name;

          scope.oldPrefixId = scope.chosenPrefixId;
          scope.chosenPrefixId = id;
          scope.update(scope.chosenPrefixTitle);
          break;
        }
      }
      focusFieldGlobal('firstFieldInput');
    };

    eraseAmountDefault = function () {
      console.log("in erase amount default");
      event.preventDefault();
      event.stopPropagation();

      if (!checkFirst) {
//        amount.value = '';
        checkFirst = true;
      }

      checkFieldsToActivateNext('sum')

    };

    // amountOnKeyUp = function () {
    //
    //   if (!amountFormatted) {
    //     console.log("onKeyUp amountFormatted false call sumForPay");
    //     sumForPay();
    //   } else {
    //     amountFormatted = false;
    //     console.log("onKeyUp amountFormatted true");
    //   }
    // };

    amountOnInput = function () {
      // amountFormatted = true;
      // console.log("ONINPUT");
      sumForPay()
      // setTimeout(sumForPay(), 0);

    };

    sumForPay = function () {
      event.preventDefault();
      event.stopPropagation();

      var amountInput = accounting.formatMoney(amount.value, options);

      console.log("amountInput =", JSON.stringify(amountInput));

      var selectionStart = amount.selectionStart,
        notVerifiedValue = amount.value,
        delta;

      delta = notVerifiedValue.length - amountInput.length;

      console.log("selectionStart 1=", JSON.stringify(selectionStart));
      console.log("notVerifiedValue =", JSON.stringify(notVerifiedValue));
      console.log("delta =", JSON.stringify(delta));

      selectionStart = selectionStart - delta;
      selectionStart = (selectionStart < 0) ? (0) : (selectionStart);

      console.log("selectionStart 2=", JSON.stringify(selectionStart));
      console.log("");

      amount.value = amountInput;

      setTimeout(function () {
          console.log('set time out');
          amount.selectionStart = selectionStart;
          amount.selectionEnd = selectionStart;
        }, 0
      );

      amountForPayTransaction = accounting.unformat(amount.value);

      opts.amountText = amount.value;
      opts.amountWithoutSpace = amountForPayTransaction;

      if (amountForPayTransaction >= 1000) {
        opts.commissionPercent = scope.commissionPercent;
        opts.nds = scope.nds;
        scope.toEnrollment = window.calculateEnrollment(amountForPayTransaction, scope.service.rate, scope.service.low_ratio);
        opts.toEnrollment = scope.toEnrollment;
        scope.amountForPayTransaction = amountForPayTransaction;
      } else {

        scope.toEnrollment = 0;
      }
      scope.update();
      checkFieldsToActivateNext('sum');
    };

    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';
      }

      enterStartY = event.changedTouches[0].pageY;
      enterStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfEnter = onTouchEndOfEnter = function () {
      event.stopPropagation();

      opts.cost = scope.service.cost;
      opts.lang_amount_title = scope.service.lang_amount_title;

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(1)';
//        this.enterButtonId.style.backgroundColor = '#00a8f1';
      }

      enterEndY = event.changedTouches[0].pageY;
      enterEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterStartY - enterEndY) <= 20 && Math.abs(enterStartX - enterEndX) <= 20) {

        window.blurFields();

        opts.formtype = scope.formType;
        opts.firstFieldId = scope.chosenFieldParamId;
        opts.firstFieldText = firstFieldInput.value;
        opts.firstFieldTitle = scope.chosenFieldName;
        opts.cardTypeId = null;
        opts.amountText = amountForPayTransaction;
        opts.firstLevelParamId = scope.chosenFieldParamIdTwo;
        opts.firstLevelFieldName = scope.chosenFieldNameTwo;
        opts.secondLevelFieldName = scope.chosenFieldNameThree;
        opts.chosenPrefixTitle = scope.chosenPrefixTitle;
        opts.chosenPrefixId = scope.chosenPrefixId;
        opts.chosenPrefixName = scope.chosenPrefixName;

        history.arrayOfHistory[history.arrayOfHistory.length - 1].params = opts;
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


        if (opts.mode == 'USUAL' || opts.mode == 'POPULAR' || !opts.mode) {

          opts.isInFavorites = !scope.enterButton;
          opts.transactionId = parseInt(Date.now() / 1000);

          event.preventDefault();
          event.stopPropagation();


          if (modeOfApp.offlineMode) {

            console.log('USSD TEMPLATE', scope.fieldArray[0].ussd_query)

            var ussdQuery = scope.fieldArray[0].ussd_query;

            console.log('opts.formtype', opts)
            console.log("opts in ussd", JSON.stringify(opts))


            if (ussdQuery) {
              if (opts.firstFieldText) {
                ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              }
              else {
                ussdQuery = ussdQuery.replace('*{param}', opts.firstFieldText);
              }
//              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (ussdQuery === null) {
              scope.clickPinError = false;
              scope.errorNote = ("Сервис временно недоступен!");

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote,
              });

              scope.update();
              return
            }

            console.log('USSD', ussdQuery, opts)

            console.log(ussdQuery + "%23")

            phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
              ussdQuery + "%23",
              function (err) {
                if (err == "empty") {
                  scope.clickPinError = false;
                  scope.errorNote = ("Unknown phone number");

                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: scope.clickPinError,
                    errornote: scope.errorNote,
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
          else {

            if (scope.service.additional_information_type == 0) {
              this.riotTags.innerHTML = "<view-service-pincards-new>";
              riot.mount('view-service-pincards-new', opts);
              scope.unmount()
            } else {
              localStorage.setItem('click_client_infoCacheEnabled', null)
              this.riotTags.innerHTML = "<view-service-info-new>";
              riot.mount('view-service-info-new', opts);
              scope.unmount()
            }


          }
        } else if (opts.mode == 'ADDFAVORITE') {

          console.log("isInFavorites=", opts.isInFavorites)

          opts.favoriteName = favoriteNameInput.value;
          viewServicePinCards.friendHelpPaymentMode = false;
          viewServicePinCards.chosenFriendForHelp = null;

          if (opts.isInFavorites) {
            editFavoritePaymentGlobal(opts, opts.favoriteId, scope);
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown();
          }
          else {
            opts.isInFavorites = true;
            addPaymentToFavorites(opts, scope.service, scope.fieldArray[0].ussd_query, scope);
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown();
            onBackKeyDown();
          }


        } else if (opts.mode == 'ADDAUTOPAY') {

          if (autoPayNameInput.value.length < 1) {
            scope.clickPinError = false;
            scope.errorNote = "Введите название автоплатежа";

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
            });

            scope.update();
            return;
          }

          scope.autoPayData.name = autoPayNameInput.value;
          localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

          if (scope.autoPayData.fromView == 'PAY') {
            this.riotTags.innerHTML = "<view-service-pincards-new>";
            riot.mount('view-service-pincards-new', opts);
            scope.unmount()

          } else if (scope.autoPayData.fromView == 'PAYCONFIRM') {
            this.riotTags.innerHTML = "<view-pay-confirm-new>";
            riot.mount('view-pay-confirm-new', opts);
            scope.unmount()

          }

        }

      }
    };


  </script>
</view-formtype-one>

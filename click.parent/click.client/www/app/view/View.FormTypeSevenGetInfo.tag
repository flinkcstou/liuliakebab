<view-formtype-seven-getinfo class="riot-tags-main-container">

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

      <div class="servicepage-fields-dropdown" ontouchend="openFirstFieldDropDown()"
           id="firstFieldChoiceId">
        <p class="servicepage-dropdown-text-field">{chosenFieldName}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <div class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
           id="amountField">
        <p id="amountFieldTitle" class="servicepage-text-field">{amountFieldTitle}</p>
        <p if="{commissionPercent}" class="servicepage-amount-tax-text-field">
          {window.languages.ViewServicePageAmountTaxText} {tax}
          {window.languages.Currency}</p>
        <input class="servicepage-amount-input" type="tel" value="{defaultAmount}" maxlength="10"
               id="amount"
               readonly="{!service['amount_editable']}"
               pattern="[0-9]"
               placeholder="{placeHolderText}"
               onfocus="colorField('amount')"
               onmouseup="eraseAmountDefault()" onkeyup="sumForPay()" oninput="sumForPay()"/>
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
    var amountCalcStartY, amountCalcStartX, amountCalcEndY, amountCalcEndX;
    var closeIconStartY, closeIconStartX, closeIconEndY, closeIconEndX;
    var closeStartY, closeStartX, closeEndY, closeEndX;
    var acceptStartY, acceptStartX, acceptEndY, acceptEndX;
    var enterStartY, enterStartX, enterEndY, enterEndX;
    scope.showErrorOfLimit = false;
    var onPaste = false;
    scope.selectedId = '';

    console.log("opts in FormTypeSeven GetInfo", opts);

    window.saveHistory('view-formtype-seven-getinfo', opts);

    if (opts.id) {
      opts.chosenServiceId = opts.id;
    }
    if (opts.amountText) {
      opts.amountText = !opts.amountText ? 0 : window.amountTransform(opts.amountText.toString());
      scope.tax = opts.tax ? opts.tax : 0;
      scope.update();
    }

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));

    scope.enterButton = opts.mode == 'ADDFAVORITE' ? false : true;
    scope.enterButtonEnabled = false;
    scope.showConfirm = false;
    var payment_data;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    if (loginInfo)
      var sessionKey = loginInfo.session_key;

    scope.update();

    if (opts.formtype == 7) {
      payment_data = {
        "value": opts.firstFieldText,
        "secondary_value": opts.secondFieldValue
      };
    }

    console.log("payment data =", payment_data);


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


    paymentNameVerificationKeyUp = function () {

      checkFieldsToActivateNext();

    };

    this.on('mount', function () {

    });

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
      var converted;
      scope.convertedAmount = 0;

      scope.convertedAmount = Math.ceil(amountCalcInputId.value * scope.currencyRate);
      converted = window.amountTransform(scope.convertedAmount.toString());

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
      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;
      scope.commissionPercent = scope.service.commission_percent;
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
      console.log("PARAMETER ID ", scope.fieldArray[0].parameter_id, scope.fieldArray[0])
      console.log("Service ", scope.service)
      scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1" || scope.fieldArray[0].parameter_id == "65536" || scope.fieldArray[0].parameter_id == "128";
      scope.calcOn = scope.service.cost == 1;

      if (scope.phoneFieldBool) {
        scope.defaultNumber = !opts.firstFieldText ? null : inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.firstFieldText));
        console.log("PHONE FIELD", scope.defaultNumber);
      }
      scope.inputMaxLength = scope.fieldArray[0].max_len;
//      scope.hasPrefixes = false;
//      scope.prefixesArray = [];
//
//      if (scope.servicesParamsMapSix[opts.chosenServiceId]) {
//
//        for (var i in scope.servicesParamsMapSix[opts.chosenServiceId]) {
//          if (scope.servicesParamsMapSix[opts.chosenServiceId][i].parent_param_id == scope.chosenFieldParamId)
//            scope.prefixesArray.push(scope.servicesParamsMapSix[opts.chosenServiceId][i]);
//        }
//        if (scope.prefixesArray.length > 0) {
//          scope.hasPrefixes = true;
//          scope.chosenPrefixTitle = opts.chosenPrefixTitle ? opts.chosenPrefixTitle : scope.prefixesArray[0].title;
//          scope.chosenPrefixId = opts.chosenPrefixId ? opts.chosenPrefixId : scope.prefixesArray[0].option_id;
//          scope.chosenPrefixName = opts.chosenPrefixName ? opts.chosenPrefixName : scope.prefixesArray[0].name;
//        }
//      }

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


    eraseAmountDefault = function () {
      console.log("in erase amount default");
      event.preventDefault();
      event.stopPropagation();

      if (!checkFirst) {
//        amount.value = '';
        checkFirst = true;
      }
      if (amount.value.match(maskOne) != null && amount.value.match(maskOne).length != null) {
        amount.selectionStart = amount.value.match(maskTwo).length;
        amount.selectionEnd = amount.value.match(maskTwo).length;
      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      checkFieldsToActivateNext('sum')

    };

    sumForPay = function () {
      event.preventDefault();
      event.stopPropagation();

      if (amount.value.length == 1) {
        amount.value = window.amountTransform(amount.value)
      }

      if (event.keyCode == 8) {
        amountForPayTransaction = amountForPayTransaction.substring(0, amountForPayTransaction.length - 1)
      }

      if (amount.value.match(maskTwo) != null && amount.value.match(maskTwo).length != null) {

        amount.value = amount.value.substring(0, event.target.value.match(maskTwo).length);
        amount.selectionStart = amount.value.match(maskTwo).length;
        amount.selectionEnd = amount.value.match(maskTwo).length;

        amountForPayTransaction = amount.value.substring(0, amount.value.match(maskTwo).length);
        amountForPayTransaction = amountForPayTransaction.replace(new RegExp(' ', 'g'), '');

        amount.value = window.amountTransform(amountForPayTransaction);

      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      opts.amountText = amount.value;
      opts.amountWithoutSpace = amountForPayTransaction;

      if (amountForPayTransaction >= 1000) {
        scope.tax = amountForPayTransaction * scope.commissionPercent / 100;
        opts.tax = scope.tax;
      }
      scope.update();
      checkFieldsToActivateNext('sum');
    };


    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';
//        this.enterButtonId.style.backgroundColor = '#76c1f4';
      }

      if (this.formTypeTwoBtnId) {
        this.formTypeTwoBtnId.style.webkitTransform = 'scale(0.8)';
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


      }
    };


  </script>
</view-formtype-seven-getinfo>

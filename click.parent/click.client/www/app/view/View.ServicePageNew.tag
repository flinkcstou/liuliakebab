<view-service-page-new class="riot-tags-main-container">

  <div id="servicePageId" class="view-service-page">

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

    <div class="servicepage-body-container" if="{formType!=2}">

      <div id="autopayField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
        <p id="autoPayNameTitle" class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="paymentNameVerificationKeyUp()" onfocus="colorField('autopay')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="paymentNameVerificationKeyUp()" onfocus="colorField('favorite')"/>
      </div>

      <div class="servicepage-fields-dropdown" if="{dropDownOn}" ontouchend="openFirstFieldDropDown()"
           id="firstFieldChoiceId">
        <p class="servicepage-dropdown-text-field">{chosenFieldName}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <div class="servicepage-second-dropdown-field" if="{hasFirstLevel && service.category_id!=11}"
           ontouchend="openDropDownTwo()" role="button" aria-label="{chosenFieldNameTwo}">
        <p if="{formType==3 || formType==4 || formType==5 || formType==6}"
           class="servicepage-text-field servicepage-second-dropdown-field-text">
          {(service.options_title)?(service.options_title):("")}</p>
        <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <div
        class="{servicepage-second-dropdown-field:formType!=3, servicepage-second-dropdown-field-diftop: formType==3}"
        if="{hasSecondLevel&& service.category_id!=11}"
        ontouchend="openDropDownThree()" role="button" aria-label="{chosenFieldNameThree}">
        <p class="servicepage-dropdown-text-field">{chosenFieldNameThree}</p>
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
               onfocus="colorField('firstField')"
               value="{defaultNumber || opts.first_field_value}"
               oninput="telVerificationOnInput()"
               onpaste="telVerificationOnPaste()"
               onkeyup="telPayVerificationKeyUp()"
               onkeydown="telPayVerificationKeyDown(this)"/>
        <div class="servicepage-phone-icon" role="button" aria-label="{window.languages.ChooseFromContacts}"
             if="{phoneFieldBool}" ontouchstart="onTouchStartOfSearchContact()"
             ontouchend="onTouchEndOfSearchContact()"></div>
      </div>

      <div class="servicepage-second-dropdown-field-pakety" role="button" aria-label="{chosenFieldNameTwo}"
           if="{hasFirstLevel&& service.category_id==11}"
           ontouchend="openDropDownTwo()" role="button" aria-label="{chosenFieldNameTwo}">
        <p if="{formType==3 || formType==4}" class="servicepage-text-field servicepage-second-dropdown-field-text">
          {(service.options_title)?(service.options_title):("")}</p>
        <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <div class="servicepage-second-dropdown-field-pakety" role="button" aria-label="{chosenFieldNameThree}"
           if="{hasSecondLevel&& service.category_id==11}"
           ontouchend="openDropDownThree()" role="button" aria-label="{chosenFieldNameThree}">
        <p class="servicepage-dropdown-text-field">{chosenFieldNameThree}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <div hidden="{formType==5 || formType==6}"
           class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
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


    <div id="blockPrefixId" class="component-first-field">
      <div type="button" class="servicepage-fields-dropdown-close-button" role="button"
           aria-label="{window.languages.Close}"
           ontouchend="closePrefixDropdownTouchEnd()" ontouchstart="closePrefixDropdownTouchStart()"></div>
      <div class="servicepage-fields-dropdown-two">
        <p class="servicepage-dropdown-text-field" style="color: white;">{chosenPrefixTitle}</p>
      </div>
      <div class="servicepage-dropdown-container">
        <div class="servicepage-dropdown-variant" each="{i in prefixesArray}" id="e{i.option_id}"
             ontouchstart="onTouchStartOfDropdown()" ontouchend="choosePrefix(this.id)">
          <p id="text{i.option_id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.title}</p>
        </div>
      </div>
    </div>

    <div id="blockSecondDropdownId" class="component-first-field">
      <div type="button" class="servicepage-fields-dropdown-close-button" role="button"
           aria-label="{window.languages.Close}"
           ontouchend="closeSecondDropdownTouchEnd()" ontouchstart="closeSecondDropdownTouchStart()"></div>
      <div class="servicepage-fields-dropdown-two">
        <p class="servicepage-dropdown-text-field" style="color: white;">
          {(secondLevelArray && secondLevelArray[0])?(secondLevelArray[0].name):("")}</p>
      </div>
      <div class="servicepage-dropdown-container">
        <div class="servicepage-dropdown-variant" each="{i in secondLevelArray}" id="two{i.id}" if="{formType==3}"
             ontouchstart="onTouchStartOfDropdownThree()" ontouchend="onTouchEndOfDropdownThree({i.id})">
          <p id="texttwo{i.id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
        </div>
        <div class="servicepage-dropdown-variant"
             each="{i in secondLevelArray}"
             id="{i.code}"
             if="{formType==4}"
             ontouchstart="onTouchStartOfDropdownThree()"
             ontouchend="onTouchEndOfDropdownThree(this.id)"
             style="height: unset;">
          <p id="texttwo{i.code}" class="servicepage-dropdown-text-field"
             style="padding-left: 6%;
            width: 88%;
            word-wrap: break-word;
            overflow: unset;
            white-space: unset;
            position: unset;
            padding-top: {30 * widthK}px;
            padding-bottom: {30 * widthK}px;">
            {i.name}</p>
        </div>
      </div>
    </div>

    <div class="servicepage-formtype-two-container" if="{formType==2}">

      <div id="autopayField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
        <p id="autoPayNameTitle" class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="paymentNameVerificationKeyUp()" onfocus="colorFieldFormTypeTwo('autopay')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="paymentNameVerificationKeyUp()" onfocus="colorFieldFormTypeTwo('favorite')"/>
      </div>

      <div
        class="{servicepage-pincards-container: opts.mode == 'USUAL',
      servicepage-pincards-container-two: opts.mode != 'USUAL'}">
        <div class="servicepage-pincards-block-container" each="{i in pincardIds}">
          <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
          <div class="servicepage-pincard-nominal-container" each="{j in pincardsMap[i]}"
               ontouchstart="onTouchStartOfPincard()" ontouchend="onTouchEndOfPincard({j.nominal},{j.card_type_id})">
            <p class="servicepage-pincard-nominal-value">{j.nominal}</p>
            <div id="radio{j.card_type_id+j.nominal}" class="{servicepage-pincard-radio-selected:'radio'+j.card_type_id+j.nominal == selectedId,
          servicepage-pincard-radio-unselected:'radio'+j.card_type_id+j.nominal != selectedId}"></div>
          </div>
        </div>
      </div>

      <button id="formTypeTwoBtnId" style="bottom: {window.bottomButtonBottom}"
              class="servicepage-button-enter-disabled"
              ontouchstart="onTouchStartOfEnter()"
              ontouchend="formTypeTwoButtonFunction()">
        {!enterButton?window.languages.ViewServicePageSaveLabel:window.languages.ViewServicePageEnterLabel}
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

  <component-dropdown dropdownlist="dropdownList"></component-dropdown>
  <component-tour view="calculator" focusfield="{true}"></component-tour>

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
    var closePrefixDropdownTouchStartX, closePrefixDropdownTouchStartY,
      closePrefixDropdownTouchEndX, closePrefixDropdownTouchEndY;
    var closeSecondDropdownTouchStartX, closeSecondDropdownTouchStartY,
      closeSecondDropdownTouchEndX, closeSecondDropdownTouchEndY;
    var enterStartY, enterStartX, enterEndY, enterEndX;
    var contactStopChanging = false;
    scope.showErrorOfLimit = false;
    var onPaste = false;
    scope.selectedId = '';

    console.log("opts in ServicePageNew", opts);

    window.saveHistory('view-service-page-new', opts);

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
    scope.servicesParamsMapTwo = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"))) : (offlineServicesParamsMapTwo);
    scope.servicesParamsMapThree = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) : (offlineServicesParamsMapThree);
    scope.servicesParamsMapFour = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"))) : (offlineServicesParamsMapFour);
    scope.servicesParamsMapFive = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"))) : (offlineServicesParamsMapFive);
    scope.servicesParamsMapSix = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapSix"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapSix"))) : (offlineServicesParamsMapSix);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));

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

      if (scope.service.form_type != 5 && scope.service.form_type != 6) {
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

      if (scope.formType == 3 || scope.formType == 5 || scope.formType == 6) {

        if (scope.hasSecondLevel)
          opts.communalParam = scope.chosenFieldParamIdThree;
        else
          opts.communalParam = scope.chosenFieldParamIdTwo;

        if (!opts.communalParam) {
          if (scope.hasSecondLevel)
            console.log("Выберите город и район");
          else {
            console.log("Выберите район");
            if (scope.formType == 6) {
              opts.communalParam = scope.chosenPrefixId;
              scope.enterButtonEnabled = true;
              scope.update(scope.enterButtonEnabled);
              return;
            }
          }

          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        }

      } else if (scope.formType == 4) {
        if (scope.chosenFieldParamIdThree)
          opts.internetPackageParam = scope.chosenFieldParamIdThree;
        else {
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        }
      } else if (scope.formType != 5 && scope.formType != 6) {

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

    paymentNameVerificationKeyUp = function () {

      if (scope.formType != 2) {
        checkFieldsToActivateNext();
      }
      else {
        if (opts.mode == 'ADDAUTOPAY' && this.autoPayNameInput && this.autoPayNameInput.value.length < 1) {
          formTypeTwoBtnId.style.pointerEvents = 'none';
          formTypeTwoBtnId.style.backgroundColor = '#D2D2D2';
          scope.update(formTypeTwoBtnId);
          return;
        }
        if (opts.mode == 'ADDFAVORITE' && this.favoriteNameInput && this.favoriteNameInput.value.length < 1) {
          formTypeTwoBtnId.style.pointerEvents = 'none';
          formTypeTwoBtnId.style.backgroundColor = '#D2D2D2';
          scope.update(formTypeTwoBtnId);
          return;
        }
        if (opts.cardTypeId || opts.amountText) {
          formTypeTwoBtnId.style.pointerEvents = 'auto';
          formTypeTwoBtnId.style.backgroundColor = '#00a8f1';
          scope.update(formTypeTwoBtnId);
        }
      }
    };

    this.on('mount', function () {

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).calculator && scope.calcOn) {

        window.blurFields();
        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#ffffff");
      }
      else {
        focusFieldAfterTourClosed();
      }

      if (opts && opts.number) {
        firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.number));
        scope.update();
      }

      if (opts.amountWithoutSpace && opts.amountWithoutSpace.length > 0) {
        amount.value = opts.amountText;
        checkFirst = true;
        amountForPayTransaction = opts.amountWithoutSpace;
      }
      else if (scope.formType != 2) {
        checkFieldsToActivateNext();
      }
    });

    scope.focusFieldAfterTourClosed = focusFieldAfterTourClosed = function () {

      if (opts.mode != 'ADDAUTOPAY' && opts.mode != 'ADDFAVORITE') {
        console.log("focus!!! scope.myNumberMode=", scope.myNumberMode);
        if (scope.myNumberMode) {
          if (device.platform == 'iOS') {
            this.amount.autofocus;
            this.amount.focus();
          } else {
            setTimeout(function () {
              if (this.amount) {
                this.amount.focus();
              }
            }, 0);
          }
        } else {
          if (device.platform == 'iOS') {
            firstFieldInput.autofocus;
            firstFieldInput.focus();
          } else {
            setTimeout(function () {
              if (this.firstFieldInput) {
                firstFieldInput.focus();
              }
            }, 0);
          }
        }
      } else if (opts.mode == 'ADDAUTOPAY') {
        if (device.platform == 'iOS') {
          autoPayNameInput.autofocus;
          autoPayNameInput.focus();
        } else {
          setTimeout(function () {
            if (this.autoPayNameInput)
              autoPayNameInput.focus();
          }, 0);
        }
      } else if (opts.mode == 'ADDFAVORITE') {
        if (device.platform == 'iOS') {
          favoriteNameInput.autofocus;
          favoriteNameInput.focus();
        } else {
          setTimeout(function () {
            if (this.favoriteNameInput)
              favoriteNameInput.focus();
          }, 0);
        }
      }
      scope.update()
    };

    colorField = function (field) {
      if (field == 'firstField') {
        firstField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        firstFieldTitle.style.color = '#01cfff';
        amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        amountFieldTitle.style.color = 'gray';
        if (opts.mode == 'ADDAUTOPAY') {
          autopayField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          autoPayNameTitle.style.color = 'gray';
        } else if (opts.mode == 'ADDFAVORITE') {
          favoriteField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          favoriteNameTitle.style.color = 'gray';
        }
      } else if (field == 'amount') {
        amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        amountFieldTitle.style.color = '#01cfff';
        firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        firstFieldTitle.style.color = 'gray';
        if (opts.mode == 'ADDAUTOPAY') {
          autopayField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          autoPayNameTitle.style.color = 'gray';
        } else if (opts.mode == 'ADDFAVORITE') {
          favoriteField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          favoriteNameTitle.style.color = 'gray';
        }
      } else if (field == 'autopay') {
        autopayField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        autoPayNameTitle.style.color = '#01cfff';
        firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        firstFieldTitle.style.color = 'gray';
        amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        amountFieldTitle.style.color = 'gray';
      } else if (field == 'favorite') {
        favoriteField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        favoriteNameTitle.style.color = '#01cfff';
        firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        firstFieldTitle.style.color = 'gray';
        amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        amountFieldTitle.style.color = 'gray';
      }

    };

    colorFieldFormTypeTwo = function (field) {
      if (field == 'autopay') {
        autopayField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        autoPayNameTitle.style.color = '#01cfff';
      } else if (field == 'favorite') {
        favoriteField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        favoriteNameTitle.style.color = '#01cfff';
      }
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

    console.log('VIEWPAY SERVICE', opts.chosenServiceId, 'mynumber' + localStorage.getItem('myNumberOperatorId'))
    if ((opts.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) || (modeOfApp.offlineMode && opts.chosenServiceId == 'mynumber') || opts.chosenServiceId == 'mynumber') {

      console.log("MY NUMBER ID");
      scope.myNumberMode = true;

      if (modeOfApp.onlineMode || opts.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
        scope.service = scope.servicesMap[localStorage.getItem('myNumberOperatorId')][0];
        scope.titleName = 'Мой номер';
        scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
        opts.firstFieldText = localStorage.getItem('click_client_phoneNumber');
        opts.firstFieldText = opts.firstFieldText ? opts.firstFieldText.substr(3, opts.firstFieldText.length - 3) : '';
        scope.fieldArray = scope.servicesParamsMapOne[localStorage.getItem('myNumberOperatorId')];
        console.log('FIELDARRAY', scope.fieldArray)
        opts.chosenServiceId = localStorage.getItem('myNumberOperatorId');
        scope.commissionPercent = scope.service.commission_percent;
        scope.amountFieldTop = '7%';

      }
      else if (opts.chosenServiceId == 'mynumber') {
        console.log('scope.servicesMap', scope.servicesMap['mynumber']);
        console.log('scope.servicesParamsMapOne', scope.servicesParamsMapOne);
        scope.service = localStorage.getItem('myNumberOperatorId') ? scope.servicesMap[localStorage.getItem('myNumberOperatorId')][0] : scope.servicesMap['mynumber'][0];

        scope.titleName = 'Мой номер';
        scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
        opts.firstFieldText = localStorage.getItem('click_client_phoneNumber');
        opts.firstFieldText = opts.firstFieldText ? opts.firstFieldText.substr(3, opts.firstFieldText.length - 3) : '';
        scope.fieldArray = [];
        scope.fieldArray[0] = {ussd_query: "*880*01999002*1*{amount}#", title: "Мой номер"};
        console.log('scope.fieldArray', scope.fieldArray)
        opts.chosenServiceId = localStorage.getItem('myNumberOperatorId') ? localStorage.getItem('myNumberOperatorId') : 'mynumber';

        scope.amountFieldTitle = 'Сумма';
        scope.commissionPercent = scope.service.commission_percent;
        scope.amountFieldTop = '5.5%';
      }

      scope.on('mount', function () {
        firstField.style.display = 'none';
        amountField.style.top = scope.amountFieldTop;

        console.log("opts.amountText", opts.amountText)

        if (opts.amountText) {
          if (opts.amountText.length > 0 && opts) {
            amount.value = window.amountTransform(opts.amountText);
            checkFirst = true;
            amountForPayTransaction = opts.amountWithoutSpace;

            if (!amountForPayTransaction) {
              amountForPayTransaction = (opts.amountText) ? (opts.amountText) : (0);
              amountForPayTransaction = parseInt(amountForPayTransaction);
            }
          }
        }

      });

    } else {

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

      if (scope.service.disable_cache && modeOfApp.onlineMode && !modeOfApp.demoVersion) {

        window.api.call({
          method: 'get.service.parameters',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            service_id: opts.chosenServiceId
          },

          scope: this,

          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              console.log('GET SERVICE PARAMETERS BY SERVICE', JSON.parse(JSON.stringify(result)))

              if (result[4]) {
                scope.servicesParamsMapFour = {};
                for (var i in result[4]) {
                  if (!scope.servicesParamsMapFour[result[4][i].service_id]) {
                    scope.servicesParamsMapFour[result[4][i].service_id] = [];
                    scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                  }
                  else
                    scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                }
              }
              if (result[5]) {
                scope.servicesParamsMapFive = {};
                for (var i in result[5]) {
                  if (!scope.servicesParamsMapFive[result[5][i].service_id]) {
                    scope.servicesParamsMapFive[result[5][i].service_id] = [];
                    scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                  }
                  else
                    scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                }
              }

              fill();

              localStorage.setItem("click_client_servicesParamsMapFour", JSON.stringify(scope.servicesParamsMapFour));
              localStorage.setItem("click_client_servicesParamsMapFive", JSON.stringify(scope.servicesParamsMapFive));

              function fill() {

                if (scope.formType == 4 && scope.servicesParamsMapFour[scope.service.id] && scope.servicesParamsMapFive[scope.service.id]) {
                  //scope.on('mount', function () {
                  console.log(scope);
                  amountField.style.display = 'none';
                  //});
                  scope.firstLevelArray = [];
                  scope.secondLevelMap = {};
                  scope.chosenFieldNameTwo = scope.servicesParamsMapFour[scope.service.id][0].name;
                  scope.hasSecondLevel = true;
                  scope.hasFirstLevel = true;

                  for (var i = 0; i < scope.servicesParamsMapFour[scope.service.id].length; i++) {
                    scope.firstLevelArray.push(scope.servicesParamsMapFour[scope.service.id][i]);
                  }
                  for (var i = 0; i < scope.servicesParamsMapFive[scope.service.id].length; i++) {
                    if (!scope.secondLevelMap[scope.servicesParamsMapFive[scope.service.id][i].type]) {
                      scope.secondLevelMap[scope.servicesParamsMapFive[scope.service.id][i].type] = [];
                      scope.secondLevelMap[scope.servicesParamsMapFive[scope.service.id][i].type].push(scope.servicesParamsMapFive[scope.service.id][i]);
                    }
                    else {
                      scope.secondLevelMap[scope.servicesParamsMapFive[scope.service.id][i].type].push(scope.servicesParamsMapFive[scope.service.id][i]);
                    }
                  }

                  if (!scope.hasSecondLevel && opts.internetPackageParam) {
                    scope.chosenFieldParamIdTwo = opts.internetPackageParam;
                    scope.chosenFieldNameTwo = opts.firstLevelFieldName;
                    amountForPayTransaction = opts.amountText ? opts.amountText : opts.amountWithoutSpace;
                  }
                  else if (scope.hasSecondLevel && opts.internetPackageParam && opts.firstLevelParamId) {
                    scope.chosenFieldParamIdTwo = opts.firstLevelParamId;
                    scope.chosenFieldNameTwo = opts.firstLevelFieldName;
                    scope.chosenFieldParamIdThree = opts.internetPackageParam;
                    scope.chosenFieldNameThree = opts.secondLevelFieldName;
                    amountForPayTransaction = opts.amountText ? opts.amountText : opts.amountWithoutSpace;

                  } else
                    scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].type;


                  if (scope.hasSecondLevel && scope.secondLevelMap[scope.firstLevelArray[0].type]) {
                    var chosenFirstLevelId = scope.firstLevelArray[0].type;
                    if (scope.chosenFieldParamIdTwo)
                      chosenFirstLevelId = scope.chosenFieldParamIdTwo;
                    scope.secondLevelArray = scope.secondLevelMap[chosenFirstLevelId];
                  }
                  checkFieldsToActivateNext();
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

    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;

    var maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      amountForPayTransaction = 0,
      checkFirst = false;

    // scope.prepareData = prepareData = function () {
    if (scope.formType != 2) {

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
        scope.hasPrefixes = false;
        scope.prefixesArray = [];

        if (scope.servicesParamsMapSix[opts.chosenServiceId]) {

          for (var i in scope.servicesParamsMapSix[opts.chosenServiceId]) {
            if (scope.servicesParamsMapSix[opts.chosenServiceId][i].parent_param_id == scope.chosenFieldParamId)
              scope.prefixesArray.push(scope.servicesParamsMapSix[opts.chosenServiceId][i]);
          }
          if (scope.prefixesArray.length > 0) {
            scope.hasPrefixes = true;
            scope.chosenPrefixTitle = opts.chosenPrefixTitle ? opts.chosenPrefixTitle : scope.prefixesArray[0].title;
            scope.chosenPrefixId = opts.chosenPrefixId ? opts.chosenPrefixId : scope.prefixesArray[0].option_id;
            scope.chosenPrefixName = opts.chosenPrefixName ? opts.chosenPrefixName : scope.prefixesArray[0].name;
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

      console.log("Yahoooo_1", scope.servicesParamsMapOne[scope.service.id], scope.servicesParamsMapTwo[scope.service.id],
        scope.servicesParamsMapThree[scope.service.id], scope.servicesParamsMapFour[scope.service.id], scope.servicesParamsMapFive[scope.service.id]);
      scope.hasFirstLevel = false;
      if (scope.servicesParamsMapTwo[scope.service.id]) {
        scope.firstLevelArray = [];
        scope.secondLevelMap = {};
        scope.chosenFieldNameTwo = scope.servicesParamsMapTwo[scope.service.id][0].name;
        scope.hasSecondLevel = false;
        scope.hasFirstLevel = true;

        for (var i = 0; i < scope.servicesParamsMapTwo[scope.service.id].length; i++) {
          if (scope.servicesParamsMapTwo[scope.service.id][i].parent == 0) {
            scope.firstLevelArray.push(scope.servicesParamsMapTwo[scope.service.id][i]);
          } else {
            scope.hasSecondLevel = true;
            if (!scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent]) {
              scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent] = [];
              scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent].push(scope.servicesParamsMapTwo[scope.service.id][i]);
            }
            else {
              scope.secondLevelMap[scope.servicesParamsMapTwo[scope.service.id][i].parent].push(scope.servicesParamsMapTwo[scope.service.id][i]);
            }
          }
        }
        if (!scope.hasSecondLevel && opts.communalParam) {
          scope.chosenFieldParamIdTwo = opts.communalParam;
          scope.chosenFieldNameTwo = opts.firstLevelFieldName;
        }
        else if (scope.hasSecondLevel && opts.communalParam && opts.firstLevelParamId) {
          scope.chosenFieldParamIdTwo = opts.firstLevelParamId;
          scope.chosenFieldNameTwo = opts.firstLevelFieldName;
          scope.chosenFieldParamIdThree = opts.communalParam;
          scope.chosenFieldNameThree = opts.secondLevelFieldName;

        } else
          scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].id;
        if (scope.hasSecondLevel && scope.secondLevelMap[scope.firstLevelArray[0].id]) {
          scope.secondLevelArray = scope.secondLevelMap[scope.firstLevelArray[0].id];
        }

      }
      checkFieldsToActivateNext();

    }

    if (scope.formType == 2) {
      scope.pincardsMap = {};
      scope.pincardIds = [];
      if (scope.servicesParamsMapThree[scope.service.id]) {
        for (var i = 0; i < scope.servicesParamsMapThree[scope.service.id].length; i++) {
          if (!scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id]) {
            scope.pincardIds.push(scope.servicesParamsMapThree[scope.service.id][i].card_type_id);
            scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id] = [];
            scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id].push(scope.servicesParamsMapThree[scope.service.id][i]);
          }
          else
            scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id].push(scope.servicesParamsMapThree[scope.service.id][i]);
        }
      }
    }

    // }

    openDropdownComponent = function () {
      window.blurFields();
      this.dropdownBackPageId.style.webkitTransition = '0.3s';
      this.servicePageId.style.webkitTransition = '0.3s';
      this.servicePageId.style.zIndex = '0';
      this.servicePageId.style.opacity = '0.1';
      this.dropdownId.style.webkitTransition = '0.3s';
      this.dropdownId.style.transform = "translate3d(0, 0, 0)";
      this.dropdownId.style.webkitTransform = "translate3d(0, 0, 0)";
      this.dropdownBackPageId.style.opacity = '1';
    };

    scope.processDropdown = processDropdown = function (id, title) {
      console.log("id got from dropdown =", id, title);
      switch (scope.dropDownType) {
        case "firstField": {
          chooseFirstField(id);
        }
        case "firstLevel": {
          chooseDropdownTwo(id);
        }
      }

    };

    openFirstFieldDropDown = function () {

      console.log("open drop down", scope.fieldArray, scope.chosenFieldParamId);
      scope.dropDownType = "firstField";
      updateDropdownList(scope.fieldArray, "parameter_id", scope.chosenFieldParamId, "title");
      openDropdownComponent();
    };

    openDropDownTwo = function () {

      console.log("open drop down two", scope.fieldArray, scope.chosenFieldParamIdTwo);
      scope.dropDownType = "firstLevel";
      var idParam = scope.formType == 4 ? "type" : "id";
      updateDropdownList(scope.firstLevelArray, idParam, scope.chosenFieldParamIdTwo, "name");
      openDropdownComponent();
    };

    openDropDownThree = function () {

      window.blurFields();
      if (scope.secondLevelArray) {
        this.blockSecondDropdownId.style.display = 'block';
        if (scope.oldFieldParamIdThree) {
          if (scope.formType == 3)
            document.getElementById('two' + scope.oldFieldParamIdThree).style.backgroundColor = 'white';
          else if (scope.formType == 4)
            document.getElementById(scope.oldFieldParamIdThree).style.backgroundColor = 'white';
          document.getElementById('texttwo' + scope.oldFieldParamIdThree).style.color = '#515151';
        }
        if (scope.chosenFieldParamIdThree) {
          if (scope.formType == 3)
            document.getElementById('two' + scope.chosenFieldParamIdThree).style.backgroundColor = '#0084E6';
          else if (scope.formType == 4)
            document.getElementById(scope.chosenFieldParamIdThree).style.backgroundColor = '#0084E6';
          document.getElementById('texttwo' + scope.chosenFieldParamIdThree).style.color = 'white';
        }
      }
    };

    openPrefixesDropDown = function () {

      window.blurFields();
      this.blockPrefixId.style.display = 'block';

      if (scope.oldPrefixId) {
        document.getElementById('e' + scope.oldPrefixId).style.backgroundColor = 'white';
        document.getElementById('text' + scope.oldPrefixId).style.color = '#515151';
      }
      document.getElementById('e' + scope.chosenPrefixId).style.backgroundColor = '#0084E6';
      document.getElementById('text' + scope.chosenPrefixId).style.color = 'white';
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
      event.stopPropagation();

      servicePageTouchEndY = event.changedTouches[0].pageY;
      servicePageTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(servicePageTouchStartY - servicePageTouchEndY) <= 20 && Math.abs(servicePageTouchStartX - servicePageTouchEndX) <= 20) {
        id = id.substr(1);

        this.blockPrefixId.style.display = 'none';

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
      }
    };

    chooseDropdownTwo = function (id) {

      if (scope.formType == 3 || scope.formType == 5 || scope.formType == 6) {
        for (var i = 0; i < scope.firstLevelArray.length; i++) {
          if (scope.firstLevelArray[i].id == id) {
            scope.chosenFieldNameTwo = scope.firstLevelArray[i].name;
            scope.oldFieldParamIdTwo = scope.chosenFieldParamIdTwo;
            scope.chosenFieldParamIdTwo = id;
            if (scope.hasSecondLevel) {
              scope.secondLevelArray = scope.secondLevelMap[id];
              if (scope.oldFieldParamIdTwo != scope.chosenFieldParamIdTwo) {
                scope.chosenFieldNameThree = '';
                scope.oldFieldParamIdThree = null;
                scope.chosenFieldParamIdThree = null;
              }
            }
            scope.update();

            break;
          }
        }
      } else if (scope.formType == 4) {
        for (var i = 0; i < scope.firstLevelArray.length; i++) {
          if (scope.firstLevelArray[i].type == id) {
            scope.chosenFieldNameTwo = scope.firstLevelArray[i].name;
            scope.oldFieldParamIdTwo = scope.chosenFieldParamIdTwo;
            scope.chosenFieldParamIdTwo = id;
            if (scope.hasSecondLevel) {
              scope.secondLevelArray = scope.secondLevelMap[id];
              if (scope.oldFieldParamIdTwo != scope.chosenFieldParamIdTwo) {
                scope.chosenFieldNameThree = '';
                scope.oldFieldParamIdThree = null;
                scope.chosenFieldParamIdThree = null;
              }
            }
            scope.update();
            break;
          }
        }
      }
      checkFieldsToActivateNext();
    };

    closePrefixDropdownTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      closePrefixDropdownTouchStartX = event.changedTouches[0].pageX;
      closePrefixDropdownTouchStartY = event.changedTouches[0].pageY;
    };

    closePrefixDropdownTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      closePrefixDropdownTouchEndX = event.changedTouches[0].pageX;
      closePrefixDropdownTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(closePrefixDropdownTouchStartX - closePrefixDropdownTouchEndX) <= 20 && Math.abs(closePrefixDropdownTouchStartY - closePrefixDropdownTouchEndY) <= 20) {
        this.blockPrefixId.style.display = 'none';
      }
    };

    closeSecondDropdownTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      closeSecondDropdownTouchStartX = event.changedTouches[0].pageX;
      closeSecondDropdownTouchStartY = event.changedTouches[0].pageY;
    };

    closeSecondDropdownTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      closeSecondDropdownTouchEndX = event.changedTouches[0].pageX;
      closeSecondDropdownTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(closeSecondDropdownTouchStartX - closeSecondDropdownTouchEndX) <= 20 && Math.abs(closeSecondDropdownTouchStartY - closeSecondDropdownTouchEndY) <= 20) {
        this.blockSecondDropdownId.style.display = 'none';
      }
    };

    scope.onTouchStartOfDropdownThree = onTouchStartOfDropdownThree = function () {
      event.stopPropagation();
      servicePageTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfDropdownThree = onTouchEndOfDropdownThree = function (id) {
      event.stopPropagation();

      servicePageTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(servicePageTouchStartY - servicePageTouchEndY) <= 20) {
        this.blockSecondDropdownId.style.display = 'none';
        if (scope.formType == 3) {
          for (var i = 0; i < scope.secondLevelArray.length; i++) {
            if (scope.secondLevelArray[i].id == id) {
              scope.chosenFieldNameThree = scope.secondLevelArray[i].name;
              if (scope.chosenFieldParamIdThree)
                scope.oldFieldParamIdThree = scope.chosenFieldParamIdThree;
              scope.chosenFieldParamIdThree = id;

              scope.update(scope.chosenFieldNameThree);
              break;
            }
          }
        } else if (scope.formType == 4) {
          for (var i = 0; i < scope.secondLevelArray.length; i++) {
            if (scope.secondLevelArray[i].code == id) {
              scope.chosenFieldNameThree = scope.secondLevelArray[i].name;
              if (scope.chosenFieldParamIdThree)
                scope.oldFieldParamIdThree = scope.chosenFieldParamIdThree;
              scope.chosenFieldParamIdThree = id;
              opts.amountText = scope.secondLevelArray[i].usd_cost;
              amountForPayTransaction = scope.secondLevelArray[i].sum_cost;
              scope.update();
              break;
            }
          }
        }
        checkFieldsToActivateNext();
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


            if (opts.formtype == 1 && ussdQuery) {
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

            if (opts.formtype == 2 && ussdQuery) {
//              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (opts.formtype == 3 && ussdQuery) {
              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (opts.formtype == 4 && ussdQuery) {
              console.log('ussdQuery', ussdQuery)
//              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (opts.formtype == 6 && ussdQuery) {
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery);
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
            editFavorite(opts);
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown();
          }
          else {
            opts.isInFavorites = true;
            addToFavoritesinServicePage(opts);
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

    scope.onTouchStartOfPincard = onTouchStartOfPincard = function () {
      event.stopPropagation();
      servicePageTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfPincard = onTouchEndOfPincard = function (nominal, cardId) {
      event.stopPropagation();

      servicePageTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(servicePageTouchStartY - servicePageTouchEndY) <= 20) {
        scope.selectedId = 'radio' + cardId + nominal;
        scope.update(scope.selectedId);
        opts.formtype = scope.formType;
        opts.cardTypeId = cardId;
        opts.amountText = nominal;

        if (opts.mode == 'ADDAUTOPAY') {
          autopayField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          autoPayNameTitle.style.color = 'gray';

          if (this.autoPayNameInput.value.length < 1) {
            console.log("Введите название автоплатежа");
            return;
          }
        } else if (opts.mode == 'ADDFAVORITE') {
          favoriteField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          favoriteNameTitle.style.color = 'gray';

          if (this.favoriteNameInput.value.length < 1) {
            console.log("Введите название избранного");
            return;
          }
        }

        formTypeTwoBtnId.style.pointerEvents = 'auto';
        formTypeTwoBtnId.style.backgroundColor = '#00a8f1';
        scope.update(formTypeTwoBtnId);
      }
    };

    formTypeTwoButtonFunction = function () {
      event.stopPropagation();

      enterEndY = event.changedTouches[0].pageY;
      enterEndX = event.changedTouches[0].pageX;

      if (this.formTypeTwoBtnId) {
        this.formTypeTwoBtnId.style.webkitTransform = 'scale(1)';
      }

      if (Math.abs(enterStartY - enterEndY) <= 20 && Math.abs(enterStartX - enterEndX) <= 20) {

        if (modeOfApp.offlineMode) {

          var ussdQuery = scope.fieldArray[0].ussd_query;
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
          ussdQuery = ussdQuery.replace('{nominal}', opts.amountText);
          ussdQuery = ussdQuery.replace('{card_type}', opts.cardTypeId);
          ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);


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

        if (opts.mode == 'USUAL' || opts.mode == 'POPULAR' || !opts.mode) {

          opts.isInFavorites = !scope.enterButton;
          opts.transactionId = parseInt(Date.now() / 1000);

          event.preventDefault();
          event.stopPropagation();

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

        } else if (opts.mode == 'ADDFAVORITE') {
          if (opts) {
            console.log("PARAMS of favorite", opts)

            opts.favoriteName = favoriteNameInput.value;

            if (opts.isInFavorites) {
              editFavorite(opts);
              event.preventDefault();
              event.stopPropagation();
              onBackKeyDown();
            }
            else {
              opts.isInFavorites = true;
              addToFavoritesinServicePage(opts);
              event.preventDefault();
              event.stopPropagation();
              onBackKeyDown();
              onBackKeyDown();
            }

          }
          else {
            scope.clickPinError = false;
            scope.errorNote = "Попробуйте еще раз";

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
            });

            scope.update();
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
          scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
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

    addToFavoritesinServicePage = function (array) {

      var favoritePaymentsList, favoritePaymentsListForApi;

      var id = Math.floor((Math.random() * 1000000) + 1);

      favoritePaymentsList = localStorage.getItem('favoritePaymentsList') ? JSON.parse(localStorage.getItem('favoritePaymentsList')) : [];
      favoritePaymentsListForApi = localStorage.getItem('favoritePaymentsListForApi') ? JSON.parse(localStorage.getItem('favoritePaymentsListForApi')) : [];


      if (favoritePaymentsListForApi.length != favoritePaymentsList.length) {
        favoritePaymentsListForApi = [];
        for (var i in favoritePaymentsList) {
          favoritePaymentsListForApi.push({
            "id": favoritePaymentsList[i].id,
            "type": 1,
            "body": JSON.stringify(favoritePaymentsList[i])
          })
        }
      }

      var newfavorite = {
        "params": array,
        "service": scope.service,
        "ussd": scope.fieldArray[0].ussd_query,
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
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote
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


    };

    editFavorite = function (params) {

      var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));

      for (var i in favoritePaymentsList) {
        if (favoritePaymentsList[i].id == opts.favoriteId) {
          favoritePaymentsList[i].params = params;

          var editedfavorite = {
            "id": favoritePaymentsList[i].id,
            "type": 1,
            "body": JSON.stringify(favoritePaymentsList[i])
          };

          for (var j in favoritePaymentsListForApi) {
            if (favoritePaymentsListForApi[i].id == opts.favoriteId) {
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
                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote
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
    };


  </script>
</view-service-page-new>

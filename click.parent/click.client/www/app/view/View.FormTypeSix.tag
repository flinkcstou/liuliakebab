<view-formtype-six class="riot-tags-main-container">

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
      <div style="width:  100%; height: 2%;">
      </div>
      <div id="autopayField" class="servicepage-first-field" if="{opts.mode=='ADDAUTOPAY'}">
        <p id="autoPayNameTitle" class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="checkFieldsToActivateNext()"
               onfocus="colorFieldGlobal('autopayField','autoPayNameTitle')"
               onblur="blurFieldGlobal('autopayField','autoPayNameTitle')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">
          {window.languages.ViewServicePageFavoriteNameField}</p>

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

      <div class="servicepage-second-dropdown-field" if="{hasFirstLevel && service.category_id!=11}"
           ontouchend="openDropDownTwo()" role="button" aria-label="{chosenFieldNameTwo}">
        <p class="servicepage-text-field servicepage-second-dropdown-field-text">
          {(service.options_title)?(service.options_title):("")}</p>
        <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
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

      <div class="servicepage-second-dropdown-field-pakety" role="button" aria-label="{chosenFieldNameTwo}"
           if="{hasFirstLevel&& service.category_id==11}"
           ontouchend="openDropDownTwo()" role="button" aria-label="{chosenFieldNameTwo}">
        <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <button id="enterButtonId" style="bottom: {window.bottomButtonBottom}"
              class="{servicepage-button-enter-enabled: enterButtonEnabled,servicepage-button-enter-disabled:!enterButtonEnabled}"
              ontouchstart="onTouchStartOfEnter()"
              ontouchend="onTouchEndOfEnter()">
        {enterButton ? (modeOfApp.offlineMode ?window.languages.ViewServicePagePayLabel:
        window.languages.ViewServicePageEnterLabel):window.languages.ViewServicePageSaveLabel}
      </button>

    </div>


  </div>

  <component-dropdown></component-dropdown>

  <script>

    window.checkShowingComponent = null;
    var scope = this;
    var backStartY, backStartX, backEndY, backEndX;
    var cursorPositionSelectionStart, cursorPositionSelectionEnd, oldValueOfNumber;
    var searchContactStartY, searchContactStartX, searchContactEndY, searchContactEndX;
    var enterStartY, enterStartX, enterEndY, enterEndX;
    var contactStopChanging = false;
    scope.showErrorOfLimit = false;
    var onPaste = false;
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

    console.log("opts in ServicePageNew", opts);

    window.saveHistory('view-formtype-six', opts);

    if (opts.id) {
      opts.chosenServiceId = opts.id;
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

    checkFieldsToActivateNext = function () {

      console.log("CHECK fields");

      if (!scope.service['amount_editable']) return;

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

        if (scope.phoneFieldBool && firstFieldInput) {

          if (firstFieldInput.value.length < 10) {

            scope.enterButtonEnabled = false;
            scope.update(scope.enterButtonEnabled);
            return;
          }

        } else if (firstFieldInput && firstFieldInput.value.length == 0) {
          console.log("Нет значения первого поля");
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        }
      }

      if (scope.hasSecondLevel)
        opts.communalParam = scope.chosenFieldParamIdThree;
      else
        opts.communalParam = scope.chosenFieldParamIdTwo;

      if (!opts.communalParam) {
        if (scope.hasSecondLevel)
          console.log("Выберите город и район");
        else {
          opts.communalParam = scope.chosenPrefixId;
          scope.enterButtonEnabled = true;
          scope.update(scope.enterButtonEnabled);
          return;

        }

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
      checkFieldsToActivateNext();

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
        case "firstLevel": {
          chooseDropdownTwo(id);
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

    openDropDownTwo = function () {

      console.log("open drop down two", scope.firstLevelArray, scope.chosenFieldParamIdTwo);
      scope.dropDownType = "firstLevel";
      var idParam = "id";
      updateDropdownList(scope.firstLevelArray, idParam, scope.chosenFieldParamIdTwo, "name", "servicePageId");
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

    chooseDropdownTwo = function (id) {
      console.log("chooseDropdownTwo function");

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

      checkFieldsToActivateNext();
    };

    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';
//        this.enterButtonId.style.backgroundColor = '#76c1f4';
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
        opts.chosenPrefixName = scope.chosenPrefixName ? scope.chosenPrefixName : "";

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
</view-formtype-six>

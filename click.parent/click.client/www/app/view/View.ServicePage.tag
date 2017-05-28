<view-service-page class="view-service-page riot-tags-main-container">
  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts.mode!='ADDAUTOPAY', autopay-method-page-title:opts.mode=='ADDAUTOPAY'}">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (window.languages.ViewAutoPayMethodSchedulerText):(categoryName)}</p>
    <div ontouchend="goToBack()"
         class="{servicepage-button-back:opts.mode!='ADDAUTOPAY', autopay-method-back-button:opts.mode=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>


  <div class="servicepage-body-container" if="{formType!=2}">

    <div class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
      <p class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

      <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
             autofocus="true"/>
    </div>

    <div class="servicepage-fields-dropdown" if="{dropDownOn}" ontouchend="openDropDown()" id="firstFieldChoiceId">
      <p class="servicepage-dropdown-text-field">{chosenFieldName}</p>
      <div class="servicepage-dropdown-icon"></div>
    </div>

    <div class="servicepage-second-dropdown-field" if="{hasFirstLevel}"
         ontouchend="openDropDownTwo()">
      <p if="{formType==3 || formType==4}" class="servicepage-text-field servicepage-second-dropdown-field-text">
        {(service.options_title)?(service.options_title):("")}</p>
      <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
      <div class="servicepage-dropdown-icon"></div>
    </div>

    <div class="{servicepage-second-dropdown-field:formType!=3, servicepage-second-dropdown-field-diftop: formType==3}"
         if="{hasSecondLevel}"
         ontouchend="openDropDownThree()">
      <p class="servicepage-dropdown-text-field">{chosenFieldNameThree}</p>
      <div class="servicepage-dropdown-icon"></div>
    </div>

    <div class="servicepage-first-field" id="firstField"
         hidden="{modeOfApp.offlineMode && viewPay.chosenServiceId == 'mynumber'}">
      <p class="servicepage-text-field">{chosenFieldName}</p>
      <p class="servicepage-number-first-part" if="{phoneFieldBool}">+{window.languages.CodeOfCountry}</p>
      <input class="{servicepage-number-input-part: phoneFieldBool, servicepage-number-input-part-two: !phoneFieldBool && isNumber,
                           servicepage-number-input-part-three: !phoneFieldBool && !isNumber}"
             type="{inputType}"
             id="firstFieldInput"
             onfocus="bordersColor()"
             autofocus="true"
             value="{defaultNumber || opts.first_field_value}" onkeydown="telPayVerificationKeyDown(this)"
             oninput="telPayVerificationKeyUp()"
             onkeyup="telPayVerificationKeyUp()"/>
      <div class="servicepage-phone-icon" if="{phoneFieldBool}" ontouchend="searchContact()"></div>
    </div>

    <div class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
         id="amountField">
      <p class="servicepage-text-field">{amountFieldTitle}</p>
      <input class="servicepage-amount-input" type="tel" value="{defaultAmount}" maxlength="9"
             id="amount"
             pattern="[0-9]"
             onfocus="amountFocus()" onblur="amountOnBlur()"
             onmouseup="eraseAmountDefault()" onkeyup="sumForPay()" oninput="sumForPay()"/>
      <div if="{!modeOfApp.offlineMode}" class="servicepage-amount-icon" ontouchend="amountCalculator()"></div>
    </div>


    <button id="enterButtonId" class="servicepage-button-enter" if="{enterButton}" ontouchend="enterButton()">
      {window.languages.ViewServicePageEnterLabel}
    </button>

    <button id="saveButtonId" class="servicepage-button-enter" if="{!enterButton}" ontouchend="enterButton()">
      {window.languages.ViewServicePageSaveLabel}
    </button>

  </div>


  <div id="blockFirstFieldId" class="component-first-field">
    <div class="servicepage-fields-dropdown-two">
      <p class="servicepage-dropdown-text-field" style="color: white;">{chosenFieldName}</p>
    </div>
    <div class="servicepage-dropdown-container">
      <div class="servicepage-dropdown-variant" each="{i in fieldArray}" id="{i.parameter_id}"
           ontouchend="chooseFirstField(this.id)">
        <p id="text{i.parameter_id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.title}</p>
      </div>
    </div>
  </div>

  <div id="blockFirstDropdownId" class="component-first-field">
    <div class="servicepage-fields-dropdown-two">
      <p class="servicepage-dropdown-text-field" style="color: white;">
        {(service.options_title)?(service.options_title):((firstLevelArray &&
        firstLevelArray[0])?(firstLevelArray[0].name):(""))}</p>
    </div>
    <div class="servicepage-dropdown-container">
      <div class="servicepage-dropdown-variant" each="{i in firstLevelArray}" id="{i.id}" if="{formType==3}"
           ontouchstart="onTouchStartOfDropdownTwo()" ontouchend="onTouchEndOfDropdownTwo({i.id})">
        <p id="text{i.id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
      </div>
      <div class="servicepage-dropdown-variant" each="{i in firstLevelArray}" id="{i.type}" if="{formType==4}"
           ontouchstart="onTouchStartOfDropdownTwo()" ontouchend="onTouchEndOfDropdownTwo({i.type})">
        <p id="text{i.type}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
      </div>
    </div>
  </div>

  <div id="blockSecondDropdownId" class="component-first-field">
    <div class="servicepage-fields-dropdown-two">
      <p class="servicepage-dropdown-text-field" style="color: white;">
        {(secondLevelArray && secondLevelArray[0])?(secondLevelArray[0].name):("")}</p>
    </div>
    <div class="servicepage-dropdown-container">
      <div class="servicepage-dropdown-variant" each="{i in secondLevelArray}" id="two{i.id}" if="{formType==3}"
           ontouchstart="onTouchStartOfDropdownThree()" ontouchend="onTouchEndOfDropdownThree({i.id})">
        <p id="texttwo{i.id}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
      </div>
      <div class="servicepage-dropdown-variant" each="{i in secondLevelArray}" id="{i.code}" if="{formType==4}"
           ontouchstart="onTouchStartOfDropdownThree()" ontouchend="onTouchEndOfDropdownThree(this.id)">
        <p id="texttwo{i.code}" class="servicepage-dropdown-text-field" style="left: 8%">{i.name}</p>
      </div>
    </div>
  </div>

  <div class="servicepage-formtype-two-container" if="{formType==2}">

    <div class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
      <p class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

      <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
             autofocus="true"/>
    </div>

    <div
      class="{servicepage-pincards-container-two: !enterButton, servicepage-pincards-container: enterButton && opts.mode!='ADDAUTOPAY',
      servicepage-pincards-container-three: enterButton && opts.mode=='ADDAUTOPAY'}">
      <div class="servicepage-pincards-block-container" each="{i in pincardIds}">
        <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
        <div class="servicepage-pincard-nominal-container" each="{j in pincardsMap[i]}"
             ontouchstart="onTouchStartOfPincard()" ontouchend="onTouchEndOfPincard({j.nominal},{j.card_type_id})">
          <p class="servicepage-pincard-nominal-value">{j.nominal}</p>
          <div class="servicepage-pincard-choose-arrow"></div>
        </div>
      </div>
    </div>

    <button id="formTypeTwoBtnSaveId" class="servicepage-button-save" if="{!enterButton}"
            ontouchend="addToFavoritesforFormTypeTwo()">
      {window.languages.ViewServicePageSaveLabel}
    </button>
  </div>

  <div id="blockAmountCalculatorId" class="component-calc">
    <div id="rightButton" type="button" class="component-banklist-close-button" ontouchend="closeComponent()"></div>
    <div class="component-calc-name-title">{window.languages.ViewAmountCalculatorNameTitle}</div>

    <div class="component-calc-fields-container">

      <div class="component-calc-first-field">
        <p class="component-calc-first-field-text">{window.languages.ViewAmountCalculatorTextOne}</p>
        <input id="amountCalcInputId" class="component-calc-first-field-input-part" type="number"
               maxlength="19" onkeyup="convertAmount()"/>
      </div>

      <p class="component-calc-currency-text">{window.languages.ViewAmountCalculatorTextTwo} {currencyRate} сум</p>
      <div id="convertedAmountFieldId" class="component-calc-second-field">
        <p class="component-calc-second-field-text">{window.languages.ViewAmountCalculatorTextThree}</p>
        <p class="component-calc-second-field-input-part">{convertedAmount} сум</p>
      </div>

      <div class="component-calc-buttons-container">
        <div class="component-calc-button component-calc-cancel-button" ontouchend="closeComponent()">
          <p class="component-calc-button-label component-calc-cancel-button-label">
            {window.languages.ViewAmountCalculatorCancelText}</p>
        </div>
        <div id="acceptConvertedBtnId" class="component-calc-button" ontouchend="acceptConvertedAmount()">
          <p class="component-calc-button-label">{window.languages.ViewAmountCalculatorAcceptText}</p>
        </div>
      </div>

    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <component-tour view="calculator"></component-tour>


  </div>


  <script>

    window.checkShowingComponent = null;

    console.log('OPTS', opts);

    var scope = this;
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.servicesParamsMapTwo = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"))) : (offlineServicesParamsMapTwo);
    scope.servicesParamsMapThree = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) : (offlineServicesParamsMapThree);
    scope.servicesParamsMapFour = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"))) : (offlineServicesParamsMapFour);
    scope.servicesParamsMapFive = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"))) : (offlineServicesParamsMapFive);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    scope.fieldsObject = JSON.parse(localStorage.getItem("servicepage_fields"));
    console.log("Fields in the history=", scope.fieldsObject);
    scope.autoPayFromConfirm = false;
    if (scope.autoPayData && scope.autoPayData.fromView == 'PAYCONFIRM' && opts[0]) {
      scope.autoPayFromConfirm = true;
    }

    //    console.log("click_client_servicesParamsMapTwo", localStorage.getItem("click_client_servicesParamsMapTwo"));
    //    console.log("click_client_servicesParamsMapThree", localStorage.getItem("click_client_servicesParamsMapThree"));
    //    console.log("click_client_servicesParamsMapFour", localStorage.getItem("click_client_servicesParamsMapFour"));
    //    console.log("click_client_servicesParamsMapFive", localStorage.getItem("click_client_servicesParamsMapFive"));

    scope.update(scope.categoryNamesMap);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-page') {
      history.arrayOfHistory.push(
        {
          "view": 'view-service-page',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    if (opts.id) {

      viewPay.chosenServiceId = opts.id;
    }


    scope.enterButton = opts.mode != 'ADDFAVORITE' ? true : false;
    scope.showError = false;
    scope.showConfirm = false;


    telPayVerificationKeyDown = function (input) {
//      console.log(event.target.value)
      if (scope.phoneFieldBool)
        if (input.value.length >= 9 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
          firstFieldInput.value = event.target.value.substring(0, event.target.value.length - 1);
        }
    }

    telPayVerificationKeyUp = function () {
      if (event.keyCode != input_codes.BACKSPACE_CODE) {
        console.log(firstFieldInput.value)
        if (firstFieldInput.type != 'text')
          firstFieldInput.value = inputVerification.telVerification(firstFieldInput.value)
      }
    }

    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    if (loginInfo) {

      var sessionKey = loginInfo.session_key;
    }

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');


    this.on('mount', function () {

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).calculator) {
        componentTourId.style.display = "block";
        StatusBar.backgroundColorByHexString("#002334");
      }

      if (opts && opts.number) {
        firstFieldInput.value = opts.number
        scope.update();

      }


      if (viewServicePage.amountWithoutSpace.length > 0 ) {
        amount.value = viewServicePage.amountText;
        checkFirst = true;
        amountForPayTransaction = viewServicePage.amountWithoutSpace;
      }
      else if (scope.formType != 2)
        amount.value = 0

      if (modeOfApp.offlineMode) {
        enterButtonId.innerText = 'Оплатить'
      }
    });

    goToBack = function () {
      viewServicePage.phoneText = null;
      viewServicePage.amountText = null;
      viewServicePinCards.friendHelpPaymentMode = false;
      viewServicePinCards.chosenFriendForHelp = null;
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    searchContact = function () {
      window.pickContactFromNativeChecker = true;
      var maskOne = /[0-9]/g;
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
          firstFieldInput.value = phone.substring(phone.length - 9, phone.length);
        }, 0);
      }, function (error) {
        console.log('error', error)
      });

    }

    amountFocus = function () {
      event.preventDefault()
      event.stopPropagation()

      if (amount.value.length == 1) {
        amount.value = '';
      }

    }

    amountOnBlur = function () {
      event.preventDefault()
      event.stopPropagation()

      if (amount.value.length == 0) {
        amount.value = 0
      }
    }

    amountCalculator = function () {

      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
        scope.confirmShowBool = true;
        scope.confirmNote = question;
        scope.confirmType = 'local';
        scope.result = function (bool) {
          if (bool) {
            localStorage.clear();
            window.location = 'index.html'
            scope.unmount()
            return
          }
          else {
            scope.confirmShowBool = false;
            return
          }
        };
        scope.update();

        return
      }

//      if (!localStorage.getItem('click_client_currency_rate')) {
//        console.log("no currency rate in localStorage");
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
//              console.log("API returned = ", scope.currencyRate);
//              localStorage.setItem('click_client_currency_rate', scope.currencyRate);

            scope.update(scope.currencyRate);
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('rate.convert');
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
//      }
//    else {
      //        scope.currencyRate = localStorage.getItem('click_client_currency_rate');
      //        console.log("currency rate is in localStorage=", scope.currencyRate);
      //      }

      blockAmountCalculatorId.style.display = 'block';
      scope.update(blockAmountCalculatorId);
    }

    closeComponent = function () {
      blockAmountCalculatorId.style.display = 'none';
      scope.update(blockAmountCalculatorId);
    }

    var converted;
    scope.convertedAmount = 0;

    convertAmount = function () {

      scope.convertedAmount = Math.ceil(amountCalcInputId.value * scope.currencyRate);
      converted = scope.convertedAmount.toString();

      converted = window.amountTransform(converted);

      console.log("after=", converted);


      if (scope.convertedAmount > scope.service.max_pay_limit) {
        console.log("max limit=", scope.service.max_pay_limit);
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
    }

    acceptConvertedAmount = function () {
      amount.value = scope.convertedAmount + ' ' + defaultAccount.currency;
      if (amount.value.length > 0) {
        checkFirst = true;
        amountForPayTransaction = converted;
      }
      blockAmountCalculatorId.style.display = 'none';
      scope.update(blockAmountCalculatorId);
    }

    if ((viewPay.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) || (modeOfApp.offlineMode && viewPay.chosenServiceId == 'mynumber')) {

      console.log("MY NUMBER ID");

      if (modeOfApp.onlineMode || viewPay.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
        scope.service = scope.servicesMap[localStorage.getItem('myNumberOperatorId')][0];
        scope.titleName = 'Мой номер';
        scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
        viewServicePage.phoneText = localStorage.getItem('click_client_phoneNumber');
        viewServicePage.phoneText = viewServicePage.phoneText ? viewServicePage.phoneText.substr(3, viewServicePage.phoneText.length - 3) : '';
        scope.fieldArray = scope.servicesParamsMapOne[localStorage.getItem('myNumberOperatorId')];
        console.log('FIELDARRAY', scope.fieldArray)
        viewPay.chosenServiceId = localStorage.getItem('myNumberOperatorId');

        this.on('mount', function () {
          firstField.style.display = 'none';
          amountField.style.top = '7%';


          if (viewServicePage.amountText)
            if (viewServicePage.amountText.length > 0 && opts) {
              amount.value = viewServicePage.amountText;
              checkFirst = true;
              amountForPayTransaction = viewServicePage.amountWithoutSpace;

              if (!amountForPayTransaction) {
                amountForPayTransaction = (viewServicePage.amountText) ? (viewServicePage.amountText) : (0);
                amountForPayTransaction = parseInt(amountForPayTransaction);
              }
            }
            else
              amount.value = 0;
        });
      }
      else {
        console.log('scope.servicesMap', scope.servicesMap['mynumber']);
        console.log('scope.servicesParamsMapOne', scope.servicesParamsMapOne);
        scope.service = localStorage.getItem('myNumberOperatorId') ? scope.servicesMap[localStorage.getItem('myNumberOperatorId')][0] : scope.servicesMap['mynumber'][0];
        scope.titleName = 'Мой номер';
        scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
        viewServicePage.phoneText = localStorage.getItem('click_client_phoneNumber');
        viewServicePage.phoneText = viewServicePage.phoneText ? viewServicePage.phoneText.substr(3, viewServicePage.phoneText.length - 3) : '';
        scope.fieldArray = [];
        scope.fieldArray[0] = {ussd_query: "*880*0199999*1*{amount}#", title: "Мой номер"};
        console.log('scope.fieldArray', scope.fieldArray)
        viewPay.chosenServiceId = localStorage.getItem('myNumberOperatorId') ? localStorage.getItem('myNumberOperatorId') : 'mynumber';

        scope.amountFieldTitle = 'Сумма';

        console.log('TTTTTT', scope.service, scope.titleName, scope.fieldArray, viewPay.chosenServiceId);

        this.on('mount', function () {
          firstField.style.display = 'none';
          amountField.style.top = '5.5%';


          if (viewServicePage.amountText)
            if (viewServicePage.amountText.length > 0 && opts) {
              amount.value = viewServicePage.amountText;
              checkFirst = true;
              amountForPayTransaction = viewServicePage.amountWithoutSpace;

              if (!amountForPayTransaction) {
                amountForPayTransaction = (viewServicePage.amountText) ? (viewServicePage.amountText) : (0);
                amountForPayTransaction = parseInt(amountForPayTransaction);
              }
            }
            else
              amount.value = 0;
        });
      }
    } else {

      scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;

      console.log("ASD");
      scope.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];
    }

    console.log('scope.categoryNamesMap', scope.categoryNamesMap)

    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;

    var maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      amountForPayTransaction = 0,
      checkFirst = false,
      defaultAccount;


    if (scope.formType != 2) {

      console.log("Yahoo1 formType=", scope.formType, ", Rest=", scope.fieldArray, scope.servicesParamsMapOne[viewPay.chosenServiceId], scope.servicesParamsMapOne, viewPay.chosenServiceId);

      if (scope.fieldArray) {
        scope.dropDownOn = scope.fieldArray.length > 1;
        scope.chosenFieldName = scope.fieldsObject ? (scope.fieldsObject.firstFieldTitle ? scope.fieldsObject.firstFieldTitle : scope.fieldArray[0].title) : scope.fieldArray[0].title;
        scope.chosenFieldParamId = scope.fieldsObject ? (scope.fieldsObject.firstFieldId ? scope.fieldsObject.firstFieldId : scope.fieldArray[0].parameter_id) : scope.fieldArray[0].parameter_id;
        opts.first_field_value = scope.fieldsObject ? (scope.fieldsObject.firstFieldText ? scope.fieldsObject.firstFieldText : null) : null;
        scope.amountFieldTitle = scope.service.lang_amount_title;
        scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1";
        if (scope.phoneFieldBool)
//          scope.defaultNumber = !viewServicePage.phoneText ? null : inputVerification.telLengthVerification(viewServicePage.phoneText, window.languages.PhoneNumberLength)
//        scope.defaultAmount = !viewServicePage.amountText ? 0 : viewServicePage.amountText;

        scope.inputMaxLength = scope.fieldArray[0].max_len;
        console.log("INPUT LENGTH=", scope.inputMaxLength);
        if (scope.dropDownOn) {
          scope.chosenFieldParamId = scope.fieldsObject ? (scope.fieldsObject.firstFieldId ? scope.fieldsObject.firstFieldId : scope.fieldArray[0].parameter_id) : scope.fieldArray[0].parameter_id;
//          scope.oldFieldParamId = scope.fieldArray[1].parameter_id;
        }

        console.log("Yahoooo_1", scope.fieldArray, scope.fieldArray[0], scope.fieldArray[0].input_type);

        if (scope.fieldArray[0].input_type == '1') {
          scope.inputType = 'tel';
          scope.isNumber = true;
        }
        else if (scope.fieldArray[0].input_type == '2') {
          scope.inputType = 'text';
          scope.isNumber = false;
        }
        scope.amountLength = ("" + scope.service.max_pay_limit).length;
      }
      scope.hasFirstLevel = false;
      if (scope.formType == 3 && scope.servicesParamsMapTwo[scope.service.id]) {
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
        if (!scope.hasSecondLevel && scope.fieldsObject && scope.fieldsObject.communalParam) {
          scope.chosenFieldParamIdTwo = scope.fieldsObject.communalParam;
          scope.chosenFieldNameTwo = scope.fieldsObject.firstLevelFieldName;
        }
        else if (scope.hasSecondLevel && scope.fieldsObject && scope.fieldsObject.communalParam && scope.fieldsObject.firstLevelParamId) {
          scope.chosenFieldParamIdTwo = scope.fieldsObject.firstLevelParamId;
          scope.chosenFieldNameTwo = scope.fieldsObject.firstLevelFieldName;
          scope.chosenFieldParamIdThree = scope.fieldsObject.communalParam;
          scope.chosenFieldNameThree = scope.fieldsObject.secondLevelFieldName;

        } else
          scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].id;
        if (scope.hasSecondLevel && scope.secondLevelMap[scope.firstLevelArray[0].id]) {
          scope.secondLevelArray = scope.secondLevelMap[scope.firstLevelArray[0].id];

        }

      }

      if (scope.formType == 4 && scope.servicesParamsMapFour[scope.service.id] && scope.servicesParamsMapFive[scope.service.id]) {
        this.on('mount', function () {
          amountField.style.display = 'none';
        });
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

        if (!scope.hasSecondLevel && scope.fieldsObject && scope.fieldsObject.internetPackageParam) {
          scope.chosenFieldParamIdTwo = scope.fieldsObject.internetPackageParam;
          scope.chosenFieldNameTwo = scope.fieldsObject.firstLevelFieldName;
          amountForPayTransaction = scope.fieldsObject ? (scope.fieldsObject.amountText ? scope.fieldsObject.amountText : viewServicePage.amountWithoutSpace) : viewServicePage.amountWithoutSpace;
        }
        else if (scope.hasSecondLevel && scope.fieldsObject && scope.fieldsObject.internetPackageParam && scope.fieldsObject.firstLevelParamId) {
          scope.chosenFieldParamIdTwo = scope.fieldsObject.firstLevelParamId;
          scope.chosenFieldNameTwo = scope.fieldsObject.firstLevelFieldName;
          scope.chosenFieldParamIdThree = scope.fieldsObject.internetPackageParam;
          scope.chosenFieldNameThree = scope.fieldsObject.secondLevelFieldName;
          amountForPayTransaction = scope.fieldsObject ? (scope.fieldsObject.amountText ? scope.fieldsObject.amountText : viewServicePage.amountWithoutSpace) : viewServicePage.amountWithoutSpace;

          console.log("amount===", amountForPayTransaction)
        } else
          scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].type;


        if (scope.hasSecondLevel && scope.secondLevelMap[scope.firstLevelArray[0].type]) {
          scope.secondLevelArray = scope.secondLevelMap[scope.firstLevelArray[0].type];

        }
      }
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


    openDropDown = function () {
      this.blockFirstFieldId.style.display = 'block';
      console.log("id=", scope.chosenFieldParamId);
      if (scope.oldFieldParamId) {
        document.getElementById(scope.oldFieldParamId).style.backgroundColor = 'white';
        document.getElementById('text' + scope.oldFieldParamId).style.color = '#515151';
      }
      document.getElementById(scope.chosenFieldParamId).style.backgroundColor = '#0084E6';
      document.getElementById('text' + scope.chosenFieldParamId).style.color = 'white';
    };

    openDropDownTwo = function () {
      this.blockFirstDropdownId.style.display = 'block';
      if (scope.oldFieldParamIdTwo) {
        document.getElementById(scope.oldFieldParamIdTwo).style.backgroundColor = 'white';
        document.getElementById('text' + scope.oldFieldParamIdTwo).style.color = '#515151';
      }
      if (scope.chosenFieldParamIdTwo) {
        document.getElementById(scope.chosenFieldParamIdTwo).style.backgroundColor = '#0084E6';
        document.getElementById('text' + scope.chosenFieldParamIdTwo).style.color = 'white';
      }
    };

    openDropDownThree = function () {
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

    chooseFirstField = function (id) {

      this.blockFirstFieldId.style.display = 'none';

      for (var i = 0; i < scope.fieldArray.length; i++) {

//        console.log("Yahoo2", id, scope.fieldArray, scope.fieldArray[i], scope.fieldArray[i].parameter_id);

        if (scope.fieldArray[i].parameter_id == id) {
          scope.chosenFieldName = scope.fieldArray[i].title;
          scope.chosenFieldPlaceholder = scope.fieldArray[i].placeholder;
          scope.phoneFieldBool = scope.fieldArray[i].parameter_id == "1";
          scope.inputMaxLength = scope.fieldArray[i].max_len;
          console.log("INPUT LENGTH=", scope.inputMaxLength);

//          console.log("Yahoooo_2", scope.fieldArray, scope.fieldArray[i], scope.fieldArray[i].input_type);

          if (scope.fieldArray[i].input_type == '1') {
            scope.inputType = 'tel';
            scope.isNumber = true;
          }
          else if (scope.fieldArray[i].input_type == '2') {
            scope.inputType = 'text';
            scope.isNumber = false;
          }
          scope.oldFieldParamId = scope.chosenFieldParamId;
          scope.chosenFieldParamId = id;
          firstFieldInput.value = '';
          scope.update(scope.chosenFieldName);
          scope.update(scope.phoneFieldBool);
          break;
        }
      }
    };

    var servicePageTouchStartY, servicePageTouchEndY

    scope.onTouchStartOfDropdownTwo = onTouchStartOfDropdownTwo = function () {
      event.stopPropagation();
      servicePageTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfDropdownTwo = onTouchEndOfDropdownTwo = function (id) {
      event.stopPropagation();

      servicePageTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(servicePageTouchStartY - servicePageTouchEndY) <= 20) {
        this.blockFirstDropdownId.style.display = 'none';
        if (scope.formType == 3) {
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
              viewServicePage.amountText = scope.secondLevelArray[i].usd_cost;
              amountForPayTransaction = scope.secondLevelArray[i].sum_cost;
              scope.update(scope.chosenFieldNameThree);
              break;
            }
          }
        }
      }
    };


    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }

    eraseAmountDefault = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!checkFirst) {
        amount.value = '';
        checkFirst = true;
      }
      if (amount.value.match(maskOne) != null && amount.value.match(maskOne).length != null) {
        amount.selectionStart = amount.value.match(maskTwo).length;
        amount.selectionEnd = amount.value.match(maskTwo).length;
      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
      firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';

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

      if (amount.value.length == 1 && amount.value == 0) {
        amount.value = '';
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

      viewServicePage.amountText = amount.value;
      viewServicePage.amountWithoutSpace = amountForPayTransaction;

      if (amount.value.length >= 1 && amount.value != 0) {
        if (scope.enterButton)
          enterButtonId.style.display = 'block';
        else saveButtonId.style.display = 'block';
      }
      else {
        if (scope.enterButton)
          enterButtonId.style.display = 'none';
        else saveButtonId.style.display = 'none';
      }

    };

    bordersColor = function () {

      event.preventDefault();
      event.stopPropagation();


      firstField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
      amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
    };

    var payment_data;

    enterButton = function () {

      try {
        this.firstFieldInput.blur();
        this.amount.blur();
      } catch (error) {

        console.log(error);
      }

      if (scope.phoneFieldBool && firstFieldInput.value.length < 9 && viewPay.chosenServiceId != "mynumber") {
        scope.clickPinError = false;
        scope.errorNote = "Неправильно введён номер телефона";
        scope.showError = true;
        scope.update();

        return;
      } else if (firstFieldInput.value.length == 0 && viewPay.chosenServiceId != "mynumber") {
        scope.clickPinError = false;
        scope.errorNote = "Введите значение первого поля";
        scope.showError = true;
        scope.update();
        return;
      }
      if (amountForPayTransaction < scope.service.min_pay_limit) {
        console.log("amount=", amountForPayTransaction);
        scope.clickPinError = false;
        scope.errorNote = "Сумма должна быть больше " + scope.service.min_pay_limit;
        scope.showError = true;
        scope.update();
        return;
      }
      if (amountForPayTransaction > scope.service.max_pay_limit) {
        scope.clickPinError = false;
        scope.errorNote = "Сумма должна быть меньше " + scope.service.max_pay_limit;
        scope.showError = true;
        scope.update();
        return;
      }

      var formtype = {"formtype": scope.formType};
      var firstFieldId = {"firstFieldId": scope.chosenFieldParamId};
      var firstFieldText = {"firstFieldText": firstFieldInput.value};
      var cardTypeId = {"cardTypeId": null};

      if (scope.formType == 3) {
        var internetPackageParam = {"internetPackageParam": null};
        var amountText = {"amountText": amountForPayTransaction};
        if (scope.hasSecondLevel)
          var communalParam = {"communalParam": scope.chosenFieldParamIdThree};
        else
          var communalParam = {"communalParam": scope.chosenFieldParamIdTwo};

      } else if (scope.formType == 1) {
        var communalParam = {"communalParam": null};
        var internetPackageParam = {"internetPackageParam": null};
        var amountText = {"amountText": amountForPayTransaction};

      } else if (scope.formType == 4) {
        var communalParam = {"communalParam": null};
        if (scope.chosenFieldParamIdThree) {
          var amountText = {"amountText": amountForPayTransaction};
          var internetPackageParam = {"internetPackageParam": scope.chosenFieldParamIdThree};

        } else {
          scope.clickPinError = false;
          scope.errorNote = "Выберите интернет пакет";
          scope.showError = true;
          scope.update();
          return;
        }
      }


      viewServicePage.firstFieldTitle = scope.chosenFieldName;
      viewServicePage.phoneText = inputVerification.telLengthVerification(firstFieldInput.value, window.languages.PhoneNumberLength);
      var isInFavorites = {"isInFavorites": !scope.enterButton};

      scope.fieldsObject = {
        formtype: formtype.formtype,
        firstFieldId: firstFieldId.firstFieldId,
        firstFieldText: firstFieldText.firstFieldText,
        firstFieldTitle: scope.chosenFieldName,
        cardTypeId: cardTypeId.cardTypeId,
        communalParam: communalParam.communalParam,
        amountText: amountText.amountText,
        internetPackageParam: internetPackageParam.internetPackageParam,
        firstLevelParamId: scope.chosenFieldParamIdTwo,
        firstLevelFieldName: scope.chosenFieldNameTwo,
        secondLevelFieldName: scope.chosenFieldNameThree,
      };
      console.log("fieldsObject=", scope.fieldsObject);
      localStorage.setItem("servicepage_fields", JSON.stringify(scope.fieldsObject));


      if (opts.mode == 'USUAL') {

        event.preventDefault();
        event.stopPropagation();
//        console.log(formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites)
//
//        console.log("OPTS", opts);
//
//        console.log('USSD', scope.fieldArray[0].ussd_query)
//        console.log('fieldArray', scope.fieldArray[0])
//
//        console.log('firstFieldText', firstFieldText)
//
//        console.log('formtype', formtype)
//        console.log('communalParam', communalParam)
//        console.log('internetPackageParam', internetPackageParam)


        if (modeOfApp.offlineMode) {

          var ussdQuery = scope.fieldArray[0].ussd_query;

          if (formtype.formtype == 1) {
            if (firstFieldText.firstFieldText) {
              ussdQuery = ussdQuery.replace('{param}', firstFieldText.firstFieldText);
            }
            else {
              ussdQuery = ussdQuery.replace('*{param}', firstFieldText.firstFieldText);
            }
            ussdQuery = ussdQuery.replace('{communal_param}', communalParam.communalParam);
            ussdQuery = ussdQuery.replace('{option}', firstFieldId.firstFieldId);
            ussdQuery = ussdQuery.replace('{amount}', amountText.amountText);
            ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
            console.log(ussdQuery)
          }

          if (formtype.formtype == 2) {
            ussdQuery = ussdQuery.replace('{communal_param}', communalParam.communalParam);
            ussdQuery = ussdQuery.replace('{param}', firstFieldText.firstFieldText);
            ussdQuery = ussdQuery.replace('{amount}', amountText.amountText);
            ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
            console.log(ussdQuery)
          }

          if (formtype.formtype == 3) {
            ussdQuery = ussdQuery.replace('{communal_param}', communalParam.communalParam);
            ussdQuery = ussdQuery.replace('{param}', firstFieldText.firstFieldText);
            ussdQuery = ussdQuery.replace('{amount}', amountText.amountText);
            ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
            console.log(ussdQuery)
          }

          if (formtype.formtype == 4) {
            console.log('ussdQuery', ussdQuery)
            ussdQuery = ussdQuery.replace('{communal_param}', communalParam.communalParam);
            ussdQuery = ussdQuery.replace('{param}', firstFieldText.firstFieldText);
            ussdQuery = ussdQuery.replace('{amount}', amountText.amountText);
            ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
            console.log(ussdQuery)
          }


          console.log(ussdQuery)

          phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
            ussdQuery + "%23",
            function (err) {
              if (err == "empty") {
                scope.clickPinError = false;
                scope.errorNote = ("Unknown phone number");
                scope.showError = true;
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
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites])
            scope.unmount()
          } else {
            this.riotTags.innerHTML = "<view-service-info>";
            riot.mount('view-service-info', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites])
            scope.unmount()
          }


        }
      } else if (opts.mode == 'ADDFAVORITE') {

        addToFavorites([formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites]);

        event.preventDefault();
        event.stopPropagation();
        viewServicePage.phoneText = '';
        window.viewServicePage = {};
        viewServicePage.amountText = '';
        viewServicePage.amountWithoutSpace = '';
        viewServicePinCards.friendHelpPaymentMode = false;
        viewServicePinCards.chosenFriendForHelp = null;
        onBackKeyDown();
        onBackKeyDown();
      } else if (opts.mode == 'ADDAUTOPAY') {

        if (autoPayNameInput.value.length < 1) {
          scope.clickPinError = false;
          scope.errorNote = "Введите название автоплатежа";
          scope.showError = true;
          scope.update();
          return;
        }

        scope.autoPayData.name = autoPayNameInput.value;
        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

        if (scope.autoPayFromConfirm) {
          this.riotTags.innerHTML = "<view-pay-confirm>";
          riot.mount('view-pay-confirm', opts);
          scope.unmount()

        } else {
          this.riotTags.innerHTML = "<view-service-pincards>";
          riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites, 'ADDAUTOPAY']);
          scope.unmount()
        }


      }
    };


    scope.onTouchStartOfPincard = onTouchStartOfPincard = function () {
      event.stopPropagation();
      servicePageTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfPincard = onTouchEndOfPincard = function (nominal, cardId) {
      event.stopPropagation();

//      console.log('scope.fieldArray[0]', scope.fieldArray)

      servicePageTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(servicePageTouchStartY - servicePageTouchEndY) <= 20) {
        var formtype = {"formtype": scope.formType};
        var firstFieldId = {"firstFieldId": null};
        var firstFieldText = {"firstFieldText": null};
        var cardTypeId = {"cardTypeId": cardId};
        var communalParam = {"communalParam": null};
        var amountText = {"amountText": nominal};
        var internetPackageParam = {"internetPackageParam": null};
        var isInFavorites = {"isInFavorites": !scope.enterButton};


        if (modeOfApp.offlineMode) {

          var ussdQuery = scope.fieldArray[0].ussd_query;
          ussdQuery = ussdQuery.replace('{nominal}', nominal);
          ussdQuery = ussdQuery.replace('{card_type}', cardId);
          ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)

          phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
            ussdQuery + "%23",
            function (err) {
              if (err == "empty") {
                scope.clickPinError = false;
                scope.errorNote = ("Unknown phone number");
                scope.showError = true;
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }

        scope.formTypeTwoOptsArray = [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites];

        if (opts.mode == 'USUAL') {
          event.preventDefault();
          event.stopPropagation();
          this.riotTags.innerHTML = "<view-service-pincards>";
          riot.mount('view-service-pincards', scope.formTypeTwoOptsArray);
          scope.unmount()
        } else if (opts.mode == 'ADDFAVORITE') {
          formTypeTwoBtnSaveId.style.pointerEvents = 'auto';
          formTypeTwoBtnSaveId.style.backgroundColor = 'rgb(1, 124, 227)';
          scope.update(formTypeTwoBtnSaveId);
        } else if (opts.mode == 'ADDAUTOPAY') {

          if (autoPayNameInput.value.length < 1) {
            scope.clickPinError = false;
            scope.errorNote = "Введите название автоплатежа";
            scope.showError = true;
            scope.update();
            return;
          }
          scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
          scope.autoPayData.name = autoPayNameInput.value;
          localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

          this.riotTags.innerHTML = "<view-service-pincards>";
          riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites, 'ADDAUTOPAY']);
          scope.unmount()
        }
      }
    };

    addToFavoritesforFormTypeTwo = function () {
      if (scope.formTypeTwoOptsArray) {
        addToFavorites(scope.formTypeTwoOptsArray);
        event.preventDefault();
        event.stopPropagation();
        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        scope.unmount()
      }
      else {
        scope.clickPinError = false;
        scope.errorNote = "Попробуйте еще раз";
        scope.showError = true;
        scope.update();
      }
    };

    addToFavorites = function (array) {
//      console.log('scope.fieldArray[0]', scope.fieldArray[0].ussd_query)

      if (!localStorage.getItem('favoritePaymentsList')) {
        var favoritePaymentsList = [];
//        console.log("OPTS TO SAVE=", array);
//        console.log("Chosen Service =", scope.service);
        favoritePaymentsList.push({
          "opts": array,
          "service": scope.service,
          "firstFieldTitle": viewServicePage.firstFieldTitle,
          "ussd": scope.fieldArray[0].ussd_query
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);
        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));

      } else {
        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
//        console.log("OPTS TO SAVE=", array);
//        console.log("Chosen Service =", scope.service);
        favoritePaymentsList.push({
          "opts": array,
          "service": scope.service,
          "firstFieldTitle": viewServicePage.firstFieldTitle,
          "ussd": scope.fieldArray[0].ussd_query
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);
        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      }
    };


  </script>
</view-service-page>

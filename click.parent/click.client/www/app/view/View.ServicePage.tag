<view-service-page class="view-service-page">
  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">{titleName}</p>
    <p class="servicepage-category-field">{categoryName}</p>
    <div ontouchend="goToBack()"
         class="servicepage-button-back">
    </div>
    <div type="button" class="servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
  </div>


  <div class="servicepage-body-container" if="{formType!=2}">
    <div class="servicepage-fields-dropdown" if="{dropDownOn}" ontouchend="openDropDown()" id="firstFieldChoiceId">
      <p class="servicepage-dropdown-text-field">{chosenFieldName}</p>
      <div class="servicepage-dropdown-icon"></div>
    </div>

    <div class="servicepage-first-field" id="firstField">
      <p class="servicepage-text-field">{chosenFieldName}</p>
      <p class="servicepage-number-first-part" if="{phoneFieldBool}">+{window.languages.CodeOfCountry}</p>
      <input class="{servicepage-number-input-part: phoneFieldBool, servicepage-number-input-part-two: !phoneFieldBool && isNumber,
                           servicepage-number-input-part-three: !phoneFieldBool && !isNumber}"
             type="{inputType}"
             id="firstFieldInput"
             maxlength="9" onfocus="bordersColor()"
             value="{defaultNumber}"/>
      <div class="servicepage-phone-icon" if="{phoneFieldBool}" ontouchend="searchContact()"></div>
    </div>

    <div class="servicepage-second-dropdown-field" if="{hasFirstLevel}"
         ontouchend="openDropDownTwo()">
      <p class="servicepage-dropdown-text-field">{chosenFieldNameTwo}</p>
      <div class="servicepage-dropdown-icon"></div>
    </div>

    <div class="servicepage-second-dropdown-field" if="{hasSecondLevel}"
         ontouchend="openDropDownThree()">
      <p class="servicepage-dropdown-text-field">{chosenFieldNameThree}</p>
      <div class="servicepage-dropdown-icon"></div>
    </div>

    <div class="{servicepage-amount-field: !dropDownOn, servicepage-amount-field-two: dropDownOn}"
         id="amountField">
      <p class="servicepage-text-field">{amountFieldTitle}</p>
      <input class="servicepage-amount-input" type="tel" value="{defaultAmount}" maxlength="13"
             id="amount"
             onfocus="amountFocus()" onblur="amountOnBlur()"
             onmouseup="eraseAmountDefault()" onkeyup="sumForPay()"/>
      <div class="servicepage-amount-icon" ontouchend="amountCalculator()"></div>
    </div>


    <div class="servicepage-button-enter" if="{enterButton}" ontouchend="enterButton()">
      <div class="servicepage-button-enter-label">{window.languages.ViewServicePageEnterLabel}</div>
    </div>

    <div class="servicepage-button-enter" if="{!enterButton}" ontouchend="enterButton()">
      <div class="servicepage-button-enter-label" style="right: 13%;">{window.languages.ViewServicePageSaveLabel}</div>
    </div>

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
      <p class="servicepage-dropdown-text-field" style="color: white;">{chosenFieldNameTwo}</p>
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
      <p class="servicepage-dropdown-text-field" style="color: white;">{chosenFieldNameThree}</p>
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

    <div class="{servicepage-pincards-container-two: !enterButton, servicepage-pincards-container: enterButton}">
      <div class="servicepage-pincards-block-container" each="{i in pincardIds}">
        <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
        <div class="servicepage-pincard-nominal-container" each="{j in pincardsMap[i]}"
             ontouchstart="onTouchStartOfPincard()" ontouchend="onTouchEndOfPincard({j.nominal},{j.card_type_id})">
          <p class="servicepage-pincard-nominal-value">{j.nominal}</p>
          <div class="servicepage-pincard-choose-arrow"></div>
        </div>
      </div>
    </div>

    <div id="formTypeTwoBtnSaveId" class="servicepage-button-save" if="{!enterButton}"
         ontouchend="addToFavoritesforFormTypeTwo()" type="button">
      <div class="servicepage-button-enter-label" if="{!enterButton}" style="right: 13%;">
        {window.languages.ViewServicePageSaveLabel}
      </div>
    </div>
  </div>


  <div id="blockAmountCalculatorId" class="component-calc">
    <div id="rightButton" type="button" class="component-banklist-close-button" ontouchend="closeComponent()"></div>
    <div class="component-calc-name-title">{window.languages.ViewAmountCalculatorNameTitle}</div>

    <div class="component-calc-fields-container">

      <div class="component-calc-first-field">
        <p class="component-calc-first-field-text">{window.languages.ViewAmountCalculatorTextOne}</p>
        <input id="amountCalcInputId" class="component-calc-first-field-input-part" type="tel"
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

  </div>


  <script>

    console.log('OPTS', opts);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-page') {
      history.arrayOfHistory.push(
        {
          "view": 'view-service-page',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var scope = this;
    scope.enterButton = opts[0] != 'ADDFAVORITE' ? true : false;


    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');


    this.on('mount', function () {
      if (opts && opts.number) {
          firstFieldInput.value = opts.number
          riot.update();

        }


      if (viewServicePage.amountWithoutSpace.length > 0) {
        amount.value = viewServicePage.amountText;
        checkFirst = true;
        amountForPayTransaction = viewServicePage.amountWithoutSpace;
      }
      else if (scope.formType != 2)
        amount.value = '0 ' + defaultAccount.currency
    })
    goToBack = function () {
      viewServicePage.phoneText = null;
      viewServicePage.amountText = null;
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    searchContact = function () {
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

      if (amount.value.length == 5 && amount.value[0] == '0') {
        amount.value = ' ' + defaultAccount.currency;
      }

    }

    amountOnBlur = function () {
      event.preventDefault()
      event.stopPropagation()

      if (amount.value.length == 4) {
        amount.value = '0 ' + defaultAccount.currency;
      }
    }

    amountCalculator = function () {

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

            riot.update(scope.currencyRate);
          }
          else {
            alert(result[0][0].error_note);
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
      riot.update(blockAmountCalculatorId);
    }

    closeComponent = function () {
      blockAmountCalculatorId.style.display = 'none';
      riot.update(blockAmountCalculatorId);
    }

    var converted;
    scope.convertedAmount = 0;

    convertAmount = function () {

      scope.convertedAmount = Math.ceil(amountCalcInputId.value * scope.currencyRate);
      converted = scope.convertedAmount.toString();


      if (converted.length == 7) {
        converted = converted.substring(0, 1) + ' ' +
          converted.substring(1, 4) + ' ' + converted.substring(4, converted.length)

      }

      if (converted.length == 6) {
        converted = converted.substring(0, 3) + ' ' +
          converted.substring(3, converted.length)

      }

      if (converted.length == 5) {
        converted = converted.substring(0, 2) + ' ' +
          converted.substring(2, converted.length);

      }

      if (converted.length == 4) {
        converted = converted.substring(0, 1) + ' ' +
          converted.substring(1, converted.length);
      }

      console.log("after=", converted);


      if (scope.convertedAmount > scope.service.max_pay_limit) {
        console.log("max limit=", scope.service.max_pay_limit);
        convertedAmountFieldId.style.borderBottomColor = 'red';
        acceptConvertedBtnId.style.pointerEvents = 'none';
        scope.convertedAmount = converted;
        riot.update(scope.convertedAmount);
      } else {
        convertedAmountFieldId.style.borderBottomColor = '#01cfff';
        acceptConvertedBtnId.style.pointerEvents = 'auto';
        scope.convertedAmount = converted;
        riot.update(scope.convertedAmount);
      }
    }

    acceptConvertedAmount = function () {
      amount.value = scope.convertedAmount + ' ' + defaultAccount.currency;
      if (amount.value.length > 0) {
        checkFirst = true;
        amountForPayTransaction = converted;
      }
      blockAmountCalculatorId.style.display = 'none';
      riot.update(blockAmountCalculatorId);
    }

    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
    scope.servicesParamsMapOne = JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"));
    scope.servicesParamsMapTwo = JSON.parse(localStorage.getItem("click_client_servicesParamsMapTwo"));
    scope.servicesParamsMapThree = JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"));
    scope.servicesParamsMapFour = JSON.parse(localStorage.getItem("click_client_servicesParamsMapFour"));
    scope.servicesParamsMapFive = JSON.parse(localStorage.getItem("click_client_servicesParamsMapFive"));
    riot.update(scope.categoryNamesMap);


    if (viewPay.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
      scope.service = scope.servicesMap[localStorage.getItem('myNumberOperatorId')][0];
      scope.titleName = 'Мой номер';
      scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
      viewServicePage.phoneText = localStorage.getItem('click_client_phoneNumber');
      viewServicePage.phoneText = viewServicePage.phoneText.substr(3, viewServicePage.phoneText.length - 3);
      scope.fieldArray = scope.servicesParamsMapOne[localStorage.getItem('myNumberOperatorId')];
      viewPay.chosenServiceId = localStorage.getItem('myNumberOperatorId');
      this.on('mount', function () {
        firstField.style.display = 'none';
        amountField.style.top = '5.5%';
      });
    } else {
      scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;
      scope.fieldArray = scope.servicesParamsMapOne[viewPay.chosenServiceId];
    }


    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;

    if (scope.formType != 2) {
      if (scope.fieldArray) {
        scope.dropDownOn = scope.fieldArray.length > 1;
        scope.chosenFieldName = scope.fieldArray[0].title;
        scope.chosenFieldParamId = scope.fieldArray[0].parameter_id;
        scope.amountFieldTitle = scope.service.lang_amount_title;
        scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1";
        if (scope.phoneFieldBool)
          scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;
        scope.defaultAmount = !viewServicePage.amountText ? 0 : viewServicePage.amountText;

        scope.inputMaxLength = scope.fieldArray[0].max_len;
        if (scope.dropDownOn) {
          scope.chosenFieldParamId = scope.fieldArray[0].parameter_id;
          scope.oldFieldParamId = scope.fieldArray[1].parameter_id;
        }
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
        scope.chosenFieldParamIdTwo = scope.firstLevelArray[0].id;
        if (scope.hasSecondLevel && scope.secondLevelMap[scope.firstLevelArray[0].id]) {
          scope.secondLevelArray = scope.secondLevelMap[scope.firstLevelArray[0].id];

        }
      }

      if (scope.formType == 4 && scope.servicesParamsMapFour[scope.service.id] && scope.servicesParamsMapFive[scope.service.id]) {
        scope.firstLevelArray = [];
        scope.secondLevelMap = {};
        scope.chosenFieldNameTwo = scope.servicesParamsMapFour[scope.service.id][0].name;
        scope.hasSecondLevel = true;
        scope.hasFirstLevel = true;
        this.on('mount', function () {
          amountField.style.display = 'none';
        });

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
      document.getElementById(scope.oldFieldParamId).style.backgroundColor = 'white';
      document.getElementById('text' + scope.oldFieldParamId).style.color = '#515151';
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
        if (scope.fieldArray[i].parameter_id == id) {
          scope.chosenFieldName = scope.fieldArray[i].title;
          scope.chosenFieldPlaceholder = scope.fieldArray[i].placeholder;
          scope.phoneFieldBool = scope.fieldArray[i].parameter_id == "1";
          scope.inputMaxLength = scope.fieldArray[i].max_len;
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
          riot.update(scope.chosenFieldName);
          riot.update(scope.phoneFieldBool);
          break;
        }
      }
    };

    scope.onTouchStartOfDropdownTwo = onTouchStartOfDropdownTwo = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfDropdownTwo = onTouchEndOfDropdownTwo = function (id) {
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20) {
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
              riot.update(scope.chosenFieldNameTwo);
              riot.update(scope.secondLevelArray);
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
              riot.update(scope.chosenFieldNameTwo);
              riot.update(scope.secondLevelArray);
              break;
            }
          }
        }
      }
    };


    scope.onTouchStartOfDropdownThree = onTouchStartOfDropdownThree = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfDropdownThree = onTouchEndOfDropdownThree = function (id) {
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20) {
        this.blockSecondDropdownId.style.display = 'none';
        if (scope.formType == 3) {
          for (var i = 0; i < scope.secondLevelArray.length; i++) {
            if (scope.secondLevelArray[i].id == id) {
              scope.chosenFieldNameThree = scope.secondLevelArray[i].name;
              if (scope.chosenFieldParamIdThree)
                scope.oldFieldParamIdThree = scope.chosenFieldParamIdThree;
              scope.chosenFieldParamIdThree = id;

              riot.update(scope.chosenFieldNameThree);
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
              scope.amountOfFormTypeFour = scope.secondLevelArray[i].sum_cost;
              viewServicePage.amountText = scope.secondLevelArray[i].usd_cost;
              riot.update(scope.chosenFieldNameThree);
              break;
            }
          }
        }
      }
    };

    this.on('mount', function () {
      if (viewServicePage.amountText)
        if (viewServicePage.amountText.length > 0) {
          amount.value = viewServicePage.amountText;
          checkFirst = true;
          amountForPayTransaction = viewServicePage.amountWithoutSpace;
        }
        else
          amount.value = 0 + ' ' + defaultAccount.currency
    });

    var maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      amountForPayTransaction,
      checkFirst = false,
      defaultAccount;

    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }

    eraseAmountDefault = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!checkFirst) {
        amount.value = ' ' + defaultAccount.currency;
        checkFirst = true;
      }
      if (amount.value.match(maskOne) != null && amount.value.match(maskOne).length != null) {
        amount.selectionStart = amount.value.match(maskTwo).length - 1;
        amount.selectionEnd = amount.value.match(maskTwo).length - 1;
      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      amountField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
      firstField.style.borderBottom = 5 * widthK + 'px solid lightgrey';

    };

    sumForPay = function () {
      event.preventDefault();
      event.stopPropagation();

      if (event.keyCode == 8) {
        amountForPayTransaction = amountForPayTransaction.substring(0, amountForPayTransaction.length - 1)
      }

      if (amount.value.length == 5 && amount.value[0] == '0') {
        amount.value = ' ' + defaultAccount.currency;
      }

      if (amount.value.match(maskTwo) != null && amount.value.match(maskTwo).length != null) {

        amount.value = amount.value.substring(0, event.target.value.match(maskTwo).length) + defaultAccount.currency;
        amount.selectionStart = amount.value.match(maskTwo).length - 1;
        amount.selectionEnd = amount.value.match(maskTwo).length - 1;

        amountForPayTransaction = amount.value.substring(0, amount.value.match(maskTwo).length);
        amountForPayTransaction = amountForPayTransaction.replace(new RegExp(' ', 'g'), '');

        if (amountForPayTransaction.length == 4) {
          amount.value = amountForPayTransaction.substring(0, 1) + ' ' + amountForPayTransaction.substring(1, amountForPayTransaction.length) + ' ' + defaultAccount.currency;
          amount.selectionStart = amount.value.match(maskTwo).length - 1;
          amount.selectionEnd = amount.value.match(maskTwo).length - 1

        }

        if (amountForPayTransaction.length == 5) {
          amount.value = amountForPayTransaction.substring(0, 2) + ' ' + amountForPayTransaction.substring(2, amountForPayTransaction.length) + ' ' + defaultAccount.currency;
          amount.selectionStart = amount.value.match(maskTwo).length - 1;
          amount.selectionEnd = amount.value.match(maskTwo).length - 1;

        }

        if (amountForPayTransaction.length == 6) {
          amount.value = amountForPayTransaction.substring(0, 3) + ' ' + amountForPayTransaction.substring(3, amountForPayTransaction.length) + ' ' + defaultAccount.currency;
          amount.selectionStart = amount.value.match(maskTwo).length - 1;
          amount.selectionEnd = amount.value.match(maskTwo).length - 1;

        }

        if (amountForPayTransaction.length == 7) {
          amount.value = amountForPayTransaction.substring(0, 1) + ' ' + amountForPayTransaction.substring(1, 4) + ' ' +
            amountForPayTransaction.substring(4, amountForPayTransaction.length) + ' ' + defaultAccount.currency;
          amount.selectionStart = amount.value.match(maskTwo).length - 1;
          amount.selectionEnd = amount.value.match(maskTwo).length - 1;

        }

        if (amountForPayTransaction.length == 8) {
          amount.value = amountForPayTransaction.substring(0, 2) + ' ' + amountForPayTransaction.substring(2, 5) + ' ' +
            amountForPayTransaction.substring(5, amountForPayTransaction.length) + ' ' + defaultAccount.currency;
          amount.selectionStart = amount.value.match(maskTwo).length - 1;
          amount.selectionEnd = amount.value.match(maskTwo).length - 1;

        }


      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      viewServicePage.amountText = amount.value;
      viewServicePage.amountWithoutSpace = amountForPayTransaction;

    };

    bordersColor = function () {

      event.preventDefault()
      event.stopPropagation()


      firstField.style.borderBottom = 5 * widthK + 'px solid #01cfff';
      amountField.style.borderBottom = 5 * widthK + 'px solid lightgrey';
    };

    enterButton = function () {

      if (scope.phoneFieldBool && firstFieldInput.value.length < 9) {
        alert("Введите валидный номер телефона");
        return;
      } else if (firstFieldInput.value.length == 0) {
        alert("Введите значение первого поля");
        return;
      }
      if (amountForPayTransaction < scope.service.min_pay_limit) {
        alert("Сумма должна быть больше " + scope.service.min_pay_limit);
        return;
      }
      if (amountForPayTransaction > scope.service.max_pay_limit) {
        alert("Сумма должна быть меньше " + scope.service.max_pay_limit);
        return;
      }

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
        if (scope.chosenFieldParamIdThree && scope.amountOfFormTypeFour) {
          var amountText = {"amountText": scope.amountOfFormTypeFour};
          var internetPackageParam = {"internetPackageParam": scope.chosenFieldParamIdThree};
        } else {
          alert("Выберите интернет пакет");
          return;
        }
      }

      var formtype = {"formtype": scope.formType};
      var firstFieldId = {"firstFieldId": scope.chosenFieldParamId};
      var firstFieldText = {"firstFieldText": firstFieldInput.value};
      var cardTypeId = {"cardTypeId": null};

      viewServicePage.firstFieldTitle = scope.chosenFieldName;
      viewServicePage.phoneText = firstFieldInput.value;
      var isInFavorites = {"isInFavorites": !scope.enterButton};

      if (scope.enterButton) {

        event.preventDefault();
        event.stopPropagation();
        this.riotTags.innerHTML = "<view-service-pincards>";
        riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites]);
      } else {
        console.log("GOING TO ADD TO FAVORITES");
        addToFavorites([formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites]);

        event.preventDefault();
        event.stopPropagation();
        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');

      }
    };


    scope.onTouchStartOfPincard = onTouchStartOfPincard = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfPincard = onTouchEndOfPincard = function (nominal, cardId) {
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20) {
        var formtype = {"formtype": scope.formType};
        var firstFieldId = {"firstFieldId": null};
        var firstFieldText = {"firstFieldText": null};
        var cardTypeId = {"cardTypeId": cardId};
        var communalParam = {"communalParam": null};
        var amountText = {"amountText": nominal};
        var internetPackageParam = {"internetPackageParam": null};
        var isInFavorites = {"isInFavorites": !scope.enterButton};

        scope.formTypeTwoOptsArray = [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites];

        if (scope.enterButton) {
          event.preventDefault();
          event.stopPropagation();
          this.riotTags.innerHTML = "<view-service-pincards>";
          riot.mount('view-service-pincards', scope.formTypeTwoOptsArray);
        } else {
          formTypeTwoBtnSaveId.style.pointerEvents = 'auto';
          formTypeTwoBtnSaveId.style.backgroundColor = 'rgb(1, 124, 227)';
          riot.update(formTypeTwoBtnSaveId);
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
      }
      else
        alert("Попробуйте еще раз");

    }

    addToFavorites = function (array) {
      if (!localStorage.getItem('favoritePaymentsList')) {
        var favoritePaymentsList = [];
        console.log("OPTS TO SAVE=", array);
        console.log("Chosen Service =", scope.service);
        favoritePaymentsList.push({
          "opts": array,
          "service": scope.service,
          "categoryId": viewPay.categoryId,
          "firstFieldTitle": viewServicePage.firstFieldTitle
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);
        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));

      } else {
        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        console.log("OPTS TO SAVE=", array);
        console.log("Chosen Service =", scope.service);
        favoritePaymentsList.push({
          "opts": array,
          "service": scope.service,
          "categoryId": viewPay.categoryId,
          "firstFieldTitle": viewServicePage.firstFieldTitle
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);
        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      }
    }


  </script>
</view-service-page>

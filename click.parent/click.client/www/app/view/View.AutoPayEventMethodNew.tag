<view-autopay-event-method-new class="riot-tags-main-container">
  <div id="autopayEventPageId" class="view-common-page">

    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodEventText}</p>
      <div ontouchend="goToBack()" ontouchstart="onTouchStartOfBack()"
           class="servicepage-button-back">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
      <div class="title-bottom-border">
      </div>
    </div>

    <div class="autopay-method-body-container">

      <div class="servicepage-first-field autopay-event-name-field">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               value="{defaultName}" autofocus="true" onkeyup="autoPayEventNameVerificationKeyUp()"/>
      </div>

      <div class="servicepage-first-field autopay-event-number-field" id="firstField">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayMethodEventPhoneNumber}</p>
        <p class="servicepage-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input class="servicepage-number-input-part" type="tel" id="PhoneNumberInput"
               autofocus="true" value="{defaultNumber}"
               onkeydown="telPayVerificationKeyDown(this)"
               onkeyup="telPayVerificationKeyUp()"/>
        <div class="servicepage-phone-icon" ontouchstart="onTouchStartOfSearchContact()"
             ontouchend="searchContact()"></div>
      </div>

      <div id="convertedAmountFieldId" class="autopay-event-step-field">
        <p class="autopay-event-step-field-text">{window.languages.ViewAutoPayMethodEventPutBalansText}</p>

        <div class="autopay-event-step-container" if="{stepsArrayExist}" ontouchend="openStepsDropDown()">
          <div class="autopay-event-step-text">{chosenStepTitle}</div>
          <div class="autopay-event-step-dropdown-icon"></div>
        </div>
      </div>

      <div class="autopay-event-amount-dropdown-field" if="{amountsArrayExist}" ontouchend="openDropDown()"
           id="amountChoiceId">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayMethodEventPayAmountText}</p>
        <p class="autopay-event-dropdown-text-field">{chosenAmount}</p>
        <div class="servicepage-dropdown-icon"></div>
      </div>

      <p class="autopay-event-amounts-info-text">{window.languages.ViewAutoPayMethodEventAmountCanBeText}</p>
      <p class="autopay-event-amounts-info-text autopay-event-amounts-info-text-two">{amountsCanBeText}сум</p>


      <button id="enterButtonId" style="bottom: {window.bottomButtonBottom}"
              class="{autopay-event-button-enter-enabled: enterButtonEnabled,autopay-event-button-enter-disabled:!enterButtonEnabled}"
              ontouchend="chooseCardToPay()" ontouchstart="onTouchStartOfChooseCard()">
        {window.languages.ViewServicePageEnterLabel}
      </button>

    </div>

  </div>

  <component-dropdown></component-dropdown>
  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.enterButtonEnabled = false;

    window.saveHistory('view-autopay-event-method-new', opts);

    var backStartY, backStartX, backEndY, backEndX;

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();
      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    goToBack = function () {
      event.stopPropagation();

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        onBackKeyDown();
        scope.unmount()
      }
    };


    scope.titleName = window.languages.ViewAutoPayTitleName;
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    onBackParams.opts = JSON.parse(JSON.stringify(opts));
    if (scope.autoPayData.fromView === 'PAYCONFIRM') {
      onBackParams.opts.mode = 'USUAL';
      opts.mode = 'ADDAUTOPAY';
    }
    console.log("Window.opts=", onBackParams.opts)
    console.log("OPTS AutoPayMethod EVENT NEW=", opts);

    if (opts.chosenServiceId === 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
      console.log("My number part");
      scope.serviceName = 'Мой номер';
      scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';

      opts.firstFieldText = localStorage.getItem('click_client_phoneNumber');
      opts.firstFieldText = opts.firstFieldText ? opts.firstFieldText.substr(3, opts.firstFieldText.length - 3) : '';
      opts.chosenServiceId = localStorage.getItem('myNumberOperatorId');
      scope.defaultNumber = !opts.firstFieldText ? null : inputVerification.telVerificationWithSpace(opts.firstFieldText);

    } else {
      scope.serviceName = scope.servicesMap[scope.autoPayData.service_id][0].name;
      scope.serviceIcon = scope.servicesMap[scope.autoPayData.service_id][0].image;
      if (opts.firstFieldText) {
        if (opts.firstFieldId == 1) {
          scope.defaultNumber = !opts.firstFieldText ? null : (inputVerification.telVerificationWithSpace(opts.firstFieldText));
        }
        else {
          scope.defaultNumber = opts.firstFieldText;
        }
      }
    }

    scope.defaultAmount = !opts.amountText ? 0 : opts.amountText;
    scope.defaultName = scope.autoPayData.name ? scope.autoPayData.name : "";

    scope.amountsArray = scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_amounts;
    scope.stepsArray = scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps;
    scope.amountsArrayExist = !!scope.amountsArray;
    scope.stepsArrayExist = !!scope.stepsArray;
    scope.amountsCanBeText = "";

    console.log("stepsArray=", scope.stepsArray);


    if (scope.amountsArrayExist) {
      scope.chosenFieldParamId = scope.autoPayData.amount ? scope.autoPayData.amount : scope.amountsArray[0];
      scope.chosenAmount = scope.autoPayData.amount ? scope.autoPayData.amount : scope.amountsArray[0];

      for (var i = 0; i < scope.amountsArray.length; i++) {
        if (i === scope.amountsArray.length - 1)
          scope.amountsCanBeText += 'или ' + scope.amountsArray[i] + ' ';
        else if (i === scope.amountsArray.length - 2)
          scope.amountsCanBeText += scope.amountsArray[i] + ' ';
        else
          scope.amountsCanBeText += scope.amountsArray[i] + ', ';
      }
    }

    if (scope.stepsArrayExist) {
      scope.chosenStepTitle = scope.autoPayData.stepTitle ? scope.autoPayData.stepTitle : scope.stepsArray[0].step_title;
      scope.chosenStepId = scope.autoPayData.step ? scope.autoPayData.step : scope.stepsArray[0].step_value;
    }

    scope.update();

    this.on('mount', function () {
      if (device.platform === 'iOS') {
        autoPayNameInput.autofocus;
        autoPayNameInput.focus();
      } else {
        setTimeout(function () {
          autoPayNameInput.focus();
        }, 0);
      }

    });


    openDropdownComponent = function () {
      window.blurFields();
      this.dropdownBackPageId.style.webkitTransition = '0.3s';
      this.autopayEventPageId.style.webkitTransition = '0.3s';
      this.autopayEventPageId.style.zIndex = '0';
      this.autopayEventPageId.style.opacity = '0.1';
      this.dropdownId.style.webkitTransition = '0.3s';
      this.dropdownId.style.transform = "translate3d(0, 0, 0)";
      this.dropdownId.style.webkitTransform = "translate3d(0, 0, 0)";
      this.dropdownBackPageId.style.opacity = '1';
    };

    scope.processDropdown = processDropdown = function (id, title) {
      console.log("id got from dropdown =", id, title);
      switch (scope.dropDownType) {
        case "amount": {
          chooseAmount(id);
          break;
        }
        case "step": {
          chooseStep(id);
          break;
        }
      }
    };

    openDropDown = function () {

      console.log("open amounts drop down", scope.amountsArray, scope.chosenFieldParamId);
      scope.dropDownType = "amount";
      updateDropdownList(scope.amountsArray, null, scope.chosenFieldParamId, null, "autopayEventPageId");
      openDropdownComponent();

    };


    openStepsDropDown = function () {

      console.log("open steps drop down", scope.stepsArray, scope.chosenStepId);
      scope.dropDownType = "step";
      updateDropdownList(scope.stepsArray, "step_value", scope.chosenStepId, "step_title", "autopayEventPageId");
      openDropdownComponent();
    };


    chooseAmount = function (id) {

      for (var i = 0; i < scope.amountsArray.length; i++) {
        if (scope.amountsArray[i] == id) {
          scope.chosenAmount = scope.amountsArray[i];

          scope.chosenFieldParamId = id;
          scope.update(scope.chosenAmount);
          break;
        }
      }

    };


    chooseStep = function (id) {

      for (var i = 0; i < scope.stepsArray.length; i++) {
        if (scope.stepsArray[i].step_value === id) {
          scope.chosenStepTitle = scope.stepsArray[i].step_title;
          scope.chosenStepId = id;
          scope.update(scope.chosenStepTitle);

          break;
        }
      }
    };

    var eventContactStopChanging = false;
    telPayVerificationKeyDown = function (input) {

      if (input.value.length >= 10 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
//          PhoneNumberInput.value = event.target.value.substring(0, event.target.value.length - 1);
        eventContactStopChanging = true;
      }
      else {
        eventContactStopChanging = false;
      }
    };

    telPayVerificationKeyUp = function () {


      if (eventContactStopChanging) {
        PhoneNumberInput.value = event.target.value.substring(0, event.target.value.length - 1);
      }

      cursorPositionSelectionStart = PhoneNumberInput.selectionStart;
      cursorPositionSelectionEnd = PhoneNumberInput.selectionEnd;
      oldValueOfNumber = PhoneNumberInput.value

      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        if (PhoneNumberInput.type != 'text')
          PhoneNumberInput.value = inputVerification.telVerificationWithSpace(PhoneNumberInput.value)

        // numberForPayTransaction = PhoneNumberInput.value.substring(0, PhoneNumberInput.value.match(maskTwo).length);
        //console.log('amount 1', numberForPayTransaction.toString())
        //numberForPayTransaction = numberForPayTransaction.replace(new RegExp(' ', 'g'), '');

        console.log('oldValueOfNumber', oldValueOfNumber.toString() + '/');
        console.log('PhoneNumberInput.value', PhoneNumberInput.value.toString() + '/');

        PhoneNumberInput.selectionStart = cursorPositionSelectionStart
        PhoneNumberInput.selectionEnd = cursorPositionSelectionEnd

        if (oldValueOfNumber != PhoneNumberInput.value && cursorPositionSelectionStart == 3) {
          console.log('cursor =3')
          PhoneNumberInput.selectionStart = cursorPositionSelectionStart + 1;
        }

      }
      checkFieldsEventToActivateNext();
    };

    var searchContactStartY, searchContactStartX, searchContactEndY, searchContactEndX;

    scope.onTouchStartOfSearchContact = onTouchStartOfSearchContact = function () {
      event.stopPropagation();
      searchContactStartY = event.changedTouches[0].pageY;
      searchContactStartX = event.changedTouches[0].pageX;
    };

    searchContact = function () {
      event.stopPropagation();

      searchContactEndY = event.changedTouches[0].pageY;
      searchContactEndX = event.changedTouches[0].pageX;

      if (Math.abs(searchContactStartY - searchContactEndY) <= 20 && Math.abs(searchContactStartX - searchContactEndX) <= 20) {
        window.pickContactFromNativeChecker = true;
        var maskOne = /[0-9]/g;
        window.plugins.PickContact.chooseContact(function (contactInfo) {
          setTimeout(function () {
            var phoneNumber;
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
            PhoneNumberInput.value = inputVerification.telVerificationWithSpace(phone.substring(phone.length - 9, phone.length));
            checkFieldsEventToActivateNext();
          }, 0);
        }, function (error) {
          console.log('error', error)
        });

      }

    };

    autoPayEventNameVerificationKeyUp = function () {

      checkFieldsEventToActivateNext();
    };

    checkFieldsEventToActivateNext = function () {

      if (this.autoPayNameInput.value.length < 1) {
        console.log("Введите название автоплатежа");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);

        return;
      }

      if (this.PhoneNumberInput.value.length < 10) {
        console.log("Неправильно введён номер телефона");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);

        return;
      } else if (this.PhoneNumberInput.value.length == 0) {
        console.log("Введите значение первого поля");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);

        return;
      }

//      if (!scope.chosenStepId) {
//        console.log("Выберите условную сумму для пополнения баланса");
//        scope.enterButtonEnabled = false;
//        scope.update(scope.enterButtonEnabled);
//
//        return;
//      }


      scope.enterButtonEnabled = true;
      scope.update(scope.enterButtonEnabled);
    };

    var chooseCardStartY, chooseCardStartX, chooseCardEndY, chooseCardEndX;

    scope.onTouchStartOfChooseCard = onTouchStartOfChooseCard = function () {
      event.stopPropagation();
      chooseCardStartY = event.changedTouches[0].pageY;
      chooseCardStartX = event.changedTouches[0].pageX;
    };


    var phoneRegexp = new RegExp(scope.servicesMap[scope.autoPayData.service_id][0].validation);

    chooseCardToPay = function () {

      event.stopPropagation();

      chooseCardEndY = event.changedTouches[0].pageY;
      chooseCardEndX = event.changedTouches[0].pageX;

      if (Math.abs(chooseCardStartY - chooseCardEndY) <= 20 && Math.abs(chooseCardStartX - chooseCardEndX) <= 20) {
        if (autoPayNameInput.value.length < 1) {
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: "Введите название автоплатежа",
          });
          scope.update();
          return;
        }

//        console.log("REGEXP =", phoneRegexp);
//        console.log("REGEXP validation=", PhoneNumberInput.value.match(phoneRegexp));
//        console.log("REGEXP validation=", phoneRegexp.test(inputVerification.spaceDeleter(PhoneNumberInput.value)));

        if (PhoneNumberInput.value.length < 10) {
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: "Неправильно введён номер телефона",
          });
          scope.update();
          return;
        } else if (PhoneNumberInput.value.length == 0) {
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: "Введите значение первого поля",
          });
          scope.update();
          return;
        }

//        if (!phoneRegexp.test(inputVerification.spaceDeleter(PhoneNumberInput.value))) {
//          scope.clickPinError = false;
//          scope.errorNote = "Возможно вы ввели номер другого оператора";
//          scope.showError = true;
//          scope.update();
//          return;
//        }

//        if (!scope.chosenStepId) {
//          scope.clickPinError = false;
//          scope.errorNote = "Выберите условную сумму для пополнения баланса";
//          scope.showError = true;
//          scope.update();
//          return;
//        }

        scope.autoPayData.name = autoPayNameInput.value;
        scope.autoPayData.isNew = true;
        scope.autoPayData.step = scope.chosenStepId;
        scope.autoPayData.stepTitle = scope.chosenStepTitle;
        scope.autoPayData.cntrg_phone_num = inputVerification.spaceDeleter(PhoneNumberInput.value);
        scope.autoPayData.amount = scope.chosenAmount;
        opts.amountText = scope.chosenAmount;

        for (var j in scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps) {
          console.log("STep =", scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j]);
          if (scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j].step_value == scope.chosenStepId) {
            scope.autoPayData.condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j].step_title;
            console.log("STep title=", scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j].step_title);
            break;
          }
        }
        console.log("Autopay Data=", scope.autoPayData);
//      scope.autoPayData.condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + scope.chosenStepId;
        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));


        if (scope.autoPayData.fromView == 'PAY') {
          opts.formtype = scope.servicesMap[opts.chosenServiceId][0].form_type;
          opts.firstFieldId = scope.servicesParamsMapOne[opts.chosenServiceId][0].parameter_id;
          opts.firstFieldTitle = scope.servicesParamsMapOne[opts.chosenServiceId][0].title;
          opts.firstFieldText = PhoneNumberInput.value;

          opts.isInFavorites = false;
          opts.mode = 'ADDAUTOPAY';

          this.riotTags.innerHTML = "<view-service-pincards-new>";
          riot.mount('view-service-pincards-new', opts);
          scope.unmount()
        }
        else if (scope.autoPayData.fromView == 'PAYCONFIRM') {
          this.riotTags.innerHTML = "<view-pay-confirm-new>";
          riot.mount('view-pay-confirm-new', opts);
          scope.unmount()

        }
      }
    };


  </script>
</view-autopay-event-method-new>

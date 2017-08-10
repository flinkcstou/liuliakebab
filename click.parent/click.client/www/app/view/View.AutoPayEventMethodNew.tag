<view-autopay-event-method-new>
  <div class="riot-tags-main-container">
    <div class="pay-page-title" style="border-style: none;">
      <p class="autopay-method-page-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodEventText}</p>
      <div ontouchend="goToBack()" ontouchstart="onTouchStartOfBack()"
           class="autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">

      <div class="servicepage-first-field autopay-event-name-field">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="autoPayEventNameVerificationKeyUp()"/>
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

        <div class="autopay-event-step-container" each="{i in stepsArray}">
          <div class="autopay-event-step-text">{i.step_title}</div>
          <div id="{i.step_value}" class="autopay-event-step-check-icon" ontouchend="chooseStep(this.id)"></div>
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


      <button
        class="{autopay-event-button-enter-enabled: enterButtonEnabled,autopay-event-button-enter-disabled:!enterButtonEnabled}"
        ontouchend="chooseCardToPay()" ontouchstart="onTouchStartOfChooseCard()">
        {window.languages.ViewServicePageEnterLabel}
      </button>

    </div>

  </div>

  <div id="blockFirstFieldId" class="autopay-event-amount-dropdown-component">
    <div class="autopay-event-amount-dropdown-field-two">
      <p class="autopay-event-dropdown-text-field" style="color: white;">{chosenAmount}</p>
    </div>
    <div class="autopay-event-dropdown-container">
      <div class="autopay-event-dropdown-variant" each="{i in amountsArray}" id="{i}"
           ontouchstart="onTouchStartOfAmountDropdown()" ontouchend="onTouchEndOfAmountDropdown(this.id)">
        <p id="text{i}" class="autopay-event-dropdown-text-field" style="left: 8%">{i}</p>
      </div>
    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    scope.enterButtonEnabled = false;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-event-method-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-event-method-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

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


    this.titleName = window.languages.ViewAutoPayTitleName;
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    onBackParams.opts = JSON.parse(JSON.stringify(opts));
    if (scope.autoPayData.fromView == 'PAYCONFIRM') {
      onBackParams.opts.mode = 'USUAL';
      opts.mode = 'ADDAUTOPAY';
    }
    console.log("Window.opts=", onBackParams.opts)
    console.log("OPTS AutoPayMethod EVENT NEW=", opts);

    if (opts.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
      console.log("My number part");
      scope.serviceName = 'Мой номер';
      scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';

      opts.firstFieldText = localStorage.getItem('click_client_phoneNumber');
      opts.firstFieldText = opts.firstFieldText ? opts.firstFieldText.substr(3, opts.firstFieldText.length - 3) : '';
      opts.chosenServiceId = localStorage.getItem('myNumberOperatorId');
      scope.defaultNumber = !opts.firstFieldText ? null : inputVerification.telVerificationWithSpace(opts.firstFieldText);

    } else {
      this.serviceName = scope.servicesMap[scope.autoPayData.service_id][0].name;
      this.serviceIcon = scope.servicesMap[scope.autoPayData.service_id][0].image;
      if (scope.autoPayData.fromView == 'PAYCONFIRM' && opts.firstFieldText) {
        if (opts.firstFieldId == 1)
          scope.defaultNumber = !opts.firstFieldText ? null : (inputVerification.telVerificationWithSpace(opts.firstFieldText));
        else scope.defaultNumber = opts.firstFieldText;
      }
    }

    scope.defaultAmount = !opts.amountText ? 0 : opts.amountText;

    this.amountsArray = scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_amounts;
    this.stepsArray = scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps;
    scope.amountsArrayExist = this.amountsArray ? true : false;
    scope.stepsArrayExist = this.stepsArray ? true : false;
    scope.chosenStep = this.stepsArray ? this.stepsArray[0].step_value : null;
    scope.amountsCanBeText = "";


    if (scope.amountsArrayExist) {
      scope.chosenFieldParamId = this.amountsArray[0];
      scope.chosenAmount = this.amountsArray[0];

      for (var i = 0; i < this.amountsArray.length; i++) {
        if (i == this.amountsArray.length - 1)
          scope.amountsCanBeText += 'или ' + this.amountsArray[i] + ' ';
        else if (i == this.amountsArray.length - 2)
          scope.amountsCanBeText += this.amountsArray[i] + ' ';
        else
          scope.amountsCanBeText += this.amountsArray[i] + ', ';
      }
    }

    scope.update(scope.amountsCanBeText);

    this.on('mount', function () {
      if (device.platform == 'iOS') {
        autoPayNameInput.autofocus;
        autoPayNameInput.focus();
      } else {
        setTimeout(function () {
          autoPayNameInput.focus();
        }, 0);
      }

    });


    var oldChosenStep, chosenStep;

    chooseStep = function (id) {
      oldChosenStep = chosenStep;
      chosenStep = id;
      document.getElementById(chosenStep).style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
      if (oldChosenStep && oldChosenStep != id)
        document.getElementById(oldChosenStep).style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
      checkFieldsEventToActivateNext();
    };

    openDropDown = function () {
      this.blockFirstFieldId.style.display = 'block';
      console.log("id=", scope.chosenFieldParamId);
      if (scope.oldFieldParamId) {
        document.getElementById(scope.oldFieldParamId).style.backgroundColor = 'white';
        document.getElementById('text' + scope.oldFieldParamId).style.color = '#515151';
      }
      if (scope.chosenFieldParamId) {
        document.getElementById(scope.chosenFieldParamId).style.backgroundColor = '#0084E6';
        document.getElementById('text' + scope.chosenFieldParamId).style.color = 'white';
      }
    };


    scope.onTouchStartOfAmountDropdown = onTouchStartOfAmountDropdown = function () {
      event.stopPropagation();
      amountOnTouchStartY = event.changedTouches[0].pageY;
      amountOnTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfAmountDropdown = onTouchEndOfAmountDropdown = function (id) {
      event.stopPropagation();

      amountOnTouchEndY = event.changedTouches[0].pageY;
      amountOnTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(amountOnTouchStartY - amountOnTouchEndY) <= 20 && Math.abs(amountOnTouchStartX - amountOnTouchEndX) <= 20) {

        this.blockFirstFieldId.style.display = 'none';

        for (var i = 0; i < scope.amountsArray.length; i++) {
          if (scope.amountsArray[i] == id) {
            scope.chosenAmount = scope.amountsArray[i];

            scope.oldFieldParamId = scope.chosenFieldParamId;
            scope.chosenFieldParamId = id;
            scope.update(scope.chosenAmount);
            break;
          }
        }
      }
    };

    var eventContactStopChanging = false
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

      if (!chosenStep) {
        console.log("Выберите условную сумму для пополнения баланса");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);

        return;
      }


      scope.enterButtonEnabled = true;
      scope.update(scope.enterButtonEnabled);
    }

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
          scope.clickPinError = false;
          scope.errorNote = "Введите название автоплатежа";
          scope.showError = true;
          scope.update();
          return;
        }

//        console.log("REGEXP =", phoneRegexp);
//        console.log("REGEXP validation=", PhoneNumberInput.value.match(phoneRegexp));
//        console.log("REGEXP validation=", phoneRegexp.test(inputVerification.spaceDeleter(PhoneNumberInput.value)));

        if (PhoneNumberInput.value.length < 10) {
          scope.clickPinError = false;
          scope.errorNote = "Неправильно введён номер телефона";
          scope.showError = true;
          scope.update();
          return;
        } else if (PhoneNumberInput.value.length == 0) {
          scope.clickPinError = false;
          scope.errorNote = "Введите значение первого поля";
          scope.showError = true;
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

        if (!chosenStep) {
          scope.clickPinError = false;
          scope.errorNote = "Выберите условную сумму для пополнения баланса";
          scope.showError = true;
          scope.update();
          return;
        }

        scope.autoPayData.name = autoPayNameInput.value;
        scope.autoPayData.isNew = true;
        scope.autoPayData.step = chosenStep;
        scope.autoPayData.cntrg_phone_num = inputVerification.spaceDeleter(PhoneNumberInput.value);
        scope.autoPayData.amount = scope.chosenAmount;
        opts.amountText = scope.chosenAmount;

        for (var j in scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps) {
          console.log("STep =", scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j]);
          if (scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j].step_value == chosenStep) {
            scope.autoPayData.condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j].step_title;
            console.log("STep title=", scope.servicesMap[scope.autoPayData.service_id][0].autopay_available_steps[j].step_title);
            break;
          }
        }
        console.log("Autopay Data=", scope.autoPayData);
//      scope.autoPayData.condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + chosenStep;
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
    }


  </script>
</view-autopay-event-method-new>

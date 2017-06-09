<view-autopay-event-method-new>
  <div class="riot-tags-main-container">
    <div class="pay-page-title" style="border-style: none;">
      <p class="autopay-method-page-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodEventText}</p>
      <div ontouchend="goToBack()"
           class="autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">

      <div class="servicepage-first-field autopay-event-name-field">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true"/>
      </div>

      <div class="servicepage-first-field autopay-event-number-field" id="firstField">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayMethodEventPhoneNumber}</p>
        <p class="servicepage-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input class="servicepage-number-input-part" type="tel" id="firstFieldInput"
               autofocus="true" value="{defaultNumber}"
               onkeydown="telPayVerificationKeyDown(this)"
               onkeyup="telPayVerificationKeyUp()"/>
        <div class="servicepage-phone-icon" ontouchend="searchContact()"></div>
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


      <button class="autopay-event-button-enter"
              ontouchend="chooseCardToPay()">{window.languages.ViewServicePageEnterLabel}
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

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-event-method-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-event-method-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown();
      scope.unmount()
    };


    this.titleName = window.languages.ViewAutoPayTitleName;
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    console.log("OPTS AutoPayMethod EVENT NEW=", opts);

    if (viewPay.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
      console.log("My number part");
      scope.serviceName = 'Мой номер';
      scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
      viewServicePage.phoneText = localStorage.getItem('click_client_phoneNumber');
      viewServicePage.phoneText = viewServicePage.phoneText ? viewServicePage.phoneText.substr(3, viewServicePage.phoneText.length - 3) : '';
      scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;
      viewPay.chosenServiceId = localStorage.getItem('myNumberOperatorId');
    } else {
      this.serviceName = scope.servicesMap[scope.autoPayData.service_id][0].name;
      this.serviceIcon = scope.servicesMap[scope.autoPayData.service_id][0].image;
      if (scope.autoPayData.fromView == 'PAYCONFIRM' && opts.firstFieldText)
        scope.defaultNumber = opts.firstFieldText;
    }

    //    scope.defaultNumber = !viewServicePage.phoneText ? null : viewServicePage.phoneText;


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


    var oldChosenStep, chosenStep;

    chooseStep = function (id) {
      oldChosenStep = chosenStep;
      chosenStep = id;
      document.getElementById(chosenStep).style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      if (oldChosenStep && oldChosenStep != id)
        document.getElementById(oldChosenStep).style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
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

    telPayVerificationKeyDown = function (input) {

      if (input.value.length >= 9 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        firstFieldInput.value = event.target.value.substring(0, event.target.value.length - 1);
      }
    };

    telPayVerificationKeyUp = function () {
      if (event.keyCode != input_codes.BACKSPACE_CODE) {
        console.log(firstFieldInput.value)
        firstFieldInput.value = inputVerification.telVerification(firstFieldInput.value)
      }
    };

    searchContact = function () {
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
          firstFieldInput.value = phone.substring(phone.length - 9, phone.length);
        }, 0);
      }, function (error) {
        console.log('error', error)
      });

    };

    chooseCardToPay = function () {
      if (autoPayNameInput.value.length < 1) {
        scope.clickPinError = false;
        scope.errorNote = "Введите название автоплатежа";
        scope.showError = true;
        scope.update();
        return;
      }

      if (firstFieldInput.value.length < 9) {
        scope.clickPinError = false;
        scope.errorNote = "Неправильно введён номер телефона";
        scope.showError = true;
        scope.update();
        return;
      } else if (firstFieldInput.value.length == 0) {
        scope.clickPinError = false;
        scope.errorNote = "Введите значение первого поля";
        scope.showError = true;
        scope.update();
        return;
      }

      if (!chosenStep) {
        scope.clickPinError = false;
        scope.errorNote = "Выберите условную сумму для пополнения баланса";
        scope.showError = true;
        scope.update();
        return;
      }

      scope.autoPayData.name = autoPayNameInput.value;
      scope.autoPayData.isNew = true;
      localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

      scope.autoPayData.step = chosenStep;
      scope.autoPayData.cntrg_phone_num = firstFieldInput.value;
      scope.autoPayData.amount = scope.chosenAmount;
      scope.autoPayData.condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + chosenStep;
      localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

      if (scope.autoPayData.fromView == 'PAY') {
        var formtype = {"formtype": 1};
        var firstFieldId = {"firstFieldId": 1};
        var firstFieldText = {"firstFieldText": firstFieldInput.value};
        var cardTypeId = {"cardTypeId": null};
        var communalParam = {"communalParam": null};
        var internetPackageParam = {"internetPackageParam": null};
        var amountText = {"amountText": scope.chosenAmount};

        viewServicePage.firstFieldTitle = "Номер абонента";
        viewServicePage.phoneText = firstFieldInput.value;
        var isInFavorites = {"isInFavorites": false};

        this.riotTags.innerHTML = "<view-service-pincards>";
        riot.mount('view-service-pincards', [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites, 'ADDAUTOPAY']);
        scope.unmount()
      }
      else if (scope.autoPayData.fromView == 'PAYCONFIRM') {
        this.riotTags.innerHTML = "<view-pay-confirm>";
        riot.mount('view-pay-confirm', opts);
        scope.unmount()

      }
    }


  </script>
</view-autopay-event-method-new>

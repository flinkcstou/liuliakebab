<view-autopay-event-method>
  <div>
    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title autopay-method-page-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodEventText}</p>
      <div ontouchend="goToBack()"
           class="servicepage-button-back autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">


      <d
        iv class="servicepage-first-field" id="firstField">
        <p class="servicepage-text-field">Номер абонента</p>
        <p class="servicepage-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input class="servicepage-number-input-part" type="{inputType}" id="firstFieldInput"
               onfocus="bordersColor()" autofocus="true"
               value="{defaultNumber || opts.first_field_value}" onkeydown="telPayVerificationKeyDown(this)"
               onkeyup="telPayVerificationKeyUp()"/>
        <div class="servicepage-phone-icon" ontouchend="searchContact()"></div>
    </div>


    <p class="component-calc-currency-text">{window.languages.ViewAmountCalculatorTextTwo} {currencyRate} сум</p>
    <div id="convertedAmountFieldId" class="component-calc-second-field">
      <p class="component-calc-second-field-text">{window.languages.ViewAmountCalculatorTextThree}</p>
      <p class="component-calc-second-field-input-part">{convertedAmount} сум</p>
    </div>


    <div class="component-calc-buttons-container">
      <div id="acceptConvertedBtnId" class="component-calc-button" ontouchend="acceptConvertedAmount()">
        <p class="component-calc-button-label">{window.languages.ViewAmountCalculatorAcceptText}</p>
      </div>
    </div>


  </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = "АВТОПЛАТЕЖ";
    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    console.log("ID of srevice=", opts);
    this.serviceName = scope.servicesMap[opts[0]][0].name;
    this.serviceIcon = scope.servicesMap[opts[0]][0].image;


    //    this.on('mount', function () {
    //
    //
    //      riot.update();
    //
    //    })


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-event-method') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-event-method',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
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


  </script>
</view-autopay-event-method>

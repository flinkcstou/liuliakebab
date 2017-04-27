<view-pin-code class="view-pincode">

  <div class="pincode-flex-container">
    <div class="pincode-unchangable-container">
      <div if="{checkPin}" class="pincode-enter-pin-label">{window.languages.ViewPinCodeClickPinLabel}</div>
      <div if="{checkPinConfirm}" class="pincode-enter-pin-confirm-label">
        {window.languages.ViewPinCodeConfirmClickPinLabel}
      </div>
      <div class="pincode-pin-container">
        <div class="pincode-pin-field">
          <div id="circleOne" class="pincode-pin-circles pincode-pin-one"></div>
          <div id="circleTwo" class="pincode-pin-circles pincode-pin-two"></div>
          <div id="circleThree" class="pincode-pin-circles pincode-pin-three"></div>
          <div id="circleFour" class="pincode-pin-circles pincode-pin-four"></div>
          <div id="circleFive" class="pincode-pin-circles pincode-pin-five"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="pincode-keyboard-field keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div class="pincode-button-offline" ontouchstart="offlineMode()">
    {window.languages.ViewAuthorizationOfflineModeLabel}
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>


  <script>

    var scope = this;

    if (history.arrayOfHistory.length != 0) {
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pin-code') {
        history.arrayOfHistory.push(
          {
            "view": 'view-pin-code',
            "params": opts
          }
        );
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }
    }

    var pin;
    var pinConfirm;
    var enteredPin = '';
    scope.checkPin = true;
    scope.checkPinConfirm = false;
    scope.showError = false;
    var fromRegistration

    if (opts[0] == 'view-registration-client') {
      fromRegistration = true;
      var cardNumber = opts[1];
      var cardInformation = opts[2];
    } else if (opts[0] == 'view-security-settings') {
      fromRegistration = false;
    }


    componentKeyboard.returnValue = function (myValue) {
      event.preventDefault();
      event.stopPropagation();

      if (enteredPin.length < 5 && myValue != 'x') {
        enteredPin += myValue;
      }
      if (myValue == 'x' && enteredPin != 4) {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }

      riot.update();
      updateEnteredPin();
    }

    offlineMode = function () {
      event.preventDefault();
      event.stopPropagation();
      modeOfflineMode.check = true;
      this.riotTags.innerHTML = "<view-main-page>";
      riot.mount('view-main-page');

      scope.unmount()

    }

    updateEnteredPin = function () {


      if (enteredPin.length == 0) {
        circleOne.style.backgroundColor = 'transparent';
        circleTwo.style.backgroundColor = 'transparent';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }
      if (enteredPin.length == 1) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = 'transparent';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }
      if (enteredPin.length == 2) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 3) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 4) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 5) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#01cfff';

        if (scope.checkPinConfirm) {
          pinConfirm = enteredPin;
          scope.checkPinConfirm = false;
          if (pin == pinConfirm) {
            if (fromRegistration)
              enter(pin);
            else changePin(pin);
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = "Different pin codes";

            console.log('scope.checkPin', scope.checkPin, 'scope.checkPinConfirm', scope.checkPinConfirm)
            scope.showError = true;
            scope.checkPin = true;
            scope.checkPinConfirm = false;
            riot.update(scope.checkPin);
            riot.update(scope.checkPinConfirm);
            console.log('scope.checkPin', scope.checkPin, 'scope.checkPinConfirm', scope.checkPinConfirm)
            pinConfirm = '';
            pin = '';
            enteredPin = '';
            updateEnteredPin()
          }

        }
        else if (scope.checkPin) {
          console.log('qwewewww')
          pin = enteredPin;
          scope.checkPin = false;
          scope.checkPinConfirm = true;
          enteredPin = '';
          riot.update();
          updateEnteredPin()
        }
      }
    }

    enter = function (pin) {
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      localStorage.setItem("click_client_pin", JSON.stringify(hex_md5(pin)))

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      window.api.call({
        method: 'registration',
        input: {
          phone_num: phoneNumber,
          card_number: cardNumber,
          card_data: cardInformation,
          pin: pin
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            console.log('REGISTRATION CLIENT', result)
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//            scope.showError = true;
            localStorage.setItem("registration_check_id", JSON.stringify(result[1][0].check_id))
            localStorage.setItem("registration_check_hash", JSON.stringify(result[1][0].check_hash))
//            riotTags.innerHTML = "<view-authorization>";
//            riot.mount('view-authorization', {from: "registration-client"});
            setInterval(checkRegistrationFunction(), 5000)
            window.standCheckRegistration = true;
            localStorage.setItem('click_client_registered', true)
            return
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            riot.update();
            riotTags.innerHTML = "<view-registration-client>";
            riot.mount('view-registration-client');
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })

    };

    checkRegistrationFunction = function () {
//      event.preventDefault();
//      event.stopPropagation();

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');

      window.api.call({
        method: 'registration.check',
        input: {
          phone_num: phoneNumber,
          check_id: JSON.parse(localStorage.getItem("registration_check_id")),
          check_hash: JSON.parse(localStorage.getItem("registration_check_hash")),
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            console.log('REGISTRATION CHECK', result)
            if(result[1][0].registered == 0){
              setInterval(checkRegistrationFunction(), 30000)
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            riot.update();
            riotTags.innerHTML = "<view-registration-client>";
            riot.mount('view-registration-client');
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })

    }

    changePin = function (pin) {
      event.preventDefault();
      event.stopPropagation();

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var currentPin = localStorage.getItem('pinForStand');

      window.api.call({
        method: 'settings.change.pin',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          current_pin: currentPin,
          new_pin: pin
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            scope.clickPinError = false;
            scope.errorNote = "Успешно изменен пин";
            riot.update();

            onBackKeyDown();
            scope.unmount()
          }
          else {
            scope.showError = true;
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            riot.update();

            onBackKeyDown();
            scope.unmount()
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }


  </script>
</view-pin-code>
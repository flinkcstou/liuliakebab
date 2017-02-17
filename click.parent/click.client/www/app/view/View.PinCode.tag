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


    <script>

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
        var cardNumber = opts[0];
        var cardInformation = opts[1];

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
                        enter(pin);
                    }
                    else {
                        alert("Different pin codes")
                        scope.checkPinConfirm = true;
                        enteredPin = '';
                        riot.update();
                        updateEnteredPin()
                    }

                }

                if (scope.checkPin) {
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
                    if(result[0][0].error == 0){
                        console.log('sdsd')
                        riotTags.innerHTML = "<view-registration-device>";
                        riot.mount('view-registration-device');
                        return
                    }
                    else {
                        alert(result[0][0].error_note);
                        riotTags.innerHTML = "<view-registration-device>";
                        riot.mount('view-registration-device');
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
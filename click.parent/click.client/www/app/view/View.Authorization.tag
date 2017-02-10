<view-authorization class="view-authorization">

    <div class="authorization-flex-container">
        <div class="authorization-unchangable-container">
            <div class="authorization-enter-pin-label">{window.languages.ViewAuthorizationClickPinLabel}</div>
            <div class="authorization-pin-container">
                <div class="authorization-pin-field">
                    <div id="circleOne" class="authorization-pin-circles authorization-pin-one"></div>
                    <div id="circleTwo" class="authorization-pin-circles authorization-pin-two"></div>
                    <div id="circleThree" class="authorization-pin-circles authorization-pin-three"></div>
                    <div id="circleFour" class="authorization-pin-circles authorization-pin-four"></div>
                    <div id="circleFive" class="authorization-pin-circles authorization-pin-five"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="authorization-keyboard-field keyboard-field">
        <component-keyboard></component-keyboard>
    </div>

    <div class="authorization-buttons-container">
        <div class="authorization-button-forget-pin">{window.languages.ViewAuthorizationForgetPinLabel}</div>
        <div class="authorization-button-registration">{window.languages.ViewAuthorizationRegistrationLabel}</div>
    </div>
    <div class="authorization-button-offline" ontouchstart="offlineMode()">
        {window.languages.ViewAuthorizationOfflineModeLabel}
    </div>


    <script>

        if (history.arrayOfHistory.length != 0) {
            if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-authorization') {
                history.arrayOfHistory.push(
                        {
                            "view": 'view-authorization',
                            "params": ''
                        }
                );
                sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
            }
        }
        else {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-authorization',
                        "params": ''
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        var pin;
        var enteredPin = '';
        var checkSessionKey = false;

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
                pin = enteredPin;
                enter();
            }
        }

        enter = function () {
            event.preventDefault();
            event.stopPropagation();

            var phoneNumber = localStorage.getItem('click_client_phoneNumber');
            var deviceId = localStorage.getItem('click_client_deviceID');
            var date = parseInt(Date.now() / 1000);
//      console.log(date);
            var token = localStorage.getItem('click_client_token');
            var password = hex_sha512(token + date + hex_md5(pin));
            localStorage.setItem("pinForStand", pin);
            authorization(phoneNumber, deviceId, password, date);
        }

        function authorization(phoneNumber, deviceId, password, date) {
            window.api.call({
                method: 'app.login',
                input: {
                    phone_num: phoneNumber,
                    device_id: deviceId,
                    password: password,
                    datetime: date
                },
                scope: this,

                onSuccess: function (result) {
                    console.log(result[0][0])
                    if (result[0][0].error == 0) {
                        if (!result[1][0].error) {
                            modeOfflineMode.check = false;
                            var JsonInfo = JSON.stringify(result[1][0]);
                            localStorage.setItem('click_client_loginInfo', JsonInfo);
                            checkSessionKey = true;
                            viewAuthorization.check = false;
                            getAccount();
                        }
                    }
                    else {
                        alert(result[0][0].error_note)
                        enteredPin = '';
                        updateEnteredPin();
                        return
                    }
                },
                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            })
        }

        if (checkSessionKey) {
            var phoneNumber = localStorage.getItem("click_client_phoneNumber");
            var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
            var sessionKey = loginInfo.session_key;
        }

        var balance;
        var arrayAccountInfo = [];
        getAccount = function (e) {
            if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
                var phoneNumber = localStorage.getItem("click_client_phoneNumber");
                var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
                var sessionKey = info.session_key;

//        console.log(phoneNumber, ' ', sessionKey);

                window.api.call({
                    method: 'get.accounts',
                    input: {
                        session_key: sessionKey,
                        phone_num: phoneNumber
                    },

                    scope: this,

                    onSuccess: function (result) {

                        if (result[0][0].error == 0) {
                            for (var i = 0; i < result[1].length; i++)
                                arrayAccountInfo.push(result[1][i])

                            var accountInfo = JSON.stringify(arrayAccountInfo);
                            localStorage.setItem("click_client_accountInfo", accountInfo);

                            this.riotTags.innerHTML = "<view-main-page>";
                            riot.mount('view-main-page');
                        }
                        else
                            alert(result[0][0].error_note);
                    },

                    onFail: function (api_status, api_status_message, data) {
                        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                        console.error(data);
                    }
                })
            }
        }

    </script>
</view-authorization>
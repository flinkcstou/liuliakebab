<view-registration-client class="view-registration-client">
    <p class="registration-client-text-field">Заполните данные вашей первой карты</p>
    <div class="registration-client-card-field">
        <p class="registration-client-card-text registration-client-card-number-text">Номер карты</p>
        <div id="cardNumberInput" class="registration-client-card-number" type="text">
            <input onfocus="onFocusOfInput()" ontouchend="touchEndBoxOne()" id="boxOne" type="text" maxlength="4"
                   class="registration-client-card-number-box registration-client-card-number-box-one">
            <input ontouchend="touchEndBoxTwo()" id="boxTwo" type="text" maxlength="4"
                   class="registration-client-card-number-box registration-client-card-number-box-two">
            <input ontouchend="touchEndBoxThree()" id="boxThree" type="text" maxlength="4"
                   class="registration-client-card-number-box registration-client-card-number-box-three">
            <input ontouchend="touchEndBoxFour()" id="boxFour" type="text" maxlength="4"
                   class="registration-client-card-number-box registration-client-card-number-box-four">
        </div>

        <p class="registration-client-card-text registration-client-card-text-date">Дата окончания</p>
        <div id="cardDateInput" class="registration-client-card-date" type="text">
            <input ontouchend="touchEndBoxData()" id="boxData" type="text" maxlength="5"
                   class="registration-client-card-date-box">
        </div>

        <p class="registration-client-card-text registration-client-card-text-pin">Пинкод</p>
        <div id="cardPinInput" class="registration-client-card-pin" type="text">
            <input id="boxPin" type="text" maxlength="12"
                   class="registration-client-card-date-pin-box">
        </div>
    </div>
    </div>

    <div class="registration-keyboard-field keyboard-field">
        <div class="registration-button-help">Помощь</div>
        <component-keyboard></component-keyboard>
    </div>

    <div class="registration-client-buttons-container">
        <div class="registration-container-offline">
            <div class="registration-button-offline">Офлайн режим</div>
        </div>
        <a id="demoContainer" class="registration-container-demo-version"
        >
            <div class="registration-button-demo-version">Демо версия</div>
        </a>
    </div>

    <script>


        this.on('mount', function () {
            boxOne.autofocus = true;
        })

        var scope = this;
        var cardNumberPartOne = '';
        var cardNumberPartTwo = '';
        var cardNumberPartThree = '';
        var cardNumberPartFour = '';
        var cardData = '';
        var cardNumber = '';
        var cardPin = '';
        var selectionStart;
        var selectionEnd;
        var changed = false;
        var date = false;

        onFocusOfInput = function () {
            if (device.platform != 'BrowserStand') {
                Keyboard.hide();
                console.log('WWWWWWWWW')
            }
        }

        touchEndBoxOne = function () {
            boxOne.autofocus = true;
            boxTwo.autofocus = false;
            boxThree.autofocus = false;
            boxFour.autofocus = false;
            boxData.autofocus = false;
            boxPin.autofocus = false;

            changed = false;
        }

        touchEndBoxTwo = function () {
            boxOne.autofocus = false;
            boxTwo.autofocus = true;
            boxThree.autofocus = false;
            boxFour.autofocus = false;
            boxData.autofocus = false;
            boxPin.autofocus = false;

            changed = false;
        }

        touchEndBoxThree = function () {
            boxOne.autofocus = false;
            boxTwo.autofocus = false;
            boxThree.autofocus = true;
            boxFour.autofocus = false;
            boxData.autofocus = false;
            boxPin.autofocus = false;

            changed = false;
        }

        touchEndBoxFour = function () {
            boxOne.autofocus = false;
            boxTwo.autofocus = false;
            boxThree.autofocus = false;
            boxFour.autofocus = true;
            boxData.autofocus = false;
            boxPin.autofocus = false;

            changed = false;
        }

        touchEndBoxData = function () {

            boxOne.autofocus = false;
            boxTwo.autofocus = false;
            boxThree.autofocus = false;
            boxFour.autofocus = false;
            boxData.autofocus = true;
            boxPin.autofocus = false;

            changed = false;
        }

        componentKeyboard.returnValue = function (myValue) {

            if (myValue != 'x') {
                if (boxOne.value.length == 4 && boxOne.autofocus) {
                    boxOne.autofocus = false;
                    boxTwo.autofocus = true;
                    boxThree.autofocus = false;
                    boxFour.autofocus = false;
                    boxData.autofocus = false;
                    boxPin.autofocus = false;
                }

                if (boxTwo.value.length == 4 && boxTwo.autofocus) {
                    boxOne.autofocus = false;
                    boxTwo.autofocus = false;
                    boxThree.autofocus = true;
                    boxFour.autofocus = false;
                    boxData.autofocus = false;
                    boxPin.autofocus = false;
                }

                if (boxThree.value.length == 4 && boxThree.autofocus) {
                    boxOne.autofocus = false;
                    boxTwo.autofocus = false;
                    boxThree.autofocus = false;
                    boxFour.autofocus = true;
                    boxData.autofocus = false;
                    boxPin.autofocus = false;
                }

                if (boxFour.value.length == 4 && boxFour.autofocus) {
                    boxOne.autofocus = false;
                    boxTwo.autofocus = false;
                    boxThree.autofocus = false;
                    boxFour.autofocus = false;
                    boxData.autofocus = true;
                    boxPin.autofocus = false;

                    cardNumber = cardNumberPartOne + cardNumberPartTwo + cardNumberPartThree + cardNumberPartFour;
                }

                if (boxData.value.length == 5 && boxData.autofocus) {
                    boxOne.autofocus = false;
                    boxTwo.autofocus = false;
                    boxThree.autofocus = false;
                    boxFour.autofocus = false;
                    boxData.autofocus = false;
                    boxPin.autofocus = true;
                    cardData = boxData.value.substring(0, 2) + boxData.value.substring(3, 5);
                }

                if (boxOne.value.length < 4 && boxOne.autofocus) {
                    boxOne.autofocus = true;
                    if (!changed)
                        boxOne.value = boxOne.value.substring(0, boxOne.selectionStart) + myValue + boxOne.value.substring(boxOne.selectionStart, boxOne.length);
                    else {
                        boxOne.value = boxOne.value.substring(0, selectionStart - 1) + myValue + boxOne.value.substring(selectionStart - 1, boxOne.length);
                        changed = false;
                    }
//          console.log('selection start ', scope.boxOne.selectionStart);
                    cardNumberPartOne = boxOne.value
                }

                if (boxTwo.value.length < 4 && boxTwo.autofocus) {

                    if (!changed)
                        boxTwo.value = boxTwo.value.substring(0, boxTwo.selectionStart) + myValue + boxTwo.value.substring(boxTwo.selectionStart, boxTwo.length);
                    else {
                        boxTwo.value = boxTwo.value.substring(0, selectionStart - 1) + myValue + boxTwo.value.substring(selectionStart - 1, boxTwo.length);
                        changed = false;
                    }
//          console.log('selection start ', scope.boxTwo.selectionStart);
                    cardNumberPartTwo = boxTwo.value
                }

                if (boxThree.value.length < 4 && boxThree.autofocus) {

                    if (!changed)
                        boxThree.value = boxThree.value.substring(0, boxThree.selectionStart) + myValue + boxThree.value.substring(boxThree.selectionStart, boxThree.length);
                    else {
                        boxThree.value = boxThree.value.substring(0, selectionStart - 1) + myValue + boxThree.value.substring(selectionStart - 1, boxThree.length);
                        changed = false;
                    }
//          console.log('selection start ', scope.boxThree.selectionStart);
                    cardNumberPartThree = boxThree.value
                }

                if (boxFour.value.length < 4 && boxFour.autofocus) {

                    if (!changed)
                        boxFour.value = boxFour.value.substring(0, boxFour.selectionStart) + myValue + boxFour.value.substring(boxFour.selectionStart, boxFour.length);
                    else {
                        boxFour.value = boxFour.value.substring(0, selectionStart - 1) + myValue + boxFour.value.substring(selectionStart - 1, boxFour.length);
                        changed = false;
                    }
                    console.log('selection start ', boxFour.selectionStart);
                    cardNumberPartFour = boxFour.value
                }

                if (boxData.value.length < 5 && boxData.autofocus) {
                    if (boxData.value.length == 0) {
                        if (myValue > 3) {
                            alert('incorrect');
                            return;
                        }
                        if (myValue == 3) {
                            date = true;
                        }
                    }
                    if (boxData.value.length == 1) {
                        if (date) {
                            if (myValue > 1) {
                                alert('incorrect')
                                return;
                            }
                        }
                        if (myValue > 3) {
                            alert('incorrect');
                            return;
                        }
                    }
                    if (boxData.value.length == 2)
                        boxData.value += '/';
                    boxData.value += myValue;
                }


                if (boxPin.value.length < 12 && boxPin.autofocus) {
                    boxPin.value += ' * ';
                    cardPin += myValue;
                    console.log(cardPin);
                }

                if (boxPin.value.length == 12 && boxPin.autofocus) {
                    console.log(" ", cardPin);
                    //registration(cardNumber, cardData, cardPin);
                }
            }
            else {
                if (boxOne.autofocus) {
                    selectionStart = boxOne.selectionStart;
                    selectionEnd = boxOne.selectionEnd;
                    changed = true;
                    console.log('Selection start ', boxOne.selectionStart)
                    boxOne.value = boxOne.value.substring(0, boxOne.selectionStart - 1) + boxOne.value.substring(boxOne.selectionStart, boxOne.value.length);

                    cardNumberPartOne = boxOne.value;

                    if (boxOne.value.length == 0) {
                        boxOne.autofocus = true;
                        boxFour.autofocus = false;
                    }
                    return;
                }
                if (boxTwo.autofocus) {
                    selectionStart = boxTwo.selectionStart;
                    selectionEnd = boxTwo.selectionEnd;
                    changed = true;
                    boxTwo.value = boxTwo.value.substring(0, boxTwo.selectionStart - 1) + boxTwo.value.substring(boxTwo.selectionStart, boxTwo.value.length);
                    cardNumberPartTwo = boxTwo.value;

                    if (boxTwo.value.length == 0) {
                        boxOne.autofocus = true;
                        boxTwo.autofocus = false;
                    }
                    return;
                }
                if (boxThree.autofocus) {
                    selectionStart = boxThree.selectionStart;
                    selectionEnd = boxThree.selectionEnd;
                    changed = true;
                    boxThree.value = boxThree.value.substring(0, boxThree.selectionStart - 1) + boxThree.value.substring(boxThree.selectionStart, boxThree.value.length);
                    cardNumberPartThree = boxThree.value;

                    if (boxThree.value.length == 0) {
                        boxTwo.autofocus = true;
                        boxThree.autofocus = false;
                    }
                    return;
                }
                if (boxFour.autofocus) {
                    selectionStart = boxFour.selectionStart;
                    selectionEnd = boxFour.selectionEnd;
                    changed = true;
                    boxFour.value = boxFour.value.substring(0, boxFour.selectionStart - 1) + boxFour.value.substring(boxFour.selectionStart, boxFour.value.length);
                    cardNumberPartFour = boxFour.value;
                    if (boxFour.value.length == 0) {

                        boxThree.autofocus = true;
                        boxFour.autofocus = false;
                    }
                    return;
                }

                if (boxData.autofocus || (boxPin.autofocus && boxPin.value.length == 0)) {
                    boxData.value = boxData.value.substring(0, boxData.value.length - 1);

                    if (boxData.value.length == 0) {
                        boxFour.autofocus = true;
                        boxData.autofocus = false;
                    }
                    return;
                }

                if (boxPin.autofocus) {
                    boxPin.value = boxPin.value.substring(0, boxPin.value.length - 3);
                    if (boxPin.value.length == 0) {
                        boxData.autofocus = true;
                        boxPin.autofocus = false;
                    }
                }
            }
            console.log('Pard one ', cardNumberPartOne, 'Part two', cardNumberPartTwo, 'Part three', cardNumberPartThree, 'Part four', cardNumberPartFour)
            console.log('Focus one ', boxOne.focus, 'Focus two', boxTwo.focus, 'Focus three', boxThree.focus, 'Focus four', boxFour.focus)
            console.log(myValue)
            riot.update();

        }

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');


        registration = function (cardNumber, cardData, cardPin) {
            window.api.call({
                method: 'registration',
                input: {
                    phone_num: phoneNumber,
                    card_number: cardNumber,
                    card_data: cardData,
                    pin: cardPin.replace(new RegExp(' ', 'g'), '')
                },
                scope: this,

                onSuccess: function (result) {
                    console.log(result);

                },
                onFail: function (api_status, api_status_message, data) {
                    console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                    console.error(data);
                }
            })
        }
    </script>
</view-registration-client>
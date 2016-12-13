<component-old-keyboard>
  <div class="keyboard-container">

    <div class="keyboard-field-one">
      <div class="keyboard-buttons keyboard-button-one" ontouchend="onTouchEndOne()"><p class="keyboard-buttons-label">
        1</p></div>
      <div class="keyboard-buttons keyboard-button-two" ontouchend="onTouchEndTwo()"><p class="keyboard-buttons-label">
        2</p></div>
      <div class="keyboard-buttons keyboard-button-three" ontouchend="onTouchEndThree()"><p
        class="keyboard-buttons-label">3</p></div>
    </div>

    <div class="keyboard-field-two">
      <div class="keyboard-buttons keyboard-button-four" ontouchend="onTouchEndFour()"><p
        class="keyboard-buttons-label">4</p></div>
      <div class="keyboard-buttons keyboard-button-five" ontouchend="onTouchEndFive()"><p
        class="keyboard-buttons-label">5</p></div>
      <div class="keyboard-buttons keyboard-button-six" ontouchend="onTouchEndSix()"><p class="keyboard-buttons-label">
        6</p></div>
    </div>

    <div class="keyboard-field-three">
      <div class="keyboard-buttons keyboard-button-seven" ontouchend="onTouchEndSeven()"><p
        class="keyboard-buttons-label">7</p></div>
      <div class="keyboard-buttons keyboard-button-eight" ontouchend="onTouchEndEight()"><p
        class="keyboard-buttons-label">8</p></div>
      <div class="keyboard-buttons keyboard-button-nine" ontouchend="onTouchEndNine()"><p
        class="keyboard-buttons-label">9</p></div>
    </div>
    <div class="keyboard-field-four">
      <div class="keyboard-buttons keyboard-space"></div>
      <div class="keyboard-buttons keyboard-button-zero" ontouchend="onTouchEndZero()"><p
        class="keyboard-buttons-label">0</p></div>
      <div class="keyboard-buttons keyboard-button-x" ontouchend="onTouchEndX()"><p class="keyboard-buttons-label">x</p>
      </div>
    </div>
  </div>

  <script>

    if (viewRegistrationClient.check) {
      if (viewRegistrationClient.cardNumberCheck) {
        viewRegistrationClient.cardNumber = '';
      }
    }

    if (viewAuthorization.check)
      viewAuthorization.enteredPin = '';

    if (viewSms.check)
      viewSms.confirmSms = '';

    if (viewRegistrationDevice.check)
      viewRegistrationDevice.phoneNumber = '+998';


    var scope = this;

    onTouchEndOne = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {
        console.log('')
        viewRegistrationClient.cardNumber += '1';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '1';
        console.log(viewRegistrationDevice.phoneNumber)
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '1';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '1';
        viewAuthorization.updateEnteredPin();
      }

      return '1';
    }

    onTouchEndTwo = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {

        console.log('')
        viewRegistrationClient.cardNumber += '2';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '2';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '2';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '2';
        viewAuthorization.updateEnteredPin();
      }

      return '2';
    }

    onTouchEndThree = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {
        console.log('')
        viewRegistrationClient.cardNumber += '3';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '3';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '3';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '3';
        viewAuthorization.updateEnteredPin();
      }

      return '3';
    }

    onTouchEndFour = function () {
      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {
        console.log('')
        viewRegistrationClient.cardNumber += '4';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '4';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '4';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '4';
        viewAuthorization.updateEnteredPin();
      }

      return '4';
    }

    onTouchEndFive = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {

        console.log('')
        viewRegistrationClient.cardNumber += '5';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '5';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '5';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '5';
        viewAuthorization.updateEnteredPin();
      }

      return '5';
    }

    onTouchEndSix = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {
        console.log('')
        viewRegistrationClient.cardNumber += '6';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '6';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '6';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '6';
        viewAuthorization.updateEnteredPin();
      }

      return '6';
    }

    onTouchEndSeven = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {
        console.log('')
        viewRegistrationClient.cardNumber += '7';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '7';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '7';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '7';
        viewAuthorization.updateEnteredPin();
      }

      return '7';
    }

    onTouchEndEight = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {

        console.log('')
        viewRegistrationClient.cardNumber += '8';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '8';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '8';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '8';
        viewAuthorization.updateEnteredPin();
      }

      return '8';
    }

    onTouchEndNine = function () {

      if (viewRegistrationClient.check && viewRegistrationClient.cardNumber.length < 30) {
        console.log('')
        viewRegistrationClient.cardNumber += '9';
        viewRegistrationClient.updateCardNumber();
      }

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '9';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '9';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '9';
        viewAuthorization.updateEnteredPin();
      }

      return '9';
    }

    onTouchEndZero = function () {
      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length < 13) {

        viewRegistrationDevice.phoneNumber += '0';
        riot.update();
      }

      if (viewSms.check && viewSms.confirmSms.length < 5) {

        viewSms.confirmSms += '0';
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {

        viewAuthorization.enteredPin += '0';
        viewAuthorization.updateEnteredPin();
      }

      return '0';
    }

    onTouchEndX = function () {

      if (viewRegistrationDevice.check && viewRegistrationDevice.phoneNumber.length > 4) {

        viewRegistrationDevice.phoneNumber = viewRegistrationDevice.phoneNumber.substring(0, viewRegistrationDevice.phoneNumber.length - 1);
        riot.update();
      }

      if (viewSms.check) {

        viewSms.confirmSms = viewSms.confirmSms.substring(0, viewSms.confirmSms.length - 1);
        viewSms.updateSmsField();
        riot.update();
      }

      if (viewAuthorization.check) {

        viewAuthorization.enteredPin = viewAuthorization.enteredPin.substring(0, viewAuthorization.enteredPin.length - 1);
        viewAuthorization.updateEnteredPin();
      }
    }
  </script>
</component-old-keyboard>
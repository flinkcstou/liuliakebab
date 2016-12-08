<component-keyboard>
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
    if (viewAuthorization.check)
      viewAuthorization.enteredPin = '';

    if (viewRegistration.check)
      viewRegistration.phoneNumber = '+998';

    var scope = this;
    onTouchEndOne = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '1';
        console.log(viewRegistration.phoneNumber)
        riot.update();
      }
      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '1';
        viewAuthorization.updateEnteredPin();
      }

      return '1';
    }

    onTouchEndTwo = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '2';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '2';
        viewAuthorization.updateEnteredPin();
      }

      return '2';
    }

    onTouchEndThree = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '3';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '3';
        viewAuthorization.updateEnteredPin();
      }

      return '3';
    }

    onTouchEndFour = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '4';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '4';
        viewAuthorization.updateEnteredPin();
      }

      return '4';
    }

    onTouchEndFive = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '5';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '5';
        viewAuthorization.updateEnteredPin();
      }

      return '5';
    }

    onTouchEndSix = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '6';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '6';
        viewAuthorization.updateEnteredPin();
      }

      return '6';
    }

    onTouchEndSeven = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '7';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '7';
        viewAuthorization.updateEnteredPin();
      }

      return '7';
    }

    onTouchEndEight = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '8';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '8';
        viewAuthorization.updateEnteredPin();
      }

      return '8';
    }

    onTouchEndNine = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '9';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '9';
        viewAuthorization.updateEnteredPin();
      }

      return '9';
    }

    onTouchEndZero = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length < 13) {
        viewRegistration.phoneNumber += '0';
        riot.update();
      }

      if (viewAuthorization.check && viewAuthorization.enteredPin.length < 5) {
        viewAuthorization.enteredPin += '0';
        viewAuthorization.updateEnteredPin();
      }

      return '0';
    }

    onTouchEndX = function () {
      if (viewRegistration.check && viewRegistration.phoneNumber.length > 4) {
        viewRegistration.phoneNumber = viewRegistration.phoneNumber.substring(0, viewRegistration.phoneNumber.length - 1);
        riot.update();
      }
      if (viewAuthorization.check) {
        viewAuthorization.enteredPin = viewAuthorization.enteredPin.substring(0, viewAuthorization.enteredPin.length - 1);
        viewAuthorization.updateEnteredPin();
      }
    }
  </script>
</component-keyboard>
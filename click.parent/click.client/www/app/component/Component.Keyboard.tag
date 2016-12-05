<component-keyboard>
  <div class="keyboard-container">

    <div class="keyboard-field-one">
      <div class="keyboard-buttons keyboard-button-one" ontouchend="onTouchEndOne()"><p class="keyboard-buttons-label">1</p></div>
      <div class="keyboard-buttons keyboard-button-two" ontouchend="onTouchEndTwo()"><p class="keyboard-buttons-label">2</p></div>
      <div class="keyboard-buttons keyboard-button-three" ontouchend="onTouchEndThree()"><p class="keyboard-buttons-label">3</p></div>
    </div>

    <div class="keyboard-field-two">
      <div class="keyboard-buttons keyboard-button-four" ontouchend="onTouchEndFour()"><p class="keyboard-buttons-label">4</p></div>
      <div class="keyboard-buttons keyboard-button-five" ontouchend="onTouchEndFive()"><p class="keyboard-buttons-label">5</p></div>
      <div class="keyboard-buttons keyboard-button-six" ontouchend="onTouchEndSix()"><p class="keyboard-buttons-label">6</p></div>
    </div>

    <div class="keyboard-field-three">
      <div class="keyboard-buttons keyboard-button-seven" ontouchend="onTouchEndSeven()"><p class="keyboard-buttons-label">7</p></div>
      <div class="keyboard-buttons keyboard-button-eight" ontouchend="onTouchEndEight()"><p class="keyboard-buttons-label">8</p></div>
      <div class="keyboard-buttons keyboard-button-nine" ontouchend="onTouchEndNine()"><p class="keyboard-buttons-label">9</p></div>
    </div>
    <div class="keyboard-field-four">
      <div class="keyboard-buttons keyboard-space"></div>
      <div class="keyboard-buttons keyboard-button-zero" ontouchend="onTouchEndZero()"><p class="keyboard-buttons-label">0</p></div>
      <div class="keyboard-buttons keyboard-button-x" ontouchend="onTouchEndX()"><p class="keyboard-buttons-label">x</p></div>
    </div>
  </div>

  <script>

    window.viewAuthorization.enteredPin = '';
    var scope = this;
    onTouchEndOne = function () {
      viewAuthorization.enteredPin += '1';
      console.log(1);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '1';
    }

    onTouchEndTwo = function () {
      viewAuthorization.enteredPin += '2';
      console.log(2);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '2';
    }

    onTouchEndThree = function () {
      viewAuthorization.enteredPin += '3';
      console.log(3);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '3';
    }

    onTouchEndFour = function () {
      viewAuthorization.enteredPin += '4';
      console.log(4);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '4';
    }

    onTouchEndFive = function () {
      viewAuthorization.enteredPin += '5';
      console.log(5);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '5';
    }

    onTouchEndSix = function () {
      viewAuthorization.enteredPin += '6';
      console.log(6);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '6';
    }

    onTouchEndSeven = function () {
      viewAuthorization.enteredPin += '7';
      console.log(7);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '7';
    }

    onTouchEndEight = function () {
      viewAuthorization.enteredPin += '8';
      console.log(8);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '8';
    }

    onTouchEndNine = function () {
      viewAuthorization.enteredPin += '9';
      console.log(9);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '9';
    }

    onTouchEndZero = function () {
      viewAuthorization.enteredPin += '0';
      console.log(0);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      return '0';
    }

    onTouchEndX = function () {
      viewAuthorization.enteredPin = viewAuthorization.enteredPin.substring(0, viewAuthorization.enteredPin.length - 1);
      console.log(viewAuthorization.enteredPin);

      viewAuthorization.updateEnteredPin();
      console.log('x');
    }
  </script>
</component-keyboard>
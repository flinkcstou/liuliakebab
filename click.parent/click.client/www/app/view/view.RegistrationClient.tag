<view-registration-client class="view-registration-client riot-tags-main-container">
  <p class="registration-client-text-field">Заполните данные вашей первой карты</p>
  <div class="registration-client-card-field">
    <p class="registration-client-card-text registration-client-card-number-text">Номер карты</p>
    <div id="cardNumberInput" class="registration-client-card-number">
      <div onfocus="boxFocus()" ontouchend="touchEndBoxOne()" id="boxOne"
           class="registration-client-card-number-box registration-client-card-number-box-one">
        {cardNumberPartOne}
      </div>
      <div ontouchend="touchEndBoxTwo()" id="boxTwo"
           class="registration-client-card-number-box registration-client-card-number-box-two">
        {cardNumberPartTwo}
      </div>
      <div ontouchend="touchEndBoxThree()" id="boxThree"
           class="registration-client-card-number-box registration-client-card-number-box-three">
        {cardNumberPartThree}
      </div>
      <div ontouchend="touchEndBoxFour()" id="boxFour"
           class="registration-client-card-number-box registration-client-card-number-box-four">
        {cardNumberPartFour}
      </div>
    </div>

    <div id="cardDateInput" class="registration-client-card-date" type="text">
      <p class="registration-client-card-text registration-client-card-text-date">Дата окончания</p>
      <div ontouchend="touchEndBoxData()" id="boxData"
           class="registration-client-card-date-box">
        {cardDate}
      </div>
    </div>

    <div style="display: none" id="cardPinInput" class="registration-client-card-pin">
      <p class="registration-client-card-text registration-client-card-text-pin">Код банка</p>
      <div ontouchend="touchEndBoxPin()" id="boxPin"
           class="registration-client-card-date-pin-box">
        {cardPin}
      </div>
    </div>
  </div>
  <div class="registration-client-button-enter registration-client-button-enter-container"
       ontouchstart="goToPinCodeTouchStart()" ontouchend="goToPinCodeTouchEnd()">
    <div class="button-enter-label">Далее</div>
  </div>

  <div class="registration-client-keyboard-field keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div class="registration-client-buttons-container">
    <div class="registration-container-offline">
      <div class="registration-button-offline" ontouchstart="registrationClientOfflineTouchStart()"
           ontouchend="registrationClientOfflineTouchEnd()">Офлайн режим
      </div>
    </div>
    <a id="demoContainer" class="registration-container-demo-version"
    >
      <div class="registration-button-demo-version">Демо версия</div>
    </a>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-registration-client') {
      history.arrayOfHistory.push(
        {
          "view": 'view-registration-client',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    this.on('mount', function () {
      boxOne.style.border = 'solid 1px gray';
      checkOne = true;
    })

    var scope = this;

    scope.showError = false;
    scope.cardNumberPartOne = '';
    scope.cardNumberPartTwo = '';
    scope.cardNumberPartThree = '';
    scope.cardNumberPartFour = '';
    scope.cardDate = '';
    scope.cardDateOriginal = '';
    scope.cardPin = '';
    scope.cardPinOriginal = '';
    var cardNumber = '';
    var selectionStart;
    var selectionEnd;
    var changed = false;
    var date = false;
    var checkOne = false, checkTwo = false, checkThree = false, checkFour = false, checkDate = false, checkPin = false, checkPinCopy = false, checkDateCopy = false;


    touchEndBoxOne = function () {

      boxOne.style.border = 'solid 1px gray';
      boxTwo.style.border = 'none';
      boxThree.style.border = 'none';
      boxFour.style.border = 'none';
      boxData.style.border = 'none';
      boxPin.style.border = 'none';
      checkOne = true;
      checkTwo = false;
      checkThree = false;
      checkFour = false;
      checkPinCopy = false;
      checkDateCopy = false;
    }

    touchEndBoxTwo = function () {
      boxOne.style.border = 'none';
      boxTwo.style.border = 'solid 1px gray';
      boxThree.style.border = 'none';
      boxFour.style.border = 'none';
      boxData.style.border = 'none';
      boxPin.style.border = 'none';
      checkOne = false;
      checkTwo = true;
      checkThree = false;
      checkFour = false;
      checkPinCopy = false;
      checkDateCopy = false;
    }

    touchEndBoxThree = function () {
      boxOne.style.border = 'none';
      boxTwo.style.border = 'none';
      boxThree.style.border = 'solid 1px gray';
      boxFour.style.border = 'none';
      boxData.style.border = 'none';
      boxPin.style.border = 'none';
      checkOne = false;
      checkTwo = false;
      checkThree = true;
      checkFour = false;
      checkPinCopy = false;
      checkDateCopy = false;
    }

    touchEndBoxFour = function () {
      boxOne.style.border = 'none';
      boxTwo.style.border = 'none';
      boxThree.style.border = 'none';
      boxFour.style.border = 'solid 1px gray';
      boxData.style.border = 'none';
      boxPin.style.border = 'none';
      checkOne = false;
      checkTwo = false;
      checkThree = false;
      checkFour = true;
      checkPinCopy = false;
      checkDateCopy = false;
    }

    touchEndBoxData = function () {
      if (checkDate) {
        boxOne.style.border = 'none';
        boxTwo.style.border = 'none';
        boxThree.style.border = 'none';
        boxFour.style.border = 'none';
        boxData.style.border = 'solid 1px gray';
        boxPin.style.border = 'none';
        checkOne = false;
        checkTwo = false;
        checkThree = false;
        checkFour = false;
        checkPinCopy = false;
        checkDateCopy = true;
      }
      else return
    }

    touchEndBoxPin = function () {
      if (checkPin) {
        boxOne.style.border = 'none';
        boxTwo.style.border = 'none';
        boxThree.style.border = 'none';
        boxFour.style.border = 'none';
        boxData.style.border = 'none';
        boxPin.style.border = 'solid 1px gray';
        checkOne = false;
        checkTwo = false;
        checkThree = false;
        checkFour = false;
        checkPinCopy = true;
        checkDateCopy = false;
      }
      else return
    }

    var offlineTouchStartX, offlineTouchStartY, offlineTouchEndX, offlineTouchEndY;

    registrationClientOfflineTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      offlineTouchStartX = event.changedTouches[0].pageX
      offlineTouchStartY = event.changedTouches[0].pageY
    }

    registrationClientOfflineTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      offlineTouchEndX = event.changedTouches[0].pageX
      offlineTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(offlineTouchStartX - offlineTouchEndX) <= 20 && Math.abs(offlineTouchStartY - offlineTouchEndY) <= 20) {

        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;

        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
        scope.unmount()
      }
    }

    var keyboardTouchStartX, keyboardTouchStartY, keyboardTouchEndX, keyboardTouchEndY;

    componentKeyboard.returnStartValue = function () {

      keyboardTouchStartX = event.changedTouches[0].pageX
      keyboardTouchStartY = event.changedTouches[0].pageY
    }

    componentKeyboard.returnValue = function (myValue) {


      keyboardTouchEndX = event.changedTouches[0].pageX
      keyboardTouchEndY = event.changedTouches[0].pageY


      if (Math.abs(keyboardTouchStartX - keyboardTouchEndX) <= 20 && Math.abs(keyboardTouchStartY - keyboardTouchEndY) <= 20) {

        scope.checkReturn = false;


        if (myValue != 'x') {
          if (!scope.checkReturn && checkOne && scope.cardNumberPartOne.length < 4) {
            scope.cardNumberPartOne += myValue;
            scope.update(scope.cardNumberPartOne)
            if (scope.cardNumberPartOne.length == 4) {
              if (scope.cardNumberPartOne == '8600') {
                checkDate = true;
                checkPin = false;
                scope.cardPin = '';
                scope.update();
              }
              else {
                checkDate = false;
                checkPin = true;
              }
              touchEndBoxTwo()
              scope.checkReturn = true;
            }
          }

          if (!scope.checkReturn && checkTwo && scope.cardNumberPartTwo.length < 4) {
            scope.cardNumberPartTwo += myValue;
            scope.update(scope.cardNumberPartTwo)
            if (scope.cardNumberPartTwo.length == 4) {
              touchEndBoxThree()
              scope.checkReturn = true;
            }
          }

          if (!scope.checkReturn && checkThree && scope.cardNumberPartThree.length < 4) {
            scope.cardNumberPartThree += myValue;
            scope.update(scope.cardNumberPartThree)
            if (scope.cardNumberPartThree.length == 4) {
              touchEndBoxFour()
              scope.checkReturn = true;
            }
          }

          if (checkDateCopy && !checkOne && !checkTwo && !checkThree && !checkFour && scope.cardDate.length < 5) {
            if (scope.cardDate.length == 2)
              scope.cardDate += '/'
            scope.cardDate += myValue;
            scope.cardDateOriginal += myValue;
            scope.update(scope.cardDate)
            if (scope.cardDate.length == 4) {
              scope.checkReturn = true;
            }
          }

          if (!scope.checkReturn && checkFour && scope.cardNumberPartFour.length < 4) {
            scope.cardNumberPartFour += myValue;
            scope.update(scope.cardNumberPartFour)
            if (scope.cardNumberPartFour.length == 4) {
              if (checkDate)
                touchEndBoxData()
              if (checkPin)
                touchEndBoxPin()
              scope.checkReturn = true;
            }
          }

          if (checkPinCopy && !checkOne && !checkTwo && !checkThree && !checkFour && scope.cardPinOriginal.length < 4) {
            scope.cardPin += ' * ';
            scope.cardPinOriginal += myValue;
            scope.update(scope.cardPin)
            if (scope.cardPin.length == 4) {
              scope.checkReturn = true;
            }
          }

        }
        else {
          if (checkOne) {
            scope.cardNumberPartOne = scope.cardNumberPartOne.substring(0, scope.cardNumberPartOne.length - 1);
            scope.update(scope.cardNumberPartOne)
          }

          if (checkTwo) {
            scope.cardNumberPartTwo = scope.cardNumberPartTwo.substring(0, scope.cardNumberPartTwo.length - 1);
            scope.update(scope.cardNumberPartTwo)
          }

          if (checkThree) {
            scope.cardNumberPartThree = scope.cardNumberPartThree.substring(0, scope.cardNumberPartThree.length - 1);
            scope.update(scope.cardNumberPartThree)
          }

          if (checkFour) {
            scope.cardNumberPartFour = scope.cardNumberPartFour.substring(0, scope.cardNumberPartFour.length - 1);
            scope.update(scope.cardNumberPartFour)
          }

          if (checkDateCopy) {
            scope.cardDate = scope.cardDate.substring(0, scope.cardDate.length - 1);
            scope.cardDateOriginal = scope.cardDateOriginal.substring(0, scope.cardDateOriginal.length - 1);
            scope.update(scope.cardDate)
          }
          if (checkPinCopy) {
            scope.cardPin = scope.cardPin.substring(0, scope.cardPin.length - 3);
            scope.cardPinOriginal = scope.cardPinOriginal.substring(0, scope.cardPinOriginal.length - 1);

            scope.update(scope.cardPin)
          }
        }

        cardNumber = scope.cardNumberPartOne + scope.cardNumberPartTwo + scope.cardNumberPartThree + scope.cardNumberPartFour;
        console.log('cardNumberPartOne', scope.cardNumberPartOne)
        console.log('cardNumberPartTwo', scope.cardNumberPartTwo)
        console.log('cardNumberPartThree', scope.cardNumberPartThree)
        console.log('cardNumberPartFour', scope.cardNumberPartFour)
      }

    }

    var goToPinCodeTouchStartX, goToPinCodeTouchStartY, goToPinCodeTouchEndX, goToPinCodeTouchEndY;

    goToPinCodeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      goToPinCodeTouchStartX = event.changedTouches[0].pageX
      goToPinCodeTouchStartY = event.changedTouches[0].pageY
    }

    goToPinCodeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      goToPinCodeTouchEndX = event.changedTouches[0].pageX
      goToPinCodeTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToPinCodeTouchStartX - goToPinCodeTouchEndX) <= 20 && Math.abs(goToPinCodeTouchStartY - goToPinCodeTouchEndY) <= 20) {

        goToPinCodeTouchEndX = event.changedTouches[0].pageX
        goToPinCodeTouchEndY = event.changedTouches[0].pageY

        var secondParameter;
        if (checkDate)
          secondParameter = scope.cardDateOriginal
        else
          secondParameter = scope.cardPinOriginal

        if (cardNumber.length == 16 && (scope.cardDateOriginal || scope.cardPinOriginal )) {
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-registration-client', cardNumber, secondParameter]);
          scope.unmount()
        }
        else {
//        alert('error')
          scope.clickPinError = false;
          scope.errorNote = 'Error';
          scope.showError = true;
          scope.update();
        }

        console.log('cardNumber', cardNumber, secondParameter)
      }
    }
  </script>
</view-registration-client>
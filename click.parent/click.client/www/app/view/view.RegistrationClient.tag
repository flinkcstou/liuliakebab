<view-registration-client class="view-registration-client">
  <p class="registration-client-text-field">Заполните данные вашей первой карты</p>
  <div class="registration-client-card-field">
    <p class="registration-client-card-text" style="top: 20px;left: 20px;">Номер карты</p>
    <div id="cardNumberInput" class="registration-client-card-number" type="text">
      <input ontouchend="touchEndBoxOne()" id="boxOne" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-one">
      <input ontouchend="touchEndBoxTwo()" id="boxTwo" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-two">
      <input ontouchend="touchEndBoxThree()" id="boxThree" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-three">
      <input ontouchend="touchEndBoxFour()" id="boxFour" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-four">
    </div>

    <p class="registration-client-card-text" style="top: 83px;left: 20px;">Дата окончания</p>
    <div id="cardDateInput" class="registration-client-card-date" type="text">
      <input ontouchend="touchEndBoxData()" id="boxData" type="text" maxlength="5"
             class="registration-client-card-date-box">
    </div>

    <p class="registration-client-card-text" style="top: 83px;left: 150px;">Пинкод</p>
    <div id="cardPinInput" class="registration-client-card-pin" type="text">
      <input ontouchend="touchEndData()" id="boxPin" type="text" maxlength="12"
             class="registration-client-card-date-pin-box">
    </div>
  </div>
  </div>

  <div class="registration-keyboard-field keyboard-field" style="top: 100px">
    <div class="registration-button-help">Помощь</div>
    <component-keyboard></component-keyboard>
  </div>

  <div class="registration-buttons-container" style="top: 180px">
    <div class="registration-container-offline">
      <div class="registration-button-offline">Офлайн режим</div>
    </div>
    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version"
       ontouchstart="goToDemo()">
      <div class="registration-button-demo-version">Демо версия</div>
    </a>
  </div>

  <script>
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
    scope.boxOne.autofocus = true;

    touchEndBoxOne = function () {

      scope.boxOne.autofocus = true;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = false;
      scope.boxData.autofocus = false;
      scope.boxPin.autofocus = false;

      changed = false;
    }

    touchEndBoxTwo = function () {
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = true;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = false;
      scope.boxData.autofocus = false;
      scope.boxPin.autofocus = false;

      changed = false;
    }

    touchEndBoxThree = function () {
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = true;
      scope.boxFour.autofocus = false;
      scope.boxData.autofocus = false;
      scope.boxPin.autofocus = false;

      changed = false;
    }

    touchEndBoxFour = function () {
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = true;
      scope.boxData.autofocus = false;
      scope.boxPin.autofocus = false;

      changed = false;
    }

    touchEndBoxData = function () {
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = false;
      scope.boxData.autofocus = true;
      scope.boxPin.autofocus = false;

      changed = false;
    }

    componentKeyboard.returnValue = function (myValue) {
      console.log()

      if (myValue != 'x') {
        if (scope.boxOne.value.length == 4 && scope.boxOne.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = true;
          scope.boxThree.autofocus = false;
          scope.boxFour.autofocus = false;
          scope.boxData.autofocus = false;
          scope.boxPin.autofocus = false;

        }

        if (scope.boxTwo.value.length == 4 && scope.boxTwo.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = false;
          scope.boxThree.autofocus = true;
          scope.boxFour.autofocus = false;
          scope.boxData.autofocus = false;
          scope.boxPin.autofocus = false;

        }

        if (scope.boxThree.value.length == 4 && scope.boxThree.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = false;
          scope.boxThree.autofocus = false;
          scope.boxFour.autofocus = true;
          scope.boxData.autofocus = false;
          scope.boxPin.autofocus = false;
        }

        if (scope.boxFour.value.length == 4 && scope.boxFour.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = false;
          scope.boxThree.autofocus = false;
          scope.boxFour.autofocus = false;
          scope.boxData.autofocus = true;
          scope.boxPin.autofocus = false;

          cardNumber = cardNumberPartOne + cardNumberPartTwo + cardNumberPartThree + cardNumberPartFour;
        }

        if (scope.boxData.value.length == 5 && scope.boxData.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = false;
          scope.boxThree.autofocus = false;
          scope.boxFour.autofocus = false;
          scope.boxData.autofocus = false;
          scope.boxPin.autofocus = true;
          cardData = scope.boxData.value.substring(0, 2) + scope.boxData.value.substring(3, 5);
        }

        if (scope.boxOne.value.length < 4 && scope.boxOne.autofocus) {
          scope.boxOne.autofocus = true;
          if (!changed)
            scope.boxOne.value = scope.boxOne.value.substring(0, scope.boxOne.selectionStart) + myValue + scope.boxOne.value.substring(scope.boxOne.selectionStart, scope.boxOne.length);
          else {
            scope.boxOne.value = scope.boxOne.value.substring(0, selectionStart - 1) + myValue + scope.boxOne.value.substring(selectionStart - 1, scope.boxOne.length);
            changed = false;
          }
          console.log('selection start ', scope.boxOne.selectionStart);
          cardNumberPartOne = scope.boxOne.value
        }

        if (scope.boxTwo.value.length < 4 && scope.boxTwo.autofocus) {

          if (!changed)
            scope.boxTwo.value = scope.boxTwo.value.substring(0, scope.boxTwo.selectionStart) + myValue + scope.boxTwo.value.substring(scope.boxTwo.selectionStart, scope.boxTwo.length);
          else {
            scope.boxTwo.value = scope.boxTwo.value.substring(0, selectionStart - 1) + myValue + scope.boxTwo.value.substring(selectionStart - 1, scope.boxTwo.length);
            changed = false;
          }
          console.log('selection start ', scope.boxTwo.selectionStart);
          cardNumberPartTwo = scope.boxTwo.value
        }

        if (scope.boxThree.value.length < 4 && scope.boxThree.autofocus) {

          if (!changed)
            scope.boxThree.value = scope.boxThree.value.substring(0, scope.boxThree.selectionStart) + myValue + scope.boxThree.value.substring(scope.boxThree.selectionStart, scope.boxThree.length);
          else {
            scope.boxThree.value = scope.boxThree.value.substring(0, selectionStart - 1) + myValue + scope.boxThree.value.substring(selectionStart - 1, scope.boxThree.length);
            changed = false;
          }
          console.log('selection start ', scope.boxThree.selectionStart);
          cardNumberPartThree = scope.boxThree.value
        }

        if (scope.boxFour.value.length < 4 && scope.boxFour.autofocus) {

          if (!changed)
            scope.boxFour.value = scope.boxFour.value.substring(0, scope.boxFour.selectionStart) + myValue + scope.boxFour.value.substring(scope.boxFour.selectionStart, scope.boxFour.length);
          else {
            scope.boxFour.value = scope.boxFour.value.substring(0, selectionStart - 1) + myValue + scope.boxFour.value.substring(selectionStart - 1, scope.boxFour.length);
            changed = false;
          }
          console.log('selection start ', scope.boxFour.selectionStart);
          cardNumberPartFour = scope.boxFour.value
        }

        if (scope.boxData.value.length < 5 && scope.boxData.autofocus) {
          if (scope.boxData.value.length == 0) {
            if (myValue > 3) {
              alert('incorrect');
              return;
            }
            if (myValue == 3) {
              date = true;
            }
          }
          if (scope.boxData.value.length == 1) {
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
          if (scope.boxData.value.length == 2)
            scope.boxData.value += '/';
          scope.boxData.value += myValue;
        }



        if (scope.boxPin.value.length < 12 && scope.boxPin.autofocus) {
          scope.boxPin.value += ' * ';
          cardPin += myValue;
          console.log(cardPin);
        }

        if (scope.boxPin.value.length == 12 && scope.boxPin.autofocus) {
          console.log(" ",cardPin);
          registration(cardNumber, cardData, cardPin);
        }
      }
      else {
        if (scope.boxOne.autofocus) {
          selectionStart = scope.boxOne.selectionStart;
          selectionEnd = scope.boxOne.selectionEnd;
          changed = true;
          console.log('Selection start ', scope.boxOne.selectionStart)
          scope.boxOne.value = scope.boxOne.value.substring(0, scope.boxOne.selectionStart - 1) + scope.boxOne.value.substring(scope.boxOne.selectionStart, scope.boxOne.value.length);

          cardNumberPartOne = scope.boxOne.value;

          if (scope.boxOne.value.length == 0) {
            scope.boxOne.autofocus = true;
            scope.boxFour.autofocus = false;
          }
          return;
        }
        if (scope.boxTwo.autofocus) {
          selectionStart = scope.boxTwo.selectionStart;
          selectionEnd = scope.boxTwo.selectionEnd;
          changed = true;
          scope.boxTwo.value = scope.boxTwo.value.substring(0, scope.boxTwo.selectionStart - 1) + scope.boxTwo.value.substring(scope.boxTwo.selectionStart, scope.boxTwo.value.length);
          cardNumberPartTwo = scope.boxTwo.value;

          if (scope.boxTwo.value.length == 0) {
            scope.boxOne.autofocus = true;
            scope.boxTwo.autofocus = false;
          }
          return;
        }
        if (scope.boxThree.autofocus) {
          selectionStart = scope.boxThree.selectionStart;
          selectionEnd = scope.boxThree.selectionEnd;
          changed = true;
          scope.boxThree.value = scope.boxThree.value.substring(0, scope.boxThree.selectionStart - 1) + scope.boxThree.value.substring(scope.boxThree.selectionStart, scope.boxThree.value.length);
          cardNumberPartThree = scope.boxThree.value;

          if (scope.boxThree.value.length == 0) {
            scope.boxTwo.autofocus = true;
            scope.boxThree.autofocus = false;
          }
          return;
        }
        if (scope.boxFour.autofocus) {
          selectionStart = scope.boxFour.selectionStart;
          selectionEnd = scope.boxFour.selectionEnd;
          changed = true;
          scope.boxFour.value = scope.boxFour.value.substring(0, scope.boxFour.selectionStart - 1) + scope.boxFour.value.substring(scope.boxFour.selectionStart, scope.boxFour.value.length);
          cardNumberPartFour = scope.boxFour.value;
          if (scope.boxFour.value.length == 0) {

            scope.boxThree.autofocus = true;
            scope.boxFour.autofocus = false;
          }
          return;
        }

        if(scope.boxData.autofocus || (scope.boxPin.autofocus && scope.boxPin.value.length == 0)){
          scope.boxData.value = scope.boxData.value.substring(0, scope.boxData.value.length - 1);

          if(scope.boxData.value.length == 0){
            scope.boxFour.autofocus = true;
            scope.boxData.autofocus = false;
          }
          return;
        }

        if(scope.boxPin.autofocus){
          scope.boxPin.value = scope.boxPin.value.substring(0, scope.boxPin.value.length - 1);
          if(scope.boxPin.value.length == 0){
            scope.boxData.autofocus = true;
            scope.boxPin.autofocus = false;
          }
        }
      }
      console.log('Pard one ', cardNumberPartOne, 'Part two', cardNumberPartTwo, 'Part three', cardNumberPartThree, 'Part four', cardNumberPartFour)
      console.log('Focus one ', scope.boxOne.focus, 'Focus two', scope.boxTwo.focus, 'Focus three', scope.boxThree.focus, 'Focus four', scope.boxFour.focus)
      console.log(myValue)
      riot.update();
    }

    history.arrayOfHistory.push('view-registration-client');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');


    registration = function (cardNumber, cardData, cardPin) {
      window.api.call({
        method: 'registration',
        input : {
          phone_num  : phoneNumber,
          card_number: cardNumber,
          card_data  : cardData,
          pin        : cardPin
        },
        scope : this,

        onSuccess: function (result) {
          console.log(result);

        },
        onFail   : function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }
  </script>
</view-registration-client>
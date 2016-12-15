<view-registration-client>
  <p class="registration-client-text-field">Заполните данные вашей первой карты</p>
  <div class="registration-client-card-field">
    <p class="registration-client-card-text" style="top: 20px;left: 20px;">Номер карты</p>
    <div id="cardNumberInput" class="registration-client-card-number" type="text">
      <input ontouchend="touchEndBoxOne()" id="boxOne" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-one">
      <input ontouchend="touchEndBoxTwo()"  id="boxTwo" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-two">
      <input ontouchend="touchEndBoxThree()" id="boxThree" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-three">
      <input ontouchend="touchEndBoxFour()" id="boxFour" type="text" maxlength="4"
             class="registration-client-card-number-box registration-client-card-number-box-four">
    </div>

    <p class="registration-client-card-text" style="top: 83px;left: 20px;">Дата окончания</p>
    <div id="cardDateInput" class="registration-client-card-date" type="text">
    </div>

    <p class="registration-client-card-text" style="top: 83px;left: 150px;">Пинкод</p>
    <div id="cardPinInput" class="registration-client-card-pin" type="text">
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
    scope.boxOne.autofocus = true;

    touchEndBoxOne = function(){

      scope.boxOne.autofocus = true;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = false;

      console.log(scope.boxOne.selectionStart);
      console.log(scope.boxOne.selectionEnd);
    }

    touchEndBoxTwo = function(){
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = true;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = false;
    }

    touchEndBoxThree = function(){
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = true;
      scope.boxFour.autofocus = false;
    }

    touchEndBoxFour = function(){
      scope.boxOne.autofocus = false;
      scope.boxTwo.autofocus = false;
      scope.boxThree.autofocus = false;
      scope.boxFour.autofocus = true;
    }

    componentKeyboard.returnValue = function (myValue) {
      console.log()

      if (myValue != 'x') {
        if (scope.boxOne.value.length == 4 && scope.boxOne.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = true;
          scope.boxThree.autofocus = false;
          scope.boxFour.autofocus = false;
        }

        if (scope.boxTwo.value.length == 4 && scope.boxTwo.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = false;
          scope.boxThree.autofocus = true;
          scope.boxFour.autofocus = false;
        }

        if (scope.boxThree.value.length == 4 && scope.boxThree.autofocus) {
          scope.boxOne.autofocus = false;
          scope.boxTwo.autofocus = false;
          scope.boxThree.autofocus = false;
          scope.boxFour.autofocus = true;
        }

        if (scope.boxOne.value.length < 4 && scope.boxOne.autofocus) {
          scope.boxOne.autofocus = true;
          scope.boxOne.value += myValue;
          cardNumberPartOne = scope.boxOne.value
        }

        if (scope.boxTwo.value.length < 4 && scope.boxTwo.autofocus) {

          scope.boxTwo.value += myValue;
          cardNumberPartTwo = scope.boxTwo.value
        }

        if (scope.boxThree.value.length < 4 && scope.boxThree.autofocus) {

          scope.boxThree.value += myValue;
          cardNumberPartThree = scope.boxThree.value
        }

        if (scope.boxFour.value.length < 4 && scope.boxFour.autofocus) {

          scope.boxFour.value += myValue;
          cardNumberPartFour = scope.boxFour.value
        }
      }
      else {
        if (scope.boxOne.autofocus) {
          scope.boxOne.value = scope.boxOne.value.substring(0, scope.boxOne.selectionStart-1) + scope.boxOne.value.substring(scope.boxOne.selectionStart, scope.boxOne.value.length);
          cardNumberPartOne = scope.boxOne.value;

          if (scope.boxOne.value.length == 0) {
            scope.boxOne.autofocus = true;
            scope.boxFour.autofocus = false;
          }
        }
        if (scope.boxTwo.autofocus) {
          scope.boxTwo.value = scope.boxTwo.value.substring(0, scope.boxTwo.selectionStart-1) + scope.boxTwo.value.substring(scope.boxTwo.selectionStart, scope.boxTwo.value.length);
          cardNumberPartTwo = scope.boxTwo.value;

          if (scope.boxTwo.value.length == 0) {
            scope.boxOne.autofocus = true;
            scope.boxTwo.autofocus = false;
          }
        }
        if (scope.boxThree.autofocus) {
          scope.boxThree.value = scope.boxThree.value.substring(0, scope.boxThree.selectionStart-1) + scope.boxThree.value.substring(scope.boxThree.selectionStart, scope.boxThree.value.length);
          cardNumberPartThree = scope.boxThree.value;

          if (scope.boxThree.value.length == 0) {
            scope.boxTwo.autofocus = true;
            scope.boxThree.autofocus = false;
          }
        }
        if (scope.boxFour.autofocus) {
          scope.boxFour.value = scope.boxFour.value.substring(0, scope.boxFour.selectionStart-1) + scope.boxFour.value.substring(scope.boxFour.selectionStart, scope.boxFour.value.length);
          cardNumberPartFour = scope.boxFour.value;
          if (scope.boxFour.value.length == 0) {
            console.log('qwrqwre')
            scope.boxThree.autofocus = true;
            scope.boxFour.autofocus = false;
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
    var pin;

    window.api.call({
      method: 'registration',
      input : {
        phone_num  : phoneNumber,
        card_number: cardNumber,
        card_data  : cardData,
        pin        : pin
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
  </script>
</view-registration-client>
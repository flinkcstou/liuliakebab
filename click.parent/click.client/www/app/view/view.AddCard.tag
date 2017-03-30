<view-add-card>

  <div class="add-card-page-title">
    <p class="add-card-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="add-card-back-button"></div>
  </div>

  <div class="view-add-card">
    <p class="add-card-text-field">{window.languages.ViewAddCardNameTitle}</p>
    <div class="add-card-card-name-input-part-container">
      <input maxlength="25" class="add-card-card-name-input-part"/>
    </div>
    <div class="add-card-card-field">
      <p class="add-card-card-text add-card-card-number-text">{window.languages.ViewAddCardNumberTitle}</p>
      <div id="cardNumberInput" class="add-card-card-number">
        <input onkeydown="boxOneKeyDown()" autofocus="true" maxlength="4" id="boxOne"
               class="add-card-card-number-box registration-client-card-number-box-one">
        </input>
        <input onkeydown="boxTwoKeyDown()" maxlength="4" id="boxTwo"
               class="add-card-card-number-box registration-client-card-number-box-two">
        </input>
        <input onkeydown="boxThreeKeyDown()" maxlength="4" id="boxThree"
               class="add-card-card-number-box registration-client-card-number-box-three">
        </input>
        <input onkeydown="boxFourKeyDown()" maxlength="4" id="boxFour"
               class="add-card-card-number-box registration-client-card-number-box-four">
        </input>
      </div>

      <p class="add-card-card-text add-card-card-text-date">{window.languages.ViewAddCardDateTitle}</p>
      <div id="cardDateInput" class="add-card-card-date" type="text">
        <input onkeydown="boxDateKeyDown()" maxlength="5" id="boxDate"
               class="add-card-card-date-box">
        </input>
      </div>

      <p class="add-card-card-text add-card-card-text-pin">{window.languages.ViewAddCardPinTitle}</p>
      <div id="cardPinInput" class="add-card-card-pin">
        <input onkeydown="boxPinKeyDown()" type="tel" maxlength="4" id="boxPin"
               class="add-card-card-date-pin-box">
        </input>
      </div>
    </div>

    <div class="add-card-main-card-field">
      <p class="add-card-main-card-text">{window.languages.ViewAddCardDoMainTitle}</p>
      <div id="doMainId" class="add-card-main-card-icon" ontouchend="doMainCardTouchEnd()"></div>
    </div>
  </div>

  <script>
    var scope = this;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-add-card') {
      history.arrayOfHistory.push(
        {
          "view": 'view-add-card',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    scope.doMainCard = false;

    doMainCardTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      if (!scope.doMainCard) {
        scope.doMainCard = true;
        doMainId.style.backgroundImage = 'url(resources/icons/ViewService/checked.png)';
      }
      else {
        scope.doMainCard = false;
        doMainId.style.backgroundImage = 'url(resources/icons/ViewService/unchecked.png)';
      }
    }
    boxOneKeyDown = function () {

      if (boxOne.value.length == 4) {
        boxTwo.focus();
      }
    }

    boxTwoKeyDown = function () {

      if (boxTwo.value.length == 4) {
        boxThree.focus();
      }
    }

    boxThreeKeyDown = function () {

      if (boxThree.value.length == 4) {
        boxFour.focus();
      }
    }

    boxFourKeyDown = function () {

      if (boxFour.value.length == 4) {
        boxDate.focus();
      }
    }

    boxDateKeyDown = function () {

      if (boxDate.value.length == 2) {
        boxDate.value += '/'
      }

      if (boxDate.value.length == 5) {
        boxPin.focus();
      }
    }

    var stars = '';
    var pinCodeOfBank = '';
    boxPinKeyDown = function () {


      if (event.keyCode != 8 && pinCodeOfBank.length < 4) {
        pinCodeOfBank += event.key;
        console.log('pinCodeOfBank', pinCodeOfBank)
        stars += '*'
        boxPin.value = stars
      }
      else {
        if (event.keyCode == 8) {
          stars = stars.substring(0, stars.length - 1)
          pinCodeOfBank = pinCodeOfBank.substring(0, pinCodeOfBank.length - 1)
          boxPin.value = stars
        }
      }

      event.preventDefault()
    }

    scope.titleName = window.languages.ViewAddCardTitle;

    goToBack = function () {
      event.preventDefault()
      event.stopPropagation()
      onBackKeyDown()
    }


    this.on('mount', function () {

    })


  </script>
</view-add-card>
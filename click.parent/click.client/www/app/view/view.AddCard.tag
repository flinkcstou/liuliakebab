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
        <input onkeyup="boxOneKeyUp()" autofocus="true" maxlength="4" id="boxOne"
               class="add-card-card-number-box registration-client-card-number-box-one">
        </input>
        <input onkeyup="boxTwoKeyUp()" maxlength="4" id="boxTwo"
               class="add-card-card-number-box registration-client-card-number-box-two">
        </input>
        <input onkeyup="boxThreeKeyUp()" maxlength="4" id="boxThree"
               class="add-card-card-number-box registration-client-card-number-box-three">
        </input>
        <input onkeyup="boxFourKeyUp()" maxlength="4" id="boxFour"
               class="add-card-card-number-box registration-client-card-number-box-four">
        </input>
      </div>

      <p class="add-card-card-text add-card-card-text-date">{window.languages.ViewAddCardDateTitle}</p>
      <div id="cardDateInput" class="add-card-card-date" type="text">
        <input onkeyup="boxDateKeyUp()" maxlength="5" id="boxDate"
               class="add-card-card-date-box">
        </input>
      </div>

      <p class="add-card-card-text add-card-card-text-pin">{window.languages.ViewAddCardPinTitle}</p>
      <div id="cardPinInput" class="add-card-card-pin">
        <input onkeyup="boxPinKeyUp()" maxlength="4" id="boxPin"
               class="add-card-card-date-pin-box">
        </input>
      </div>
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

    boxOneKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      if (boxOne.value.length == 4) {
        console.log('qwe')
        boxTwo.focus();
      }
    }

    boxTwoKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      if (boxTwo.value.length == 4) {
        boxThree.focus();
      }
    }

    boxThreeKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      if (boxThree.value.length == 4) {
        boxFour.focus();
      }
    }

    boxFourKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      if (boxFour.value.length == 4) {
        boxDate.focus();
      }
    }

    boxDateKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()

      if (boxDate.value.length == 5) {
        boxPin.focus();
      }
    }

    var stars = '';
    boxPinKeyUp = function () {
      event.preventDefault()
      event.stopPropagation()
      stars += '*'
      if (stars.length > 4)
        return

      if (boxPin.value.length < 5)
        boxPin.value = stars
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
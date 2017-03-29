<view-add-card>

  <div class="add-card-page-title">
    <p class="add-card-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="add-card-back-button"></div>
  </div>

  <div class="view-add-card">
    <p class="add-card-text-field">Заполните данные вашей первой карты</p>
    <div class="add-card-card-field">
      <p class="add-card-card-text add-card-card-number-text">Номер карты</p>
      <div id="cardNumberInput" class="add-card-card-number">
        <div onfocus="boxFocus()" ontouchend="touchEndBoxOne()" id="boxOne"
             class="add-card-card-number-box registration-client-card-number-box-one">
        </div>
        <div ontouchend="touchEndBoxTwo()" id="boxTwo"
             class="add-card-card-number-box registration-client-card-number-box-two">
        </div>
        <div ontouchend="touchEndBoxThree()" id="boxThree"
             class="add-card-card-number-box registration-client-card-number-box-three">
        </div>
        <div ontouchend="touchEndBoxFour()" id="boxFour"
             class="add-card-card-number-box registration-client-card-number-box-four">
        </div>
      </div>

      <p class="add-card-card-text add-card-card-text-date">Дата окончания</p>
      <div id="cardDateInput" class="add-card-card-date" type="text">
        <div ontouchend="touchEndBoxData()" id="boxData"
             class="add-card-card-date-box">
        </div>
      </div>

      <p class="add-card-card-text add-card-card-text-pin">Код банка</p>
      <div id="cardPinInput" class="add-card-card-pin">
        <div ontouchend="touchEndBoxPin()" id="boxPin"
             class="add-card-card-date-pin-box">
        </div>
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
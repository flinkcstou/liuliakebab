<view-click-pass class="riot-tags-main-container">

  <component-click-pass-help></component-click-pass-help>
  <component-click-pass-cards></component-click-pass-cards>

  <div id="clickPassPageId" class="view-click-pass">
    <div class="page-title">
      <p class="name-title">{window.languages.ViewClickPassTitle}</p>
      <div id="backButton"
           ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div id="helpButtonId" role="button"
           type="button"
           class="click-pass-help-button"
           ontouchstart="openHelpTouchStart()"
           ontouchend="clickPassHelpMenuOpenTouchEnd()">
      </div>
      <div class="title-bottom-border">
      </div>
    </div>

    <canvas id="qr" class="click-pass-qr-code-canvas"></canvas>
    <div class="click-pass-progress-bar-container">
      <div id="progressBar" class="click-pass-progress-bar-line">
      </div>
    </div>
    <canvas id="barcode" class="click-pass-bar-code-canvas"></canvas>

    <div class="click-pass-chosen-card-container"
         ontouchstart="openCardsTouchStart()"
         ontouchend="clickPassCardsMenuOpenTouchEnd()"
         id="chosenCardId" if="{chosenCard}">
      <div class="click-pass-chosen-card-logo-container"
           style="background-image: url({chosenCard.url})"></div>
      <div class="click-pass-chosen-card-info-container">
        <p class="click-pass-chosen-card-info-text-one">{chosenCard.name}</p>
        <p class="click-pass-chosen-card-info-text-three">{chosenCard.numberPartOne} **** {chosenCard.numberPartTwo}</p>
      </div>
      <div class="click-pass-chosen-card-next-icon"></div>
    </div>
  </div>

  <script>

    var scope = this;

    var goBackButtonStartX, goBackButtonEndX,
      goBackButtonStartY, goBackButtonEndY;

    var openHelpTouchStartX,
      openHelpTouchStartY,
      openHelpTouchEndX,
      openHelpTouchEndY;

    var openCardsTouchStartX,
      openCardsTouchStartY,
      openCardsTouchEndX,
      openCardsTouchEndY;

    var deviceId = localStorage.getItem('click_client_deviceID');
    var cardsArray = {};
    if (JSON.parse(localStorage.getItem('click_client_cards'))) {
      cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    }
    var codeData = '';
    scope.chosenCard;

    window.saveHistory('view-click-pass', opts);

    scope.on('mount', function () {
      for (var i in cardsArray){
        if (cardsArray[i].default_account){
          scope.chosenCard = cardsArray[i];
          console.log('default Card', scope.chosenCard);
          codeData = prepareCodeData(scope.chosenCard.card_id);
          generateQrCode(codeData);
          generateBarCode(codeData);
        }
      }
      scope.update();
    });

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    openHelpTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      helpButtonId.style.webkitTransform = 'scale(0.7)';

      openHelpTouchStartX = event.changedTouches[0].pageX;
      openHelpTouchStartY = event.changedTouches[0].pageY;
    };

    clickPassHelpMenuOpenTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      helpButtonId.style.webkitTransform = 'scale(1)'

      openHelpTouchEndX = event.changedTouches[0].pageX;
      openHelpTouchEndY = event.changedTouches[0].pageY;

      if ((Math.abs(openHelpTouchStartX - openHelpTouchEndX) <= 20 && Math.abs(openHelpTouchStartY - openHelpTouchEndY) <= 20)) {

        componentClickPassHelp.checkOpen = true;

        this.clickPassCardsMenuBackPageId.style.zIndex = '-1';

        this.clickPassHelpMenuBackPageId.style.webkitTransition = '0.3s';
        this.clickPassPageId.style.webkitTransition = '0.3s';
        this.clickPassPageId.style.zIndex = '-1';
        this.clickPassPageId.style.opacity = '0.1';
        this.clickPassHelpMenuId.style.webkitTransition = '0.3s';
        this.clickPassHelpMenuId.style.transform = "translate3d(0, 0, 0)";
        this.clickPassHelpMenuId.style.webkitTransform = "translate3d(0, 0, 0)";

        this.clickPassHelpMenuBackPageId.style.opacity = '1';
      }
    };

    openCardsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      chosenCardId.style.webkitTransform = 'scale(0.7)';

      openCardsTouchStartX = event.changedTouches[0].pageX;
      openCardsTouchStartY = event.changedTouches[0].pageY;
    };

    clickPassCardsMenuOpenTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      chosenCardId.style.webkitTransform = 'scale(1)';

      openCardsTouchEndX = event.changedTouches[0].pageX;
      openCardsTouchEndY = event.changedTouches[0].pageY;

      if ((Math.abs(openCardsTouchStartX - openCardsTouchEndX) <= 20 && Math.abs(openCardsTouchStartY - openCardsTouchEndY) <= 20)) {

        componentClickPassCards.checkOpen = true;

        this.clickPassHelpMenuBackPageId.style.zIndex = '-1';

        this.clickPassCardsMenuBackPageId.style.webkitTransition = '0.3s';
        this.clickPassPageId.style.webkitTransition = '0.3s';
        this.clickPassPageId.style.zIndex = '-1';
        this.clickPassPageId.style.opacity = '0.1';
        this.clickPassCardsMenuId.style.webkitTransition = '0.3s';
        this.clickPassCardsMenuId.style.transform = "translate3d(0, 0, 0)";
        this.clickPassCardsMenuId.style.webkitTransform = "translate3d(0, 0, 0)";

        this.clickPassCardsMenuBackPageId.style.opacity = '1';
      }
    };

    generateQrCode = function (data) {
      var qr = new QRious({
        element: document.getElementById('qr'),
        size: 410 * widthK,
        value: data
      });
    };

    generateBarCode = function (data) {
      JsBarcode(barcode, data, {
        format: "codabar",
        displayValue: false,
        width: 3.5,
        height: 120 * widthK,
      });
    };

    prepareCodeData = function (card_id) {
      var currentTime = new Date().getTime() / 1000;
      var OTP = updateOtp(deviceId, currentTime);
      var luna = codeCheckLuna(card_id.toString() + OTP.toString());
      var result = card_id.toString() + OTP.toString() + '1';
      console.log('code data:', result);
      return result;
    }

  </script>
</view-click-pass>
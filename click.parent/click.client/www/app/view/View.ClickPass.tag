<view-click-pass class="riot-tags-main-container">

  <component-click-pass-help></component-click-pass-help>
  <component-click-pass-cards show_balance="{showBalance}"></component-click-pass-cards>

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

    <div class="view-click-pass-shot-to-seller">
      {window.languages.ViewClickPassShowToSeller}
    </div>

    <canvas id="qr" class="click-pass-qr-code-canvas"></canvas>
    <div id="statusBarId" class="click-pass-progress-bar-container">
      <div id="statusBarLineId" class="click-pass-progress-bar-container-line">
      </div>
    </div>
    <canvas id="barcode"
            class="click-pass-bar-code-canvas"
            ontouchstart="openBarCodeStart()"
            ontouchend="openBarCodeEnd()"></canvas>

    <div class="click-pass-chosen-card-container"
         ontouchstart="openCardsTouchStart()"
         ontouchend="clickPassCardsMenuOpenTouchEnd()"
         id="chosenCardId" if="{chosenCard}">
      <div class="click-pass-chosen-card-logo-container"
           style="background-image: url({chosenCard.url})"></div>
      <div class="click-pass-chosen-card-info-container">
        <p class="click-pass-chosen-card-info-text-one"
           style="top: 22%;">{chosenCard.name}</p>
        <p class="click-pass-chosen-card-info-text-three">{chosenCard.numberPartOne} **** {chosenCard.numberPartTwo}</p>
      </div>
      <div class="click-pass-chosen-card-next-icon"></div>
    </div>

    <div id="fullBarCodeId" class="click-pass-full-bar-code">
      <canvas id="fullBarCodeCanvasId"
              class="click-pass-full-bar-code-canvas">
      </canvas>
      <img id="fullBarCodeImgId"
           class="click-pass-full-bar-code-img"
           ontouchstart="closeBarCodeStart()"
           ontouchend="closeBarCodeEnd()">
    </div>
  </div>

  <script>

    var scope = this;
    scope.codeInterval = 0;
    scope.timerInterval = 0;
    scope.showBalance = false;

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

    var barCodeTouchStartX,
      barCodeTouchStartY,
      barCodeTouchEndX,
      barCodeTouchEndY;

    scope.OTP = '';

    scope.showCreatingTime = '';
    scope.showCorCurrentTime = '';
    scope.showCodeData = '';

    var deviceId = localStorage.getItem('click_client_deviceID');
    scope.cardsArray;
    if (localStorage.getItem('click_client_cards')) {
      scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    }
    scope.chosenCard;

    if (opts && opts[0] !== 'fromPinCode') {
      window.saveHistory('view-click-pass', opts);
      scope.showBalance = true;
      scope.update(scope.showBalance);
    }

    scope.on('mount', function () {

      checkCardsArray();
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].default_account) {
          scope.chosenCard = scope.cardsArray[i];
        }
      }
      if (!scope.chosenCard && JSON.stringify(scope.cardsArray).length > 2) {
        for (var i in scope.cardsArray) {
//          console.log("card", scope.cardsArray[i]);
          if (scope.cardsArray[i]) {
            scope.chosenCard = scope.cardsArray[i];
          }
        }
      }
      if (!scope.chosenCard) {
        scope.errorNote = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
        window.common.alert.show("componentAlertId", {
          parent: scope,
          viewpage: "view-main-page",
          errornote: scope.errorNote,
        });
        return;
      }
      if (correctTime() % 30 != 0) {
        var restOfTime = 30 - correctTime() % 30;
        setTimeout(function () {
          updateRestTimeCode();
          clearRestTransitionStatus(restOfTime);
        }, 0);
        setTimeout(function () {
          updateCode();
          scope.codeInterval = setInterval(updateCode, 30000);
        }, restOfTime * 1000);
      } else {
        updateCode();
        scope.codeInterval = setInterval(updateCode, 30000);
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
        clearInterval(scope.codeInterval);
        clearTransitionStatus();
        onBackKeyDown();
        scope.unmount();
      }
    };

    openBarCodeStart = function () {
      event.preventDefault();
      event.stopPropagation();

      barCodeTouchStartX = event.changedTouches[0].pageX;
      barCodeTouchStartY = event.changedTouches[0].pageY;

      barcode.style.webkitTransform = 'scale(0.7)';

    };

    openBarCodeEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      barCodeTouchEndX = event.changedTouches[0].pageX;
      barCodeTouchEndY = event.changedTouches[0].pageY;

      barcode.style.webkitTransform = 'scale(1)';

      if (Math.abs(barCodeTouchStartX - barCodeTouchEndX) <= 20 && Math.abs(barCodeTouchStartY - barCodeTouchEndY) <= 20) {
        fullBarCodeId.style.display = 'block';
      }
    };

    closeBarCodeStart = function () {
      event.preventDefault();
      event.stopPropagation();

      barCodeTouchStartX = event.changedTouches[0].pageX;
      barCodeTouchStartY = event.changedTouches[0].pageY;


    };

    closeBarCodeEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      barCodeTouchEndX = event.changedTouches[0].pageX;
      barCodeTouchEndY = event.changedTouches[0].pageY;


      if (Math.abs(barCodeTouchStartX - barCodeTouchEndX) <= 20 && Math.abs(barCodeTouchStartY - barCodeTouchEndY) <= 20) {
        fullBarCodeId.style.display = 'none';
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

    scope.changeChosenCard = changeChosenCard = function (id) {
      id = parseInt(id);
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].card_id === id) {
          scope.chosenCard = scope.cardsArray[i];
        }
      }
      console.log(scope.chosenCard);
      updateOnlyCardId(scope.chosenCard.card_id);
      scope.update();
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
        format: "CODE128",
        displayValue: false,
        height: 220 * widthK,
      });
      JsBarcode(fullBarCodeCanvasId, data, {
        format: "CODE128",
        displayValue: false,
        height: 1232 * heightK,
      });
      var fullBarCodeImg = fullBarCodeCanvasId.toDataURL("image/png");
      fullBarCodeImgId.src = fullBarCodeImg;
    };

    prepareCodeData = function (card_id) {
      var timeForOtp = correctTime();
      scope.showCreatingTime = timeForOtp;
      scope.OTP = updateOtp(deviceId, timeForOtp);
      var luna = generateLuhn(card_id.toString() + scope.OTP.toString());
      var result = card_id.toString() + scope.OTP.toString() + luna;
//      scope.showCodeData = result;
      scope.update();
      return result;
    };

    updateCode = function () {
      if (!document.getElementById("clickPassPageId")) {
        clearInterval(scope.codeInterval);
        return;
      }
      var codeData = prepareCodeData(scope.chosenCard.card_id);
      generateQrCode(codeData);
      generateBarCode(codeData);
      setTimeout(clearTransitionStatus, 0);
    };

    clearTransitionStatus = function () {
      if (document.getElementById("statusBarId")) {
        statusBarLineId.style.webkitTransition = 'none';
        statusBarLineId.style.transition = 'none';
        statusBarLineId.style.width = 410 * widthK + 'px';
        setTimeout(restartTransitionStatus, 100);
      }
    };

    restartTransitionStatus = function () {
      if (document.getElementById("statusBarId")) {
        statusBarLineId.style.webkitTransition = '29.9s linear';
        statusBarLineId.style.transition = '29.9s linear';
        statusBarLineId.style.width = 0 * widthK + 'px';
      }
    };

    updateRestTimeCode = function () {
      var codeData = prepareCodeData(scope.chosenCard.card_id);
      generateQrCode(codeData);
      generateBarCode(codeData);
    };

    clearRestTransitionStatus = function (restTime) {
      if (document.getElementById("statusBarId")) {

        statusBarLineId.style.webkitTransition = 'none';
        statusBarLineId.style.transition = 'none';
        statusBarLineId.style.width = 410 * (restTime / 30) * widthK + 'px';
        setTimeout(function () {
          restartRestTransitionStatus(restTime);
        }, 100);
      }
    };

    restartRestTransitionStatus = function (restTime) {

      if (document.getElementById("statusBarId")) {
        statusBarLineId.style.webkitTransition = (restTime - 1) + '.9s linear';
        statusBarLineId.style.transition = (restTime - 1) + '.9s linear';
        statusBarLineId.style.width = 0 * widthK + 'px';
      }
    };

    function checkCardsArray() {
      for (var i in scope.cardsArray) {
        scope.cardsArray[i].permission = true;
        if (scope.cardsArray[i].access != 2) {
          scope.cardsArray[i].permission = false;
        }
        if (scope.cardsArray[i].payment_allowed != 1) {
          scope.cardsArray[i].permission = false;
        }
        if (!scope.cardsArray[i].permission) {
          delete scope.cardsArray[i];
        }
      }
    }

    function correctTime() {
      if (localStorage.getItem('click_client_otp_time')) {
        var otpTime = JSON.parse(localStorage.getItem('click_client_otp_time'));
        var result = parseInt(new Date().getTime() / 1000) + otpTime.diffTime;
        return result;
      } else {
        return parseInt(new Date().getTime() / 1000);
      }
    }

    function updateOnlyCardId(card_id) {
      var luna = generateLuhn(card_id.toString() + scope.OTP.toString());
      var result = card_id.toString() + scope.OTP.toString() + luna;
      generateQrCode(result);
      generateBarCode(result);
//      scope.showCodeData = result;
      scope.update();
//      console.log('Updating only card_id', result);
    }


  </script>
</view-click-pass>
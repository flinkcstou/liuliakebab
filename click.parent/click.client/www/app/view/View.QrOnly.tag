<view-qr-only class="riot-tags-main-container">
  <div class="view-qr-blue-container page-title-shadow">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchend="goToBack()"
           class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="view-qr-company-icon" style="background-image: url({opts.image})"></div>
    <p class="view-qr-company-name">
      {opts.name}</p>
    <p class="view-qr-address-name">
      {opts.address}</p>
  </div>
  <div class="view-qr-container">

    <div class="view-qr-contact-phone-field-container">
      <div class="view-qr-only-container">

        <div class="view-qr-only-scan-instruction-label">{languages.QrOnlyStartQrText}</div>
        <div class="view-qr-only-scan-container">
          <div id="qrButtonId" class="view-qr-only-scan-button" ontouchstart="goToQrTouchStart()"
               ontouchend="goToQrTouchEnd()"></div>
          <div class="view-qr-only-scan-label">{languages.QrOnlyQrText}</div>
        </div>

      </div>
    </div>

    <button id="bottomButtonContainerId" class="bottom-button-container" ontouchend="onTouchEndAccept()"
            ontouchstart="onTouchStartAccept()">
      {window.languages.ViewQrInfoTitleAccept}
    </button>

  </div>

  <script>

    var scope = this;
    this.titleName = window.languages.ViewQrTitle;
    var touchStartAcceptX, touchStartAcceptY, touchStartDeclineX, touchStartDeclineY;
    scope.showPlaceHolderError = false;

    window.saveHistory('view-qr-only', opts);

    console.log('QR OPTS', opts);


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown();
      scope.unmount()
    };

    onTouchStartAccept = function () {

      touchStartAcceptX = event.changedTouches[0].pageX;
      touchStartAcceptY = event.changedTouches[0].pageY;

      bottomButtonContainerId.style.webkitTransform = 'scale(0.8)';
    };

    onTouchEndAccept = function () {

      touchEndAcceptX = event.changedTouches[0].pageX;
      touchEndAcceptY = event.changedTouches[0].pageY;

      bottomButtonContainerId.style.webkitTransform = 'scale(1)';

      if (Math.abs(touchEndAcceptX - touchStartAcceptX) < 20 &&
        Math.abs(touchEndAcceptY - touchStartAcceptY) < 20) {
        opts.qrSum = scope.amount;
        opts.transactionId = parseInt(Date.now() / 1000);

        riotTags.innerHTML = "<view-qr-pincards>";
        opts.tax = scope.tax;
        riot.mount('view-qr-pincards', opts);

        scope.unmount()

      }
    };


  </script>
</view-qr-only>

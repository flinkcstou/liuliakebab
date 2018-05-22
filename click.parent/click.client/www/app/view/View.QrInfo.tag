<view-qr-info class="riot-tags-main-container">
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
      <div class="view-qr-info-menu-container">
        <div class="view-qr-info-menu-title-container">

          <div class="view-qr-info-menu-title">Наименование</div>
          <div class="view-qr-info-menu-title view-qr-info-menu-title-count">Кол-во</div>
          <div class="view-qr-info-menu-title view-qr-info-menu-title-amount">Сумма</div>

        </div>
        <div class="view-qr-info-menu-body-container">
          <div class="view-qr-info-menu-body-line-container" each="{i in menu}">

            <div class="view-qr-info-menu-body-line-name">{i.name}</div>
            <div class="view-qr-info-menu-body-line-name view-qr-info-menu-body-line-count">{i.count}</div>
            <div class="view-qr-info-menu-body-line-name view-qr-info-menu-body-line-amount">{i.amountTransformed}</div>

          </div>

        </div>
        <div class="view-qr-info-menu-sum-container">
          <div class="view-qr-info-total-amount-title">Итоговая сумма:</div>
          <div class="view-qr-info-total-amount">{amountCopy} сум</div>
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
    scope.menu = opts.menu.item ? opts.menu.item : [];
    scope.amount = opts.amount;

    transformAmounts = function () {
      for (var i in scope.menu) {
        console.log("amount=", scope.menu[i].amount);
        scope.menu[i].intPartAmount = Math.floor(scope.menu[i].amount.toString().replace(/\s/g, '')).toFixed(0).toString();
        scope.menu[i].fracPartAmount = window.getFractionalPart(scope.menu[i].amount.toString());
        scope.menu[i].amountTransformed = window.amountTransform(window.inputVerification.spaceDeleter(scope.menu[i].intPartAmount)) + scope.menu[i].fracPartAmount;
      }
      if (scope.amount) {
        scope.intPartAmount = Math.floor(scope.amount.toString().replace(/\s/g, '')).toFixed(0).toString();
        scope.fracPartAmount = window.getFractionalPart(scope.amount.toString());
        scope.amountCopy = window.amountTransform(window.inputVerification.spaceDeleter(scope.intPartAmount)) + scope.fracPartAmount;
      }
    };

    transformAmounts();

    window.saveHistory('view-qr-info', opts);

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
</view-qr-info>

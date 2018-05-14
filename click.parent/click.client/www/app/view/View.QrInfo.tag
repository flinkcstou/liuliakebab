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
          <div class="view-qr-info-menu-title view-qr-info-menu-title-quantity">Кол-во</div>
          <div class="view-qr-info-menu-title view-qr-info-menu-title-sum">Сумма</div>

        </div>
        <div class="view-qr-info-menu-body-container">

        </div>
        <div class="view-qr-info-menu-sum-container">

        </div>

      </div>
    </div>

    <button id="bottomButtonContainerId" class="bottom-button-container" ontouchend="onTouchEndAccept()"
            ontouchstart="onTouchStartAccept()">
      {window.languages.ViewQrTitleAccept}
    </button>

  </div>

  <script>

    var scope = this;
    this.titleName = window.languages.ViewQrTitle;
    var touchStartAcceptX, touchStartAcceptY, touchStartDeclineX, touchStartDeclineY;
    var sumForQrPay;
    var defaultAccount;
    scope.showPlaceHolderError = false;

    if (!opts.commission_percent)
      scope.showPlaceHolderError = true;

    window.saveHistory('view-qr-info', opts);

    this.on('mount', function () {


    });

    console.log('QR OPTS', opts);

    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }

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
        opts.qrSum = sumForQrPay;
        opts.transactionId = parseInt(Date.now() / 1000);

        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*0" + opts.id + "*" + parseInt(sumForQrPay) + "%23",
            function (err) {
              if (err == "empty") {
                scope.clickPinError = false;
                scope.errorNote = ("Неверный номер");
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote
                });
                scope.update();
              }
              else console.log("Ошибка USSD:" + err);
            },
            function (success) {

            }
          );
          return
        }
        if (parseInt(sumForQrPay) <= opts.max_pay_limit && parseInt(sumForQrPay) >= opts.min_pay_limit) {
          riotTags.innerHTML = "<view-qr-pincards>";
          opts.tax = scope.tax;
          riot.mount('view-qr-pincards', opts);

          scope.unmount()
        }
        else {
          scope.clickPinError = false;
          if (parseInt(sumForQrPay) > opts.max_pay_limit) {
            scope.errorNote = opts.lang_max_amount;
          }
          else {
            scope.errorNote = opts.lang_min_amount
          }

          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
          scope.update();
        }

      }
    };


  </script>
</view-qr-info>

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
    var sumForQrPay;
    var defaultAccount;
    scope.showPlaceHolderError = false;
    scope.menu = opts.menu.item ? opts.menu.item : [];
    //    scope.menu = [{name: "c 001", count: "1", amount: "1000"}, {
    //      name: "c 002",
    //      count: "1",
    //      amount: "1000"
    //    }, {name: "c 003", count: "1", amount: "1000"}, {name: "c 004", count: "1", amount: "100010.33"}, {
    //      name: "c 005",
    //      count: "1",
    //      amount: "1000520"
    //    }, {name: "c 006", count: "1", amount: "1000"}, {name: "c 007", count: "1", amount: "1000"}];
    scope.amount = opts.amount;
    //    scope.amount = "7000150";

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

    if (!opts.commission_percent)
      scope.showPlaceHolderError = true;

    window.saveHistory('view-qr-info', opts);

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
        opts.qrSum = scope.amount;
        opts.transactionId = parseInt(Date.now() / 1000);


//        if (parseInt(sumForQrPay) <= opts.max_pay_limit && parseInt(sumForQrPay) >= opts.min_pay_limit) {
        riotTags.innerHTML = "<view-qr-pincards>";
        opts.tax = scope.tax;
        riot.mount('view-qr-pincards', opts);

        scope.unmount()
//        }
//        else {
//          scope.clickPinError = false;
//          if (parseInt(sumForQrPay) > opts.max_pay_limit) {
//            scope.errorNote = opts.lang_max_amount;
//          }
//          else {
//            scope.errorNote = opts.lang_min_amount
//          }
//
//          window.common.alert.show("componentAlertId", {
//            parent: scope,
//            clickpinerror: scope.clickPinError,
//            errornote: scope.errorNote
//          });
//          scope.update();
//        }

      }
    };


  </script>
</view-qr-info>

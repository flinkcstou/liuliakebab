<view-qr>
  <div class="view-qr-blue-container">
    <div class="view-qr-page-title">
      <p class="view-qr-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="view-qr-company-icon" style="background-image: url({opts.image})"></div>
    <p class="view-qr-company-name">
      {opts.name}</p>
    <p class="view-qr-address-name">
      {opts.address}</p>
  </div>
  <div class="view-qr-container">

    <div class="view-qr-contact-phone-field-container">
      <div class="view-qr-contact-phone-field">
        <p class="view-qr-contact-text-field">{window.languages.ViewTransferTwoTax} {tax}
          {window.languages.Currency}</p>
        <input maxlength="13" class="view-qr-contact-number-input-part" onfocus="sumFocus()" id="sumValueId"
               onmouseup="sumMouseUp()"
               type="tel" onblur="sumOnBlur()" onkeyup="sumKeyUp()"/>
      </div>
    </div>

    <div class="view-qr-buttons-container">
      <p class="view-qr-button-cancel" ontouchend="onTouchEndDecline()" ontouchstart="onTouchStartDecline()">
        {window.languages.ViewQrTitleCancel}</p>
      <p class="view-qr-button-accept" ontouchend="onTouchEndAccept()" ontouchstart="onTouchStartAccept()">
        {window.languages.ViewQrTitleAccept}</p>
    </div>

  </div>


  <script>
    var scope = this;
    this.titleName = window.languages.ViewQrTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-qr') {
      history.arrayOfHistory.push(
        {
          "view": 'view-qr',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    this.on('mount', function () {
//      if (viewTransferStepTwo.sum.length > 0) {
//        sumValueId.value = viewTransferStepTwo.sum;
//        checkFirst = true;
//        sumForTransfer = viewTransferStepTwo.sumWithoutSpace;
//      }
//      else
      sumValueId.value = 0 + ' ' + defaultAccount.currency
    })

    var checkFirst = false,
      maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      defaultAccount;

    console.log('QR OPTS', opts);

    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    var touchStartAcceptX, touchStartAcceptY, touchStartDeclineX, touchStartDeclineY
    onTouchStartAccept = function () {

      touchStartAcceptX = event.changedTouches[0].pageX;
      touchStartAcceptY = event.changedTouches[0].pageY;
    };

    onTouchEndAccept = function () {

      touchEndAcceptX = event.changedTouches[0].pageX;
      touchEndAcceptY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndAcceptX - touchStartAcceptX) < 20 &&
        Math.abs(touchEndAcceptY - touchStartAcceptY) < 20) {
        riotTags.innerHTML = "<view-qr-pincards>";
        riot.mount('view-qr-pincards', opts);

      }
    };

    onTouchStartDecline = function () {

      touchStartDeclineX = event.changedTouches[0].pageX;
      touchStartDeclineY = event.changedTouches[0].pageY;
    };

    onTouchEndDecline = function () {

      touchEndDeclineX = event.changedTouches[0].pageX;
      touchEndDeclineY = event.changedTouches[0].pageY;

      if (Math.abs(touchEndDeclineX - touchStartDeclineX) < 20 &&
        Math.abs(touchEndDeclineY - touchStartDeclineY) < 20) {
        onBackKeyDown()
      }
    };

    sumMouseUp = function () {
      event.preventDefault()
      event.stopPropagation()
      if (!checkFirst) {
        sumValueId.value = ' ' + defaultAccount.currency
        checkFirst = true;
      }

      if (sumValueId.value.match(maskOne) != null && sumValueId.value.match(maskOne).length != null) {
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1
      } else {
        sumValueId.selectionStart = 0
        sumValueId.selectionEnd = 0
      }
    }

    sumOnBlur = function () {
      event.preventDefault()
      event.stopPropagation()

      if (sumValueId.value.length == 4) {
        sumValueId.value = '0 ' + defaultAccount.currency;
      }
    }

    var sumForQrPay;

    sumFocus = function () {
      event.preventDefault()
      event.stopPropagation()

      if (sumValueId.value.length == 5 && sumValueId.value[0] == '0') {
        sumValueId.value = ' ' + defaultAccount.currency;
      }
    }

    sumKeyUp = function () {

      if (sumValueId.value.length == 5 && sumValueId.value[0] == '0') {
        sumValueId.value = ' ' + defaultAccount.currency;
      }
      if (event.keyCode == 8) {
        sumForQrPay = sumForQrPay.substring(0, sumForQrPay.length - 1)
      }

      if (sumValueId.value.match(maskTwo) != null && sumValueId.value.match(maskTwo).length != null) {

        sumValueId.value = sumValueId.value.substring(0, event.target.value.match(maskTwo).length) + defaultAccount.currency
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        sumForQrPay = sumValueId.value.substring(0, sumValueId.value.match(maskTwo).length);
        sumForQrPay = sumForQrPay.replace(new RegExp(' ', 'g'), '');

        if (sumForQrPay.length == 4) {
          sumValueId.value = sumForQrPay.substring(0, 1) + ' ' + sumForQrPay.substring(1, sumForQrPay.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForQrPay.length == 5) {
          sumValueId.value = sumForQrPay.substring(0, 2) + ' ' + sumForQrPay.substring(2, sumForQrPay.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForQrPay.length == 6) {
          sumValueId.value = sumForQrPay.substring(0, 3) + ' ' + sumForQrPay.substring(3, sumForQrPay.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForQrPay.length == 7) {
          sumValueId.value = sumForQrPay.substring(0, 1) + ' ' + sumForQrPay.substring(1, 4) + ' ' +
            sumForQrPay.substring(4, sumForQrPay.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForQrPay.length == 8) {
          sumValueId.value = sumForQrPay.substring(0, 2) + ' ' + sumForQrPay.substring(2, 5) + ' ' +
            sumForQrPay.substring(5, sumForQrPay.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }


      } else {
        sumValueId.selectionStart = 0
        sumValueId.selectionEnd = 0
      }

      riot.update()
    }


  </script>
</view-qr>

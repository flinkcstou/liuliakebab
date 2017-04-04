<view-qr>
  <div class="view-qr-blue-container">
    <div class="view-qr-page-title">
      <p class="view-qr-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="view-qr-company-icon"></div>
    <p class="view-qr-company-name">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartOne}</p>
    <p class="view-qr-address-name">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartTwo}</p>
  </div>
  <div class="settings-container view-qr-container">

    <div class="view-qr-contact-phone-field">
      <p class="view-qr-contact-text-field">{window.languages.ViewTransferTwoTax} {tax}
        {window.languages.Currency}</p>
      <input maxlength="13" class="view-qr-contact-number-input-part" onfocus="sumFocus()" id="sumValueId"
             onmouseup="sumMouseUp()"
             type="tel" onblur="sumOnBlur()" onkeyup="sumKeyUp()"/>
    </div>

    <div class="transfer-detail-buttons-container">
      <p class="transfer-detail-button-accept" ontouchend="onTouchEndAccept()" ontouchstart="onTouchStartAccept()">
        {window.languages.ViewTransferDetailTitleAccept}</p>
      <p class="transfer-detail-button-cancel" ontouchend="onTouchEndDecline()" ontouchstart="onTouchStartDecline()">
        {window.languages.ViewTransferDetailTitleDecline}</p>
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
        sumForTransfer = sumForTransfer.substring(0, sumForTransfer.length - 1)
      }

      if (sumValueId.value.match(maskTwo) != null && sumValueId.value.match(maskTwo).length != null) {

        sumValueId.value = sumValueId.value.substring(0, event.target.value.match(maskTwo).length) + defaultAccount.currency
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        sumForTransfer = sumValueId.value.substring(0, sumValueId.value.match(maskTwo).length);
        sumForTransfer = sumForTransfer.replace(new RegExp(' ', 'g'), '');

        if (sumForTransfer.length == 4) {
          sumValueId.value = sumForTransfer.substring(0, 1) + ' ' + sumForTransfer.substring(1, sumForTransfer.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForTransfer.length == 5) {
          sumValueId.value = sumForTransfer.substring(0, 2) + ' ' + sumForTransfer.substring(2, sumForTransfer.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForTransfer.length == 6) {
          sumValueId.value = sumForTransfer.substring(0, 3) + ' ' + sumForTransfer.substring(3, sumForTransfer.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForTransfer.length == 7) {
          sumValueId.value = sumForTransfer.substring(0, 1) + ' ' + sumForTransfer.substring(1, 4) + ' ' +
            sumForTransfer.substring(4, sumForTransfer.length) + ' ' + defaultAccount.currency
          sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
          sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1

        }

        if (sumForTransfer.length == 8) {
          sumValueId.value = sumForTransfer.substring(0, 2) + ' ' + sumForTransfer.substring(2, 5) + ' ' +
            sumForTransfer.substring(5, sumForTransfer.length) + ' ' + defaultAccount.currency
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

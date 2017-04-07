<view-transfer-steptwo>
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchstart="goToBack()" class="{transfer-back-button: backbuttoncheck}"></div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
  </div>

  <div class="transfertwo-body-container">
    <div class="transfertwo-menus-container">
      <p id="cardLabelId" class="transfertwo-menu-name-label" ontouchend="card()">
        {window.languages.ViewTransferTwoSum}</p>
    </div>

    <div class="transfertwo-contact-phone-field">
      <p class="transfertwo-contact-text-field">{window.languages.ViewTransferTwoTax} {tax}
        {window.languages.Currency}</p>
      <input maxlength="13" class="transfertwo-contact-number-input-part" onfocus="sumFocus()" id="sumValueId"
             onmouseup="sumMouseUp()"
             type="tel" onblur="sumOnBlur()" onkeyup="sumKeyUp()"/>
    </div>

    <button class="transfertwo-next-button-inner-container" ontouchend="goToTransferThree()">
      {window.languages.ViewTransferTwoNext}
    </button>

    <div class="transfertwo-comment-container">
            <textarea id="commentTextId" maxlength="255" class="transfertwo-comment-input"
                      type="text" placeholder={comment}></textarea>
    </div>

  </div>

  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>


  <script>


    this.on('mount', function () {
      if (viewTransferStepTwo.sum.length > 0) {
        sumValueId.value = viewTransferStepTwo.sum;
        checkFirst = true;
        sumForTransfer = viewTransferStepTwo.sumWithoutSpace;
      }
      else
        sumValueId.value = 0 + ' ' + defaultAccount.currency
    })

    var scope = this,
      transferTitle,
      objectForTransfer = opts[0],
      defaultAccount,
      maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      checkFirst = false,
      sumForTransfer = 0;


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
//      console.log('sumValueId.value', sumValueId.value[0])
//      console.log('sumValueId.value.length', sumValueId.value.length)
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

        sumValueId.value = window.amountTransform(sumForTransfer) + ' ' + defaultAccount.currency
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length - 1
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length - 1


      } else {
        sumValueId.selectionStart = 0
        sumValueId.selectionEnd = 0
      }

      viewTransferStepTwo.sum = sumValueId.value;
      viewTransferStepTwo.sumWithoutSpace = sumForTransfer;

      scope.tax = sumForTransfer * objectForTransfer.percent / 100;
      riot.update()
    }

    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = false;
    scope.comment = 'комментарий';

    var cards = JSON.parse(localStorage.getItem('click_client_cards'));
    for (var i in cards) {
      if (cards[i].default_account === true)
        defaultAccount = cards[i];
    }


    if (objectForTransfer.type == 1) {
      transferTitle = objectForTransfer.name.substring(0, 4) + ' **** ' + objectForTransfer.name.substring(15, objectForTransfer.name.length)
    }
    else
      transferTitle = objectForTransfer.name

    if (objectForTransfer.type == 2)
      this.titleName = window.languages.ViewTransferTwoTitle + ' +' + transferTitle;
    else
      this.titleName = window.languages.ViewTransferTwoTitle + ' ' + transferTitle;
    ;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-steptwo') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-steptwo',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

    goToTransferThree = function () {
      event.preventDefault()
      event.stopPropagation()
//      console.log('objectForTransfer', objectForTransfer)
      var codeOfBank = objectForTransfer.name.replace(/\s/g, '').substring(3, 6);
      var bankList = JSON.parse(localStorage.getItem('click_client_p2p_bank_list'));
      var maxLimit;
      var minLimit;
      for (var i = 0; i < bankList.length; i++) {
        if (bankList[i].code == codeOfBank) {
          maxLimit = bankList[i].p2p_max_limit
          minLimit = bankList[i].p2p_min_limit
          break;
        }
      }
      if (!maxLimit) {
        maxLimit = 5000000;
      }

      if (!minLimit) {
        minLimit = 5000;
      }
      if (sumForTransfer < minLimit) {
        scope.clickPinError = false;
        scope.errorNote = ('Минимальная сумма 5 000');
        riot.update();
        componentAlertId.style.display = 'block';
        return;
      }
      if (sumForTransfer > maxLimit) {
        scope.clickPinError = false;
        scope.errorNote = ('Максимальная сумма 5 000 000');
        riot.update();
        componentAlertId.style.display = 'block';
        return;
      }
      var sum = {"sum": sumForTransfer};
      var comment = {"comment": commentTextId.value};

      riotTags.innerHTML = "<view-transfer-stepthree>";
      riot.mount('view-transfer-stepthree', [objectForTransfer, sum, comment, scope.tax]);
    }


  </script>
</view-transfer-steptwo>

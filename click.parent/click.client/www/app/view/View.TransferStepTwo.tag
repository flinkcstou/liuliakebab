<view-transfer-steptwo class="riot-tags-main-container">
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
      <p if="{opts[0].type == 1}" class="transfertwo-contact-text-field">{window.languages.ViewTransferTwoTax} {tax}
        {window.languages.Currency}</p>
      <input maxlength="13" class="transfertwo-contact-number-input-part" onfocus="sumFocus()" id="sumValueId"
             onmouseup="sumMouseUp()"
             type="tel" pattern="[0-9]" onblur="sumOnBlur()" onkeyup="sumKeyUp()" oninput="sumKeyUp()"/>
    </div>

    <button class="transfertwo-next-button-inner-container" ontouchstart="goToTransferThreeTouchStart()"
            ontouchend="goToTransferThreeTouchEnd()">
      {window.languages.ViewTransferTwoNext}
    </button>

    <div style="display: none" class="transfertwo-comment-container">
            <textarea id="commentTextId" maxlength="255" class="transfertwo-comment-input"
                      type="text" placeholder={comment}></textarea>
    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>


    this.on('mount', function () {
      if (viewTransferStepTwo.sum.length > 0) {
        sumValueId.value = viewTransferStepTwo.sum;
        checkFirst = true;
        sumForTransfer = viewTransferStepTwo.sumWithoutSpace;
        scope.tax = sumForTransfer * objectForTransfer.percent / 100;
      }
      else
        sumValueId.value = 0

      setTimeout(function () {
        riot.update()
      }, 0)
    })

    if (modeOfApp.offlineMode) {
      window.languages.ViewTransferTwoNext = 'Перевести'
    }

    console.log(opts)
    var scope = this,
      transferTitle,
      objectForTransfer = opts[0],
      defaultAccount,
      maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      checkFirst = false,
      sumForTransfer = 0;
    owner = opts[2];

    scope.showError = false;

    sumMouseUp = function () {
      event.preventDefault()
      event.stopPropagation()
      if (!checkFirst) {
        sumValueId.value = ''
        checkFirst = true;
      }
      if (sumValueId.value.match(maskOne) != null && sumValueId.value.match(maskOne).length != null) {
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length
      } else {
        sumValueId.selectionStart = 0
        sumValueId.selectionEnd = 0
      }
    }

    sumOnBlur = function () {
      event.preventDefault()
      event.stopPropagation()

      if (sumValueId.value.length == 0) {
        sumValueId.value = 0;
      }
    }


    sumFocus = function () {
      event.preventDefault()
      event.stopPropagation()

      if (sumValueId.value.length == 1 && sumValueId.value[0] == 0) {
        sumValueId.value = '';
      }
    }

    sumKeyUp = function () {
      //.replace(new RegExp('[^0-9]', 'g'), '');
//      console.log('sumValueId.value', sumValueId.value[0])
//      console.log('sumValueId.value.length', sumValueId.value.length)
      if (sumValueId.value.length == 1) {
        sumValueId.value = window.amountTransform(sumValueId.value.toString())
      }

      if (event.keyCode == 8) {
        sumForTransfer = sumForTransfer.substring(0, sumForTransfer.length - 1)
      }

      if (sumValueId.value.match(maskTwo) != null && sumValueId.value.match(maskTwo).length != null) {

        sumValueId.value = sumValueId.value.substring(0, event.target.value.match(maskTwo).length)
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length

        sumForTransfer = sumValueId.value.substring(0, sumValueId.value.match(maskTwo).length);
        sumForTransfer = sumForTransfer.replace(new RegExp(' ', 'g'), '');

        sumValueId.value = window.amountTransform(sumForTransfer.toString())
        sumValueId.selectionStart = sumValueId.value.match(maskTwo).length
        sumValueId.selectionEnd = sumValueId.value.match(maskTwo).length


      } else {
        sumValueId.selectionStart = 0
        sumValueId.selectionEnd = 0
      }

      viewTransferStepTwo.sum = sumValueId.value;
      viewTransferStepTwo.sumWithoutSpace = sumForTransfer;

      if (sumForTransfer >= 5000)
        scope.tax = sumForTransfer * objectForTransfer.percent / 100;
      scope.update()
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

    var goToTransferThreeTouchStartX, goToTransferThreeTouchStartY, goToTransferThreeTouchEndX, goToTransferThreeTouchEndY;

    goToTransferThreeTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      goToTransferThreeTouchStartX = event.changedTouches[0].pageX
      goToTransferThreeTouchStartY = event.changedTouches[0].pageY
    }

    goToTransferThreeTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      goToTransferThreeTouchEndX = event.changedTouches[0].pageX
      goToTransferThreeTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToTransferThreeTouchStartX - goToTransferThreeTouchEndX) <= 20 && Math.abs(goToTransferThreeTouchStartY - goToTransferThreeTouchEndY) <= 20) {

//      console.log('objectForTransfer', objectForTransfer)
        if (objectForTransfer.type == 1 && modeOfApp.onlineMode) {
          var codeOfBank = objectForTransfer.name.replace(/\s/g, '').substring(3, 6);
          console.log('CODE OF BANK', codeOfBank)
          console.log("objectForTransfer.name.replace(/\s/g, '')", objectForTransfer.name.replace(/\s/g, ''))
          var bankList = JSON.parse(localStorage.getItem('click_client_p2p_bank_list'));
          var maxLimit = 0;
          var minLimit = 0;
          for (var i = 0; i < bankList.length; i++) {
            console.log('bankList[i].code', bankList[i].code)
            if (bankList[i].code == codeOfBank) {
              console.log("EQUAL")
              maxLimit = bankList[i].p2p_max_limit
              minLimit = bankList[i].p2p_min_limit
              break;
            }
          }
        }
        else {
          maxLimit = 5000000;

          minLimit = 5000;

        }

        console.log('maxLimit', maxLimit)
        console.log('minLimit', minLimit)
        if (maxLimit == 0) {
          maxLimit = 5000000;
        }

        if (minLimit == 0) {
          minLimit = 5000;
        }
        if (sumForTransfer < minLimit) {

          sumValueId.blur();
          scope.clickPinError = false;
          scope.errorNote = ('Минимальная сумма ' + minLimit);
          scope.showError = true;
          scope.update();
          return;
        }
        if (sumForTransfer > maxLimit) {
          sumValueId.blur();
          scope.clickPinError = false;
          scope.errorNote = ('Максимальная сумма ' + maxLimit);
          scope.showError = true;
          scope.update();
          return;
        }
        var sum = {"sum": sumForTransfer};
        var comment = {"comment": commentTextId.value};


        console.log(opts)
        if (modeOfApp.offlineMode) {
          console.log("opts[0].name.replace(/\s/g, '')", opts[0].name.replace(/\s/g, ''))
          if (opts[0].type == 2) {
            phonedialer.dial(
              "*880*3*" + opts[0].name.replace(/\s/g, '') + "*" + parseInt(sumForTransfer) + "%23",
              function (err) {
                if (err == "empty") {
                  scope.clickPinError = false;
                  scope.errorNote = ("Unknown phone number");
                  scope.showError = true;
                  scope.update();
                }
                else console.log("Dialer Error:" + err);
              },
              function (success) {
                console.log('success', success)
                console.log("*880*3*" + opts[0].name.replace(/\s/g, '') + "*" + parseInt(sumForTransfer) + "%23")
              }
            );
            return
          }
          else {
            phonedialer.dial(
              "*880*" + opts[0].name.replace(/\s/g, '') + "*" + parseInt(sumForTransfer) + "%23",
              function (err) {
                if (err == "empty") {
                  scope.clickPinError = false;
                  scope.errorNote = ("Unknown phone number");
                  scope.showError = true;
                  scope.update();
                }
                else console.log("Dialer Error:" + err);
              },
              function (success) {
                console.log('success', success)
                console.log("*880*" + opts[0].name.replace(/\s/g, '') + "*" + parseInt(sumForTransfer) + "%23")
              }
            );
          }
          return
        }
        else {

          riotTags.innerHTML = "<view-transfer-stepthree>";
          riot.mount('view-transfer-stepthree', [objectForTransfer, sum, comment, scope.tax, owner]);

          scope.unmount()
        }
      }
    }


  </script>
</view-transfer-steptwo>

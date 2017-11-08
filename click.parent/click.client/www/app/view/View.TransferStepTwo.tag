<view-transfer-steptwo class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
         ontouchend="goToBackEnd()"
         class="{transfer-back-button: backbuttoncheck}"></div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
  </div>

  <div class="transfertwo-body-container">
    <div class="transfertwo-menus-container">
      <p id="cardLabelId" class="transfertwo-menu-name-label" ontouchend="card()">
        {window.languages.ViewTransferTwoSum}</p>
    </div>

    <div class="transfertwo-contact-phone-field">
      <input pattern="\d*" id="sumValueId" type="tel" maxlength="14" class="transfertwo-contact-number-input-part"
             onfocus="sumFocus()"
             onmouseup="sumMouseUp()"
             onblur="sumOnBlur()" onkeyup="sumKeyUp()" oninput="sumKeyUp()"/>
      <p if="{showPlaceHolderError}" id="placeHolderSumId" class="transfertwo-limit-title">{placeHolderText}</p>
      <p if="{!showPlaceHolderError && !modeOfApp.offlineMode}" class="transfertwo-contact-text-field">
        {window.languages.ViewTransferTwoTax} {tax}
        {window.languages.Currency}</p>
    </div>

    <button id="nextButtonId" class="transfertwo-next-button-inner-container"
            ontouchstart="goToTransferThreeTouchStart()"
            ontouchend="goToTransferThreeTouchEnd()">
      {window.languages.ViewTransferTwoNext}
    </button>

    <div style="display: none" class="transfertwo-comment-container">
            <textarea id="commentTextId" maxlength="255" class="transfertwo-comment-input"
                      type="text" placeholder={comment}></textarea>
    </div>

  </div>

  <script>

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-steptwo') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-steptwo',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    this.on('mount', function () {
      if (viewTransferStepTwo.sum.length > 0) {
        sumValueId.value = viewTransferStepTwo.sum;
        checkFirst = true;
        sumForTransfer = viewTransferStepTwo.sumWithoutSpace;

        scope.tax = sumForTransfer * objectForTransfer.percent / 100;
      }
      else
        sumValueId.value = 0


      console.log('scope.tax', scope.tax)

      if (device.platform == 'iOS') {
        sumValueId.focus()
      }
      setTimeout(function () {
        sumValueId.focus()
        riot.update()
      }, 0)
    })


    if (modeOfApp.offlineMode) {
      window.languages.ViewTransferTwoNext = 'Перевести'
    }

    console.log(opts)
    console.log(opts[0])
    console.log(opts[0].percent)
    var scope = this,
      transferTitle,
      objectForTransfer = opts[0],
      defaultAccount,
      maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      checkFirst = false,
      sumForTransfer = 0;
    owner = opts[2];

    scope.showPlaceHolderError = false;

    console.log("TAX=", objectForTransfer.percent);

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

      if (sumForTransfer)
        scope.tax = sumForTransfer * objectForTransfer.percent / 100;
      else {
        scope.tax = 0
      }

      scope.showPlaceHolderError = false;

      if (sumForTransfer > maxLimit) {

        scope.placeHolderText = 'Максимальная сумма ' + window.amountTransform(maxLimit)
        scope.showPlaceHolderError = true;
      }

      if (sumForTransfer < minLimit) {
        scope.placeHolderText = "Минимальная сумма " + window.amountTransform(minLimit)
        scope.showPlaceHolderError = true;
      }

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
      transferTitle = objectForTransfer.name.substring(0, 3) + ' ' + inputVerification.telVerificationWithSpace(objectForTransfer.name.substring(3, objectForTransfer.name.length));

    if (objectForTransfer.type == 2)
      this.titleName = window.languages.ViewTransferTwoTitle + ' +' + transferTitle;
    else
      this.titleName = window.languages.ViewTransferTwoTitle + ' ' + transferTitle;


    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    var goToTransferThreeTouchStartX, goToTransferThreeTouchStartY, goToTransferThreeTouchEndX,
      goToTransferThreeTouchEndY;

    goToTransferThreeTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      nextButtonId.style.webkitTransform = 'scale(0.8)'

      goToTransferThreeTouchStartX = event.changedTouches[0].pageX
      goToTransferThreeTouchStartY = event.changedTouches[0].pageY
    }

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
      maxLimit = 99999999999;

      minLimit = 5000;

    }

    goToTransferThreeTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      nextButtonId.style.webkitTransform = 'scale(1)'

      goToTransferThreeTouchEndX = event.changedTouches[0].pageX
      goToTransferThreeTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToTransferThreeTouchStartX - goToTransferThreeTouchEndX) <= 20 && Math.abs(goToTransferThreeTouchStartY - goToTransferThreeTouchEndY) <= 20) {

//      console.log('objectForTransfer', objectForTransfer)

        scope.showPlaceHolderError = false;

        if (sumForTransfer > maxLimit) {

          scope.placeHolderText = 'Максимальная сумма ' + window.amountTransform(maxLimit)
          scope.showPlaceHolderError = true;
          scope.update()
          return
        }

        if (sumForTransfer < minLimit) {
          scope.placeHolderText = "Минимальная сумма " + window.amountTransform(minLimit)
          scope.showPlaceHolderError = true;
          scope.update()
          return
        }
        var sum = {"sum": sumForTransfer};
        var comment = {"comment": commentTextId.value};
        objectForTransfer.transactionId = parseInt(Date.now() / 1000);


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

                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: scope.clickPinError,
                    errornote: scope.errorNote
                  });

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

                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: scope.clickPinError,
                    errornote: scope.errorNote
                  });

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

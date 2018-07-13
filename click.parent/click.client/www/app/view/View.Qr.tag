<view-qr class="riot-tags-main-container">
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
      <div id="sumField" class="view-qr-contact-phone-field">
        <p id="sumFieldTitle" class="view-qr-contact-text-field">Сумма</p>
        <p if="{!showPlaceHolderError && !modeOfApp.offlineMode}" class="view-qr-contact-number-input-commission">
          {window.languages.ViewTransferTwoTax} {tax}
          {window.languages.Currency}</p>
        <input maxlength="14" class="view-qr-contact-number-input-part" onfocus="sumFocus()" id="sumValueId"
               autofocus
               onmouseup="sumMouseUp()"
               type="tel" onblur="sumOnBlur()" oninput="sumInput()"/>
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
    var checkFirst = false,
      maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      defaultAccount;
    scope.showPlaceHolderError = false;

    var options = {
      symbol: "",
      decimal: ".",
      thousand: " ",
      precision: 0,
      format: {
        pos: "%v",
        zero: ""
      }
    };

    if (!opts.commission_percent)
      scope.showPlaceHolderError = true;

    window.saveHistory('view-qr', opts);

    this.on('mount', function () {

      if (device.platform === 'Android')
        setTimeout(function () {
          sumValueId.focus()
        }, 0);
      else {
        sumValueId.focus();
        sumValueId.autofocus
      }

      if (opts.rk_amount) {
        sumValueId.value = window.amountTransform(opts.rk_amount);
        sumForQrPay = opts.rk_amount
      }

      scope.tax = sumForQrPay * opts.commission_percent / 100;
      scope.update();

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


    sumMouseUp = function () {
      event.preventDefault();
      event.stopPropagation();
    };

    sumOnBlur = function () {
      event.preventDefault();
      event.stopPropagation();

      sumField.style.borderBottom = "" + 3 * widthK + "px solid #e8e8e8";
      sumFieldTitle.style.color = '#565d6a';

    };

    sumFocus = function () {
      event.preventDefault();
      event.stopPropagation();

      sumField.style.borderBottom = "" + 3 * widthK + "px solid #01cfff";
      sumFieldTitle.style.color = '#01cfff';

    };

    sumInput = function () {

      if (sumValueId.value.length == 1) {
        sumValueId.value = window.amountTransform(sumValueId.value.toString())
      }

      var amountInput = accounting.formatMoney(sumValueId.value, options);

      var selectionStart = sumValueId.selectionStart,
        notVerifiedValue = sumValueId.value,
        delta;

      delta = notVerifiedValue.length - amountInput.length;

      selectionStart = selectionStart - delta;
      selectionStart = (selectionStart < 0) ? (0) : (selectionStart);

      sumValueId.value = amountInput;

      setTimeout(function() {
          sumValueId.selectionStart = selectionStart;
          sumValueId.selectionEnd = selectionStart;
        }, 0
      );

      sumForQrPay = accounting.unformat(amountInput);

      if (sumForQrPay)
        scope.tax = sumForQrPay * opts.commission_percent / 100;
      else {
        scope.tax = 0
      }
      if (event.keyCode === input_codes.ENTER) {
        if (device.platform !== 'BrowserStand')
          cordova.plugins.Keyboard.close();
      }
      scope.update()
    }


  </script>
</view-qr>

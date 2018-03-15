<view-service-additional-info class="view-service-page riot-tags-main-container">
  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts.mode!='ADDAUTOPAY', autopay-method-page-title:opts.mode=='ADDAUTOPAY'}">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (window.languages.ViewAutoPayMethodSchedulerText):(categoryName)}</p>
    <div id="servicePageBackButtonId" role="button" aria-label="{window.languages.Back}" ontouchend="onTouchEndOfBack()"
         ontouchstart="onTouchStartOfBack()"
         class="{servicepage-button-back:opts.mode!='ADDAUTOPAY', autopay-method-back-button:opts.mode=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>


  <div class="servicepage-body-container">


    <p id="rangeFieldsTitle" class="service-addinfo-choose-period-text">{(code)? ("Выберите период:"):("Введите
      показания счетчика:")}</p>
    <div if="{code}" class="service-addinfo-period-containter" id="fromField" ontouchend="pickDateFrom()">
      <div class="service-addinfo-field-title">{languages.ComponentReportFilterByDateFrom}</div>
      <div class="service-addinfo-field-date"> {dateFrom}</div>
    </div>
    <div if="{code}" class="service-addinfo-period-containter" id="toField" ontouchend="pickDateTo()">
      <div class="service-addinfo-field-title">{languages.ComponentReportFilterByDateTo}</div>
      <div class="service-addinfo-field-date">{dateTo}</div>
    </div>

    <div if="{!code}" class="service-addinfo-period-containter" id="fromField">
      <input class="service-addinfo-from-input" type="tel" pattern="[0-9]" id="fromInput" placeholder="С:"
             onmouseup="periodFromInputMouseUp('from')" onkeyup="indicators()" oninput="indicators()"/>
    </div>
    <div if="{!code}" class="service-addinfo-period-containter" id="toField">
      <input class="service-addinfo-from-input" type="tel" pattern="[0-9]" id="toInput" placeholder="По:"
             onmouseup="periodFromInputMouseUp('to')" onkeyup="indicators()" oninput="indicators()"/>
    </div>


    <div class="service-addinfo-amount-field" id="amountField">
      <p id="amountFieldTitle" class="servicepage-text-field">Сумма</p>
      <p if="{commissionPercent}" class="servicepage-amount-tax-text-field">
        {window.languages.ViewServicePageAmountTaxText} {tax}
        {window.languages.Currency}</p>
      <input class="service-addinfo-amount-input" type="tel" value="{defaultAmount}" maxlength="10"
             id="amount"
             readonly="{!service['amount_editable']}"
             pattern="[0-9]"
             placeholder="{placeHolderText}"
             onmouseup="eraseAmountDefault()" onkeyup="sumForPay()" oninput="sumForPay()"/>
      <div if="{!modeOfApp.offlineMode && service['amount_editable'] && calcOn}" class="service-addinfo-amount-icon"
           ontouchstart="onTouchStartOfAmountCalculator()" role="button"
           aria-label="{window.languages.ViewServicePageVoiceOverOpenCalculator}"
           ontouchend="onTouchEndOfAmountCalculator()"></div>

      <p if="{showErrorOfLimit}" id="placeHolderSumId" class="servicepage-limit-title">{placeHolderText}</p>
    </div>

    <button id="enterButtonId"
            class="{servicepage-button-enter-enabled: enterButtonEnabled,servicepage-button-enter-disabled:!enterButtonEnabled}"
            ontouchstart="onTouchStartOfEnter()"
            ontouchend="onTouchEndOfEnter()">
      {enterButton ? (modeOfApp.offlineMode ?window.languages.ViewServicePagePayLabel:
      window.languages.ViewServicePageEnterLabel):window.languages.ViewServicePageSaveLabel}
    </button>

  </div>


  <div hidden="{!showComponent}" id="blockAmountCalculatorId" class="component-calc">
    <div id="rightButton" type="button" role="button" aria-label="{window.languages.Close}"
         class="component-banklist-close-button" ontouchstart="closeCalculatorTouchStart()"
         ontouchend="closeCalculatorTouchEnd()"></div>
    <div class="component-calc-name-title">{window.languages.ViewAmountCalculatorNameTitle}</div>

    <div class="component-calc-fields-container">

      <div class="component-calc-first-field">
        <p class="component-calc-first-field-text">{window.languages.ViewAmountCalculatorTextOne}</p>
        <input id="amountCalcInputId" class="component-calc-first-field-input-part" type="tel" autofocus="true"
               maxlength="19" onkeyup="convertAmount()"/>
      </div>

      <p class="component-calc-currency-text">{window.languages.ViewAmountCalculatorTextTwo} {currencyRate} сум</p>
      <div id="convertedAmountFieldId" class="component-calc-second-field">
        <p class="component-calc-second-field-text">{window.languages.ViewAmountCalculatorTextThree}</p>
        <p class="component-calc-second-field-input-part">{convertedAmount} сум</p>
      </div>

      <div class="component-calc-buttons-container">
        <div class="component-calc-button component-calc-cancel-button"
             ontouchstart="closeAmountComponentTouchStart()"
             ontouchend="closeAmountComponentTouchEnd()">
          <p class="component-calc-button-label component-calc-cancel-button-label">
            {window.languages.ViewAmountCalculatorCancelText}</p>
        </div>
        <div id="acceptConvertedBtnId" class="component-calc-button" ontouchstart="acceptConvertedAmountTouchStart()"
             ontouchend="acceptConvertedAmountTouchEnd()">
          <p class="component-calc-button-label">{window.languages.ViewAmountCalculatorAcceptText}</p>
        </div>
      </div>

    </div>

  </div>


  </div>

  <script>

    window.checkShowingComponent = null;
    var scope = this;
    var backStartY, backStartX, backEndY, backEndX;
    var amountCalcStartY, amountCalcStartX, amountCalcEndY, amountCalcEndX;
    var closeIconStartY, closeIconStartX, closeIconEndY, closeIconEndX;
    var closeStartY, closeStartX, closeEndY, closeEndX;
    var acceptStartY, acceptStartX, acceptEndY, acceptEndX;
    var enterStartY, enterStartX, enterEndY, enterEndX;
    scope.showErrorOfLimit = false;
    scope.selectedId = '';
    var dateFrom, dateTo;
    var range_from, range_to;
    scope.code = opts.code.value == "01";
    scope.dateTo = '';
    scope.dateFrom = '';

    console.log("opts in ServiceAdditionalInfo", opts);

    window.saveHistory('view-service-additional-info', opts);

    if (opts.id) {
      opts.chosenServiceId = opts.id;
    }
    if (opts.amountText) {
      opts.amountText = !opts.amountText ? 0 : window.amountTransform(opts.amountText.toString());
      scope.tax = opts.tax ? opts.tax : 0;

      scope.update();
    }


    scope.enterButton = opts.mode == 'ADDFAVORITE' ? false : true;
    scope.enterButtonEnabled = false;
    scope.showConfirm = false;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    this.categoryName = scope.categoryNamesMap[opts.categoryId].name;
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    scope.calcOn = scope.service.cost == 1;
    this.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.commissionPercent = scope.service.commission_percent;
    if (loginInfo)
      var sessionKey = loginInfo.session_key;

    if (!scope.service['amount_editable'] && scope.service['amount_value']) {
      scope.defaultAmount = window.amountTransform(scope.service['amount_value']);
      opts.amountText = scope.service['amount_value'];
      if (scope.service['amount_information_text']) {
        scope.showErrorOfLimit = true;
        scope.placeHolderText = scope.service['amount_information_text']
      }

      scope.enterButtonEnabled = true;
      scope.update();
    }

    if (!scope.placeHolderText)
      scope.placeHolderText = "от " + window.amountTransform(scope.service.min_pay_limit) + " " + scope.service.lang_amount_currency + " до " + window.amountTransform(scope.service.max_pay_limit) + " " + scope.service.lang_amount_currency


    scope.update(scope.categoryNamesMap);


    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();

      servicePageBackButtonId.style.webkitTransform = 'scale(0.7)';

      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfBack = onTouchEndOfBack = function () {
      event.stopPropagation();

      servicePageBackButtonId.style.webkitTransform = 'scale(1)';

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        window.viewServicePinCards = {};
        event.preventDefault();
        event.stopPropagation();
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        onBackKeyDown();
        scope.unmount()
      }
    };

    indicators = function () {
      checkFields();
    }

    pickDateFrom = function () {

      fromField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
      toField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
      amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';

      scope.showErrorOfLimit = false;

      var currentDate = new Date(),
        verifiedDate;

      var options = {
        date: new Date(),
        doneButtonLabel: window.languages.ComponentReportFilterDoneButtonLabel,
        cancelButtonLabel: window.languages.ComponentReportFilterCancelButtonLabel,
        mode: 'date',
        androidTheme: 5,
        locale: "ru_RU",
      };

      function onSuccess(pickedDate) {

        verifiedDate = pickedDate;

//        if (verifiedDate.getTime() > currentDate.getTime()) {
//
//          verifiedDate = currentDate;
//
//        }

        if (dateTo) {

          if (dateTo.getTime() < verifiedDate.getTime()) {

            verifiedDate = dateTo;
          }
        }

        dateFrom = verifiedDate;

        scope.from_dd = dateFrom.getDate();
        scope.from_mm = dateFrom.getMonth() + 1;
        scope.from_yyyy = dateFrom.getFullYear();
        scope.dateFrom = representDotedDate(scope.from_dd, scope.from_mm, scope.from_yyyy)
        console.log(dateFrom, 'dateFrom');
        console.log(scope.from_dd, 'from_dd');

        checkFields();
        scope.update();
      }

      datePicker.show(options, onSuccess);
    };

    pickDateTo = function () {

      console.log(navigator.language);

      toField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
      fromField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
      amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';

      scope.showErrorOfLimit = false;

      var currentDate = new Date(),
        verifiedDate;

      var options = {
        date: new Date(),
        doneButtonLabel: window.languages.ComponentReportFilterDoneButtonLabel,
        cancelButtonLabel: window.languages.ComponentReportFilterCancelButtonLabel,
        mode: 'date',
        androidTheme: 5,
        locale: "ru_RU",
      };

      function onSuccess(pickedDate) {

        verifiedDate = pickedDate;

//        if (verifiedDate.getTime() > currentDate.getTime()) {
//
//          verifiedDate = currentDate;
//        }

        if (dateFrom) {

          if (dateFrom.getTime() > verifiedDate.getTime()) {

            verifiedDate = dateFrom;
          }
        }

        dateTo = verifiedDate;

        scope.to_dd = dateTo.getDate();
        scope.to_mm = dateTo.getMonth() + 1;
        scope.to_yyyy = dateTo.getFullYear();
        scope.dateTo = representDotedDate(scope.to_dd, scope.to_mm, scope.to_yyyy);

        console.log(dateTo, 'dateTo');
        console.log(scope.to_dd, 'to_dd');

        checkFields();

        scope.update();
      };

      datePicker.show(options, onSuccess);
    };

    periodFromInputMouseUp = function (source) {

      scope.showErrorOfLimit = false;

      if (source == 'from') {
        fromField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        toField.style.borderBottom = 3 * widthK + 'px solid lightgrey';

      } else if (source == 'to') {
        toField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        fromField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
      }
      rangeFieldsTitle.style.color = '#01cfff';
      amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
      amountFieldTitle.style.color = 'gray';

      checkFields();

      scope.update();

    };

    scope.onTouchStartOfAmountCalculator = onTouchStartOfAmountCalculator = function () {
      event.stopPropagation();
      amountCalcStartY = event.changedTouches[0].pageY;
      amountCalcStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfAmountCalculator = onTouchEndOfAmountCalculator = function () {
      event.stopPropagation();

      amountCalcEndY = event.changedTouches[0].pageY;
      amountCalcEndX = event.changedTouches[0].pageX;

      if (Math.abs(amountCalcStartY - amountCalcEndY) <= 20 && Math.abs(amountCalcStartX - amountCalcEndX) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';

          scope.confirmNote = question;
          scope.confirmType = 'local';

          window.common.alert.show("componentConfirmId", {
            parent: scope,
            "confirmnote": scope.confirmNote,
            "confirmtype": scope.confirmType
          });

          scope.result = function (bool) {
            if (bool) {
              localStorage.clear();
              window.location = 'index.html';
              scope.unmount();
              return
            }
            else {
              window.common.alert.hide("componentConfirmId");
              return
            }
          };
          scope.update();

          return
        }

        window.api.call({
          method: 'rate.convert',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            amount: 1
          },

          scope: this,

          onSuccess: function (result) {
            console.log('rate.convert', result);
            if (result[0][0].error == 0) {

              scope.currencyRate = result[1][0].current_rate;
              scope.update(scope.currencyRate);
            }
            else {
              scope.errorNote = result[0][0].error_note;

              window.common.alert.show("componentAlertId", {
                parent: scope,
                errornote: scope.errorNote
              });

              scope.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              errornote: api_status_message
            });
          }
        });

        window.blurFields();

        scope.showComponent = true;
        window.checkShowingComponent = scope;
        amountCalcInputId.focus();
        scope.update();
      }
    };

    scope.closeCalculatorTouchStart = closeCalculatorTouchStart = function () {
      event.stopPropagation();
      closeIconStartY = event.changedTouches[0].pageY;
      closeIconStartX = event.changedTouches[0].pageX;
    };

    scope.closeCalculatorTouchEnd = closeCalculatorTouchEnd = function () {
      event.stopPropagation();

      closeIconEndY = event.changedTouches[0].pageY;
      closeIconEndX = event.changedTouches[0].pageX;

      if (Math.abs(closeIconStartY - closeIconEndY) <= 20 && Math.abs(closeIconStartX - closeIconEndX) <= 20) {
        scope.showComponent = false;
        window.checkShowingComponent = null;
        scope.update();
      }
    };

    scope.closeAmountComponentTouchStart = closeAmountComponentTouchStart = function () {
      event.stopPropagation();
      closeStartY = event.changedTouches[0].pageY;
      closeStartX = event.changedTouches[0].pageX;
    };

    scope.closeAmountComponentTouchEnd = closeAmountComponentTouchEnd = function () {
      event.stopPropagation();

      closeEndY = event.changedTouches[0].pageY;
      closeEndX = event.changedTouches[0].pageX;

      if (Math.abs(closeStartY - closeEndY) <= 20 && Math.abs(closeStartX - closeEndX) <= 20) {
        scope.showComponent = false;
        window.checkShowingComponent = null;
        scope.update();
      }
    };

    convertAmount = function () {
      var converted;
      scope.convertedAmount = 0;

      scope.convertedAmount = Math.ceil(amountCalcInputId.value * scope.currencyRate);
      converted = window.amountTransform(scope.convertedAmount.toString());

      if (scope.convertedAmount > scope.service.max_pay_limit) {
        convertedAmountFieldId.style.borderBottomColor = 'red';
        acceptConvertedBtnId.style.pointerEvents = 'none';
        scope.convertedAmount = converted;
        scope.update(scope.convertedAmount);
      } else {
        convertedAmountFieldId.style.borderBottomColor = '#01cfff';
        acceptConvertedBtnId.style.pointerEvents = 'auto';
        scope.convertedAmount = converted;
        scope.update(scope.convertedAmount);
      }
    };

    scope.acceptConvertedAmountTouchStart = acceptConvertedAmountTouchStart = function () {
      event.stopPropagation();
      acceptStartY = event.changedTouches[0].pageY;
      acceptStartX = event.changedTouches[0].pageX;
    };

    scope.acceptConvertedAmountTouchEnd = acceptConvertedAmountTouchEnd = function () {
      event.stopPropagation();

      acceptEndY = event.changedTouches[0].pageY;
      acceptEndX = event.changedTouches[0].pageX;

      if (Math.abs(acceptStartY - acceptEndY) <= 20 && Math.abs(acceptStartX - acceptEndX) <= 20) {
        amount.value = scope.convertedAmount;


        if (amount.value.match(maskTwo) != null && amount.value.match(maskTwo).length != null) {

          amount.value = amount.value.substring(0, amount.value.match(maskTwo).length);

          amountForPayTransaction = amount.value.substring(0, amount.value.match(maskTwo).length);
          amountForPayTransaction = amountForPayTransaction.replace(new RegExp(' ', 'g'), '');

          amount.value = window.amountTransform(amountForPayTransaction);
          checkFirst = true;
        }

        opts.amountText = amount.value;
        opts.amountWithoutSpace = amountForPayTransaction;
        scope.showComponent = false;
        window.checkShowingComponent = null;
        scope.update();
        checkFields();
      }
    };

    var maskOne = /[0-9]/g,
      maskTwo = /[0-9' ']/g,
      amountForPayTransaction = 0,
      checkFirst = false;


    eraseAmountDefault = function () {
      console.log("in erase amount default");
      event.preventDefault();
      event.stopPropagation();

      if (!checkFirst) {
//        amount.value = '';
        checkFirst = true;
      }
      if (amount.value.match(maskOne) != null && amount.value.match(maskOne).length != null) {
        amount.selectionStart = amount.value.match(maskTwo).length;
        amount.selectionEnd = amount.value.match(maskTwo).length;
      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
      amountFieldTitle.style.color = '#01cfff';
      fromField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
      toField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
      rangeFieldsTitle.style.color = 'gray';

      checkFields('sum')
    };

    sumForPay = function () {
      event.preventDefault();
      event.stopPropagation();

      if (amount.value.length == 1) {
        amount.value = window.amountTransform(amount.value)
      }

      if (event.keyCode == 8) {
        amountForPayTransaction = amountForPayTransaction.substring(0, amountForPayTransaction.length - 1)
      }

      if (amount.value.match(maskTwo) != null && amount.value.match(maskTwo).length != null) {

        amount.value = amount.value.substring(0, event.target.value.match(maskTwo).length);
        amount.selectionStart = amount.value.match(maskTwo).length;
        amount.selectionEnd = amount.value.match(maskTwo).length;

        amountForPayTransaction = amount.value.substring(0, amount.value.match(maskTwo).length);
        amountForPayTransaction = amountForPayTransaction.replace(new RegExp(' ', 'g'), '');

        amount.value = window.amountTransform(amountForPayTransaction);

      } else {
        amount.selectionStart = 0;
        amount.selectionEnd = 0;
      }

      opts.amountText = amount.value;
      opts.amountWithoutSpace = amountForPayTransaction;

      if (amountForPayTransaction >= 1000) {
        scope.tax = amountForPayTransaction * scope.commissionPercent / 100;
        opts.tax = scope.tax;
      }
      scope.update();
      checkFields('sum');
    };


    checkFields = function (from) {
      if (!scope.service['amount_editable']) return;

      if (amountForPayTransaction < scope.service.min_pay_limit) {

        if (from == 'sum' && amount.value.length != 0) {
          scope.showErrorOfLimit = true;
          amountField.style.borderBottom = 3 * widthK + 'px solid red';
          amountFieldTitle.style.color = 'red';
          scope.update();
          placeHolderSumId.style.color = 'red';
        }
        scope.enterButtonEnabled = false;
        scope.update();
        return;
      }
      else if (from == 'sum' && amountField.length >= 1) {
        amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        amountFieldTitle.style.color = '#01cfff';
        scope.showErrorOfLimit = false;
        scope.update()
      }
      if (amountForPayTransaction > scope.service.max_pay_limit) {
        if (from == 'sum' && amount.value.length != 0) {
          scope.showErrorOfLimit = true;
          amountField.style.borderBottom = 3 * widthK + 'px solid red';
          amountFieldTitle.style.color = 'red';
          scope.update();
          placeHolderSumId.style.color = 'red';
        }
        scope.enterButtonEnabled = false;
        scope.update();
        return;
      }
      else if (from == 'sum') {
        amountField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        amountFieldTitle.style.color = '#01cfff';
        scope.showErrorOfLimit = false;
        scope.update()
      }

      if (scope.code) {
        if (!dateFrom || !dateTo) {
          console.log("dates ", dateFrom, dateTo)
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        } else {
          range_from = representDotedDate(scope.from_dd, scope.from_mm, scope.from_yyyy)
          range_to = representDotedDate(scope.to_dd, scope.to_mm, scope.to_yyyy);
        }
      } else {
        if (!fromInput.value || !toInput.value) {
          console.log("indicators ", fromInput.value, toInput.value)
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        } else {
          range_from = fromInput.value;
          range_to = toInput.value;
        }
      }

      scope.enterButtonEnabled = true;
      scope.update(scope.enterButtonEnabled);

    };

    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled)
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';

      enterStartY = event.changedTouches[0].pageY;
      enterStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfEnter = onTouchEndOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled)
        this.enterButtonId.style.webkitTransform = 'scale(1)';

      enterEndY = event.changedTouches[0].pageY;
      enterEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterStartY - enterEndY) <= 20 && Math.abs(enterStartX - enterEndX) <= 20) {

        window.blurFields();

        opts.amountText = amountForPayTransaction;

        for (var i in opts.paymentDataAttributes) {
          if (opts.paymentDataAttributes[i].value == 'region_id')
            opts.paymentDataAttributes[i].value = opts.communalParam;
          else if (opts.paymentDataAttributes[i].value == 'range_from')
            opts.paymentDataAttributes[i].value = range_from;
          else if (opts.paymentDataAttributes[i].value == 'range_to')
            opts.paymentDataAttributes[i].value = range_to;
        }


        history.arrayOfHistory[history.arrayOfHistory.length - 1].params = opts;
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

        this.riotTags.innerHTML = "<view-service-pincards-new>";
        riot.mount('view-service-pincards-new', opts);
        scope.unmount()

      }
    };


  </script>
</view-service-additional-info>

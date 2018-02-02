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

    <p class="service-addinfo-choose-period-text">Выберите период:</p>
    <div class="service-addinfo-period-containter" ontouchend="pickDateFrom()">
      <div class="service-addinfo-field">{languages.ComponentReportFilterByDateFrom} {from_dd}.{from_mm}.{from_yyyy}
      </div>
    </div>
    <div class="service-addinfo-period-containter" ontouchend="pickDateTo()">
      <div class="service-addinfo-field">{languages.ComponentReportFilterByDateTo} {to_dd}.{to_mm}.{to_yyyy}</div>
    </div>

    <div class="service-addinfo-amount-field" id="amountField">
      <p class="servicepage-text-field">Сумма</p>
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


    <div if="{false}">

      <div class="service-addinfo-period-field">
        <p class="servicepage-text-field">Выберите период:</p>
        <input class="service-addinfo-from-input" type="tel" id="from" readonly="true"
               ontouchend="pickDateFrom()"/>
      </div>
      <div class="service-addinfo-from-field">
        <input class="service-addinfo-from-input" type="tel" id="to" readonly="true"
               ontouchend="pickDateTo()"/>
      </div>

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

    pickDateFrom = function () {

      var currentDate = new Date(),
        verifiedDate;

      var options = {
        date: new Date(),
        doneButtonLabel: window.languages.ComponentReportFilterDoneButtonLabel,
        cancelButtonLabel: window.languages.ComponentReportFilterCancelButtonLabel,
        mode: 'date',
        androidTheme: 5
      };

      function onSuccess(pickedDate) {

        verifiedDate = pickedDate;

        if (verifiedDate.getTime() > currentDate.getTime()) {

          verifiedDate = currentDate;

        }

        if (dateTo) {

          if (dateTo.getTime() < verifiedDate.getTime()) {

            verifiedDate = dateTo;
          }
        }

        dateFrom = verifiedDate;

        scope.from_dd = dateFrom.getDate();
        scope.from_mm = dateFrom.getMonth() + 1;
        scope.from_yyyy = dateFrom.getFullYear();

        scope.update();
      }

      datePicker.show(options, onSuccess);
    };

    pickDateTo = function () {

      var currentDate = new Date(),
        verifiedDate;

      var options = {
        date: new Date(),
        doneButtonLabel: window.languages.ComponentReportFilterDoneButtonLabel,
        cancelButtonLabel: window.languages.ComponentReportFilterCancelButtonLabel,
        mode: 'date',
        androidTheme: 5
      };

      function onSuccess(pickedDate) {

        verifiedDate = pickedDate;

        if (verifiedDate.getTime() > currentDate.getTime()) {

          verifiedDate = currentDate;
        }

        if (dateFrom) {

          if (dateFrom.getTime() > verifiedDate.getTime()) {

            verifiedDate = dateFrom;
          }
        }

        dateTo = verifiedDate;

        scope.to_dd = dateTo.getDate();
        scope.to_mm = dateTo.getMonth() + 1;
        scope.to_yyyy = dateTo.getFullYear();

        scope.update();
      };

      datePicker.show(options, onSuccess);
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
        checkFieldsToActivateNext();
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
      firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';

      checkFieldsToActivateNext('sum')

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
      checkFieldsToActivateNext('sum');
    };

    bordersColor = function () {

      event.preventDefault();
      event.stopPropagation();


      firstField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
      amountField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
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


        history.arrayOfHistory[history.arrayOfHistory.length - 1].params = opts;
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


        if (opts.mode == 'USUAL' || opts.mode == 'POPULAR' || !opts.mode) {

          opts.isInFavorites = !scope.enterButton;

          event.preventDefault();
          event.stopPropagation();


          if (modeOfApp.offlineMode) {

            console.log('USSD TEMPLATE', scope.fieldArray[0].ussd_query)

            var ussdQuery = scope.fieldArray[0].ussd_query;

            console.log('opts.formtype', opts)
            console.log("opts in ussd", JSON.stringify(opts))


            if (opts.formtype == 1 && ussdQuery) {
              if (opts.firstFieldText) {
                ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              }
              else {
                ussdQuery = ussdQuery.replace('*{param}', opts.firstFieldText);
              }
//              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (opts.formtype == 2 && ussdQuery) {
//              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (opts.formtype == 3 && ussdQuery) {
              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (opts.formtype == 4 && ussdQuery) {
              console.log('ussdQuery', ussdQuery)
//              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
              ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
              console.log(ussdQuery)
            }

            if (ussdQuery === null) {
              scope.clickPinError = false;
              scope.errorNote = ("Сервис временно недоступен!");

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote,
              });

              scope.update();
              return
            }

            console.log('USSD', ussdQuery, opts)

            console.log(ussdQuery)

            phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
              ussdQuery + "%23",
              function (err) {
                if (err == "empty") {
                  scope.clickPinError = false;
                  scope.errorNote = ("Unknown phone number");

                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: scope.clickPinError,
                    errornote: scope.errorNote,
                  });

                  scope.update();
                }
                else console.log("Dialer Error:" + err);
              },
              function (success) {
              }
            );
            return
          }
          else {

            if (scope.service.additional_information_type == 0) {
              this.riotTags.innerHTML = "<view-service-pincards-new>";
              riot.mount('view-service-pincards-new', opts);
              scope.unmount()
            } else {
              localStorage.setItem('click_client_infoCacheEnabled', null)
              this.riotTags.innerHTML = "<view-service-info-new>";
              riot.mount('view-service-info-new', opts);
              scope.unmount()
            }


          }
        } else if (opts.mode == 'ADDFAVORITE') {

          console.log("isInFavorites=", opts.isInFavorites)

          opts.favoriteName = favoriteNameInput.value;
          viewServicePinCards.friendHelpPaymentMode = false;
          viewServicePinCards.chosenFriendForHelp = null;

          if (opts.isInFavorites) {
            editFavorite(opts);
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown();
          }
          else {
            opts.isInFavorites = true;
            addToFavoritesinServicePage(opts);
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown();
            onBackKeyDown();
          }


        } else if (opts.mode == 'ADDAUTOPAY') {

          if (autoPayNameInput.value.length < 1) {
            scope.clickPinError = false;
            scope.errorNote = "Введите название автоплатежа";

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
            });

            scope.update();
            return;
          }

          scope.autoPayData.name = autoPayNameInput.value;
          localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

          if (scope.autoPayData.fromView == 'PAY') {
            this.riotTags.innerHTML = "<view-service-pincards-new>";
            riot.mount('view-service-pincards-new', opts);
            scope.unmount()

          } else if (scope.autoPayData.fromView == 'PAYCONFIRM') {
            this.riotTags.innerHTML = "<view-pay-confirm-new>";
            riot.mount('view-pay-confirm-new', opts);
            scope.unmount()

          }

        }

      }
    };

    addToFavoritesinServicePage = function (array) {

      var favoritePaymentsList, favoritePaymentsListForApi;

      var id = Math.floor((Math.random() * 1000000) + 1);

      favoritePaymentsList = localStorage.getItem('favoritePaymentsList') ? JSON.parse(localStorage.getItem('favoritePaymentsList')) : [];
      favoritePaymentsListForApi = localStorage.getItem('favoritePaymentsListForApi') ? JSON.parse(localStorage.getItem('favoritePaymentsListForApi')) : [];


      if (favoritePaymentsListForApi.length != favoritePaymentsList.length) {
        favoritePaymentsListForApi = [];
        for (var i in favoritePaymentsList) {
          favoritePaymentsListForApi.push({
            "id": favoritePaymentsList[i].id,
            "type": 1,
            "body": JSON.stringify(favoritePaymentsList[i])
          })
        }
      }

      var newfavorite = {
        "params": array,
        "service": scope.service,
        "ussd": scope.fieldArray[0].ussd_query,
        "id": id
      };

      favoritePaymentsList.push(newfavorite);
      favoritePaymentsListForApi.push({
        "id": id,
        "type": 1,
        "body": JSON.stringify(newfavorite)
      });

      localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));


      window.api.call({
        method: 'add.favourite',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          wishlist_data: favoritePaymentsListForApi
        },

        scope: this,

        onSuccess: function (result) {

          if (result[0][0].error == 0) {

            console.log("SUCCESSFULLY ADDED")

          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote
            });

            scope.update();
            console.log(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });


    };

    editFavorite = function (params) {

      var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));

      for (var i in favoritePaymentsList) {
        if (favoritePaymentsList[i].id == opts.favoriteId) {
          favoritePaymentsList[i].params = params;

          var editedfavorite = {
            "id": favoritePaymentsList[i].id,
            "type": 1,
            "body": JSON.stringify(favoritePaymentsList[i])
          };

          for (var j in favoritePaymentsListForApi) {
            if (favoritePaymentsListForApi[i].id == opts.favoriteId) {
              favoritePaymentsListForApi[i] = editedfavorite;
              break;
            }
          }

          window.api.call({
            method: 'update.favourite',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              wishlist_data: editedfavorite
            },

            scope: this,

            onSuccess: function (result) {

              if (result[0][0].error == 0) {

                console.log("SUCCESSFULLY edited")

              }
              else {
                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote
                });

                scope.update();
                console.log(result[0][0].error_note);
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });

          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
          localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));

          break;

        }
      }
    };


  </script>
</view-service-additional-info>

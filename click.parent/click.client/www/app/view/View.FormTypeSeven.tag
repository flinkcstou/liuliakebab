<view-formtype-seven class="riot-tags-main-container">

  <div id="servicePageId" class="view-common-page">

    <div class="pay-page-title page-title-shadow" style="border-style: none;">
      <p class="servicepage-title">
        {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
        {titleName}</p>
      <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
        (window.languages.ViewAutoPayMethodSchedulerText):(categoryName)}</p>
      <div id="servicePageBackButtonId" role="button" aria-label="{window.languages.Back}"
           ontouchend="onTouchEndOfBack()"
           ontouchstart="onTouchStartOfBack()"
           class="servicepage-button-back">
      </div>
      <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
           style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="servicepage-body-container">

      <div id="autopayField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
        <p id="autoPayNameTitle" class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="checkFieldsToActivateNext()"
               onfocus="colorFieldGlobal('autopayField','autoPayNameTitle')"
               onblur="blurFieldGlobal('autopayField','autoPayNameTitle')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="checkFieldsToActivateNext()" onfocus="colorFieldGlobal('favoriteField','favoriteNameTitle')"
               onblur="blurFieldGlobal('favoriteField','favoriteNameTitle')"/>
      </div>

      <div class="servicepage-first-field" id="firstField">
        <p id="firstFieldTitle" class="servicepage-text-field">{chosenFieldName}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="{inputType}" id="firstFieldInput"
               onfocus="colorFieldGlobal('firstField','firstFieldTitle')"
               onblur="blurFieldGlobal('firstField','firstFieldTitle')"
               value="{defaultNumber || opts.first_field_value}"
               maxlength="7"
               oninput="telVerificationOnInput()" onpaste="telVerificationOnPaste()"
               onkeyup="telPayVerificationKeyUp()" onkeydown="telPayVerificationKeyDown(this)"/>
      </div>

      <div id="secondFieldId" class="servicepage-first-field">
        <p id="secondFieldTitle" class="servicepage-text-field">{secondFieldTitle}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="secondFieldInput"
               onkeyup="checkFieldsToActivateNext()" onfocus="colorFieldGlobal('secondFieldId','secondFieldTitle')"
               onblur="blurFieldGlobal('secondFieldId','secondFieldTitle')" value="{opts.secondFieldValue}"/>
      </div>


      <button id="enterButtonId" style="bottom: {window.bottomButtonBottom}"
              class="{servicepage-button-enter-enabled: enterButtonEnabled,servicepage-button-enter-disabled:!enterButtonEnabled}"
              ontouchstart="onTouchStartOfEnter()"
              ontouchend="onTouchEndOfEnter()">
        {enterButton ? (modeOfApp.offlineMode ?window.languages.ViewServicePagePayLabel:
        window.languages.ViewServicePageEnterLabel):window.languages.ViewServicePageSaveLabel}
      </button>

    </div>

  </div>

  <script>

    window.checkShowingComponent = null;
    var scope = this;
    var backStartY, backStartX, backEndY, backEndX;
    var cursorPositionSelectionStart, cursorPositionSelectionEnd, oldValueOfNumber;

    var enterStartY, enterStartX, enterEndY, enterEndX;
    var contactStopChanging = false;
    var onPaste = false;

    console.log("opts in FormTypeSeven", opts);

    window.saveHistory('view-formtype-seven', opts);

    if (opts.id) {
      opts.chosenServiceId = opts.id;
    }

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    onBackParams.opts = JSON.parse(JSON.stringify(opts));
    scope.enterButton = opts.mode == 'ADDFAVORITE' ? false : true;
    scope.enterButtonEnabled = false;
    scope.showConfirm = false;

    scope.update();


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

    checkFieldsToActivateNext = function () {

      console.log("CHECK fields");

      if (opts.mode == 'ADDAUTOPAY' && this.autoPayNameInput && this.autoPayNameInput.value.length < 1) {
        console.log("Введите название автоплатежа");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      if (opts.mode == 'ADDFAVORITE' && this.favoriteNameInput && this.favoriteNameInput.value.length < 1) {
        console.log("Введите название избранного платежа");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      if (scope.phoneFieldBool && this.firstFieldInput) {

        if (firstFieldInput.value.length < 7) {
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        }

      } else if (this.firstFieldInput && firstFieldInput.value.length == 0) {
        console.log("Нет значения первого поля");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      if (this.secondFieldInput && secondFieldInput.value.length == 0) {
        console.log("Нет значения второго поля");
        scope.enterButtonEnabled = false;
        scope.update(scope.enterButtonEnabled);
        return;
      }

      scope.enterButtonEnabled = true;
      scope.update(scope.enterButtonEnabled);

    };

    telPayVerificationKeyDown = function (input) {
//
//      if (scope.phoneFieldBool)
//        if (input.value.length >= 10 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
//          contactStopChanging = true;
//        }
//        else {
//          contactStopChanging = false;
//        }
    };

    telVerificationOnPaste = function () {
//      onPaste = true;
    };

    telVerificationOnInput = function () {
//      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT && onPaste) {
//        if (firstFieldInput.type != 'text' && scope.phoneFieldBool)
//          firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(firstFieldInput.value))
//
//        onPaste = false;
//      }
    };

    telPayVerificationKeyUp = function () {
//
//      if (contactStopChanging) {
//        firstFieldInput.value = event.target.value.substring(0, event.target.value.length - 1);
//      }
//
//      cursorPositionSelectionStart = firstFieldInput.selectionStart;
//      cursorPositionSelectionEnd = firstFieldInput.selectionEnd;
//      oldValueOfNumber = firstFieldInput.value;
//
//      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
//        if (firstFieldInput.type != 'text' && scope.phoneFieldBool)
//          firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(firstFieldInput.value));
//
//        if (!onPaste) {
//          firstFieldInput.selectionStart = cursorPositionSelectionStart;
//          firstFieldInput.selectionEnd = cursorPositionSelectionEnd;
//        }
//
//        if (oldValueOfNumber != firstFieldInput.value && cursorPositionSelectionStart == 3)
//          firstFieldInput.selectionStart = cursorPositionSelectionStart + 1;
//
//      }

      checkFieldsToActivateNext();
    };


    this.on('mount', function () {

      focusFieldAfterTourClosed();

//      if (opts && opts.number) {
//        firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.number));
//        scope.update();
//      }

      checkFieldsToActivateNext();

    });

    scope.focusFieldAfterTourClosed = focusFieldAfterTourClosed = function () {

      if (opts.mode != 'ADDAUTOPAY' && opts.mode != 'ADDFAVORITE') {

        focusFieldGlobal('firstFieldInput');

      } else if (opts.mode == 'ADDAUTOPAY') {

        focusFieldGlobal('autoPayNameInput');

      } else if (opts.mode == 'ADDFAVORITE') {

        focusFieldGlobal('favoriteNameInput');

      }
      scope.update()
    };

    if (scope.servicesMap[opts.chosenServiceId]) {
      scope.service = scope.servicesMap[opts.chosenServiceId][0];
      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;
    }


    scope.fieldArray = scope.servicesParamsMapOne[opts.chosenServiceId];
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;
    scope.secondFieldTitle = scope.service.options_title;
    console.log("Yahoo1 formType=", scope.formType);

    if (scope.fieldArray) {
      scope.chosenFieldName = opts.firstFieldTitle ? opts.firstFieldTitle : scope.fieldArray[0].title;
      opts.first_field_value = opts.firstFieldText ? opts.firstFieldText : null;
      console.log("PARAMETER ID ", scope.fieldArray[0].parameter_id, scope.fieldArray[0])
      console.log("Service ", scope.service)
      scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1" || scope.fieldArray[0].parameter_id == "65536" || scope.fieldArray[0].parameter_id == "128";


      if (scope.phoneFieldBool) {
//        scope.defaultNumber = !opts.firstFieldText ? null : inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.firstFieldText));
        scope.defaultNumber = opts.firstFieldText;
        console.log("PHONE FIELD", scope.defaultNumber);
      }

      scope.update();
      scope.inputMaxLength = scope.fieldArray[0].max_len;

      if (scope.fieldArray[0].input_type == '1' && modeOfApp.onlineMode) {
        scope.inputType = 'tel';
        scope.isNumber = true;
      }
      else if (scope.fieldArray[0].input_type == '2' && modeOfApp.onlineMode) {
        scope.inputType = 'text';
        scope.isNumber = false;
      }
      else if (modeOfApp.offlineMode) {
        scope.inputType = 'tel';
        scope.isNumber = true;
      }
    }

    checkFieldsToActivateNext();


    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';
      }

      enterStartY = event.changedTouches[0].pageY;
      enterStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfEnter = onTouchEndOfEnter = function () {
      event.stopPropagation();

      opts.cost = scope.service.cost;
      opts.lang_amount_title = scope.service.lang_amount_title;

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(1)';
      }

      enterEndY = event.changedTouches[0].pageY;
      enterEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterStartY - enterEndY) <= 20 && Math.abs(enterStartX - enterEndX) <= 20) {

        window.blurFields();

        opts.formtype = scope.formType;
        opts.firstFieldId = scope.chosenFieldParamId;
        opts.firstFieldText = firstFieldInput.value;
        opts.firstFieldTitle = scope.chosenFieldName;
        opts.secondFieldValue = secondFieldInput.value;
        opts.amountText = 0;

        history.arrayOfHistory[history.arrayOfHistory.length - 1].params = opts;
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


        if (opts.mode == 'USUAL' || opts.mode == 'POPULAR' || !opts.mode) {

          opts.isInFavorites = !scope.enterButton;
          opts.transactionId = parseInt(Date.now() / 1000);

          event.preventDefault();
          event.stopPropagation();


          if (modeOfApp.offlineMode) {

            console.log('USSD TEMPLATE', scope.fieldArray[0].ussd_query)

            var ussdQuery = scope.fieldArray[0].ussd_query;

//            console.log('opts.formtype', opts)
//            console.log("opts in ussd", JSON.stringify(opts))
//
//
//            if (opts.formtype == 7 && ussdQuery) {
//              if (opts.firstFieldText) {
//                ussdQuery = ussdQuery.replace('{param}', opts.firstFieldText);
//              }
//              else {
//                ussdQuery = ussdQuery.replace('*{param}', opts.firstFieldText);
//              }
////              ussdQuery = ussdQuery.replace('{communal_param}', opts.communalParam);
//              ussdQuery = ussdQuery.replace('{option}', opts.chosenPrefixId);
//              ussdQuery = ussdQuery.replace('{amount}', opts.amountText);
//              ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
//              console.log(ussdQuery)
//            }


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

            console.log(ussdQuery + "%23")

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
              getInformation();
            }


          }
        } else if (opts.mode == 'ADDFAVORITE') {

          console.log("isInFavorites=", opts.isInFavorites)

          opts.favoriteName = favoriteNameInput.value;
          viewServicePinCards.friendHelpPaymentMode = false;
          viewServicePinCards.chosenFriendForHelp = null;

          if (opts.isInFavorites) {
            editFavoritePaymentGlobal(opts, opts.favoriteId, scope);
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown();
          }
          else {
            opts.isInFavorites = true;
            addPaymentToFavorites(opts, scope.service, scope.fieldArray[0].ussd_query, scope);
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

    function getInformation() {

      var payment_data, timeOutTimer = 0;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      if (loginInfo)
        var sessionKey = loginInfo.session_key;

      window.startSpinner();

      payment_data = {
        "value": opts.firstFieldText,
        "secondary_value": opts.secondFieldValue,
        "transaction_id": opts.transactionId
      };

      console.log("payment data =", payment_data);

      window.api.call({
        method: 'get.additional.information',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          service_id: opts.chosenServiceId,
          payment_data: payment_data
        },
        scope: this,

        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimer);
          window.stopSpinner();
          window.clearTimeout(timeOutTimer);
          if (result[0][0].error == 0) {
            opts.getInformation = result[1];
            localStorage.setItem('click_client_infoCacheEnabled', null);
            this.riotTags.innerHTML = "<view-formtype-seven-getinfo>";
            riot.mount('view-formtype-seven-getinfo', opts);
            scope.unmount();
          }
          else {
            scope.errorMessage = result[0][0].error_note;
            scope.stepAmount = 1;
            window.common.alert.show("componentUnsuccessId", {
              parent: scope,
//              step_amount: scope.stepAmount,
              operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
              operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
              operationmessagepartthree: scope.errorMessage
            });
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          scope.stepAmount = 1;
          window.common.alert.show("componentUnsuccessId", {
            parent: scope,
//            step_amount: scope.stepAmount,
            operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
            operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
            operationmessagepartthree: api_status_message
          });
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'get.additional.information'
            });
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 1;
            scope.update();

            window.common.alert.show("componentAlertId", {
              parent: scope,
//              step_amount: scope.stepAmount,
              viewmount: true,
              errornote: scope.errorNote
            });
            window.stopSpinner();
          }, 15000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      }, 15000);
    }


  </script>
</view-formtype-seven>

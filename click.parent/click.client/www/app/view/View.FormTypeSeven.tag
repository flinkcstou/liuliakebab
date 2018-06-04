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
               autofocus="true" onkeyup="paymentNameVerificationKeyUp()" onfocus="colorField('autopay')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="paymentNameVerificationKeyUp()" onfocus="colorField('favorite')"/>
      </div>

      <div class="servicepage-first-field" id="firstField"
           hidden="{modeOfApp.offlineMode && opts.chosenServiceId == 'mynumber'}">
        <p id="firstFieldTitle" class="servicepage-text-field">{chosenFieldName}</p>

        <input class="servicepage-number-input-part" type="{inputType}" id="firstFieldInput"
               onfocus="colorField('firstField')" value="{defaultNumber || opts.first_field_value}"
               oninput="telVerificationOnInput()" onpaste="telVerificationOnPaste()"
               onkeyup="telPayVerificationKeyUp()" onkeydown="telPayVerificationKeyDown(this)"/>
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

    scope.enterButton = opts.mode == 'ADDFAVORITE' ? false : true;
    scope.enterButtonEnabled = false;
    scope.showConfirm = false;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    if (loginInfo)
      var sessionKey = loginInfo.session_key;

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

    checkFieldsToActivateNext = function (from) {

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

      if (this.firstFieldInput) {

        if (scope.phoneFieldBool && firstFieldInput && opts.chosenServiceId != "mynumber") {

          if (firstFieldInput.value.length < 7) {
            scope.enterButtonEnabled = false;
            scope.update(scope.enterButtonEnabled);
            return;
          }

        } else if (firstFieldInput && firstFieldInput.value.length == 0 && opts.chosenServiceId != "mynumber") {
          console.log("Нет значения первого поля");
          scope.enterButtonEnabled = false;
          scope.update(scope.enterButtonEnabled);
          return;
        }
      }

      scope.enterButtonEnabled = true;
      scope.update(scope.enterButtonEnabled);


    };

    telPayVerificationKeyDown = function (input) {

      if (scope.phoneFieldBool)
        if (input.value.length >= 10 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
          contactStopChanging = true;
        }
        else {
          contactStopChanging = false;
        }
    };

    telVerificationOnPaste = function () {
      onPaste = true;
    };

    telVerificationOnInput = function () {
      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT && onPaste) {
        if (firstFieldInput.type != 'text' && scope.phoneFieldBool)
          firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(firstFieldInput.value))

        onPaste = false;
      }
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

    paymentNameVerificationKeyUp = function () {

      checkFieldsToActivateNext();

    };

    this.on('mount', function () {

      focusFieldAfterTourClosed();

      if (opts && opts.number) {
        firstFieldInput.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.number));
        scope.update();
      }

      checkFieldsToActivateNext();

    });

    scope.focusFieldAfterTourClosed = focusFieldAfterTourClosed = function () {

      if (opts.mode != 'ADDAUTOPAY' && opts.mode != 'ADDFAVORITE') {
        if (device.platform == 'iOS') {
          firstFieldInput.autofocus;
          firstFieldInput.focus();
        } else {
          setTimeout(function () {
            if (this.firstFieldInput) {
              firstFieldInput.focus();
            }
          }, 0);
        }

      } else if (opts.mode == 'ADDAUTOPAY') {
        if (device.platform == 'iOS') {
          autoPayNameInput.autofocus;
          autoPayNameInput.focus();
        } else {
          setTimeout(function () {
            if (this.autoPayNameInput)
              autoPayNameInput.focus();
          }, 0);
        }
      } else if (opts.mode == 'ADDFAVORITE') {
        if (device.platform == 'iOS') {
          favoriteNameInput.autofocus;
          favoriteNameInput.focus();
        } else {
          setTimeout(function () {
            if (this.favoriteNameInput)
              favoriteNameInput.focus();
          }, 0);
        }
      }
      scope.update()
    };

    colorField = function (field) {
      if (field == 'firstField') {
        firstField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        firstFieldTitle.style.color = '#01cfff';
        if (opts.mode == 'ADDAUTOPAY') {
          autopayField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          autoPayNameTitle.style.color = 'gray';
        } else if (opts.mode == 'ADDFAVORITE') {
          favoriteField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          favoriteNameTitle.style.color = 'gray';
        }
      } else if (field == 'amount') {
        firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        firstFieldTitle.style.color = 'gray';
        if (opts.mode == 'ADDAUTOPAY') {
          autopayField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          autoPayNameTitle.style.color = 'gray';
        } else if (opts.mode == 'ADDFAVORITE') {
          favoriteField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          favoriteNameTitle.style.color = 'gray';
        }
      } else if (field == 'autopay') {
        autopayField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        autoPayNameTitle.style.color = '#01cfff';
        firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        firstFieldTitle.style.color = 'gray';
      } else if (field == 'favorite') {
        favoriteField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        favoriteNameTitle.style.color = '#01cfff';
        firstField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
        firstFieldTitle.style.color = 'gray';
      }

    };


    if (scope.servicesMap[opts.chosenServiceId]) {
      scope.service = scope.servicesMap[opts.chosenServiceId][0];
      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;
    }


    scope.fieldArray = scope.servicesParamsMapOne[opts.chosenServiceId];
    console.log('field array filled:', JSON.stringify(scope.fieldArray));

    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;


    // scope.prepareData = prepareData = function () {
    if (scope.formType != 2) {

      console.log("Yahoo1 formType=", scope.formType);

      if (scope.fieldArray) {
        scope.chosenFieldName = opts.firstFieldTitle ? opts.firstFieldTitle : scope.fieldArray[0].title;
        opts.first_field_value = opts.firstFieldText ? opts.firstFieldText : null;
        console.log("PARAMETER ID ", scope.fieldArray[0].parameter_id, scope.fieldArray[0])
        console.log("Service ", scope.service)
        scope.phoneFieldBool = scope.fieldArray[0].parameter_id == "1" || scope.fieldArray[0].parameter_id == "65536" || scope.fieldArray[0].parameter_id == "128";


        if (scope.phoneFieldBool) {
          scope.defaultNumber = !opts.firstFieldText ? null : inputVerification.telVerificationWithSpace(inputVerification.telVerification(opts.firstFieldText));
          console.log("PHONE FIELD", scope.defaultNumber);
        }
        scope.inputMaxLength = scope.fieldArray[0].max_len;

        if (!scope.placeHolderText)
          scope.placeHolderText = "от " + window.amountTransform(scope.service.min_pay_limit) + " " + scope.service.lang_amount_currency + " до " + window.amountTransform(scope.service.max_pay_limit) + " " + scope.service.lang_amount_currency

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

    }

    // }


    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';
//        this.enterButtonId.style.backgroundColor = '#76c1f4';
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
//        this.enterButtonId.style.backgroundColor = '#00a8f1';
      }

      enterEndY = event.changedTouches[0].pageY;
      enterEndX = event.changedTouches[0].pageX;

      if (Math.abs(enterStartY - enterEndY) <= 20 && Math.abs(enterStartX - enterEndX) <= 20) {

        window.blurFields();

        opts.formtype = scope.formType;
        opts.firstFieldId = scope.chosenFieldParamId;
        opts.firstFieldText = firstFieldInput.value;
        opts.firstFieldTitle = scope.chosenFieldName;
        opts.cardTypeId = null;

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
//
//      var favoritePaymentsList, favoritePaymentsListForApi;
//
//      var id = Math.floor((Math.random() * 1000000) + 1);
//
//      favoritePaymentsList = localStorage.getItem('favoritePaymentsList') ? JSON.parse(localStorage.getItem('favoritePaymentsList')) : [];
//      favoritePaymentsListForApi = localStorage.getItem('favoritePaymentsListForApi') ? JSON.parse(localStorage.getItem('favoritePaymentsListForApi')) : [];
//
//
//      if (favoritePaymentsListForApi.length != favoritePaymentsList.length) {
//        favoritePaymentsListForApi = [];
//        for (var i in favoritePaymentsList) {
//          favoritePaymentsListForApi.push({
//            "id": favoritePaymentsList[i].id,
//            "type": 1,
//            "body": JSON.stringify(favoritePaymentsList[i])
//          })
//        }
//      }
//
//      var newfavorite = {
//        "params": array,
//        "service": scope.service,
//        "ussd": scope.fieldArray[0].ussd_query,
//        "id": id
//      };
//
//      favoritePaymentsList.push(newfavorite);
//      favoritePaymentsListForApi.push({
//        "id": id,
//        "type": 1,
//        "body": JSON.stringify(newfavorite)
//      });
//
//      localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
//      localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));
//
//
//      window.api.call({
//        method: 'add.favourite',
//        input: {
//          session_key: sessionKey,
//          phone_num: phoneNumber,
//          wishlist_data: favoritePaymentsListForApi
//        },
//
//        scope: this,
//
//        onSuccess: function (result) {
//
//          if (result[0][0].error == 0) {
//
//            console.log("SUCCESSFULLY ADDED")
//
//          }
//          else {
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//
//            window.common.alert.show("componentAlertId", {
//              parent: scope,
//              clickpinerror: scope.clickPinError,
//              errornote: scope.errorNote
//            });
//
//            scope.update();
//            console.log(result[0][0].error_note);
//          }
//        },
//
//        onFail: function (api_status, api_status_message, data) {
//          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//          console.error(data);
//        }
//      });

      addPaymentToFavorites(array, scope.service, scope.fieldArray[0].ussd_query, scope);


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
</view-formtype-seven>

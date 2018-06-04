<view-formtype-two class="riot-tags-main-container">

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


    <div class="servicepage-formtype-two-container">

      <div id="autopayField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDAUTOPAY'}">
        <p id="autoPayNameTitle" class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true" onkeyup="paymentNameVerificationKeyUp()" onfocus="colorFieldFormTypeTwo('autopay')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="paymentNameVerificationKeyUp()" onfocus="colorFieldFormTypeTwo('favorite')"/>
      </div>

      <div
        class="{servicepage-pincards-container: opts.mode == 'USUAL',
      servicepage-pincards-container-two: opts.mode != 'USUAL'}">
        <div class="servicepage-pincards-block-container" each="{i in pincardIds}">
          <div class="servicepage-pincard-title">{pincardsMap[i][0].name}</div>
          <div class="servicepage-pincard-nominal-container" each="{j in pincardsMap[i]}"
               ontouchstart="onTouchStartOfPincard()" ontouchend="onTouchEndOfPincard({j.nominal},{j.card_type_id})">
            <p class="servicepage-pincard-nominal-value">{j.nominal}</p>
            <div id="radio{j.card_type_id+j.nominal}" class="{servicepage-pincard-radio-selected:'radio'+j.card_type_id+j.nominal == selectedId,
          servicepage-pincard-radio-unselected:'radio'+j.card_type_id+j.nominal != selectedId}"></div>
          </div>
        </div>
      </div>

      <button id="formTypeTwoBtnId" style="bottom: {window.bottomButtonBottom}"
              class="servicepage-button-enter-disabled"
              ontouchstart="onTouchStartOfEnter()"
              ontouchend="formTypeTwoButtonFunction()">
        {!enterButton?window.languages.ViewServicePageSaveLabel:window.languages.ViewServicePageEnterLabel}
      </button>
    </div>

  </div>

  <script>

    var scope = this;
    var backStartY, backStartX, backEndY, backEndX;
    var servicePageTouchStartY, servicePageTouchEndY;
    var enterStartY, enterStartX, enterEndY, enterEndX;
    scope.selectedId = '';

    console.log("opts in FormTypeTwo", opts);

    window.saveHistory('view-formtype-two', opts);

    if (opts.id) {
      opts.chosenServiceId = opts.id;
    }

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.servicesParamsMapThree = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) : (offlineServicesParamsMapThree);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));

    scope.enterButton = opts.mode == 'ADDFAVORITE' ? false : true;
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

    paymentNameVerificationKeyUp = function () {

      if (opts.mode == 'ADDAUTOPAY' && this.autoPayNameInput && this.autoPayNameInput.value.length < 1) {
        formTypeTwoBtnId.style.pointerEvents = 'none';
        formTypeTwoBtnId.style.backgroundColor = '#D2D2D2';
        scope.update(formTypeTwoBtnId);
        return;
      }
      if (opts.mode == 'ADDFAVORITE' && this.favoriteNameInput && this.favoriteNameInput.value.length < 1) {
        formTypeTwoBtnId.style.pointerEvents = 'none';
        formTypeTwoBtnId.style.backgroundColor = '#D2D2D2';
        scope.update(formTypeTwoBtnId);
        return;
      }
      if (opts.cardTypeId || opts.amountText) {
        formTypeTwoBtnId.style.pointerEvents = 'auto';
        formTypeTwoBtnId.style.backgroundColor = '#00a8f1';
        scope.update(formTypeTwoBtnId);
      }

    };

    this.on('mount', function () {

      focusFieldAfterTourClosed();

    });

    scope.focusFieldAfterTourClosed = focusFieldAfterTourClosed = function () {

      if (opts.mode == 'ADDAUTOPAY') {
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

    colorFieldFormTypeTwo = function (field) {
      if (field == 'autopay') {
        autopayField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        autoPayNameTitle.style.color = '#01cfff';
      } else if (field == 'favorite') {
        favoriteField.style.borderBottom = 3 * widthK + 'px solid #01cfff';
        favoriteNameTitle.style.color = '#01cfff';
      }
    };


    if (scope.servicesMap[opts.chosenServiceId]) {
      scope.service = scope.servicesMap[opts.chosenServiceId][0];
      scope.titleName = scope.service.name;
      scope.serviceIcon = scope.service.image;
    }
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;

    scope.pincardsMap = {};
    scope.pincardIds = [];
    if (scope.servicesParamsMapThree[scope.service.id]) {
      for (var i = 0; i < scope.servicesParamsMapThree[scope.service.id].length; i++) {
        if (!scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id]) {
          scope.pincardIds.push(scope.servicesParamsMapThree[scope.service.id][i].card_type_id);
          scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id] = [];
          scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id].push(scope.servicesParamsMapThree[scope.service.id][i]);
        }
        else
          scope.pincardsMap[scope.servicesParamsMapThree[scope.service.id][i].card_type_id].push(scope.servicesParamsMapThree[scope.service.id][i]);
      }
    }


    scope.onTouchStartOfPincard = onTouchStartOfPincard = function () {
      event.stopPropagation();
      servicePageTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfPincard = onTouchEndOfPincard = function (nominal, cardId) {
      event.stopPropagation();

      servicePageTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(servicePageTouchStartY - servicePageTouchEndY) <= 20) {
        scope.selectedId = 'radio' + cardId + nominal;
        scope.update(scope.selectedId);
        opts.formtype = scope.formType;
        opts.cardTypeId = cardId;
        opts.amountText = nominal;

        if (opts.mode == 'ADDAUTOPAY') {
          autopayField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          autoPayNameTitle.style.color = 'gray';

          if (this.autoPayNameInput.value.length < 1) {
            console.log("Введите название автоплатежа");
            return;
          }
        } else if (opts.mode == 'ADDFAVORITE') {
          favoriteField.style.borderBottom = 3 * widthK + 'px solid lightgrey';
          favoriteNameTitle.style.color = 'gray';

          if (this.favoriteNameInput.value.length < 1) {
            console.log("Введите название избранного");
            return;
          }
        }

        formTypeTwoBtnId.style.pointerEvents = 'auto';
        formTypeTwoBtnId.style.backgroundColor = '#00a8f1';
        scope.update(formTypeTwoBtnId);
      }
    };

    formTypeTwoButtonFunction = function () {
      event.stopPropagation();

      enterEndY = event.changedTouches[0].pageY;
      enterEndX = event.changedTouches[0].pageX;

      if (this.formTypeTwoBtnId) {
        this.formTypeTwoBtnId.style.webkitTransform = 'scale(1)';
      }

      if (Math.abs(enterStartY - enterEndY) <= 20 && Math.abs(enterStartX - enterEndX) <= 20) {

        if (modeOfApp.offlineMode) {

          var ussdQuery = scope.fieldArray[0].ussd_query;
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
          ussdQuery = ussdQuery.replace('{nominal}', opts.amountText);
          ussdQuery = ussdQuery.replace('{card_type}', opts.cardTypeId);
          ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);


          phonedialer.dial(
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

        if (opts.mode == 'USUAL' || opts.mode == 'POPULAR' || !opts.mode) {

          opts.isInFavorites = !scope.enterButton;
          opts.transactionId = parseInt(Date.now() / 1000);

          event.preventDefault();
          event.stopPropagation();

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

        } else if (opts.mode == 'ADDFAVORITE') {
          if (opts) {
            console.log("PARAMS of favorite", opts)

            opts.favoriteName = favoriteNameInput.value;

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

          }
          else {
            scope.clickPinError = false;
            scope.errorNote = "Попробуйте еще раз";

            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
            });

            scope.update();
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
          scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
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
          if (favoritePaymentsList[i].params.transactionId)
            favoritePaymentsList[i].params.transactionId = null;
          console.log("fav transaction id=", favoritePaymentsList[i].params.transactionId);
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
</view-formtype-two>

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
               autofocus="true" onkeyup="paymentNameVerificationKeyUp()"
               onfocus="colorFieldGlobal('autopayField','autoPayNameTitle')"
               onblur="blurFieldGlobal('autopayField','autoPayNameTitle')"/>
      </div>

      <div id="favoriteField" class="servicepage-first-field autopay-event-name-field" if="{opts.mode=='ADDFAVORITE'}">
        <p id="favoriteNameTitle" class="servicepage-text-field">{window.languages.ViewServicePageFavoriteNameField}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="favoriteNameInput"
               placeholder="{window.languages.ViewServicePageFavoriteNamePlaceholder}" autofocus="true"
               value="{opts.favoriteName}"
               onkeyup="paymentNameVerificationKeyUp()" onfocus="colorFieldGlobal('favoriteField','favoriteNameTitle')"
               onblur="blurFieldGlobal('favoriteField','favoriteNameTitle')"/>
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
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.servicesParamsMapThree = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapThree"))) : (offlineServicesParamsMapThree);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));

    scope.enterButton = opts.mode != 'ADDFAVORITE';
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
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.formType = scope.service.form_type;
    scope.fieldArray = scope.servicesParamsMapOne[opts.chosenServiceId];
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

          if (this.autoPayNameInput.value.length < 1) {
            console.log("Введите название автоплатежа");
            return;
          }
        } else if (opts.mode == 'ADDFAVORITE') {

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

    scope.onTouchStartOfEnter = onTouchStartOfEnter = function () {
      event.stopPropagation();

      if (this.enterButtonId && scope.enterButtonEnabled) {
        this.enterButtonId.style.webkitTransform = 'scale(0.8)';
//        this.enterButtonId.style.backgroundColor = '#76c1f4';
      }

      enterStartY = event.changedTouches[0].pageY;
      enterStartX = event.changedTouches[0].pageX;
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


  </script>
</view-formtype-two>

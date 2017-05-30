<view-report-service class="view-report-service riot-tags-main-container">
  <div>

    <div class="report-service-upper-container">

      <div class="page-title settings-general-page-title">
        <div id="backButton" ontouchend="reportServiceGoToBack()" class="settings-general-back-button"></div>
      </div>

      <img src="{opts.image}" id="serviceIconId"
           class="report-service-icon"/>

      <div class="report-service-upper-info-container">
        <div class="report-service-title">{(opts.service_name) ? (opts.service_name) : ("")}</div>
        <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentNumber}
          {(opts.payment_id) ? (opts.payment_id) : ("")}
        </div>
        <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentDate} {opts.created}
        </div>
      </div>

    </div>

    <div class="report-service-body-container">
      <div class="report-service-body-info-container">
        <div class="report-service-phone-field">
          <p class="report-service-text-field">{(opts.parameter_name) ? (opts.parameter_name) : ("")}</p>
          <p class="report-service-phone-input">{(opts.cntrg_info_param2) ? (opts.cntrg_info_param2) : ("")}</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServiceAmountOfPay}</p>
          <p class="report-service-info-input report-service-info-input-amount">-
            {(opts.amount) ? (amountTransform(opts.amount.toString())) : ("")} сум</p>
        </div>
        <div class="report-service-field">
          <p class="report-service-text-field">{window.languages.ViewReportServicePayWithCard}</p>
          <p class="report-service-info-input">{(cards[opts.account_id])? (cards[opts.account_id].name+ " " +
            cards[opts.account_id].numberPartOne + " **** **** " + cards[opts.account_id].numberPartTwo):"UNKNOWN"}</p>
        </div>
        <div class="report-service-field report-service-last-field">
          <p class="report-service-text-field">{window.languages.ViewReportServiceStatus}</p>
          <p class="report-service-info-input {report-service-status-wait: opts.state == 1,
                                               report-service-status-error: opts.state == -1,
                                               report-service-status-success: opts.state == 0}">
            {((opts.status_note) ? ((opts.status_note == -1) ? (opts.error) : (opts.status_note)) : (""))}</p>
        </div>
      </div>

      <div class="report-service-data-button-info-container" if="{!opts.is_indoor}"
           ontouchend="addToFavoritesTouchEnd()" ontouchstart="addToFavoritesTouchStart()">
        <div class="report-service-button-info-container">
          <div class="report-service-button-icon report-service-button-favorites-icon"></div>
          <a class="report-service-button-action">{languages.ViewReportServiceAddToFavorites}</a>
        </div>
        <div class="report-service-button-info-container" if="{false}">
          <div class="report-service-button-icon report-service-button-auto-payment-icon"></div>
          <a class="report-service-button-action">{languages.ViewReportServiceAddToAutoPayment}</a>
        </div>
        <div class="report-service-button-info-container" ontouchend="goToSupportTouchEnd()"
             ontouchstart="goToSupportTouchStart()">
          <div class="report-service-button-icon report-service-button-support-icon"></div>
          <a class="report-service-button-action">{languages.ViewReportServiceGetSupportHelp}</a>
        </div>

        <button if="{opts.service_id != -4}" class="report-service-repeat-button" if="{!opts.is_indoor}"
                ontouchend="onTouchEndOfService()"
                ontouchstart="onTouchStartOfService()">
          {languages.ViewReportServiceRepeatButtonLabel}
        </button>
      </div>

    </div>

  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessageForAddingToFavorites}"
                     viewpage="{undefined}" step_amount="{0}" close_action="{goToBack}"></component-success>

  <script>
    var scope = this,
      goToSupportTouchStartX,
      goToSupportTouchEndX,
      addToFavoritesTouchStartX,
      addToFavoritesTouchEndX,
      onTouchStartOfServiceX,
      onTouchEndOfServiceX;

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");

      scope.update();
    })


    scope.cards = localStorage.getItem("click_client_cards");
    scope.cards = JSON.parse(scope.cards);

    //    console.log("ASDASDASDASD", scope.cards, opts.account_id);
    //    try {
    //      console.log("TRY CARD NAME");
    //
    //      scope.cardName = scope.cards[scope.opts.account_id].name + " " + scope.cards[scope.opts.account_id].numberPartOne + " **** **** " + scope.cards[scope.opts.account_id].numberPartTwo;
    //    } catch (err) {
    //
    //      scope.cardName = "UNKNOWN";
    //    }
    //    scope.update(scope.cardName);

    //    console.log("OPTS=", scope.opts);

    if (scope.parent == null)
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-report-service') {
        history.arrayOfHistory.push(
          {
            "view": 'view-report-service',
            "params": scope.opts
          }
        );
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }

    goToSupportTouchStart = function () {

      goToSupportTouchStartX = event.changedTouches[0].pageX;
    };

    goToSupportTouchEnd = function () {

      goToSupportTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(goToSupportTouchEndX - goToSupportTouchStartX) < 20) {

        event.preventDefault();
        event.stopPropagation();

        window.checkShowingComponent = null;
        riotTags.innerHTML = "<view-settings-support-part-two>";
        riot.mount('view-settings-support-part-two', {title: window.languages.VewSettingsSupportPay, key: 'PAY'});

//        scope.unmount()
      }
    };

    addToFavoritesTouchStart = function () {

      addToFavoritesTouchStartX = event.changedTouches[0].pageX;
    };

    addToFavoritesTouchEnd = function () {

      addToFavoritesTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(addToFavoritesTouchEndX - addToFavoritesTouchStartX) < 20) {

        var servicesMap = localStorage.getItem("click_client_servicesMap");
        servicesMap = JSON.parse(servicesMap);

//        console.log("Preparing inputs for favorites", localStorage.getItem("click_client_servicesMap"), scope.opts.service_id, servicesMap, servicesMap[scope.opts.service_id][0]);

        var formType = {"formtype": servicesMap[scope.opts.service_id][0].form_type};
        var firstFieldId = {"firstFieldId": servicesMap[scope.opts.service_id][0].service_parameters};
        var firstFieldText = {"firstFieldText": scope.opts.cntrg_info_param2};
        var cardTypeId = {"cardTypeId": scope.opts.account_id};
        var communalParam = {"communalParam": opts.cntrg_info_param5};
        var amountText = {"amountText": scope.opts.amount};
        var internetPackageParam = {"internetPackageParam": scope.opts.cntrg_info_param5};
        var isInFavorites = {"isInFavorites": true};

        var array = [formType, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites];

        console.log("ADD TO FAVORITES INPUT", array);

        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));

        favoritePaymentsList = (favoritePaymentsList) ? (favoritePaymentsList) : ([]);

        console.log("OPTS TO SAVE=", array);
        console.log("Chosen Service =", servicesMap[scope.opts.service_id][0]);

        favoritePaymentsList.push({
          "opts": array,
          "service": servicesMap[scope.opts.service_id][0],
          "firstFieldTitle": scope.opts.parameter_name
        });

        console.log("favoritePaymentsList=", favoritePaymentsList);

        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));

        componentSuccessId.style.display = 'block';
      }
    };

    onTouchStartOfService = onTouchStartOfService = function () {

      event.stopPropagation();
      onTouchStartOfServiceX = event.changedTouches[0].pageX;
    };

    console.log('OPTS', scope.opts);

    onTouchEndOfService = function () {

      event.stopPropagation();
      onTouchEndOfServiceX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchEndOfServiceX - onTouchStartOfServiceX) <= 20) {

        var cards = JSON.parse(localStorage.getItem('click_client_cards'));

        console.log("chosen id in pay view=", scope.opts.service_id);


        localStorage.setItem('chosenServiceId', scope.opts.service_id);
        viewPay.chosenServiceId = scope.opts.service_id;
        console.log('CHOOSEN SERVICE OPTS', scope.opts.service_id)
        console.log('CHOOSEN SERVICE', viewPay.chosenServiceId)
        viewServicePage.amountText = inputVerification.spaceDeleter(scope.opts.amount.toString());
        viewServicePage.amountWithoutSpace = inputVerification.spaceDeleter(scope.opts.amount.toString());
//        console.log('AMOUNT=', viewServicePage.amountText)

        scope.fieldsObject = {
//          formtype: formtype.formtype,
//          firstFieldId: firstFieldId.firstFieldId,
          firstFieldText: scope.opts.cntrg_info_param2,
//          firstFieldTitle: scope.chosenFieldName,
//          cardTypeId: cardTypeId.cardTypeId,
//          communalParam: communalParam.communalParam,
          amountText: scope.opts.amount,
//          internetPackageParam: internetPackageParam.internetPackageParam,
//          firstLevelParamId: scope.chosenFieldParamIdTwo,
//          firstLevelFieldName: scope.chosenFieldNameTwo,
//          secondLevelFieldName: scope.chosenFieldNameThree,
        };
        console.log("fieldsObject=", scope.fieldsObject);
        localStorage.setItem("servicepage_fields", JSON.stringify(scope.fieldsObject));
        opts.mode = 'USUAL';

        riotTags.innerHTML = "<view-service-page>";
        riot.mount("view-service-page", opts);

        scope.update();
//        scope.unmount()
      }
    };

    reportServiceGoToBack = function () {
      event.preventDefault();
      event.stopPropagation();

      onBackKeyDown()
      riot.update()
//      scope.unmount()

    };


  </script>
</view-report-service>

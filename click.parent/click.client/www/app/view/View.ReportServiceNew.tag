<view-report-service-new class="view-report-service riot-tags-main-container">
  <div>

    <div class="report-service-upper-container">
      <div class="page-title">
        <div id="backButton" ontouchstart="reportServiceGoToBackStart()" ontouchend="reportServiceGoToBackEnd()"
             class="back-button"></div>
        <div class="title-bottom-border">
        </div>
      </div>

      <img src="{opts.image}" id="serviceIconId"
           class="report-service-icon"/>

      <div class="report-service-title">{(opts.service_name) ? (opts.service_name) : ("")}</div>
      <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentNumber}
        {(opts.payment_id) ? (opts.payment_id) : ("")}
      </div>
      <div class="report-service-payment-info-text">{window.languages.ViewReportServicePaymentDate} {opts.created}
      </div>
      <div class="title-bottom-border">
      </div>
    </div>

    <div class="report-service-body-container">
      <div class="report-service-body-info-container">
        <div class="report-info-container" style="height:{85*heightK}px">
          <div class="horizontal-centering">
            <p class="title-text text-margin">
              {(opts.parameter_name) ? (opts.parameter_name) : ("")}
            </p>
            <p class="main-text text-margin">
              {(opts.cntrg_info_param2) ? (opts.cntrg_info_param2) : ("")}
            </p>
          </div>
          <div class="solid-border-bottom"></div>
        </div>
        <div
          class="report-info-container" style="height:{110*heightK}px">
          <div class="horizontal-centering">
            <p class="title-text text-margin">{window.languages.ViewReportServiceAmountOfPay}</p>
            <p
              class="main-text text-margin"
              style="color: #ff6d65">
              -
              {(opts.amount) ? (amountTransform(opts.amount.toString())) : ("")} сум</p>
            <p if="{cost > 1}"
               class="title-text text-margin">
              {lang_amount_title+':'}
              {amount_in_int/cost}
            </p>
            <p if="{opts.comission_amount > 0 && (opts.nds == null || opts.nds == 0)}"
               class="title-text text-margin">
              {window.languages.Commission}
              {opts.comission_amount}
              {window.languages.Currency}
            </p>
            <p if="{(opts.comission_amount == 0 || opts.comission_amount == null) && opts.nds > 0}"
               class="title-text text-margin">
              {window.languages.Nds}
              {window.calculateNds(window.toInt(opts.amount), opts.nds)}
              {window.languages.Currency}
            </p>
            <p if="{opts.comission_amount > 0 && opts.nds > 0}"
               class="title-text text-margin">
              {window.languages.CommissionAndNds}
              {opts.comission_amount}
              {window.languages.Currency}
            </p>
          </div>
          <div class="solid-border-bottom"></div>
        </div>
        <div class="report-info-container" style="height:{90*heightK}px">
          <div class="horizontal-centering">
            <p class="title-text text-margin">{window.languages.ViewReportServicePayWithCard}</p>
            <p class="main-text text-margin" style="font-size: {30 * widthK}px">{(cards[opts.account_id])?
              (cards[opts.account_id].name+ " " +
              cards[opts.account_id].numberPartOne + " **** **** " +
              cards[opts.account_id].numberPartTwo):"UNKNOWN"}</p>
          </div>
          <div class="solid-border-bottom"></div>
        </div>
        <div class="report-info-container">
          <div class="horizontal-centering">
            <p class="title-text text-margin">{window.languages.ViewReportServiceStatus}</p>
            <p class="report-service-info-input {report-service-status-wait: opts.state == 1,
                                               report-service-status-error: opts.state == -1,
                                               report-service-status-success: opts.state == 0}">
              {((opts.status_note) ? ((opts.status_note == -1) ? (opts.error) : (opts.status_note)) : (""))}</p>
          </div>
        </div>
      </div>


      <div class="report-service-button-info-container" if="{opts.is_indoor != 1 && opts.canAddToFavorite === true}">

        <div class="report-service-button-icon report-service-button-favorites-icon" if="{!isInFavorites}"></div>
        <div id="addToFavouriteButtonId" class="report-service-button-action"
             ontouchend="addToFavoritesTouchEnd(this.id)" if="{!isInFavorites}"
             ontouchstart="addToFavoritesTouchStart(this.id)">{languages.ViewReportServiceAddToFavorites}
        </div>

        <div class="report-service-button-icon report-service-button-favorites-icon-added"
             if="{isInFavorites}"></div>
        <div id="delToFavouriteButtonId" class="report-service-button-action"
             ontouchend="removeFromFavoritesTouchEnd(this.id)" if="{isInFavorites}"
             ontouchstart="addToFavoritesTouchStart(this.id)">{languages.ViewReportServiceRemoveFromFavorites}
        </div>

      </div>
      <div class="report-service-button-info-container" if="{false}">
        <div class="report-service-button-icon report-service-button-auto-payment-icon"></div>
        <a class="report-service-button-action">{languages.ViewReportServiceAddToAutoPayment}</a>
      </div>
      <div class="report-service-button-info-container">
        <div class="report-service-button-icon report-service-button-support-icon"></div>
        <div id="supportButtonId" class="report-service-button-action" ontouchend="goToSupportTouchEnd(this.id)"
             ontouchstart="goToSupportTouchStart(this.id)">{languages.ViewReportServiceGetSupportHelp}
        </div>
      </div>

      <button id="repeatButtinId" if="{opts.is_indoor != 1 && opts.canAddToFavorite === true}"
              class="bottom-button-container"
              ontouchend="onTouchEndOfService(this.id)"
              ontouchstart="onTouchStartOfService(this.id)">
        {opts.qr_image? languages.ViewReportServiceShowQrButtonLabel : languages.ViewReportServiceRepeatButtonLabel}
      </button>


    </div>
  </div>

  <script>

    console.log("OPTS in ReportService New=", opts);
    var scope = this,
      goToSupportTouchStartX,
      goToSupportTouchEndX,
      addToFavoritesTouchStartX,
      addToFavoritesTouchEndX,
      onTouchStartOfServiceX,
      onTouchEndOfServiceX;

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#ffffff");

      scope.update()

    });

    scope.on('update', function() {
      if(servicesMap[scope.opts.service_id]) {
        scope.cost = servicesMap[scope.opts.service_id][0].cost;
        scope.lang_amount_title = servicesMap[scope.opts.service_id][0].lang_amount_title;
        if(scope.opts.amount) scope.amount_in_int = parseInt(scope.opts.amount.replace(/\s/g,''));
      }
    });

    var servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    var servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
    var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.isInFavorites = scope.opts.isInFavorites;
    console.log("scope.isInFavorites", scope.isInFavorites)
    scope.update(scope.isInFavorites);


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

    if (scope.parent == null) {
      window.saveHistory('view-report-service-new', opts);
    }


    goToSupportTouchStart = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      goToSupportTouchStartX = event.changedTouches[0].pageX;
    };

    goToSupportTouchEnd = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)'

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

    addToFavoritesTouchStart = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      addToFavoritesTouchStartX = event.changedTouches[0].pageX;
    };

    addToFavoritesTouchEnd = function (id) {

      var amount = Math.floor(parseInt(inputVerification.spaceDeleter(scope.opts.amount.toString()))
        - scope.opts.comission_amount);
      var amountText=inputVerification.spaceDeleter(amount.toString());
      console.log('addToFavoritesTouchEnd amountText='+amountText);
      document.getElementById(id).style.webkitTransform = 'scale(1)'

      addToFavoritesTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(addToFavoritesTouchEndX - addToFavoritesTouchStartX) < 20) {

//        console.log("Preparing inputs for favorites", localStorage.getItem("click_client_servicesMap"), scope.opts.service_id, servicesMap, servicesMap[scope.opts.service_id][0]);
        var newFavorite = {};

//        console.log("serviceMap=", servicesMap);
//        console.log("servicesParamsMapOne =", servicesParamsMapOne);
//        console.log("scope.opts.service_id=", scope.opts.service_id);
//        console.log("scope.opts.payment_id=", scope.opts.payment_id);
//        console.log("scope.service=", servicesMap[scope.opts.service_id][0]);
        newFavorite.formtype = servicesMap[scope.opts.service_id][0].form_type;
        newFavorite.firstFieldId = servicesMap[scope.opts.service_id][0].service_parameters;
        newFavorite.firstFieldText = scope.opts.cntrg_info_param2;
        newFavorite.cardTypeId = scope.opts.account_id;
        newFavorite.communalParam = opts.cntrg_info_param5;
        if(scope.cost) {
          newFavorite.cost=scope.cost;
          newFavorite.amountText = scope.amount_in_int / scope.cost;
          newFavorite.lang_amount_title=scope.lang_amount_title;
        }
        else
          newFavorite.amountText = amountText;
        newFavorite.internetPackageParam = scope.opts.cntrg_info_param5;
        newFavorite.isInFavorites = true;
        scope.isInFavorites = true;
        newFavorite.firstFieldTitle = scope.opts.parameter_name;
        newFavorite.chosenServiceId = scope.opts.service_id;
        newFavorite.favoriteName = servicesMap[scope.opts.service_id][0].name;
        newFavorite.paymentId = scope.opts.payment_id;
        newFavorite.chosenPrefixTitle = scope.opts.chosenPrefixTitle;
        newFavorite.chosenPrefixId = scope.opts.chosenPrefixId;
        newFavorite.chosenPrefixName = scope.opts.chosenPrefixName;
        newFavorite.nds=servicesMap[scope.opts.service_id][0].nds;
        if(scope.cost)
          newFavorite.amountWithoutSpace = scope.amount_in_int/scope.cost;
        else
          newFavorite.amountWithoutSpace=amountText;
        newFavorite.commissionPercent=servicesMap[scope.opts.service_id][0].commission_percent;


        favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        favoritePaymentsList = (favoritePaymentsList) ? (favoritePaymentsList) : ([]);
        favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));
        favoritePaymentsListForApi = (favoritePaymentsListForApi) ? (favoritePaymentsListForApi) : ([]);
        var id = Math.floor((Math.random() * 1000000) + 1);
        scope.opts.favoriteId = id;


        var newItem = {
          "params": newFavorite,
          "service": servicesMap[scope.opts.service_id][0],
          "ussd": servicesParamsMapOne[scope.opts.service_id][0].ussd_query,
          "id": id
        }

        favoritePaymentsList.push(newItem);

        favoritePaymentsListForApi.push({
          "id": id,
          "type": 1,
          "body": JSON.stringify(newItem)
        });


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


            }
            else {
              scope.errorNote = result[0][0].error_note
              scope.update();

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote,
              });
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
        scope.operationMessage = window.languages.ComponentSuccessMessageForAddingToFavorites;
        scope.update(scope.operationMessage);

        //componentSuccessId.style.display = 'block';
      }
    };


    removeFromFavoritesTouchEnd = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      addToFavoritesTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(addToFavoritesTouchEndX - addToFavoritesTouchStartX) < 20) {

        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));
        for (var i in favoritePaymentsList)
          if (favoritePaymentsList[i].id == scope.opts.favoriteId) {
            favoritePaymentsList.splice(i, 1);
            scope.isInFavorites = false;
            scope.update(scope.isInFavorites);

            for (var j in favoritePaymentsListForApi)
              if (favoritePaymentsListForApi[j].id == scope.opts.favoriteId) {
                favoritePaymentsListForApi.splice(j, 1);
                break;
              }

            window.api.call({
              method: 'delete.favourite',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                wishlist_data: [{"id": scope.opts.favoriteId, "type": 1}]
              },

              scope: this,

              onSuccess: function (result) {

                if (result[0][0].error == 0) {

                }
                else {
                  scope.clickPinError = false;
                  scope.errorNote = result[0][0].error_note
                  scope.update();
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    clickpinerror: scope.clickPinError,
                    errornote: scope.errorNote,
                  });
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


        scope.operationMessage = window.languages.ComponentSuccessMessageForRemovingFromFavorites;
        scope.update(scope.operationMessage);
        //componentSuccessId.style.display = 'block';
      }
    };

    onTouchStartOfService = onTouchStartOfService = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      event.stopPropagation();
      onTouchStartOfServiceX = event.changedTouches[0].pageX;
    };

    console.log('OPTS', scope.opts);

    onTouchEndOfService = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      event.stopPropagation();
      onTouchEndOfServiceX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchEndOfServiceX - onTouchStartOfServiceX) <= 20) {

        if (!scope.opts.qr_image) {

          var cards = JSON.parse(localStorage.getItem('click_client_cards'));

          console.log("chosen id in pay view=", scope.opts.service_id);

          localStorage.setItem('chosenServiceId', scope.opts.service_id);
          opts.chosenServiceId = scope.opts.service_id;
          console.log('CHOOSEN SERVICE OPTS', scope.opts.service_id);
          console.log("scope.service=", servicesMap[scope.opts.service_id][0]);


          var amount = Math.floor(parseInt(inputVerification.spaceDeleter(scope.opts.amount.toString()))
            - scope.opts.comission_amount);
          if(scope.cost){
            opts.amountText = inputVerification.spaceDeleter(amount.toString())/scope.cost;
            opts.amountWithoutSpace = inputVerification.spaceDeleter(amount.toString())/scope.cost;
          }
          else {
            opts.amountText = inputVerification.spaceDeleter(amount.toString());
            opts.amountWithoutSpace = inputVerification.spaceDeleter(amount.toString());
          }

          //
          opts.formtype = servicesMap[scope.opts.service_id][0].form_type;
          opts.firstFieldId = scope.opts.parameter_id;
          opts.firstFieldText = scope.opts.cntrg_info_param2;
          opts.firstFieldTitle = scope.opts.parameter_name;
          opts.cardTypeId = scope.opts.account_id;
          opts.communalParam = opts.cntrg_info_param5;
          opts.internetPackageParam = scope.opts.cntrg_info_param5;
          opts.isInFavorites = scope.isInFavorites;
          opts.chosenServiceId = scope.opts.service_id;
          opts.favoriteName = servicesMap[scope.opts.service_id][0].name;
          opts.paymentId = scope.opts.payment_id;
          opts.payByCard = true;
          opts.mode = 'USUAL';
          opts.categoryId = servicesMap[scope.opts.service_id][0].category_id;
          opts.chosenCardId = scope.opts.account_id;

          //

          opts.mode = 'USUAL';

          if (window.checkShowingComponent) {
            window.checkShowingComponent = null;
          }

//          riotTags.innerHTML = "<view-service-page-new>";
//          riot.mount("view-service-page-new", opts);
          openPayServiceById(opts.chosenServiceId, opts);

          scope.update();
//        scope.unmount()
        } else {
          window.common.alert.show("componentGeneratedQrId", {
            parent: scope,
            qr_image: scope.opts.qr_image,
            qr_header: scope.opts.qr_header,
            qr_footer: scope.opts.qr_footer,
            viewpage: undefined,
            step_amount: 0
          });
          qrFooterTextId.innerHTML = scope.opts.qr_footer;
        }
      }
    };

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    reportServiceGoToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

//      scope.unmount()

    };

    reportServiceGoToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        console.log("report service component should be closed");
        onBackKeyDown();
        scope.update()
      }
//      scope.unmount()

    };


  </script>
</view-report-service-new>
<view-pay-confirm-new class="view-pay-confirm riot-tags-main-container">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts.mode!='ADDAUTOPAY', autopay-method-page-title:opts.mode=='ADDAUTOPAY'}">
      {(opts.mode=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts.mode=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div ontouchend="goToBack()"
         class="{servicepage-button-back:opts.mode!='ADDAUTOPAY', autopay-method-back-button:opts.mode=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts.mode=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="payconfirm-body-container">
    <div class="payconfirm-data-container">
      <div class="payconfirm-phone-field" if="{formType!=2}">
        <p class="payconfirm-text-field">{firstFieldTitle}</p>
        <p class="payconfirm-phone-input">{firstFieldText}</p>
      </div>
      <div class="payconfirm-field">
        <p class="payconfirm-text-field">{window.languages.ViewPayConfirmAmountOfPay}</p>
        <p class="payconfirm-phone-input">{amountTextCopy} {currency}</p>
      </div>
      <div class="payconfirm-field">
        <p class="payconfirm-text-field">{(opts.mode=='ADDAUTOPAY')?
          (window.languages.ViewAutoPayConditionFieldText):(window.languages.ViewPayConfirmCategory)}</p>
        <p class="{payconfirm-category-input:opts.mode!='ADDAUTOPAY',payconfirm-phone-input:opts.mode=='ADDAUTOPAY'}">
          {(opts.mode=='ADDAUTOPAY')?
          (autoPayConditionText):(categoryName)}</p>
      </div>
      <div class="payconfirm-card-field" if="{cardOrFriendBool}">
        <div class="payconfirm-card-info-container">
          <p class="payconfirm-text-one">{window.languages.ViewPayConfirmPayFromCard}</p>
          <p class="payconfirm-text-two">{cardName}</p>
          <p class="payconfirm-detail-text">{numberPartOne} **** {numberPartTwo}</p>
          <p class="payconfirm-detail-text">{window.languages.ViewPayConfirmAvailable}:{salary} {currency}</p>
        </div>
        <div class="payconfirm-card-logo-container"
             style="background-image: url({url})">
        </div>
      </div>
      <div class="payconfirm-card-field" if="{!cardOrFriendBool}">
        <div class="payconfirm-card-info-container">
          <p class="payconfirm-text-one">{window.languages.ViewPayConfirmFriendHelp}</p>
          <p class="payconfirm-text-two">{friendName}</p>
          <p class="payconfirm-detail-text">+{friendNumber}</p>
        </div>
        <div class="payconfirm-chosen-friend-photo" style="background-image: url({friendPhoto})">
          {friendFirstLetterOfName}
        </div>
      </div>

    </div>
    <div class="payconfirm-bottom-container">
      <div class="payconfirm-action-autopay-container" if="{opts.mode!='ADDAUTOPAY'}">
        <div
          class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-favorite-center:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-one" if="{!isInFavorites}"
               style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
          <div class="payconfirm-action-text" ontouchend="addToFavorites()" if="{!isInFavorites}">
            {window.languages.ViewPayConfirmAddToFavorites}
          </div>
          <div class="payconfirm-action-icon-one" if="{isInFavorites}"
               style="background-image: url('resources/icons/ViewService/addedfavorite.png');"></div>
          <div class="payconfirm-action-text" ontouchend="removeFromFavorites()" if="{isInFavorites}">
            {window.languages.ViewPayConfirmRemoveFromFavorites}
          </div>
        </div>
        <div id="addToAutoPayContainerId"
             class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-autopay-none:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-two"
               style="background-image: url('resources/icons/ViewService/addautopay.png');"></div>
          <div class="payconfirm-action-text" ontouchend="addToAutoPay()">
            {window.languages.ViewPayConfirmAddToAutoPay}
          </div>
        </div>
      </div>
      <button class="{payconfirm-button-enter:opts.mode!='ADDAUTOPAY', autopay-button:opts.mode=='ADDAUTOPAY'}"
              ontouchend="payService()" if="{!autoPayDelete}">
        {(opts.mode=='ADDAUTOPAY')? window.languages.ViewAutoPayCreateButtonText : window.languages.ViewPayConfirmPay}
      </button>
      <button class="payconfirm-button-delete" ontouchend="deleteAutoPay()"
              if="{autoPayDelete && opts.mode=='ADDAUTOPAY'}">
        {window.languages.ViewAutoPayDeleteButtonText}
      </button>

    </div>
  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{operationMessage}"
                     goback="{goBack}"
                     viewpage="{viewPage}" step_amount="{stepAmount}"></component-success>
  <component-unsuccess id="componentUnsuccessId" viewpage="{viewPage}" step_amount="{stepAmount}"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{window.languages.ComponentUnsuccessMessagePart3ForPay}"></component-unsuccess>

  <component-in-processing id="componentInProcessingId" viewpage="{viewPage}"
                           operationmessagepartone="{window.languages.ComponentInProcessingPartOneForPay}"
                           operationmessageparttwo="{window.languages.ComponentInProcessingPartTwo}"></component-in-processing>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>


  <script>

    console.log("OPTS PAYCONFIRM NEW", opts)

    var scope = this;
    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDownWithParams(opts, 1);
      scope.unmount()
    };

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pay-confirm-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-pay-confirm-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    var serviceId = localStorage.getItem('chosenServiceId');
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    scope.isInFavorites = opts.isInFavorites;
    scope.fieldsObject = JSON.parse(localStorage.getItem("servicepage_fields"));
    console.log("Fields in the history=", scope.fieldsObject);

    if (opts.mode == 'ADDAUTOPAY') {
      scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
      if (scope.autoPayData.fromView == 'AFTERCREATION') {
        opts.mode = 'USUAL';
        scope.update();
      } else {
        scope.autoPayTypeText = scope.autoPayData.title;
        scope.autoPayConditionText = scope.autoPayData.condition_text;
        scope.autoPayDelete = !scope.autoPayData.isNew;
        console.log("autoPayData=", scope.autoPayData);
      }
    }
    scope.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.cardOrFriendBool = opts.payByCard;

    scope.stepAmount = 3;

    this.formType = opts.formtype;
    this.firstFieldId = opts.firstFieldId;

    this.firstFieldTitle = opts.firstFieldTitle;
    console.log("firstFieldTitle pay confirm=", this.firstFieldTitle);


    if (opts.firstFieldId == '1') {
//      console.log("TEL LENGTH VERIFICATION=", inputVerification.telLengthVerification(opts[0][2].firstFieldText, window.languages.PhoneNumberLength));
      opts.firstFieldText = inputVerification.telLengthVerification(opts.firstFieldText, window.languages.PhoneNumberLength);

      this.firstFieldText = "+" + window.languages.CodeOfCountry + opts.firstFieldText;
      var firstFieldtext = "+" + window.languages.CodeOfCountry + opts.firstFieldText;
      console.log("text=", firstFieldtext)
    }
    else {
      this.firstFieldText = opts.firstFieldText;
      var firstFieldtext = opts.firstFieldText;
      console.log("text in else=", firstFieldtext)
    }

    this.cardTypeId = opts.cardTypeId;
    this.amountText = opts.amountText;

    scope.amountTextCopy = this.amountText;

    console.log("AMOUNT", this.amountText)

    if (scope.amountTextCopy.length == 8) {
      scope.amountTextCopy = scope.amountTextCopy.substring(0, 2) + ' ' +
        scope.amountTextCopy.substring(2, 5) + ' ' + scope.amountTextCopy.substring(5, scope.amountTextCopy.length)
    }

    if (scope.amountTextCopy.length == 7) {
      scope.amountTextCopy = scope.amountTextCopy.substring(0, 1) + ' ' +
        scope.amountTextCopy.substring(1, 4) + ' ' + scope.amountTextCopy.substring(4, scope.amountTextCopy.length)
    }

    if (scope.amountTextCopy.length == 6) {
      scope.amountTextCopy = scope.amountTextCopy.substring(0, 3) + ' ' + scope.amountTextCopy.substring(3, scope.amountTextCopy.length)
    }

    if (scope.amountTextCopy.length == 5) {
      scope.amountTextCopy = scope.amountTextCopy.substring(0, 2) + ' ' + scope.amountTextCopy.substring(2, scope.amountTextCopy.length)
    }

    if (scope.amountTextCopy.length == 4) {
      scope.amountTextCopy = scope.amountTextCopy.substring(0, 1) + ' ' + scope.amountTextCopy.substring(1, scope.amountTextCopy.length)
    }


    //    riot.update()

    if (scope.cardOrFriendBool) {
      var chosenCardId = opts.chosenCardId;

      if (cardsArray[chosenCardId]) {
        scope.cardName = cardsArray[chosenCardId].name;
        scope.numberPartOne = cardsArray[chosenCardId].numberPartOne;
        scope.numberPartTwo = cardsArray[chosenCardId].numberPartTwo;
        scope.salary = cardsArray[chosenCardId].salary;
        scope.currency = cardsArray[chosenCardId].currency;
        scope.url = cardsArray[chosenCardId].url;
        scope.update();
      }
    }
    else {
      var friendForHelp = opts.chosenFriendForHelp;
      scope.friendName = friendForHelp.name;
      scope.friendNumber = friendForHelp.number;
      scope.friendFirstLetterOfName = friendForHelp.firstLetterOfName;
      scope.friendPhoto = friendForHelp.photo;
//      this.on('mount', function () {
//        addToAutoPayContainerId.style.display = 'none';
//      });
    }
    scope.update();

    addToFavorites = function () {

      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
        scope.showError = true;
        scope.errorNote = question;
//        confirm(question)
//        scope.confirmShowBool = true;
//        scope.confirmNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//        };
        scope.update();

        return
      }
      scope.isInFavorites = true;
      scope.update(scope.isInFavorites);
      opts.isInFavorites = true;
      var favoritePaymentsList;

      if (!localStorage.getItem('favoritePaymentsList')) {
        favoritePaymentsList = [];

        favoritePaymentsList.push({
          "params": opts,
          "service": scope.service,
//          "firstFieldTitle": opts.firstFieldTitle
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);

        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      } else {
        favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        favoritePaymentsList.push({
          "params": opts,
          "service": scope.service,
//          "firstFieldTitle": opts.firstFieldTitle
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);
        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      }

    };

    removeFromFavorites = function () {
      var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      console.log(favoritePaymentsList);
      for (var i in favoritePaymentsList)
        if (favoritePaymentsList[i].service.id == opts.chosenServiceId) {
          console.log("i=", i);
          favoritePaymentsList.splice(i, 1);
          console.log(favoritePaymentsList);
          scope.isInFavorites = false;
          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
          scope.update(scope.isInFavorites);
        }
    };


    payService = function () {

      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
        scope.showError = true;
        scope.errorNote = question;
//        confirm(question)
//        scope.confirmShowBool = true;
//        scope.confirmNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//        };
        scope.update();

        return
      }

      var date = parseInt(Date.now() / 1000);
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var serviceId = opts.chosenServiceId;
      var amount = inputVerification.spaceDeleter(opts[0][5].amountText.toString());
      var accountId;
      var friendPhone;
      var payment_data;
//      console.log("AMOUNT UPDATED=", amount)

      // friend help or own payment

      if (scope.cardOrFriendBool) {
        accountId = chosenCardId;
        friendPhone = 0;
        scope.operationMessage = window.languages.ComponentSuccessMessageForPay;
      }
      else {
        accountId = 0;
        friendPhone = scope.friendNumber;
        scope.operationMessage = window.languages.ComponentSuccessMessageForPayFriendHelp;
      }

      scope.update();
      console.log("accountId", accountId);
      console.log("friendPhone", friendPhone);

      if (opts[0][0].formtype == 1) {
        payment_data = {
          "param": opts[0][1].firstFieldId,
          "value": firstFieldtext,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }
      else if (opts[0][0].formtype == 2) {
        payment_data = {
          "pin_param": opts[0][3].cardTypeId,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }
      else if (opts[0][0].formtype == 3) {
        payment_data = {
          "param": opts[0][1].firstFieldId,
          "value": firstFieldtext,
          "communal_param": opts[0][4].communalParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);

      }
      else if (opts[0][0].formtype == 4) {
        payment_data = {
          "param": opts[0][1].firstFieldId,
          "value": firstFieldtext,
          "internet_package_param": opts[0][6].internetPackageParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }

      var statusCheckCounter = 0;

      function paymentFunction(payment_data) {

        if (device.platform != 'BrowserStand') {
          var options = {dimBackground: true};

          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
            console.log("Started");
          }, function () {
            console.log("closed");
          });
        }


        if (opts[0].optionAttribute && opts[0].optionValue) {
          payment_data[opts[0].optionAttribute] = opts[0].optionValue;
        }

        window.api.call({
          method: 'app.payment',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            service_id: Number(serviceId),
            account_id: Number(accountId),
            amount: Number(amount),
            payment_data: payment_data,
            datetime: date,
            friend_phone: friendPhone
          },

          scope: this,

          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              if (result[1]) {
                console.log("result of APP.PAYMENT 1", result);
                if (result[1][0].payment_id && !result[1][0].invoice_id) {
                  console.log("Payment id");
                  if (device.platform != 'BrowserStand') {
                    var options = {dimBackground: true};

                    SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                      console.log("Started");
                    }, function () {
                      console.log("closed");
                    });
                  }
                  setTimeout(function () {
                    checkPaymentStatus(result[1][0].payment_id);
                  }, 2000);

                }
                else if (result[1][0].invoice_id && !result[1][0].payment_id) {
                  console.log("Invoice id");

                  viewServicePage.phoneText = '';
                  window.viewServicePage = {};
                  viewServicePage.amountText = '';
                  viewServicePage.amountWithoutSpace = '';
                  viewServicePinCards.friendHelpPaymentMode = false;
                  viewServicePinCards.chosenFriendForHelp = null;
                  localStorage.setItem('servicepage_fields', null);
                  componentSuccessId.style.display = 'block';
                }
              }
            }
            else {
              console.log("result of APP.PAYMENT 3", result);
              componentUnsuccessId.style.display = 'block';
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }

      function checkPaymentStatus(payment_id) {

        console.log("check payment status");

        window.api.call({
          method: 'get.payment',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            payment_id: payment_id,
          },

          scope: this,

          onSuccess: function (result) {
            if (result[0][0].error == 0 && result[1][0]) {

              console.log("result of get.payment success=", result);
              if (result[1][0].state == -1) {
                scope.viewPage = (scope.isInFavorites || opts.mode == 'POPULAR') ? 'view-main-page' : 'view-service-page';
                scope.stepAmount = (scope.isInFavorites || opts.mode == 'POPULAR') ? 2 : scope.stepAmount;
                scope.update();
                console.log("state=-1 error,view=", scope.viewPage, ",step=", scope.stepAmount);
                componentUnsuccessId.style.display = 'block';
              } else if (result[1][0].state == 2) {
                window.updateBalanceGlobalFunction();
                viewServicePage.phoneText = '';
                window.viewServicePage = {};
                viewServicePage.amountText = '';
                viewServicePage.amountWithoutSpace = '';
                viewServicePinCards.friendHelpPaymentMode = false;
                viewServicePinCards.chosenFriendForHelp = null;
                localStorage.setItem('servicepage_fields', null);
                scope.viewPage = (scope.isInFavorites || opts.mode == 'POPULAR') ? 'view-main-page' : 'view-pay';
                scope.stepAmount = (scope.isInFavorites || opts.mode == 'POPULAR') ? 2 : scope.stepAmount;
                scope.update();
                console.log("state=2 success,view=", scope.viewPage, ",step=", scope.stepAmount);
                componentSuccessId.style.display = 'block';
              } else if (result[1][0].state == 1) {
                statusCheckCounter++;
//                console.log("statusCheckCounter=", statusCheckCounter);
                if (statusCheckCounter < 5) {
                  if (device.platform != 'BrowserStand') {
                    var options = {dimBackground: true};

                    SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                      console.log("Started");
                    }, function () {
                      console.log("closed");
                    });
                  }
                  setTimeout(function () {
                    checkPaymentStatus(result[1][0].payment_id);
                  }, 2000);
                } else {
                  viewServicePage.phoneText = '';
                  window.viewServicePage = {};
                  viewServicePage.amountText = '';
                  viewServicePage.amountWithoutSpace = '';
                  viewServicePinCards.friendHelpPaymentMode = false;
                  viewServicePinCards.chosenFriendForHelp = null;
                  localStorage.setItem('servicepage_fields', null);
                  scope.viewPage = (scope.isInFavorites || opts.mode == 'POPULAR') ? 'view-main-page' : 'view-pay';
                  scope.stepAmount = (scope.isInFavorites || opts.mode == 'POPULAR') ? 2 : scope.stepAmount;
                  scope.update();
                  console.log("state=1 waiting,view=", scope.viewPage, ",step=", scope.stepAmount);
                  componentInProcessingId.style.display = 'block';
                }

              }

            }
            else {
              console.log("result of GET.PAYMENT in else", result);
              componentUnsuccessId.style.display = 'block';
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }

      function createAutoPay(payment_data) {
        scope.operationMessage = window.languages.ViewAutoPayCreatedSuccessTextOne + "\"" + scope.autoPayData.name + "\"" + window.languages.ViewAutoPayCreatedSuccessTextTwo;
        if (scope.autoPayData && scope.autoPayData.fromView == 'PAYCONFIRM') {
          scope.viewPage = 'view-pay-confirm';
          scope.stepAmount = 0;
          scope.goBack = true;

        } else {
          scope.viewPage = 'view-auto-pay';
          scope.stepAmount = 6;

        }

        scope.update();
        console.log("in create autopay func", scope.autoPayData);
        if (scope.autoPayData) {
          if (scope.autoPayData.autopay_type == 2) {
            console.log(Number(amount));
            window.api.call({
              method: 'autopay.add.by.event',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                service_id: Number(serviceId),
                account_id: Number(accountId),
                amount: amount,
                cntrg_phone_num: scope.autoPayData.cntrg_phone_num,
                step: scope.autoPayData.step,
                title: scope.autoPayData.name
              },

              scope: this,

              onSuccess: function (result) {
                if (result[0][0].error == 0) {
                  console.log("result of autopay.add.by.event", result);
//                  scope.autoPayDelete = true;
//                  scope.update(scope.autoPayDelete);

                  if (scope.autoPayData.fromView != 'PAYCONFIRM') {
                    viewServicePage.phoneText = '';
                    window.viewServicePage = {};
                    viewServicePage.amountText = '';
                    viewServicePage.amountWithoutSpace = '';
                    viewServicePinCards.friendHelpPaymentMode = false;
                    viewServicePinCards.chosenFriendForHelp = null;
//                    localStorage.setItem('autoPayData', null);
                  } else {
                    scope.autoPayData.fromView = 'AFTERCREATION';
                  }
                  scope.autoPayData.isNew = false;
                  localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                  componentSuccessId.style.display = 'block';

                }
                else {
                  console.log("result of autopay.add.by.event", result);
                  componentUnsuccessId.style.display = 'block';
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
          } else if (scope.autoPayData.autopay_type == 1) {

            window.api.call({
              method: 'autopay.add.by.schedule',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                type: scope.autoPayData.type,
                service_id: Number(serviceId),
                account_id: Number(accountId),
                amount: Number(amount),
                payment_data: payment_data,
                paytime: scope.autoPayData.paytime,
                week_day: scope.autoPayData.week_day ? scope.autoPayData.week_day : null,
                month_day: scope.autoPayData.month_day ? scope.autoPayData.month_day : null,
                title: scope.autoPayData.name
              },

              scope: this,

              onSuccess: function (result) {
                if (result[0][0].error == 0) {
                  console.log("result of autopay.add.by.schedule", result);
//                  localStorage.setItem('autoPayData', null);
                  if (scope.autoPayData.fromView != 'PAYCONFIRM') {
                    viewServicePage.phoneText = '';
                    window.viewServicePage = {};
                    viewServicePage.amountText = '';
                    viewServicePage.amountWithoutSpace = '';
                    viewServicePinCards.friendHelpPaymentMode = false;
                    viewServicePinCards.chosenFriendForHelp = null;
                  } else {
                    scope.autoPayData.fromView = 'AFTERCREATION';
                  }
                  scope.autoPayData.isNew = false;
                  localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
                  componentSuccessId.style.display = 'block';

                }
                else {
                  console.log("result of autopay.add.by.schedule", result);
                  componentUnsuccessId.style.display = 'block';
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
          }
        }

      }
    };

    deleteAutoPay = function () {
      console.log("delete autopay =", scope.autoPayData);
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      window.api.call({
        method: 'autopay.delete',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          autopay_id: scope.autoPayData.id,
          autopay_type: scope.autoPayData.autopay_type
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log("result of autopay.delete", result);
            localStorage.setItem('autoPayData', null);
            viewServicePage.phoneText = '';
            window.viewServicePage = {};
            viewServicePage.amountText = '';
            viewServicePage.amountWithoutSpace = '';
            viewServicePinCards.friendHelpPaymentMode = false;
            viewServicePinCards.chosenFriendForHelp = null;
            scope.operationMessage = window.languages.ViewAutoPayDeletedSuccessText;
            scope.viewPage = 'view-auto-pay';
            scope.stepAmount = 1;
            scope.update();
            componentSuccessId.style.display = 'block';
          }
          else {
            console.log("result of autopay.delete", result);
            componentUnsuccessId.style.display = 'block';
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    addToAutoPay = function () {

      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
        scope.showError = true;
        scope.errorNote = question;
//        confirm(question)
//        scope.confirmShowBool = true;
//        scope.confirmNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//        };
        scope.update();

        return
      }

      opts.mode = 'ADDAUTOPAY';
      opts[3] = 'ADDAUTOPAY';
      scope.autoPayData = {};
      opts.id = opts.chosenServiceId;
      scope.autoPayData.service_id = opts.chosenServiceId;
      scope.autoPayData.fromView = 'PAYCONFIRM';
      scope.autoPayData.isNew = true;

      event.preventDefault();
      event.stopPropagation();
      if (scope.servicesMap[scope.autoPayData.service_id][0].autopay_available) {
        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
        riotTags.innerHTML = "<view-autopay-method>";
        riot.mount("view-autopay-method", opts);
        scope.unmount()
      } else {
        scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
        scope.autoPayData.autopay_type = 1;
        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
        riotTags.innerHTML = "<view-autopay-schedule-method>";
        riot.mount("view-autopay-schedule-method", opts);
        scope.unmount()
      }

    }


  </script>
</view-pay-confirm-new>

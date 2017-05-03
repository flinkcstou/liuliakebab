<view-pay-confirm class="view-pay-confirm">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts[3]!='ADDAUTOPAY', autopay-method-page-title:opts[3]=='ADDAUTOPAY'}">
      {(opts[3]=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts[3]=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div ontouchend="goToBack()"
         class="{servicepage-button-back:opts[3]!='ADDAUTOPAY', autopay-method-back-button:opts[3]=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts[3]=='ADDAUTOPAY'}"
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
        <p class="payconfirm-text-field">{(opts[3]=='ADDAUTOPAY')?
          (window.languages.ViewAutoPayConditionFieldText):(window.languages.ViewPayConfirmCategory)}</p>
        <p class="{payconfirm-category-input:opts[3]!='ADDAUTOPAY',payconfirm-phone-input:opts[3]=='ADDAUTOPAY'}">
          {(opts[3]=='ADDAUTOPAY')?
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
      <div class="payconfirm-action-autopay-container" if="{opts[3]!='ADDAUTOPAY'}">
        <div
          class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-favorite-center:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-one" if="{!isInFavorites}"
               style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
          <div class="payconfirm-action-text" ontouchend="addToFavorites()" if="{!isInFavorites}">
            {window.languages.ViewPayConfirmAddToFavorites}
          </div>
          <div class="payconfirm-action-icon-one" if="{isInFavorites}"
               style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
          <div class="payconfirm-action-text" ontouchend="removeFromFavorites()" if="{isInFavorites}">
            {window.languages.ViewPayConfirmRemoveFromFavorites}
          </div>
        </div>
        <div id="addToAutoPayContainerId"
             class="{payconfirm-action-containter: cardOrFriendBool, payconfirm-action-containter-autopay-none:!cardOrFriendBool}">
          <div class="payconfirm-action-icon-two"
               style="background-image: url('resources/icons/ViewService/addautopay.png');"></div>
          <div class="payconfirm-action-text">{window.languages.ViewPayConfirmAddToAutoPay}</div>
        </div>
      </div>
      <button class="payconfirm-button-enter" ontouchend="payService()" if="{!autoPayDelete}">
        {(opts[3]=='ADDAUTOPAY')? window.languages.ViewAutoPayCreateButtonText : window.languages.ViewPayConfirmPay}
      </button>
      <button class="payconfirm-button-delete" ontouchend="deleteAutoPay()"
              if="{autoPayDelete && opts[3]=='ADDAUTOPAY'}">
        {window.languages.ViewAutoPayDeleteButtonText}
      </button>

    </div>
  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{operationMessage}"
                     viewpage="{viewPage}" step_amount="{3}"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{window.languages.ComponentUnsuccessMessagePart3ForPay}"></component-unsuccess>


  <script>

    var scope = this;
    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pay-confirm') {
      history.arrayOfHistory.push(
        {
          "view": 'view-pay-confirm',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
    cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
    var serviceId = localStorage.getItem('chosenServiceId');
    scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
    scope.isInFavorites = opts[0][7].isInFavorites;

    if (opts[3] == 'ADDAUTOPAY') {
      scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
      scope.autoPayTypeText = scope.autoPayData.title;
      scope.autoPayConditionText = scope.autoPayData.condition_text;
      scope.autoPayDelete = !scope.autoPayData.isNew;
      console.log("autoPayData=", scope.autoPayData);
    }
    scope.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    scope.cardOrFriendBool = opts[1];

    if (scope.isInFavorites)
      this.viewPage = 'view-main-page';
    else this.viewPage = 'view-pay';


    console.log("OPTS=", opts);
    this.formType = opts[0][0].formtype;
    this.firstFieldId = opts[0][1].firstFieldId;
    this.firstFieldTitle = viewServicePage.firstFieldTitle;


    if (opts[0][1].firstFieldId == '1') {
//      console.log("TEL LENGTH VERIFICATION=", inputVerification.telLengthVerification(opts[0][2].firstFieldText, window.languages.PhoneNumberLength));
      opts[0][2].firstFieldText = inputVerification.telLengthVerification(opts[0][2].firstFieldText, window.languages.PhoneNumberLength);

      this.firstFieldText = "+" + window.languages.CodeOfCountry + opts[0][2].firstFieldText;
      var firstFieldtext = "+" + window.languages.CodeOfCountry + opts[0][2].firstFieldText;
      console.log("text=", firstFieldtext)
    }
    else {
      this.firstFieldText = opts[0][2].firstFieldText;
      var firstFieldtext = opts[0][2].firstFieldText;
      console.log("text in else=", firstFieldtext)
    }

    this.cardTypeId = opts[0][3].cardTypeId;
    this.amountText = opts[0][5].amountText;

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
      var chosenCardId = opts[2];
      if (cardsArray[chosenCardId]) {
        scope.cardName = cardsArray[chosenCardId].name;
        scope.numberPartOne = cardsArray[chosenCardId].numberPartOne;
        scope.numberPartTwo = cardsArray[chosenCardId].numberPartTwo;
        scope.salary = cardsArray[chosenCardId].salary;
        scope.currency = cardsArray[chosenCardId].currency;
        scope.url = cardsArray[chosenCardId].url;
      }
    }
    else {
      var friendForHelp = opts[2];
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
      scope.isInFavorites = true;
      scope.update(scope.isInFavorites);
      opts[0][7].isInFavorites = true;

      if (!localStorage.getItem('favoritePaymentsList')) {
        var favoritePaymentsList = [];

        favoritePaymentsList.push({
          "opts": opts[0],
          "service": scope.service,
          "firstFieldTitle": viewServicePage.firstFieldTitle
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);

        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      } else {
        var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
        favoritePaymentsList.push({
          "opts": opts[0],
          "service": scope.service,
          "firstFieldTitle": viewServicePage.firstFieldTitle
        });
        console.log("favoritePaymentsList=", favoritePaymentsList);
        localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
      }

    }

    removeFromFavorites = function () {
      var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      console.log(favoritePaymentsList);
      for (var i in favoritePaymentsList)
        if (favoritePaymentsList[i].service.id == viewPay.chosenServiceId) {
          console.log("i=", i);
          favoritePaymentsList.splice(i, 1);
          console.log(favoritePaymentsList);
          scope.isInFavorites = false;
          localStorage.setItem('favoritePaymentsList', JSON.stringify(favoritePaymentsList));
          scope.update(scope.isInFavorites);
        }
    }


    payService = function () {

      var date = parseInt(Date.now() / 1000);
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var serviceId = viewPay.chosenServiceId;
      var amount = inputVerification.spaceDeleter(opts[0][5].amountText.toString());
      var accountId;
      var friendPhone;
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
        var payment_data = {
          "param": opts[0][1].firstFieldId,
          "value": firstFieldtext,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }
      else if (opts[0][0].formtype == 2) {
        var payment_data = {
          "pin_param": opts[0][3].cardTypeId,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }
      else if (opts[0][0].formtype == 3) {
        var payment_data = {
          "param": opts[0][1].firstFieldId,
          "value": firstFieldtext,
          "communal_param": opts[0][4].communalParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);

      }
      else if (opts[0][0].formtype == 4) {
        var payment_data = {
          "param": opts[0][1].firstFieldId,
          "value": firstFieldtext,
          "internetPackageParam": opts[0][6].internetPackageParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        opts[3] != 'ADDAUTOPAY' ? paymentFunction(payment_data) : createAutoPay(payment_data);
      }

      function paymentFunction(payment_data) {

        if (device.platform != 'BrowserStand') {
          var options = {dimBackground: true};

          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
            console.log("Started");
          }, function () {
            console.log("closed");
          });
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
              if (result[1])
                if (result[1][0].payment_id || result[1][0].invoice_id) {
                  console.log("result of APP.PAYMENT 1", result);
                  viewServicePage.phoneText = '';
                  window.viewServicePage = {};
                  viewServicePage.amountText = '';
                  viewServicePage.amountWithoutSpace = '';
                  viewServicePinCards.friendHelpPaymentMode = false;
                  viewServicePinCards.chosenFriendForHelp = null;
                  componentSuccessId.style.display = 'block';
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

      function createAutoPay(payment_data) {
        scope.operationMessage = window.languages.ViewAutoPayCreatedSuccessTextOne + "\"" + scope.autoPayData.name + "\"" + window.languages.ViewAutoPayCreatedSuccessTextTwo;
        scope.viewPage = 'view-auto-pay';
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
                  scope.autoPayDelete = true;
                  scope.update(scope.autoPayDelete);

                  viewServicePage.phoneText = '';
                  window.viewServicePage = {};
                  viewServicePage.amountText = '';
                  viewServicePage.amountWithoutSpace = '';
                  viewServicePinCards.friendHelpPaymentMode = false;
                  viewServicePinCards.chosenFriendForHelp = null;
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

                  viewServicePage.phoneText = '';
                  window.viewServicePage = {};
                  viewServicePage.amountText = '';
                  viewServicePage.amountWithoutSpace = '';
                  viewServicePinCards.friendHelpPaymentMode = false;
                  viewServicePinCards.chosenFriendForHelp = null;
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
            scope.operationMessage = window.languages.ViewAutoPayDeletedSuccessText;
            scope.viewPage = 'view-auto-pay';
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

    }

  </script>
</view-pay-confirm>

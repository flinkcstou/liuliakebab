<view-pay-confirm class="view-pay-confirm">

  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">{titleName}</p>
    <p class="servicepage-category-field">{categoryName}</p>
    <div ontouchend="goToBack()"
         class="servicepage-button-back">
    </div>
    <div type="button" class="servicepage-service-icon"
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
        <p class="payconfirm-phone-input">{amountText} {currency}</p>
      </div>
      <div class="payconfirm-field">
        <p class="payconfirm-text-field">{window.languages.ViewPayConfirmCategory}</p>
        <p class="payconfirm-phone-input" style="text-decoration: underline">
          {window.languages.ViewPayConfirmMobileConnection}</p>
      </div>
      <div class="payconfirm-card-field">
        <div class="payconfirm-card-info-container">
          <p class="payconfirm-text-one">{window.languages.ViewPayConfirmPayFromCard}</p>
          <p class="payconfirm-text-two">{cardName}</p>
          <p class="payconfirm-detail-text">{numberPartOne} **** {numberPartTwo}</p>
          <p class="payconfirm-detail-text">Доступно:{salary} {currency}</p>
        </div>
        <div class="payconfirm-card-logo-container"
             style="background-image: url({url})">
        </div>
      </div>

    </div>
    <div class="payconfirm-bottom-container">
      <div class="payconfirm-action-containter">
        <div class="payconfirm-action-icon-one"
             style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
        <div class="payconfirm-action-text">{window.languages.ViewPayConfirmAddToFavourite}</div>
      </div>
      <div class="payconfirm-action-containter">
        <div class="payconfirm-action-icon-two"
             style="background-image: url('resources/icons/ViewService/addautopay.png');"></div>
        <div class="payconfirm-action-text">{window.languages.ViewPayConfirmAddToAutoPay}</div>
      </div>
      <div class="payconfirm-button-enter" ontouchend="payService()">
        <div class="payconfirm-button-enter-label">{window.languages.ViewPayConfirmPay}</div>
      </div>
    </div>
  </div>

  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessageForPay}"
                     viewpage="view-pay"></component-success>
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
    }

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
    console.log("OPTS=", opts);
    this.formType = opts[0][0].formtype;
    this.firstFieldId = opts[0][1].firstFieldId;
    this.firstFieldTitle = viewServicePage.firstFieldTitle;
    if (this.firstFieldId == '1')
      this.firstFieldText = "+" + window.languages.CodeOfCountry + opts[0][2].firstFieldText;
    else
      this.firstFieldText = opts[0][2].firstFieldText;

    this.cardTypeId = opts[0][3].cardTypeId;
    this.communalParam = opts[0][4].communalParam;
    this.amountText = opts[0][5].amountText;

    scope.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.categoryName = scope.categoryNamesMap[viewPay.categoryId];
    var chosenCardId = opts[1];
    console.log("chosen card id=", chosenCardId);

    if (cardsArray[chosenCardId]) {
      scope.cardName = cardsArray[chosenCardId].name;
      scope.numberPartOne = cardsArray[chosenCardId].numberPartOne;
      scope.numberPartTwo = cardsArray[chosenCardId].numberPartTwo;
      scope.salary = cardsArray[chosenCardId].salary;
      scope.currency = cardsArray[chosenCardId].currency;
      scope.url = cardsArray[chosenCardId].url;
    }


    payService = function () {
      console.log("inPayService");

      var date = parseInt(Date.now() / 1000);
      console.log("date", date);
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      console.log("sk", sessionKey);
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      console.log("pn", phoneNumber);
      var serviceId = viewPay.chosenServiceId;
      console.log("si", serviceId);
      var accountId = chosenCardId;
      console.log("ai", accountId);
      var amount = this.amountText;
      console.log("amount", amount);

      console.log("before PD");

      if (this.formType == 1) {
        console.log("before PD");
        var payment_data = {
          "param": this.firstFieldId,
          "value": this.firstFieldText,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("xsaxqa", payment_data);
        paymentFunction();
      }
      else if (this.formType == 2) {
        console.log("before PD");
        var payment_data = {
          "pin_param": this.cardTypeId,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("xsaxqa", payment_data);
        paymentFunction();
      }
      else if (this.formType == 3) {
        console.log("before PD");
        var payment_data = {
          "param": this.firstFieldId,
          "value": this.firstFieldText,
          "communl_param": this.communalParam,
          "transaction_id": parseInt(Date.now() / 1000)
        };
        console.log("xsaxqa", payment_data);
        paymentFunction();
      }
    }

    paymentFunction = function () {
      console.log("in function pay");

      window.api.call({
        method: 'app.payment',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          service_id: Number(serviceId),
          account_id: Number(accountId),
          amount: Number(amount),
          payment_data: payment_data,
          datetime: date
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1])
              if (result[1][0]['payment_id']) {
                console.log("result of APP.PAYMENT 1", result);
                componentSuccessId.style.display = 'block';
              } else {
                console.log("result of APP.PAYMENT 2", result);
                componentUnsuccessId.style.display = 'block';
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


  </script>
</view-pay-confirm>

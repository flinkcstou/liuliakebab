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
            <div class="payconfirm-phone-field" if="{viewServicePage.formType!=2}">
                <p class="payconfirm-text-field">{window.languages.ViewPayConformEnterPhone}</p>
                <p class="payconfirm-phone-input">{phoneText}</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">{window.languages.ViewPayConfirmAmountOfPay}</p>
                <p class="payconfirm-phone-input">{amountText} сум</p>
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


    <script>

        var scope = this;
        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-pay-confirm') {
            history.arrayOfHistory.push('view-pay-confirm');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
        }

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
        cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        var serviceId = localStorage.getItem('chosenServiceId');
        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];

        this.phoneText = "+998 " + viewServicePage.phoneText;
        this.amountText = viewServicePage.amountText;

        scope.titleName = scope.service.name;
        scope.serviceIcon = scope.service.image;
        scope.categoryName = scope.categoryNamesMap[viewPay.categoryId];

        for (var i = 0; i < cardsArray.length; i++)
            if (cardsArray[i].chosenCard === true) {
                scope.cardName = cardsArray[i].name;
                scope.numberPartOne = cardsArray[i].numberPartOne;
                scope.numberPartTwo = cardsArray[i].numberPartTwo;
                scope.salary = cardsArray[i].salary;
                scope.currency = cardsArray[i].currency;
                scope.url = cardsArray[i].url;
                break;
            }

        payService = function () {
            var date = parseInt(Date.now() / 1000);
            var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
            var phoneNumber = localStorage.getItem('click_client_phoneNumber');
            var serviceId = viewPay.chosenServiceId;
            var accountId = JSON.parse(localStorage.getItem('click_client_loginInfo')).default_account;
            var amount = viewServicePage.amountText;
            var phoneParam = viewServicePage.phoneText;
//            var payment_data = {
//                "item": {"param": "1", "value": phoneParam},
//                "transaction_id": parseInt(Date.now() / 1000)
//            }

            var payment_data = {"param": "1", "value": phoneParam, "transaction_id": parseInt(Date.now() / 1000)};


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
                        console.log("result of APP.PAYMENT ", result);
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

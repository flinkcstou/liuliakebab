<view-pay-confirm class="view-pay-confirm">

    <div class="page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchend="touchStartTitle()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="payconfirm-body-container">
        <div class="payconfirm-data-container">
            <div class="payconfirm-phone-field">
                <p class="payconfirm-text-field">{window.languages.ViewPayConformEnterPhone}</p>
                <p class="payconfirm-phone-input">{phoneText}</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">{window.languages.ViewPayConfirmAmountOfPay}</p>
                <p class="payconfirm-phone-input">{amountText} сум</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">{window.languages.ViewPayConfirmCategory}</p>
                <p class="payconfirm-phone-input" style="text-decoration: underline">{window.languages.ViewPayConfirmMobileConnection}</p>
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
            <div class="payconfirm-button-enter">
                <div class="payconfirm-button-enter-label">{window.languages.ViewPayConfirmPay}</div>
            </div>
        </div>
    </div>


    <script>

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        if(history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-pay-confirm') {
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




    </script>
</view-pay-confirm>

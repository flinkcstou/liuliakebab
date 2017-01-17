<view-pay-confirm>

    <div class="page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchstart="touchStartTitle()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="servicepage-body-container">
        <div class="payconfirm-data-container">
            <div class="payconfirm-phone-field">
                <p class="payconfirm-text-field">Номер абонента:</p>
                <p class="payconfirm-phone-input">{phoneText}</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">Сумма оплаты:</p>
                <p class="payconfirm-phone-input">{amountText} сум</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">Категория:</p>
                <p class="payconfirm-phone-input" style="text-decoration: underline">{categoryName}</p>
            </div>
            <div class="payconfirm-card-field">
                <div class="payconfirm-card-info-container">
                    <p class="payconfirm-text-field">Оплата с карты:</p>
                    <p class="payconfirm-phone-input">{cardName}</p>
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
                <div class="payconfirm-action-icon"
                     style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
                <div class="payconfirm-action-text">Добавить в избранные</div>
            </div>
            <div class="payconfirm-action-containter">
                <div class="payconfirm-action-icon"
                     style="background-image: url('resources/icons/ViewService/addautopay.png');"></div>
                <div class="payconfirm-action-text">Добавить в автоплатеж</div>
            </div>
            <div class="payconfirm-button-enter">
                <div class="payconfirm-button-enter-label">ОПЛАТИТЬ</div>
            </div>
        </div>
    </div>


    <script>

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');
        }

        history.arrayOfHistory.push('view-pay');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
        cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
        var serviceId = localStorage.getItem('chosenServiceId');
        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];

        this.phoneText = viewServicePage.phoneText;
        this.amountText = viewServicePage.amountText;

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;
        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];

        for (var i = 0; i < cardsArray.length; i++)
            if (cardsArray[i].card_id == viewServicePinCards.chosenCardId) {
                this.cardName = cardsArray[i].name;
                this.numberPartOne = cardsArray[i].numberPartOne;
                this.numberPartTwo = cardsArray[i].numberPartTwo;
                this.salary = cardsArray[i].salary;
                this.currency = cardsArray[i].currency;
                this.url = cardsArray[i].url;
                break;
            }


        console.log("chosen card id", viewServicePinCards.chosenCardId);


    </script>
</view-pay-confirm>

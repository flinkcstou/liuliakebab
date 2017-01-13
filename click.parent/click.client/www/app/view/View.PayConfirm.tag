<view-pay-confirm>

    <div class="page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">Мобильные операторы</p>
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
                <p class="payconfirm-phone-input">+998 90 359 39 57</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">Сумма оплаты:</p>
                <p class="payconfirm-phone-input">5000 сум</p>
            </div>
            <div class="payconfirm-field">
                <p class="payconfirm-text-field">Категория:</p>
                <p class="payconfirm-phone-input" style="text-decoration: underline">Мобильная связь</p>
            </div>
            <div class="payconfirm-card-field">
                <div class="payconfirm-card-info-container">
                    <p class="payconfirm-text-field">Оплата с карты:</p>
                    <p class="payconfirm-phone-input">Зарплатная карта</p>
                    <p class="payconfirm-detail-text">8610 **** 9784</p>
                    <p class="payconfirm-detail-text">Доступно:21 057 789 сум</p>
                </div>
                <div class="payconfirm-card-logo-container"
                     style="background-image: url('https://merchant.click.uz/static/content/app/bank/ofb.png')">
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

        scope.servicesMap = JSON.parse(localStorage.getItem("servicesMap"));
        var serviceId = localStorage.getItem('chosenServiceId');
        scope.service = scope.servicesMap[serviceId][0];

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;

        scope.servicesMap = JSON.parse(localStorage.getItem("cardsArray"));
        scope.card = JSON.parse(localStorage.getItem('click_client_cards'));

        console.log(scope.card);


    </script>
</view-pay-confirm>

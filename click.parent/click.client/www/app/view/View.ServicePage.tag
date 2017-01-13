<view-service-page class="view-service-page">

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
        <div class="servicepage-phone-field">
            <p class="servicepage-text-field">Номер абонента</p>
            <p class="servicepage-phone-input">+998 90 359 39 57</p>
            <div class="servicepage-phone-icon"></div>
        </div>
        <div class="servicepage-amount-field">
            <p class="servicepage-text-field">Сумма оплаты</p>
            <p class="servicepage-phone-input">0</p>
            <div class="servicepage-amount-icon"></div>
        </div>
        <div class="servicepage-button-enter" ontouchend="choosePinCard()">
            <div class="button-enter-label">ДАЛЕЕ</div>
        </div>
    </div>


    <script>

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();

            this.riotTags.innerHTML = "<view-pay>";
            riot.mount('view-pay');
        }

        scope.servicesMap = JSON.parse(localStorage.getItem("servicesMap"));
        var serviceId = localStorage.getItem('chosenServiceId');
        scope.service = scope.servicesMap[serviceId][0];

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;


        choosePinCard = function () {
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards');

        }


    </script>
</view-service-page>

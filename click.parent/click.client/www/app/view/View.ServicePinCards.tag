<view-service-pincards>

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
        <p class="pincard-payfrom-field">Оплатить с:</p>
        <div class="pincard-card-container">ASD</div>

        <div class="pincard-button-enter"
             ontouchend="confirmDetails()">
            <div class="pincard-button-enter-label">ОПЛАТИТЬ</div>
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

        scope.servicesMap = JSON.parse(localStorage.getItem("cardsArray"));
        scope.card = JSON.parse(localStorage.getItem('click_client_cards'));

        console.log(scope.card);


    </script>
</view-service-pincards>

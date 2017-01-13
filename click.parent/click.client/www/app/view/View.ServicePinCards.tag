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
        <div class="pincard-payfrom-container">
            <p class="pincard-payfrom-field">Оплатить с:</p></div>
        <div class="pincard-allcards-container">
            <div class="pincard-card-container">
                <div class="pincard-card-logo-container"
                     style="background-image: url('https://merchant.click.uz/static/content/app/bank/ofb.png')"></div>
                <div class="pincard-card-info-container">
                    <p class="pincard-card-info-text-one">Зарплатная карта</p>
                    <p class="pincard-card-info-text-two">15 789 сум</p>
                    <p class="pincard-card-info-text-three">8610 **** 9784</p>
                </div>
                <div class="pincard-card-checkmark"
                     style="background-image: url('resources/icons/ViewService/checked.png')"></div>
            </div>
            <div class="pincard-card-container">
                <div class="pincard-card-logo-container"
                     style="opacity:0.3; filter: grayscale(100%);background-image: url('https://merchant.click.uz/static/content/app/bank/ofb.png')"></div>
                <div class="pincard-card-info-container">
                    <p class="pincard-card-info-text-one">Зарплатная карта</p>
                    <p class="pincard-card-info-text-two" style="color: #EB604D">0 сум</p>
                    <p class="pincard-card-info-text-three">8610 **** 9784</p>
                </div>
                <div class="pincard-card-checkmark"
                     style="background-image: url('resources/icons/ViewService/unchecked.png')"></div>
            </div>
            <div class="pincard-card-container">
                <div class="pincard-card-logo-container"
                     style="opacity:0.3; filter: grayscale(100%);background-image: url('https://merchant.click.uz/static/content/app/bank/ofb.png')"></div>
                <div class="pincard-card-info-container">
                    <p class="pincard-card-info-text-one">Зарплатная карта</p>
                    <p class="pincard-card-info-text-two" style="color: #EB604D">0 сум</p>
                    <p class="pincard-card-info-text-three">8610 **** 9784</p>
                </div>
                <div class="pincard-card-checkmark"
                     style="background-image: url('resources/icons/ViewService/unchecked.png')"></div>
            </div>
            <div class="pincard-card-container">
                <div class="pincard-card-logo-container"
                     style="opacity:0.3; filter: grayscale(100%);background-image: url('https://merchant.click.uz/static/content/app/bank/ofb.png')"></div>
                <div class="pincard-card-info-container">
                    <p class="pincard-card-info-text-one">Зарплатная карта</p>
                    <p class="pincard-card-info-text-two" style="color: #EB604D">0 сум</p>
                    <p class="pincard-card-info-text-three">8610 **** 9784</p>
                </div>
                <div class="pincard-card-checkmark"
                     style="background-image: url('resources/icons/ViewService/unchecked.png')"></div>
            </div>
        </div>
        <div class="pincard-bottom-container">
            <div class="pincard-help-text">Помощь друга</div>
            <div class="pincard-button-enter"
                 ontouchend="confirmDetails()">
                <div class="pincard-button-enter-label">ОПЛАТИТЬ</div>
            </div>
        </div>


    </div>


    <script>

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-service-page>";
            riot.mount('view-service-page');
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

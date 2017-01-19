<view-service-pincards class="view-service-pincards">

    <div class="page-title" style="border-style: none;">
        <p class="servicepage-title">{titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchstart="touchStartTitle()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="pincard-body-container">
        <div class="pincard-payfrom-container">
            <p class="pincard-payfrom-field">Оплатить с:</p></div>
        <div class="pincard-allcards-container">
            <div class="pincard-card-container" each="{i in cardsArray}" ontouchend="checkCard(this.id)"
                 id="{i.card_id}">
                <div class="pincard-card-logo-container" if="{i.salary>0}"
                     style="background-image: url({i.url})"></div>
                <div class="pincard-card-logo-container" if="{i.salary<=0}"
                     style="opacity:0.3; filter: grayscale(100%);background-image: url({i.url})"></div>
                <div class="pincard-card-info-container">
                    <p class="pincard-card-info-text-one">{i.name}</p>
                    <p class="pincard-card-info-text-two" if="{i.salary>0}">{i.salary} {i.currency}</p>
                    <p class="pincard-card-info-text-two" style="color: #EB604D" if="{i.salary<=0}">
                        0 {i.currency}</p>
                    <p class="pincard-card-info-text-three">{i.numberPartOne} **** {i.numberPartTwo}</p>
                </div>
                <div class="pincard-card-checkmark" id="check{i.card_id}"
                     style="background-image: url('resources/icons/ViewService/unchecked.png')">
                </div>
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

        history.arrayOfHistory.push('view-service-pincards');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));

        this.titleName = scope.service.name;
        this.serviceIcon = scope.service.image;
        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];


        cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));

        console.log("cardsArray : ", cardsArray);


        confirmDetails = function () {
            if (!scope.checked) {
                alert("Выберите карту для оплаты");
                return;
            }
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-pay-confirm>";
            riot.mount('view-pay-confirm');

        }

        scope.ind = -1;
        scope.checked = false;

        checkCard = function (id) {
            if (scope.ind != -1) {
                document.getElementById("check" + scope.ind).style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
            }
            scope.ind = id;
            document.getElementById("check" + id).style.backgroundImage = "url(resources/icons/ViewService/checked.png)";
            scope.checked = true;
            viewServicePinCards.chosenCardId = scope.ind;
        }


    </script>
</view-service-pincards>

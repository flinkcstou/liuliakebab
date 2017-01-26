<view-service-pincards class="view-service-pincards">

    <div class="pay-page-title" style="border-style: none;">
        <p class="servicepage-title">Оплата {titleName}</p>
        <p class="servicepage-category-field">{categoryName}</p>
        <div ontouchend="touchStartTitle()"
             class="servicepage-button-back">
        </div>
        <div type="button" class="servicepage-service-icon"
             style="background-image: url({serviceIcon})"></div>
    </div>

    <div class="pincard-body-container">
        <div class="pincard-payfrom-container">
            <p class="pincard-payfrom-field">{window.languages.ViewServicePinCardPayFromField}</p></div>
        <div class="pincard-allcards-container">
            <div class="pincard-card-container" each="{i in cardsArray}" ontouchend="chooseCard(this.id)"
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
                <div class="{pincard-card-uncheckmark: !i.chosenCard, pincard-card-checkmark: i.chosenCard}"
                     id="check{i.card_id}">
                </div>
            </div>
        </div>

        <div class="pincard-bottom-container">
            <div class="pincard-help-text">{window.languages.ViewServicePinCardHelpText}</div>
            <div class="pincard-button-enter"
                 ontouchend="goToPayConfirmView()">
                <div class="pincard-button-enter-label">{window.languages.ViewServicePinCardButtonEnterLabel}</div>
            </div>
        </div>
    </div>


    <script>
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-service-pincards') {
            history.arrayOfHistory.push('view-service-pincards');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
        }

        var scope = this;
        touchStartTitle = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
        scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
        scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
        cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));

        this.titleName = scope.service.name;
        this.categoryName = scope.categoryNamesMap[viewPay.categoryId];

        scope.checked = false;

        chooseCard = function (id) {

            for (var i = 0; i < cardsArray.length; i++) {

                if (cardsArray[i].card_id == id) {
                    scope.checked = true;
                    cardsArray[i].chosenCard = true;
                }
                else
                    cardsArray[i].chosenCard = false;

            }
            localStorage.setItem('click_client_cards', JSON.stringify(cardsArray))
            riot.update(document.getElementById("check" + id))
        }

        goToPayConfirmView = function () {
            for (var i = 0; i < cardsArray.length; i++) {
                if (cardsArray[i].chosenCard) {
                    scope.checked = true;
                    break;
                }
            }
            if (!scope.checked) {
                alert("Выберите карту для оплаты");
                return;
            }
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-pay-confirm>";
            riot.mount('view-pay-confirm');

        }


    </script>
</view-service-pincards>

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

        <component-pincards></component-pincards>
        <div class="pincard-bottom-container">
            <div class="pincard-help-text">{window.languages.ViewServicePinCardHelpText}</div>
            <div class="pincard-button-enter"
                 ontouchend="goToPayConfirmView()">
                <div class="pincard-button-enter-label">{window.languages.ViewServicePinCardButtonEnterLabel}</div>
            </div>
        </div>
    </div>


    <script>
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-pincards') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-service-pincards',
                        "params": ''
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
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


        goToPayConfirmView = function () {
            console.log("cardsArray=", cardsArray);
            for (var i = 0; i < cardsArray.length; i++) {
                if (cardsArray[i].chosenCard) {
                    scope.chosencardId = cardsArray[i].card_id;
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
            riot.mount('view-pay-confirm', [scope.chosencardId]);

        }


    </script>
</view-service-pincards>

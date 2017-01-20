<view-mycard-list>
    <div class="view-pay">
        <div class="mycardlist-page-title">
            <p class="pay-name-title">{titleName}</p>
            <div id="backButton" ontouchend="goToMainPage()"
                 class="back-button">
            </div>
            <div id="rightButton" type="button" class="{search-button: rightbuttoncheck}" ontouchend="search()"></div>
        </div>

        <div class="mycardlist">
            <div class="mycardlist-card" each="{i in cardsarray}" style="background-image: url({i.background});"
                 ontouchend="goToCardPage({i.card_id})">

                <div class="mycardlist-card-bank-name-url" style="background-image: url({i.url})"></div>
                <div class="mycardlist-card-bank-name" style="background-image: url({i.bankname})"></div>
                <div class="mycardlist-card-salary-title">{i.name}</div>

                <div class="mycardlist-card-balance-currency-container">
                    <p class="mycardlist-card-balance">{i.salary}</p>
                    <p class="mycardlist-card-currency">{i.currency}</p>
                </div>

                <div class="mycardlist-card-number">
                    <div class="mycardlist-card-number-part-one">{i.numberPartOne}</div>
                    <p class="mycardlist-number-stars">**** ****</p>
                    <div class="mycardlist-card-number-part-two">{i.numberPartTwo}</div>
                </div>
            </div>
        </div>

    </div>

    <script>
        var scope = this;

        goToMainPage = function () {
            viewMyCardList.chosenCardId = null;
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
        }

        this.titleName = 'МОИ КАРТЫ';

        history.arrayOfHistory.push('view-mycard-list');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

        scope.cardsArray = JSON.parse(localStorage.getItem("click_client_cards"));
        scope.cardsMap = JSON.parse(localStorage.getItem("click_client_cardsMap"));

        //        if (!scope.cardsMap && !scope.cardsArray) {
        //            scope.cardsMap = {};
        //            for (var i = 0; i < scope.cardsArray.length; i++)
        //                scope.cardsMap[cardsArray[i].card_id] = scope.cardsArray[i];
        //            localStorage.setItem("click_client_cardsMap", scope.cardsMap);
        //        }

        goToCardPage = function (cardId) {
            for (var i = 0; i < scope.cardsArray.length; i++)
                if (scope.cardsArray[i].card_id == cardId) {
                    localStorage.setItem('cardNumber', i);
                    alert("cardNumber in list" + i);
                    break;
                }
            viewMyCardList.myCardListBoolean = true;
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-my-cards>";
            riot.mount('view-my-cards');


        }


    </script>
</view-mycard-list>

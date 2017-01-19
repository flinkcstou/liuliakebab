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
            <div class="mycardlist-card" each="{i in cardsarray}" style="background-image: url({i.background});">

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
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-main-page>";
            riot.mount('view-main-page');
        }

        this.titleName = 'МОИ КАРТЫ';

        history.arrayOfHistory.push('view-mycard-list');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

        cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));


    </script>
</view-mycard-list>

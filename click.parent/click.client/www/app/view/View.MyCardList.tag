<view-mycard-list>
    <div class="view-pay">
        <div class="mycardlist-page-title">
            <p class="pay-name-title">{titleName}</p>
            <div id="backButton" ontouchend="goToMainPage()"
                 class="back-button">
            </div>
            <div id="rightButton" type="button" class="{search-button: rightbuttoncheck}" ontouchend="search()"></div>
        </div>

        <div class="mycardList">
            <div class="mycardList-card" each="{i in cardsarray}" style="background-image: url({i.background});">

                <div class="card-bank-name-url" style="background-image: url({i.url})"></div>
                <div class="card-bank-name" style="background-image: url({i.bankname})"></div>
                <div class="card-salary-title">{i.name}</div>

                <div class="card-balance-currency-container">
                    <p class="card-balance">{i.salary}</p>
                    <p class="card-currency">{i.currency}</p>
                </div>

                <div class="card-number">
                    <div class="card-number-part-one">{i.numberPartOne}</div>
                    <p class="number-stars">**** ****</p>
                    <div class="card-number-part-two">{i.numberPartTwo}</div>
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

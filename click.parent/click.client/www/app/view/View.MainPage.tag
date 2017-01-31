<view-main-page>
    <component-menu></component-menu>
    <div id="mainPageId" class="view-main-page">
        <component-toolbar></component-toolbar>
        <component-bank-operations></component-bank-operations>
        <component-service-carousel></component-service-carousel>
        <component-footer></component-footer>
        <component-card-carousel>
        </component-card-carousel>
        <div class="bank-operation-button-my-cards">
            <div class="bank-operation-button-my-cards-container">
                <div class="bank-operation-button-my-cards-icon"></div>
                <div class="bank-operation-button-my-cards-label">
                    {window.languages.BankOperationsAutoPay}
                </div>
                <div class="bank-operation-button-container" ontouchend="myCardList()"></div>
            </div>
        </div>
    </div>
    <script>

        localStorage.setItem('cardNumber', 0);
        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-main-page') {
            history.arrayOfHistory.push(
                    {
                        "view": 'view-main-page',
                        "params": ''
                    }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        viewMainPage.myCards = false;

        myCardList = function () {
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-mycard-list>";
            riot.mount('view-mycard-list');
        }

    </script>
</view-main-page>


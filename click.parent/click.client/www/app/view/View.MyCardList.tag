<view-mycard-list>
    <div class="view-pay">
        <div class="page-title">
            <p class="pay-name-title">{titleName}</p>
            <div id="backButton" ontouchend="goToMainPage()"
                 class="back-button">
            </div>
            <div id="rightButton" type="button" class="{search-button: rightbuttoncheck}" ontouchend="search()"></div>
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


    </script>
</view-mycard-list>

<view-transfer-stepthree>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="{transfer-back-button: backbuttoncheck}"></div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transferthree-body-container">
        <div class="transferthree-menus-container">
                <p id="cardLabelId" class="transferthree-menu-name-label" ontouchend="card()">{window.languages.ViewTransferThreeMenuTitle}</p>
        </div>
        <component-pincards></component-pincards>

            <div class="transferthree-next-button-inner-container" ontouchend="goToTransferFour()">
                <p class="transferthree-next-button-label">ДАЛЕЕ</p>
            </div>

    </div>


    <script>

        this.titleName = window.languages.ViewTransferThreeTitle;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-transfer-stepthree') {
            history.arrayOfHistory.push('view-transfer-stepthree');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

        scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = false;

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);
        //        console.log('PHONE NUMBER ', phoneNumber);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

        scope.contactMode = false;
        scope.cardMode = false;
        contact = function () {
            scope.contactMode = true;
            this.contactLabelId.style.color = 'black';
            this.cardLabelId.style.color = 'gray';
            scope.cardMode = false;
            riot.update(scope.cardMode);
            riot.update(scope.contactMode);
        }

        card = function () {
            scope.cardMode = true;
            this.cardLabelId.style.color = 'black';
            this.contactLabelId.style.color = 'gray';
            scope.contactMode = false;
            riot.update(scope.contactMode);
            riot.update(scope.cardMode);
        }

        goToTransferFour = function () {
            event.preventDefault()
            event.stopPropagation()

            this.riotTags.innerHTML = "<view-transfer-stepfour>";
            riot.mount('view-transfer-stepfour');
        }


    </script>
</view-transfer-stepthree>

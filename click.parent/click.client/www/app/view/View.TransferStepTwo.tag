<view-transfer-steptwo>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="{transfer-back-button: backbuttoncheck}"></div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transfertwo-body-container">
        <div class="transfertwo-menus-container">
            <p id="cardLabelId" class="transfertwo-menu-name-label" ontouchend="card()">{window.languages.ViewTransferTwoSum}</p>
        </div>

        <div class="transfertwo-contact-phone-field">
            <p class="transfertwo-contact-text-field">{window.languages.ViewTransferTwoTax}</p>
            <input class="transfertwo-contact-number-input-part" id="contactPhoneNumberId" autofocus="true" type="tel"
                   onkeyup="searchContacts()"/>
        </div>

        <div class="transfertwo-next-button-inner-container" ontouchend="goToTransferThree()">
            <p class="transfertwo-next-button-label">{window.languages.ViewTransferTwoNext}</p>
        </div>

        <div class="transfertwo-comment-container">
            <textarea maxlength="255" class="transfertwo-comment-input"
                      type="text" placeholder={comment}></textarea>
        </div>

    </div>


    <script>
        console.log(opts);

        this.titleName = window.languages.ViewTransferTwoTitle;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-transfer-steptwo') {
            history.arrayOfHistory.push('view-transfer-steptwo');
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

        scope.comment = 'комментарий';

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);
        //        console.log('PHONE NUMBER ', phoneNumber);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

        scope.contactMode = false;
        scope.cardMode = false;
        contact = function () {
            event.preventDefault()
            event.stopPropagation()
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

        goToTransferThree = function () {
            event.preventDefault()
            event.stopPropagation()

            this.riotTags.innerHTML = "<view-transfer-stepthree>";
            riot.mount('view-transfer-stepthree');
        }



    </script>
</view-transfer-steptwo>

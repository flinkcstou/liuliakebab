<view-transfer-steptwo>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="touchStartTitle()" class="{transfer-back-button: backbuttoncheck}"></div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transfertwo-body-container">
        <div class="transfertwo-menus-container">
            <div class="transfertwo-menu-container-sum">
                <p id="contactLabelId" class="transfertwo-menu-name-label" ontouchend="contact()">СУММА</p>
            </div>
            <div class="transfertwo-menu-container-transfer-to">
                <p id="cardLabelId" class="transfertwo-menu-name-label" ontouchend="card()">ПЕРЕВЕСТИ С</p>
            </div>
        </div>
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
        <div class="transfer-contact-body-container" if="{contactMode}">
            <div class="transfer-contact-phone-field">
                <p class="transfer-contact-number-first-part">+998</p>
                <input class="transfer-contact-number-input-part" type="tel"
                       maxlength="9"/>
            </div>
        </div>
        <div class="transfer-contact-body-container" if="{cardMode}">
            <div class="transfer-contact-phone-field">
                <input class="transfer-contact-number-input-part" type="tel"
                       maxlength="9"/>
            </div>
        </div>
        <div class="transfer-next-button-container">
            <div class="transfer-next-button-inner-container">
                <p class="transfer-next-button-label">ДАЛЕЕ</p>
                <div class="transfer-next-button-icon"></div>
            </div>

        </div>
    </div>


    <script>
        this.titleName = 'ПЕРЕВОД НА 8600 **** 7987';

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-transfer-steptwo') {
            history.arrayOfHistory.push('view-transfer-steptwo');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
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

        //    window.api.call({
        //      method: 'get.service.list',
        //      input : {
        //        session_key: sessionKey,
        //        phone_num  : phoneNumber
        //      },
        //      scope : this,
        //
        //      onSuccess: function (result) {
        //        console.log(result)
        //      },
        //      onFail   : function (api_status, api_status_message, data) {
        //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        //        console.error(data);
        //      }
        //    })
        //
        //    ////////////////////////////////////////////////
        //
        //    window.api.call({
        //      method: 'get.service.parameters.list',
        //      input : {
        //        session_key: sessionKey,
        //        phone_num  : phoneNumber
        //      },
        //      scope : this,
        //
        //      onSuccess: function (result) {
        //        console.log(result)
        //      },
        //      onFail   : function (api_status, api_status_message, data) {
        //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        //        console.error(data);
        //      }
        //    })
        //
        //    ///////////////////////////////////////////////////////////
        //
        //    var asd;
        //    window.api.call({
        //      method: 'app.payment',
        //      input : {
        //        session_key : sessionKey,
        //        phone_num   : phoneNumber,
        //        service_id  : asd,
        //        account_id  : asd,
        //        amount      : asd,
        //        payment_data: asd,
        //        datetime    : asd,
        //        friend_phone: asd,
        //      },
        //      scope : this,
        //
        //      onSuccess: function (result) {
        //        console.log(result)
        //      },
        //      onFail   : function (api_status, api_status_message, data) {
        //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        //        console.error(data);
        //      }
        //    })
        //
        //    ///////////
        //
        //    window.api.call({
        //      method: 'app.payment.repeat',
        //      input : {
        //        session_key      : sessionKey,
        //        phone_num        : phoneNumber,
        //        repeat_payment_id: asd,
        //        transaction_id   : asd,
        //        amount           : asd,
        //      },
        //      scope : this,
        //
        //      onSuccess: function (result) {
        //        console.log(result)
        //      },
        //      onFail   : function (api_status, api_status_message, data) {
        //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        //        console.error(data);
        //      }
        //    })
        //
        //    ////////////////////////////////
        //    window.api.call({
        //      method: 'p2p.bank.list',
        //      input : {
        //        session_key: sessionKey,
        //        phone_num  : phoneNumber
        //      },
        //      scope : this,
        //
        //      onSuccess: function (result) {
        //        console.log(result)
        //      },
        //      onFail   : function (api_status, api_status_message, data) {
        //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        //        console.error(data);
        //      }
        //    })

    </script>
</view-transfer-steptwo>

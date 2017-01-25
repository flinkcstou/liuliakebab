<view-transfer-steptwo>
    <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
    </component-page-title>

    <div class="transfertwo-body-container">
        <div class="transfertwo-menus-container">
            <div class="transfertwo-menu-container">
                <p id="contactLabelId" class="transfertwo-menu-name-label" ontouchend="contact()">СУММА</p>
            </div>
            <div class="transfertwo-menu-container">
                <p id="cardLabelId" class="transfertwo-menu-name-label" ontouchend="card()">ПЕРЕВЕСТИ С</p>
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
                <p class="transfer-contact-number-first-part">8600</p>
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

        if(history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-transfer-steptwo') {
            history.arrayOfHistory.push('view-transfer-steptwo');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = true;

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

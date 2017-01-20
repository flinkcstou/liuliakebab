<view-transfer>
    <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
    </component-page-title>

    <div class="transfer-body-container">
        <div class="transfer-menus-container">
            <div class="transfer-menu-container">
                <div class="transfer-menu-icon"></div>
                <p class="transfer-menu-name-label">КОНТАКТ</p>
            </div>
            <div class="transfer-menu-container">
                <div class="transfer-menu-icon"></div>
                <p class="transfer-menu-name-label">КАРТА</p>
            </div>
        </div>
        <div class="transfer-contact-body-container">
            <div class="transfer-contact-phone-field">
                <p class="transfer-contact-text-field">Номер телефона получателя</p>
                <p class="transfer-contact-number-first-part">+998</p>
                <input class="transfer-contact-number-input-part" type="tel"
                       maxlength="9"/>
                <div class="transfer-contact-phone-icon"></div>
            </div>
            <div class="transfer-contact-found-container">
                <div class="transfer-contact-found-photo"></div>
                <div class="transfer-contact-found-text-one">Юлдашев Александр</div>
                <div class="transfer-contact-found-text-two">+998 90 359 39 57</div>
            </div>
            <div class="transfer-contact-found-container">
                <div class="transfer-contact-found-photo"></div>
                <div class="transfer-contact-found-text-one">Sipa</div>
                <div class="transfer-contact-found-text-two">+998 90 359 51 98</div>
            </div>
        </div>


    </div>


    <script>
        this.titleName = 'ПЕРЕВОДЫ';

        history.arrayOfHistory.push('view-transfer');
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

        scope = this;
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = true;

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);
        console.log('PHONE NUMBER ', phoneNumber);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

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
</view-transfer>

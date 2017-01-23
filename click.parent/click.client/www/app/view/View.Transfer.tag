<view-transfer>
    <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
    </component-page-title>

    <div class="transfer-body-container">
        <div class="transfer-menus-container">
            <div class="transfer-menu-container">
                <div class="transfer-menu-icon"></div>
                <p id="contactLabelId" class="transfer-menu-name-label" ontouchend="contact()">КОНТАКТ</p>
            </div>
            <div class="transfer-menu-container">
                <div class="transfer-menu-icon"></div>
                <p id="cardLabelId" class="transfer-menu-name-label" ontouchend="card()">КАРТА</p>
            </div>
        </div>
        <div class="transfer-contact-body-container" if="{contactMode}">
            <div class="transfer-contact-phone-field">
                <p class="transfer-contact-text-field">Номер телефона получателя:</p>
                <p class="transfer-contact-number-first-part">+998</p>
                <input class="transfer-contact-number-input-part" type="tel"
                       maxlength="9" onkeyup="searchContacts()"/>
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
        <div class="transfer-contact-body-container" if="{cardMode}">
            <div class="transfer-contact-phone-field">
                <p class="transfer-contact-text-field">Номер карты получателя:</p>
                <p class="transfer-contact-number-first-part">8600</p>
                <input class="transfer-contact-number-input-part" type="tel"
                       maxlength="9"/>
                <div class="transfer-contact-phone-icon"></div>
            </div>
            <div class="transfer-contact-found-container">
                <div class="transfer-contact-found-photo"></div>
                <div class="transfer-contact-found-text-one">Юлдашев Александр</div>
                <div class="transfer-contact-found-text-two">8760 **** **** 9870</div>
            </div>
            <div class="transfer-contact-found-container">
                <div class="transfer-contact-found-photo"></div>
                <div class="transfer-contact-found-text-one">Дмитрий Чеченин</div>
                <div class="transfer-contact-found-text-two">8760 **** **** 9870</div>
            </div>
        </div>
        <div class="transfer-next-button-container">
            <div class="transfer-next-button-inner-container" ontouchend="goToTransferStepTwo()">
                <p class="transfer-next-button-label">ДАЛЕЕ</p>
                <div class="transfer-next-button-icon"></div>
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

        scope.contactMode = true;
        this.contactLabelId.style.color = 'black';
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

        goToTransferStepTwo = function () {
            event.preventDefault();
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-transfer-steptwo>";
            riot.mount('view-transfer-steptwo');
        }

        var arrayOfContacts = [];


        findContacts = function () {
            var options = new ContactFindOptions();
            options.filter = "";
            options.multiple = true;
            var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
            navigator.contacts.find(fields, success, error, options);

            function success(contacts) {
                for (var i = 0; i < contacts.length; i++) {
                    if ((contacts[i].name.familyName != null || contacts[i].name.givenName) && contacts[i].phoneNumbers != null)
                        arrayOfContacts.push(contacts[i])
                }
                console.log('arrayOfContacts', arrayOfContacts);
            }

            function error(message) {
                alert('Failed because: ' + message);
            }
        }
        if (device.platform != 'BrowserStand')
            findContacts();

        searchContacts = function () {

        }


    </script>
</view-transfer>

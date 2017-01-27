<view-transfer>
    <div class="transfer-page-title">
        <p class="transfer-name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()"
             class="{transfer-back-button: backbuttoncheck}">

        </div>
        <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
    </div>

    <div class="transfer-body-container">
        <div class="transfer-menus-container">
            <div class="transfer-menu-container-contact" ontouchend="contact()">
                <div class="transfer-menu-contact-icon"></div>
                <p id="contactLabelId" class="transfer-menu-contact-label">
                    {window.languages.ViewPayTransferMenuNameContact}</p>
            </div>
            <div class="transfer-menu-container-card" ontouchend="card()">
                <div class="transfer-menu-card-icon"></div>
                <p id="cardLabelId" class="transfer-menu-card-label">{window.languages.ViewPayTransferMenuNameCard}</p>
            </div>
        </div>
        <div class="transfer-contact-body-container" if="{contactMode}">
            <div class="transfer-contact-phone-field">
                <p class="transfer-contact-text-field">{window.languages.ViewPayTransferContactTextField}</p>
                <p class="transfer-contact-number-first-part">+998</p>
                <input autofocus="true" class="transfer-contact-number-input-part" type="tel"
                       maxlength="9" onkeyup="searchContacts()"/>
                <div class="transfer-contact-phone-icon"></div>
            </div>
            <div id="firstSuggestionBlockId" class="transfer-contact-found-container-one">
                <div class="transfer-contact-found-photo" style="background-image: url({suggestionOne.photo})"></div>
                <div class="transfer-contact-found-text-container">
                    <div class="transfer-contact-found-text-one">{suggestionOne.fName} {suggestionOne.lName}</div>
                </div>
                <div class="transfer-contact-found-text-two">{suggestionOne.phoneNumber}</div>
            </div>
            <div id="secondSuggestionBlockId" class="transfer-contact-found-container-two">
                <div class="transfer-contact-found-photo" style="background-image: url({suggestionTwo.photo})"></div>
                <div class="transfer-contact-found-text-container">
                    <div class="transfer-contact-found-text-one">{suggestionTwo.fName} {suggestionTwo.lName}</div>
                </div>
                <div class="transfer-contact-found-text-two">{suggestionTwo.phoneNumber}</div>
            </div>
        </div>
        <div class="transfer-contact-body-container" if="{cardMode}">
            <div class="transfer-contact-phone-field">
                <p class="transfer-contact-text-field">{window.languages.ViewPayTransferCardTextField}</p>
                <input id="cardInputId" class="transfer-card-number-input-part" type="tel"
                       maxlength="19" onkeyup="searchCard()"/>
                <div class="transfer-contact-phone-icon"></div>
            </div>
            <div class="transfer-contact-found-container-one">
                <div class="transfer-contact-found-photo"></div>
                <div class="transfer-contact-found-text-one">Юлдашев Александр</div>
                <div class="transfer-contact-found-text-two">8760 **** **** 9870</div>
            </div>
            <div class="transfer-contact-found-container-two">
                <div class="transfer-contact-found-photo"></div>
                <div class="transfer-contact-found-text-one">Дмитрий Чеченин</div>
                <div class="transfer-contact-found-text-two">8760 **** **** 9870</div>
            </div>
        </div>

        <div class="transfer-next-button-inner-container" ontouchend="goToTransferStepTwo()">
            <p class="transfer-next-button-label">{window.languages.ViewPayTransferNext}</p>
        </div>


    </div>


    <script>

        var scope = this;
        this.titleName = 'ПЕРЕВОДЫ';

        scope.suggestionOne = {};
        scope.suggestionOne.photo = '';
        scope.suggestionOne.fName = '';
        scope.suggestionOne.lName = '';

        scope.suggestionTwo = {};
        scope.suggestionTwo.photo = '';
        scope.suggestionTwo.fName = '';
        scope.suggestionTwo.lName = '';

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1] != 'view-transfer') {
            history.arrayOfHistory.push('view-transfer');
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }

        scope.searchWord = '';
        scope.backbuttoncheck = true;
        scope.rightbuttoncheck = true;

        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        phoneNumber = phoneNumber.substring(3, phoneNumber.length);
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

        scope.contactMode = true;

        scope.cardMode = false;

        goToBack = function () {
            event.preventDefault();
            event.stopPropagation();
            onBackKeyDown()
        }

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
            }

            function error(message) {
                alert('Failed because: ' + message);
            }
        }
        if (device.platform != 'BrowserStand')
            findContacts();

        searchContacts = function () {
            event.preventDefault();
            event.stopPropagation();

            var countOfFound = 0;
            var check = false;

            if (event.keyCode != 16 && event.keyCode != 18)
                scope.searchWord = event.target.value;

            arrayOfContacts.filter(function (wordOfFunction) {

                console.log(wordOfFunction)
                var index = wordOfFunction.phoneNumbers[0].value.indexOf(scope.searchWord);
                if (index != -1 && countOfFound < 2) {

                    check = true;

                    if (countOfFound == 0) {

                        scope.suggestionOne.phoneNumber = wordOfFunction.phoneNumbers[0].value;
                        scope.suggestionOne.fName = wordOfFunction.name.givenName;
                        scope.suggestionOne.lName = wordOfFunction.name.familyName;

                        if (wordOfFunction.photos != null)
                            if (wordOfFunction.photos[0] != null)
                                scope.suggestionOne.photo = wordOfFunction.photos[0].value;


                        riot.update(scope.suggestionOne)

                        scope.firstSuggestionBlockId.style.display = 'block';
                        scope.secondSuggestionBlockId.style.display = 'none';
                    }

                    if (countOfFound == 1) {

                        scope.suggestionTwo.phoneNumber = wordOfFunction.phoneNumbers[0].value;
                        scope.suggestionTwo.fName = wordOfFunction.name.givenName;
                        scope.suggestionTwo.lName = wordOfFunction.name.familyName;

                        if (wordOfFunction.photos != null)
                            if (wordOfFunction.photos[0] != null)
                                scope.suggestionTwo.photo = wordOfFunction.photos[0].value;

                        riot.update(scope.suggestionTwo)

                        scope.secondSuggestionBlockId.style.display = 'block';
                    }
                    countOfFound++;
                    if (countOfFound == 2)
                        return;
                }
                else if (!check) {
                    scope.firstSuggestionBlockId.style.display = 'none';
                    scope.secondSuggestionBlockId.style.display = 'none';
                }
            });
        }

        searchCard = function () {

            var suggestionCard = [];

            if (localStorage.getItem('click_client_suggestion_cards'))
                suggestionCard = JSON.parse(localStorage.getItem('click_client_suggestion_cards'))
//            else
//                localStorage.setItem('click_client_suggestion_cards')
            if ((scope.cardInputId.value.length == 4 || scope.cardInputId.value.length == 9 || scope.cardInputId.value.length == 14) && event.keyCode != 8) {
                scope.cardInputId.value += ' ';

            }
        }


    </script>
</view-transfer>

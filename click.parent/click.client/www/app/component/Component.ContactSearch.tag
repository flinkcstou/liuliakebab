<component-contact-search id="blockSearchId" class="component-contact-search">
    <div class="contact-search-title-container">
        <div class="contact-search-search-icon"></div>
        <p class="contact-search-title-name">{window.languages.ComponentContactSearchTitle}</p>
        <div class="contact-search-cancel-icon" ontouchend="searchCancelEnd()"></div>
    </div>
    <div id="searchContainerId" class="contact-search-container">
        <div class="contact-search-phone-field">
            <p class="contact-number-first-part">+{window.languages.CodeOfCountry}</p>

            <input id="contactPhoneNumberId" autofocus="true" type="tel" maxlength="9" class="contact-search-input"
                   onkeyup="searchContacts()"/>
        </div>
        <div class="contact-search-suggestion-container">

            <div id="firstSuggestionBlockId" class="contact-search-suggestion-field-one"
                 ontouchend="firstSuggestionBlock()">
                <div class="contact-search-found-photo" style="background-image: url({suggestionOne.photo})"></div>
                <div class="contact-search-found-text-container">
                    <div class="contact-search-found-text-one">{suggestionOne.fName} {suggestionOne.lName}</div>
                </div>
                <div class="contact-search-found-text-two">{suggestionOne.phoneNumber}</div>
            </div>
            <div id="secondSuggestionBlockId" class="contact-search-suggestion-field-two"
                 ontouchend="secondSuggestionBlock()">
                <div class="contact-search-found-photo" style="background-image: url({suggestionTwo.photo})"></div>
                <div class="contact-search-found-text-container">
                    <div class="contact-search-found-text-one">{suggestionTwo.fName} {suggestionTwo.lName}</div>
                </div>
                <div class="contact-search-found-text-two">{suggestionTwo.phoneNumber}</div>
            </div>
            <div id="thirdSuggestionBlockId" class="contact-search-suggestion-field-three"
                 ontouchend="thirdSuggestionBlock()">
                <div class="contact-search-found-photo" style="background-image: url({suggestionThree.photo})"></div>
                <div class="contact-search-found-text-container">
                    <div class="contact-search-found-text-one">{suggestionThree.fName} {suggestionThree.lName}</div>
                </div>
                <div class="contact-search-found-text-two">{suggestionThree.phoneNumber}</div>
            </div>
            <div id="fourthSuggestionBlockId" class="contact-search-suggestion-field-four"
                 ontouchend="fourthSuggestionBlock()">
                <div class="contact-search-found-photo" style="background-image: url({suggestionFour.photo})"></div>
                <div class="contact-search-found-text-container">
                    <div class="contact-search-found-text-one">{suggestionFour.fName} {suggestionFour.lName}</div>
                </div>
                <div class="contact-search-found-text-two">{suggestionFour.phoneNumber}</div>
            </div>

        </div>
    </div>

    <script>
        var scope = this;

        scope.suggestionOne = {};
        scope.suggestionOne.photo = '';
        scope.suggestionOne.fName = '';
        scope.suggestionOne.lName = '';

        scope.suggestionTwo = {};
        scope.suggestionTwo.photo = '';
        scope.suggestionTwo.fName = '';
        scope.suggestionTwo.lName = '';

        scope.suggestionThree = {};
        scope.suggestionThree.photo = '';
        scope.suggestionThree.fName = '';
        scope.suggestionThree.lName = '';

        scope.suggestionFour = {};
        scope.suggestionFour.photo = '';
        scope.suggestionFour.fName = '';
        scope.suggestionFour.lName = '';

        scope.searchWord = '';

        searchContact = function () {
            event.preventDefault();
            event.stopPropagation();
            blockSearchId.style.display = 'block';
            if (scope.categoryList)
                arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);
            if (device.platform != 'BrowserStand')
                StatusBar.backgroundColorByHexString("#353340");
        }

        searchCancelEnd = function () {
            event.preventDefault();
            event.stopPropagation();
            blockSearchId.style.display = 'none';
            if (device.platform != 'BrowserStand')
                StatusBar.backgroundColorByHexString("#007AE2");
            scope.searchWord = '';
            Keyboard.hide();
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

                var index = wordOfFunction.phoneNumbers[0].value.indexOf(scope.searchWord);
                if (index != -1 && countOfFound < 4) {

                    check = true;

                    if (countOfFound == 0) {

                        scope.suggestionOne.phoneNumber = wordOfFunction.phoneNumbers[0].value;
                        scope.suggestionOne.fName = wordOfFunction.name.givenName;
                        scope.suggestionOne.lName = wordOfFunction.name.familyName;

                        if (wordOfFunction.photos != null) {
                            if (wordOfFunction.photos[0] != null)
                                scope.suggestionOne.photo = wordOfFunction.photos[0].value;
                            else
                                scope.suggestionOne.photo = '';
                        }
                        else
                            scope.suggestionOne.photo = '';


                        riot.update(scope.suggestionOne)

                        firstSuggestionBlockId.style.display = 'block';
                        secondSuggestionBlockId.style.display = 'none';
                        thirdSuggestionBlockId.style.display = 'none';
                        fourthSuggestionBlockId.style.display = 'none';
                    }

                    if (countOfFound == 1) {

                        scope.suggestionTwo.phoneNumber = wordOfFunction.phoneNumbers[0].value;
                        scope.suggestionTwo.fName = wordOfFunction.name.givenName;
                        scope.suggestionTwo.lName = wordOfFunction.name.familyName;

                        if (wordOfFunction.photos != null) {
                            if (wordOfFunction.photos[0] != null)
                                scope.suggestionTwo.photo = wordOfFunction.photos[0].value;
                            else
                                scope.suggestionTwo.photo = '';
                        }
                        else
                            scope.suggestionTwo.photo = '';

                        riot.update(scope.suggestionTwo)

                        firstSuggestionBlockId.style.display = 'block';
                        secondSuggestionBlockId.style.display = 'block';
                        thirdSuggestionBlockId.style.display = 'none';
                        fourthSuggestionBlockId.style.display = 'none';
                    }

                    if (countOfFound == 2) {

                        scope.suggestionThree.phoneNumber = wordOfFunction.phoneNumbers[0].value;
                        scope.suggestionThree.fName = wordOfFunction.name.givenName;
                        scope.suggestionThree.lName = wordOfFunction.name.familyName;

                        if (wordOfFunction.photos != null) {
                            if (wordOfFunction.photos[0] != null)
                                scope.suggestionThree.photo = wordOfFunction.photos[0].value;
                            else
                                scope.suggestionThree.photo = '';
                        }
                        else
                            scope.suggestionThree.photo = '';

                        riot.update(scope.suggestionThree)

                        firstSuggestionBlockId.style.display = 'block';
                        secondSuggestionBlockId.style.display = 'block';
                        thirdSuggestionBlockId.style.display = 'block';
                        fourthSuggestionBlockId.style.display = 'none';

                    }

                    if (countOfFound == 3) {

                        scope.suggestionFour.phoneNumber = wordOfFunction.phoneNumbers[0].value;
                        scope.suggestionFour.fName = wordOfFunction.name.givenName;
                        scope.suggestionFour.lName = wordOfFunction.name.familyName;

                        if (wordOfFunction.photos != null) {
                            if (wordOfFunction.photos[0] != null)
                                scope.suggestionFour.photo = wordOfFunction.photos[0].value;
                            else
                                scope.suggestionFour.photo = '';
                        }
                        else
                            scope.suggestionFour.photo = '';

                        riot.update(scope.suggestionFour)

                        firstSuggestionBlockId.style.display = 'block';
                        secondSuggestionBlockId.style.display = 'block';
                        thirdSuggestionBlockId.style.display = 'block';
                        fourthSuggestionBlockId.style.display = 'block';
                    }

                    countOfFound++;
                    if (countOfFound == 2)
                        return;
                }
                else if (!check) {
                    firstSuggestionBlockId.style.display = 'none';
                    secondSuggestionBlockId.style.display = 'none';
                    thirdSuggestionBlockId.style.display = 'none';
                    fourthSuggestionBlockId.style.display = 'none';
                }
            });
        }

        firstSuggestionBlock = function () {
            event.preventDefault();
            event.stopPropagation();

            contactPhoneNumberId.value = scope.suggestionOne.phoneNumber.substring(3, scope.suggestionOne.phoneNumber.length).replace(/\s/g, '');
        }

        secondSuggestionBlock = function () {
            event.preventDefault();
            event.stopPropagation();

            contactPhoneNumberId.value = scope.suggestionTwo.phoneNumber.substring(3, scope.suggestionTwo.phoneNumber.length).replace(/\s/g, '');
        }

        thirdSuggestionBlock = function () {
            event.preventDefault();
            event.stopPropagation();

            contactPhoneNumberId.value = scope.suggestionThree.phoneNumber.substring(3, scope.suggestionThree.phoneNumber.length).replace(/\s/g, '');
        }

        fourthSuggestionBlock = function () {
            event.preventDefault();
            event.stopPropagation();

            contactPhoneNumberId.value = scope.suggestionFour.phoneNumber.substring(3, scope.suggestionFour.phoneNumber.length).replace(/\s/g, '');
        }


    </script>
</component-contact-search>
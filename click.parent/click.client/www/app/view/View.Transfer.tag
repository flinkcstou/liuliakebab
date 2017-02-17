<view-transfer>
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()"
         class="{transfer-back-button: backbuttoncheck}">

    </div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
  </div>

  <div class="transfer-body-container">
    <div id="menuContainerId" class="transfer-menus-container">
      <div class="transfer-menu-container-contact" ontouchend="contact()">
        <div id="contactIconId" class="transfer-menu-contact-icon"></div>
        <p id="contactLabelId" class="transfer-menu-contact-label">
          {window.languages.ViewPayTransferMenuNameContact}</p>
      </div>
      <div class="transfer-menu-container-card" ontouchend="card()">
        <div id="cardIconId" class="transfer-menu-card-icon"></div>
        <p id="cardLabelId" class="transfer-menu-card-label">{window.languages.ViewPayTransferMenuNameCard}</p>
      </div>
    </div>
    <contact-input-field class="transfer-contact-body-container" if="{contactMode}">
      <div class="transfer-contact-phone-field">
        <p class="transfer-contact-text-field">{window.languages.ViewPayTransferContactTextField}</p>
        <p class="transfer-contact-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input id="contactPhoneNumberId" autofocus="true" class="transfer-contact-number-input-part" type="tel"
               maxlength="9" onkeyup="searchContacts()"/>
        <div class="transfer-contact-phone-icon" ontouchend="pickContactFromNative()"></div>
      </div>
      <div id="firstSuggestionBlockId" class="transfer-contact-found-container-one"
           ontouchend="firstSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionOne.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionOne.fName} {suggestionOne.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionOne.phoneNumber}</div>
      </div>
      <div id="secondSuggestionBlockId" class="transfer-contact-found-container-two"
           ontouchend="secondSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionTwo.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionTwo.fName} {suggestionTwo.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionTwo.phoneNumber}</div>
      </div>
    </contact-input-field>
    <card-input-field class="transfer-contact-body-container" if="{cardMode}">
      <div class="transfer-contact-phone-field">
        <p class="transfer-contact-text-field">{window.languages.ViewPayTransferCardTextField}</p>
        <input id="cardInputId" class="transfer-card-number-input-part" type="tel"
               maxlength="19" onkeydown="searchCard()"/>
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
    </card-input-field>

    <div class="transfer-next-button-inner-container" ontouchend="goToTransferStepTwo()">
      <p class="transfer-next-button-label">{window.languages.ViewPayTransferNext}</p>
    </div>


  </div>
  <script>

    this.on('mount', function () {
      if (viewTransfer.type == 2)
        contact();
      else
        card();
    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    pickContactFromNative = function() {
      navigator.contacts.pickContact(function (contact) {
        console.log('The following contact has been selected:' + JSON.stringify(contact));
      }, function (err) {
        console.log('Error: ' + err);
      });
    }


    this.titleName = window.languages.ViewPayTransferTitle;
    var scope = this,
      phoneNumberForTransfer = '',
      cardNumberForTransfer = '',
      arrayOfContacts = [];


    scope.suggestionOne = {};
    scope.suggestionOne.photo = '';
    scope.suggestionOne.fName = '';
    scope.suggestionOne.lName = '';

    scope.suggestionTwo = {};
    scope.suggestionTwo.photo = '';
    scope.suggestionTwo.fName = '';
    scope.suggestionTwo.lName = '';

    scope.searchWord = '';
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;

    if (viewTransfer.phoneNumber.length > 0 || viewTransfer.cardNumber.length > 0) {
      if (viewTransfer.type == 2) {
        scope.contactMode = true;
        scope.cardMode = false;
      }
      if (viewTransfer.type == 1) {
        scope.contactMode = false;
        scope.cardMode = true;
      }
    }
    else {
      scope.contactMode = true;
      scope.cardMode = false;
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }


    contact = function () {
      event.preventDefault();
      event.stopPropagation();

      menuContainerId.style.backgroundImage = 'url(resources/icons/ViewTransfer/contactMenu.png)';
      scope.contactMode = true;
      this.contactLabelId.style.color = 'black';
      this.cardLabelId.style.color = 'gray';
      this.contactIconId.style.opacity = '1'
      this.cardIconId.style.opacity = '0.5'
      scope.cardMode = false;
      riot.update(scope.cardMode);
      riot.update(scope.contactMode);
      contactPhoneNumberId.value = viewTransfer.phoneNumber;

      viewTransfer.type = 2;
    }

    card = function () {
      event.preventDefault();
      event.stopPropagation();

      menuContainerId.style.backgroundImage = 'url(resources/icons/ViewTransfer/cardMenu.png)';
      scope.cardMode = true;
      this.cardLabelId.style.color = 'black';
      this.contactLabelId.style.color = 'gray';
      this.cardIconId.style.opacity = '1'
      this.contactIconId.style.opacity = '0.5'
      scope.contactMode = false;

      riot.update(scope.contactMode);
      riot.update(scope.cardMode);
      cardInputId.value = viewTransfer.cardNumber

      viewTransfer.type = 1;
    }


    goToTransferStepTwo = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!checkPhoneForTransfer && !checkCardForTransfer)
        alert('Write phone number or card number for transfer')
      else {
        if (viewTransfer.type == 2) {
          phoneNumberForTransfer = contactPhoneNumberId.value;
          viewTransfer.phoneNumber = phoneNumberForTransfer;
          viewTransfer.type = 2;
          if (phoneNumberForTransfer.length != 9) {
            alert('Incorrect phone number')
            return
          }
          else {
            phoneNumberForTransfer = window.languages.CodeOfCountry + phoneNumberForTransfer
            this.riotTags.innerHTML = "<view-transfer-steptwo>";
            riot.mount('view-transfer-steptwo', [
              {
                "name": phoneNumberForTransfer,
                "type": 2
              }
            ]);
            return
          }
        }

        if (viewTransfer.type == 1) {
          cardNumberForTransfer = cardInputId.value;
          viewTransfer.cardNumber = cardNumberForTransfer
          viewTransfer.type = 1;
          if (cardNumberForTransfer.length != 19) {
            alert('Incorrect card number')
            return
          }
          else {
            var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
            var phoneNumber = localStorage.getItem('click_client_phoneNumber');

            window.api.call({
              method: 'p2p.card.info',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                card_number: cardNumberForTransfer.replace(/\s/g, ''),

              },

              scope: this,

              onSuccess: function (result) {
                if (result[0][0].error == 0) {
                  console.log("result of APP.PAYMENT ", result);
                }
                else
                  alert(result[0][0].error_note);
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
            this.riotTags.innerHTML = "<view-transfer-steptwo>";
            riot.mount('view-transfer-steptwo', [
              {
                "name": cardNumberForTransfer,
                "type": 1
              }
            ]);
            return
          }
        }
      }

    }

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
      checkPhoneForTransfer = true;
      checkCardForTransfer = false;
      event.preventDefault();
      event.stopPropagation();

      var countOfFound = 0;
      var check = false;

      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = event.target.value;

      arrayOfContacts.filter(function (wordOfFunction) {

        var index = wordOfFunction.phoneNumbers[0].value.indexOf(scope.searchWord);
        if (index != -1 && countOfFound < 2) {

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

            secondSuggestionBlockId.style.display = 'block';
          }
          countOfFound++;
          if (countOfFound == 2)
            return;
        }
        else if (!check) {
          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
        }
      });
    }

    searchCard = function () {
      checkPhoneForTransfer = false;
      checkCardForTransfer = true;

      var suggestionCard = [];

      if (localStorage.getItem('click_client_suggestion_cards'))
        suggestionCard = JSON.parse(localStorage.getItem('click_client_suggestion_cards'))
//            else
//                localStorage.setItem('click_client_suggestion_cards')
      if ((cardInputId.value.length == 4 || cardInputId.value.length == 9 || cardInputId.value.length == 14) && event.keyCode != 8) {
        cardInputId.value += ' ';

      }
    }

    var maskOne = /[0-9]/g;

    firstSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      var digits = scope.suggestionOne.phoneNumber.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      scope.suggestionOne.phoneNumber = phone;
      console.log(scope.suggestionOne.phoneNumber)
      contactPhoneNumberId.value = scope.suggestionOne.phoneNumber.substring(scope.suggestionOne.phoneNumber.length - 9, scope.suggestionOne.phoneNumber.length);
    }

    secondSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      var digits = scope.suggestionTwo.phoneNumber.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      scope.suggestionTwo.phoneNumber = phone;

      contactPhoneNumberId.value = scope.suggestionTwo.phoneNumber.substring(scope.suggestionTwo.phoneNumber.length - 9, scope.suggestionTwo.phoneNumber.length);
    }


  </script>
</view-transfer>

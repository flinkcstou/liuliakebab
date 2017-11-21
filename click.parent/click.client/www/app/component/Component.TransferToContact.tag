<component-transfer-to-contact>
  <div class="transfer-new-contact-phone-field">
    <p class="transfer-new-contact-text-field">{window.languages.ViewPayTransferNewContactTextField}</p>
    <p class="transfer-new-contact-number-first-part">+{window.languages.CodeOfCountry}</p>
    <input id="contactPhoneNumberId"
           class="transfer-new-contact-number-input-part"
           type="tel"
           onpaste="onPasteTrigger()"
           oninput="contactPhoneBlurAndChange()"
           onchange="contactPhoneBlurAndChange()"
           onkeyup="searchContacts()"
           onkeydown="telTransferVerificationKeyDown(this)"/>
    <div class="transfer-new-contact-phone-icon"
         role="button"
         aria-label="{window.languages.ChooseFromContacts}"
         ontouchstart="pickContactFromNativeTouchStart()"
         ontouchend="pickContactFromNativeTouchEnd()">
    </div>
  </div>
  <div id="contactPhoneSuggestions" class="transfer-new-contact-suggestions-container">
    <div each="{i in phoneSuggestionsArray}"
         id="{'id'+i.id}"
         class="transfer-new-contact-suggestion"
         ontouchstart="phoneSuggestionTouchStart()"
         ontouchend="phoneSuggestionTouchEnd({i.phone})">
      <div class="transfer-contact-found-photo" style="background-image: url({i.photo})">
        {i.firstLetter}
      </div>
      <div class="transfer-contact-found-text-container">
        <div class="transfer-contact-found-text-one">{i.familyName} {i.name}</div>
      </div>
      <div class="transfer-contact-found-text-two">{i.phone}</div>
    </div>
  </div>

  <script>

    var scope = this;
    var onPaste = false;
    var contactStopChanging = false;
    var arrayOfContacts = [];
    var transferContactTouchStartX,
      transferContactTouchStartY,
      transferContactTouchEndX,
      transferContactTouchEndY;
    scope.numberLength = 10;
    scope.searchNumber = '';
    scope.phoneSuggestionsArray = [];

    //Find contacts after page is loaded
    findContacts = function () {
      var options = new ContactFindOptions();
      var fields = [''];
      options.filter = "";
      options.multiple = true;
      options.desiredFields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.phoneNumbers];
      navigator.contacts.find(fields, success, error, options);
      function success(contacts) {
        for (var i = 0; i < contacts.length; i++) {
          if (contacts[i].name)
            if ((contacts[i].name.familyName !== null || contacts[i].name.givenName !== null) && contacts[i].phoneNumbers !== null) {
              for (var j = 0; j < contacts[i].phoneNumbers.length; j++) {
                var phone = inputVerification.telVerification(contacts[i].phoneNumbers[j].value);
                contacts[i].phoneNumbers[j].value = phone;
              }
              arrayOfContacts.push(contacts[i])
            }
        }
      }

      function error(message) {
        scope.accessToContacts = false;
        scope.update();
      }
    };
    if (device.platform !== 'BrowserStand') {
      try {
        findContacts();
      }
      catch (e) {
        console.log(e)
      }
    }

    //Contact phone input handler
    contactPhoneBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();
      if (onPaste) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(contactPhoneNumberId.value));
        onPaste = false;
      }
      scope.contactMode = true;
      scope.cardMode = false;
      checkPhoneNumberLength();
      scope.update();
    };

    //Search contacts in phonebook and verify contactPhoneNumber input
    searchContacts = function () {

      event.preventDefault();
      event.stopPropagation();

      var index = -1;

      if (contactStopChanging) {
        contactPhoneNumberId.value = event.target.value.substring(0, event.target.value.length - 1);
      }
      cursorPositionSelectionStart = contactPhoneNumberId.selectionStart;
      cursorPositionSelectionEnd = contactPhoneNumberId.selectionEnd;
      oldValueOfNumber = contactPhoneNumberId.value;
      if (event.keyCode !== input_codes.BACKSPACE_CODE
        && event.keyCode !== input_codes.NEXT) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(contactPhoneNumberId.value);
        contactPhoneNumberId.selectionStart = cursorPositionSelectionStart;
        contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd;

        if (oldValueOfNumber !== contactPhoneNumberId.value
          && cursorPositionSelectionStart === 3)
          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart + 1;
      }

      if (event.keyCode !== 16 && event.keyCode !== 18)
        scope.searchNumber = inputVerification.spaceDeleter(event.target.value);

      scope.phoneSuggestionsArray = [];

      arrayOfContacts.forEach(function (contactInBook) {
        if (contactInBook.phoneNumbers && scope.phoneSuggestionsArray.length < 5) {
          for (var i in contactInBook.phoneNumbers) {
            index = contactInBook.phoneNumbers[i].value.indexOf(scope.searchNumber);
            if (index !== -1) {
              suggestion = {
                phone: contactInBook.phoneNumbers[i].value,
                name: contactInBook.name.givenName,
                familyName: contactInBook.name.familyName,
                id: "suggestion" + scope.phoneSuggestionsArray.length,
              };
              if (suggestion.name) {
                suggestion.firstLetter = suggestion.name[0].toUpperCase();
              }
              else if (suggestion.familyName) {
                suggestion.firstLetter = suggestion.firstLetter[0].toUpperCase();
              }
              if (contactInBook.photos) {
                suggestion.photo = contactInBook.photos[0].value;
              }
              scope.phoneSuggestionsArray.push(suggestion);
              break;
            }
          }
        }
      });
      checkPhoneNumberLength();
      scope.update();
    };

    //Check changing contact input
    telTransferVerificationKeyDown = function (input) {
      contactStopChanging = input.value.length >= scope.numberLength
        && event.keyCode !== input_codes.BACKSPACE_CODE
        && event.keyCode !== input_codes.NEXT;
    };

    onPasteTrigger = function () {
      onPaste = true;
    };

    phoneSuggestionTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();
      transferContactTouchStartX = event.changedTouches[0].pageX;
      transferContactTouchStartY = event.changedTouches[0].pageY;
    };

    phoneSuggestionTouchEnd = function (suggestionPhone) {
      event.preventDefault();
      event.stopPropagation();

      transferContactTouchEndX = event.changedTouches[0].pageX;
      transferContactTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferContactTouchStartX - transferContactTouchEndX) <= 20
        && Math.abs(transferContactTouchStartY - transferContactTouchEndY) <= 20) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(suggestionPhone));
      }
      checkPhoneNumberLength();
    };

    pickContactFromNativeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();
      transferContactTouchStartX = event.changedTouches[0].pageX;
      transferContactTouchStartY = event.changedTouches[0].pageY;
    };

    pickContactFromNativeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      transferContactTouchEndX = event.changedTouches[0].pageX;
      transferContactTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferContactTouchStartX - transferContactTouchEndX) <= 20
        && Math.abs(transferContactTouchStartY - transferContactTouchEndY) <= 20) {
        try {
          window.plugins.PickContact.chooseContact(function (contactInfo) {
            setTimeout(function () {
              var phoneNumber;
              if (device.platform === 'iOS')
                phoneNumber = contactInfo.phoneNr;
              if (device.platform === 'Android') {
                phoneNumber = contactInfo.nameFormated
              }
              var phone = inputVerification.telVerification(phoneNumber);
              contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(phone.substring(phone.length - 9, phone.length));
              checkPhoneNumberLength();
            }, 0);
          }, function (error) {
            console.error('Error on picking contact from native', error)
          });
        } catch (e) {
          console.log(e);
        }
      }
    };

    checkPhoneNumberLength = function () {
      if (contactPhoneNumberId.value.length === scope.numberLength) {
        scope.parent.showBottomButton = true;
        contactPhoneSuggestions.style.display = 'none';
      }
      else {
        scope.parent.showBottomButton = false;
        contactPhoneSuggestions.style.display = 'block';
      }
      scope.parent.update();
    }
  </script>
</component-transfer-to-contact>
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
  <div if="{!accessToContacts}" class="transfer-contact-access-container">
    <p class="transfer-contact-access-text">{window.languages.ViewPayTransferAccessToContacts}</p>
    <p class="transfer-contact-access-text-settings"
       ontouchstart="goToSettingsStart()"
       ontouchend="goToSettingsEnd()">{window.languages.ViewPayTransferAccessToContactsSettings}</p>
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
  <button if="{showBottomButton}"
          id="bottomButtonContactId"
          class="transfer-new-button-container"
          style="bottom: {window.bottomButtonBottom}"
          ontouchstart="onTouchStartOfNextContact(this)"
          ontouchend="onTouchEndOfNextContact(this)">
    {window.languages.ViewPayTransferNewContinue}
  </button>
  <script>

    var scope = this;
    var onPaste = false;
    var contactStopChanging = false;
    var arrayOfContacts = [];
    var taxPercent = 0;
    var transferContactTouchStartX,
      transferContactTouchStartY,
      transferContactTouchEndX,
      transferContactTouchEndY;
    scope.numberLength = 10;
    scope.searchNumber = '';
    scope.phoneSuggestionsArray = [];
    scope.showBottomButton = false;
    scope.phoneNumberForSubmit = '';
    scope.cardsarray = {};
    scope.cardNumberFromMain = 1;
    scope.idCardFromMyCards = -1;
    scope.cardCounter = 1;
    scope.accessToContacts = true;

    scope.on('mount', function () {
      if (opts && JSON.stringify(opts) !== '{}') {
        if (opts.cardsarray) {
          scope.cardsarray = opts.cardsarray;
        }
      }
      if (opts.idcardfrommycards !== -1) {
        scope.idCardFromMyCards = opts.idcardfrommycards;
        scope.countCard = scope.cardsarray[scope.idCardFromMyCards].countCard;
      }
      if (opts.cardcounter) {
        scope.cardCounter = opts.cardcounter;
      }
      scope.update();
    });

    //Find contacts after page is loaded
    findContacts = function () {
      console.log('in find contacts function');
      var options = new ContactFindOptions();
      var fields = [''];
      options.filter = "";
      options.multiple = true;
      options.desiredFields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.phoneNumbers];
      navigator.contacts.find(fields, success, error, options);
      function success(contacts) {
        console.log('in find contacts success function');
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
      }
      if (device.platform == 'Android') {
        var permissions = cordova.plugins.permissions;
        permissions.checkPermission(permissions.READ_CONTACTS, function(status) {
          if (status.hasPermission) {
            scope.accessToContacts = true;
          }
          else {
            scope.accessToContacts = false;
          }
        },
        function() {
          scope.accessToContacts = false;
        });
      }
      scope.update();
    };
    if (device.platform !== 'BrowserStand') {
      try {
        findContacts();
      }
      catch (e) {
        console.error(e)
      }
    }

    //get comission percent
    if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
      taxPercent = JSON.parse(localStorage.getItem('click_client_loginInfo')).p2p_comission;


    //Contact phone input handler
    contactPhoneBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();
      if (onPaste) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(inputVerification.telVerification(contactPhoneNumberId.value));
        onPaste = false;
      }
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

      scope.parent.transitionRunning = true;

      transferContactTouchStartX = event.changedTouches[0].pageX;
      transferContactTouchStartY = event.changedTouches[0].pageY;
    };

    phoneSuggestionTouchEnd = function (suggestionPhone) {
      event.preventDefault();
      event.stopPropagation();

      scope.parent.transitionRunning = false;

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
            window.pickContactFromNativeChecker = true;
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
          console.error(e);
        }
      }
    };

    checkPhoneNumberLength = function () {
      if (contactPhoneNumberId.value.length === scope.numberLength) {
        scope.showBottomButton = true;
        contactPhoneNumberId.blur();
        contactPhoneSuggestions.style.display = 'none';
      }
      else {
        scope.showBottomButton = false;
        contactPhoneSuggestions.style.display = 'block';
      }
      scope.update();
      scope.parent.update();
    };

    //Go to next step
    onTouchStartOfNextContact = function (button) {

      scope.parent.transitionRunning = true;
      button.style.webkitTransform = 'scale(0.7)';

      event.preventDefault();
      event.stopPropagation();

      transferContactTouchStartX = event.changedTouches[0].pageX;
      transferContactTouchStartY = event.changedTouches[0].pageY;
    };
    onTouchEndOfNextContact = function (button) {

      scope.parent.transitionRunning = false;
      button.style.webkitTransform = 'scale(1)';

      event.preventDefault();
      event.stopPropagation();

      transferContactTouchEndX = event.changedTouches[0].pageX;
      transferContactTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferContactTouchStartX - transferContactTouchEndX) <= 20
        && Math.abs(transferContactTouchStartY - transferContactTouchEndY) <= 20) {
        scope.phoneNumberForSubmit = window.languages.CodeOfCountry + inputVerification.spaceDeleter(contactPhoneNumberId.value);
        params = {
          transferType: 'contact',
          phoneNumber: scope.phoneNumberForSubmit,
          cardsarray: scope.cardsarray,
          cardcounter: scope.cardCounter,
          idcardfrommycards: scope.idCardFromMyCards,
          taxPercent: taxPercent,
          maxLimit: 9999999999999,
          minLimit: 5000,
        };
        if (scope.parent.countCardFromMain)
          params.countCardFromMain = scope.parent.countCardFromMain;
        riotTags.innerHTML = "<view-transfer-submit>";
        riot.mount('view-transfer-submit', params);
      }
    };

    goToSettingsStart = function () {
      event.preventDefault();
      event.stopPropagation();

      transferContactTouchStartX = event.changedTouches[0].pageX;
      transferContactTouchStartY = event.changedTouches[0].pageY;
    };
    goToSettingsEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      transferContactTouchEndX = event.changedTouches[0].pageX;
      transferContactTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferContactTouchStartX - transferContactTouchEndX) <= 20
        && Math.abs(transferContactTouchStartY - transferContactTouchEndY) <= 20) {
        window.cordova.plugins.settings.open("application_details", function () {
            console.log('opened settings');
          },
          function () {
            console.log('failed to open settings');
          }
        );
      }
    }
  </script>
</component-transfer-to-contact>
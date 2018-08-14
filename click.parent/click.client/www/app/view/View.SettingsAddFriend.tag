<view-add-friend>
  <div class="riot-tags-main-container">
    <div class="page-title page-title-shadow">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">

      <div id="contactPhoneFieldId" class="settings-add-friend-contact-phone-field">
        <div class="settings-add-friend-contact-phone-icon" role="button"
             aria-label="{window.languages.ChooseFromContacts}" ontouchend="pickContactFromNative()"></div>
        <p id="contactPhoneFieldTitle" class="settings-add-friend-contact-text-field">
          {window.languages.ViewSettingsAddFriendPhoneNumberTitle}</p>
        <p class="settings-add-friend-contact-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input onchange="contactPhoneBlurAndChange()" onfocus="contactPhoneBlurAndChange()"
               id="contactPhoneNumberId"
               class="settings-add-friend-contact-number-input-part" type="tel"
               onkeyup="searchContacts()"
               oninput="contactPhoneBlurAndChange()"
               onpaste="onPasteTriggered()"
               onkeydown="contactTelVerificationKeyDown(this)"/>
      </div>

      <div class="settings-add-friend-add-container">
        <p id="nameFieldTitle" class="settings-add-friend-add-title">
          {window.languages.ViewSettingsAddFriendNameTitle}</p>
        <div id="namePhoneFieldId" class="settings-add-friend-name-phone-field">
          <p class="settings-add-friend-contact-text-field"></p>
          <p class="settings-add-friend-contact-number-first-part"></p>
          <input maxlength="20" id="contactNameId" onfocus="colorFieldAddFriend('name')"
                 class="settings-add-friend-name-number-input-part" oninput="checkFieldsInAddFriend()"
                 type="text"/>
        </div>
      </div>

      <div id="firstSuggestionBlockId" class="settings-add-friend-contact-found-container-one"
           ontouchend="firstSuggestionBlockTouchEnd()" ontouchstart="firstSuggestionBlockTouchStart()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionOne.photo})">
          {suggestionOne.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionOne.fName} {suggestionOne.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionOne.phoneNumber}</div>
      </div>
      <div id="secondSuggestionBlockId" class="settings-add-friend-contact-found-container-two"
           ontouchend="secondSuggestionBlockTouchEnd()" ontouchstart="secondSuggestionBlockTouchStart()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionTwo.photo})">
          {suggestionTwo.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionTwo.fName} {suggestionTwo.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionTwo.phoneNumber}</div>
      </div>

      <button id="nextButtonId" style="bottom: {window.bottomButtonBottom}"
              class="settings-add-friend-next-button-inner-container"
              ontouchstart="addFriendTouchStart()" ontouchend="addFriendTouchEnd()">
        {window.languages.ViewPayTransferNext}
      </button>
    </div>

  </div>

  <script>

    var scope = this;
    scope.numberLength = 10;
    this.titleName = window.languages.ViewSettingsAddFriendTitleName;
    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;
    var firstSuggestionChooseTouchStartX, firstSuggestionChooseTouchStartY,
      firstSuggestionChooseTouchEndX, firstSuggestionChooseTouchEndY;
    var secondSuggestionChooseTouchStartX, secondSuggestionChooseTouchStartY,
      secondSuggestionChooseTouchEndX, secondSuggestionChooseTouchEndY;
    var addButtonStartX, addButtonEndX, addButtonStartY, addButtonEndY;
    scope.suggestionOne = {};
    scope.suggestionOne.photo = '';
    scope.suggestionOne.fName = '';
    scope.suggestionOne.lName = '';
    scope.suggestionOne.displayName = '';
    scope.suggestionOne.phoneNumber = '';
    scope.suggestionOne.firstLetterOfName = '';

    scope.suggestionTwo = {};
    scope.suggestionTwo.photo = '';
    scope.suggestionTwo.fName = '';
    scope.suggestionTwo.lName = '';
    scope.suggestionTwo.displayName = '';
    scope.suggestionTwo.phoneNumber = '';
    scope.suggestionTwo.firstLetterOfName = '';
    scope.onPaste = false;
    var arrayOfFriends = [];

    var maskOne = /[0-9]/g;
    arrayOfContacts = [];
    var checkFirstBlock = false;
    var checkSecondBlock = false;
    var contactStopChanging = false;

    window.saveHistory('view-add-friend', opts);

    scope.on('mount', function () {

      contactPhoneNumberId.focus();
      contactPhoneNumberId.autofocus;
      if (contactPhoneNumberId.value.length != scope.numberLength) {
        nextButtonId.style.display = 'none'
      }
      scope.update();

    });

    colorFieldAddFriend = function (field) {
      if (field == 'phone') {
        namePhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb";
        nameFieldTitle.style.color = '#cbcbcb';
        contactPhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff";
        contactPhoneFieldTitle.style.color = '#01cfff';
      } else if (field == 'name') {
        contactPhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb";
        contactPhoneFieldTitle.style.color = '#cbcbcb';
        namePhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff";
        nameFieldTitle.style.color = '#01cfff';
      }
    };

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    checkFieldsInAddFriend = function () {

      console.log("contactNameId.value.length", contactNameId.value.length)

      if (contactPhoneNumberId.value.length == scope.numberLength && !contactNameId.value.length < 1) {
        console.log("qqq");
        nextButtonId.style.display = 'block';
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
      }
      else {
        console.log("ddd");
        nextButtonId.style.display = 'none'
      }
    };

    contactPhoneBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      if (scope.onPaste) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(contactPhoneNumberId.value);
        scope.onPaste = false;
      }

      checkFieldsInAddFriend();
      colorFieldAddFriend('phone');
      scope.update();
    };

    contactTelVerificationKeyDown = function (input) {

      if (input.value.length >= scope.numberLength && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        contactStopChanging = true;
      }
      else {
        contactStopChanging = false;
      }
    };

    pickContactFromNative = function () {

      window.plugins.PickContact.chooseContact(function (contactInfo) {
        window.pickContactFromNativeChecker = true;

        setTimeout(function () {
          var phoneNumber;
          if (device.platform === 'iOS') {
            phoneNumber = contactInfo.phoneNr;
            contactNameId.value = contactInfo.displayName;
            if (contactNameId.value.length > 20) {
              contactNameId.value = contactNameId.value.substring(0, 21) + "...";
            }
          }

          if (device.platform === 'Android') {
            phoneNumber = contactInfo.nameFormated;
            contactNameId.value = contactInfo.displayName;
            if (contactNameId.value.length > 20) {
              contactNameId.value = contactNameId.value.substring(0, 21) + "...";
            }
          }

          var phone = inputVerification.telVerification(phoneNumber);

          contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(phone.substring(phone.length - 9, phone.length));
          if (contactPhoneNumberId.value.length != 0) {

            checkFieldsInAddFriend();

          }// use time-out to fix iOS alert problem
        }, 0);
      }, function (error) {
        console.log('error', error)
      });
    };

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
            if ((contacts[i].name.familyName != null || contacts[i].name.givenName != null) && contacts[i].phoneNumbers != null) {
              for (var j = 0; j < contacts[i].phoneNumbers.length; j++) {
                var phone = inputVerification.telVerification(contacts[i].phoneNumbers[j].value);
                contacts[i].phoneNumbers[j].value = phone;
              }
              arrayOfContacts.push(contacts[i])
            }
        }
      }

      function error(message) {
        scope.clickPinError = false;
        scope.errorNote = 'Failed because: ' + message;

        window.common.alert.show("componentAlertId", {
          parent: scope,
          clickpinerror: scope.clickPinError,
          errornote: scope.errorNote
        });

        scope.update();
      }
    };

    if (device.platform != 'BrowserStand') {
      try {
        findContacts();
      }
      catch (e) {
        console.log(e)
      }
    }

    onPasteTriggered = function () {
      scope.onPaste = true;
    };

    searchContacts = function () {

      if (contactStopChanging) {
        contactPhoneNumberId.value = event.target.value.substring(0, event.target.value.length - 1);
      }

      cursorPositionSelectionStart = contactPhoneNumberId.selectionStart;
      cursorPositionSelectionEnd = contactPhoneNumberId.selectionEnd;
      oldValueOfNumber = contactPhoneNumberId.value

      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {

        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(contactPhoneNumberId.value);
        console.log("after with space changing=", contactPhoneNumberId.value);

        contactPhoneNumberId.selectionStart = cursorPositionSelectionStart;
        contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd;

        if (oldValueOfNumber != contactPhoneNumberId.value && cursorPositionSelectionStart == 3)
          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart + 1;
      }


      if (contactPhoneNumberId.value.length == 0) {

        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        scope.update();
        return
      }


      event.preventDefault();
      event.stopPropagation();

      var countOfFound = 0;
      var check = false;
      var index = -1;
      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = inputVerification.spaceDeleter(event.target.value);

      arrayOfContacts.filter(function (wordOfFunction) {
        var objectPos = '';
        if (wordOfFunction.phoneNumbers) {
          for (var i in wordOfFunction.phoneNumbers) {
            index = wordOfFunction.phoneNumbers[i].value.indexOf(scope.searchWord);
            if (index != -1) {
              objectPos = i;
              break;
            }
          }
        }
        else
          index = -1;

        if (index != -1 && countOfFound < 2) {

          check = true;

          if (countOfFound == 0) {

            scope.suggestionOne.phoneNumber = wordOfFunction.phoneNumbers[objectPos].value;
            scope.suggestionOne.fName = wordOfFunction.name.givenName;
            scope.suggestionOne.lName = wordOfFunction.name.familyName;
            scope.suggestionOne.displayName = wordOfFunction.name.displayName;

            if (wordOfFunction.photos != null) {
              if (wordOfFunction.photos[0] != null) {
                scope.suggestionOne.photo = wordOfFunction.photos[0].value;
                scope.suggestionOne.firstLetterOfName = '';
              }
              else {
                scope.suggestionOne.photo = '';
                if (scope.suggestionOne.lName) {
                  scope.suggestionOne.firstLetterOfName = scope.suggestionOne.lName[0];
                }
                else {
                  if (scope.suggestionOne.fName)
                    scope.suggestionOne.firstLetterOfName = scope.suggestionOne.fName[0];
                }
              }
            }
            else {
              scope.suggestionOne.photo = '';
              if (scope.suggestionOne.lName) {
                scope.suggestionOne.firstLetterOfName = scope.suggestionOne.lName[0];
              }
              else {
                if (scope.suggestionOne.fName)
                  scope.suggestionOne.firstLetterOfName = scope.suggestionOne.fName[0];
              }
            }


            scope.update(scope.suggestionOne);

            firstSuggestionBlockId.style.display = 'block';
            secondSuggestionBlockId.style.display = 'none';
          }

          if (countOfFound == 1) {

            scope.suggestionTwo.phoneNumber = wordOfFunction.phoneNumbers[objectPos].value;
            scope.suggestionTwo.fName = wordOfFunction.name.givenName;
            scope.suggestionTwo.lName = wordOfFunction.name.familyName;
            scope.suggestionTwo.displayName = wordOfFunction.name.displayName;

            if (wordOfFunction.photos != null) {
              if (wordOfFunction.photos[0] != null) {
                scope.suggestionTwo.photo = wordOfFunction.photos[0].value;
                scope.suggestionTwo.firstLetterOfName = '';
              }
              else {
                scope.suggestionTwo.photo = '';
                if (scope.suggestionTwo.lName) {
                  scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.lName[0];
                }
                else {
                  if (scope.suggestionTwo.fName)
                    scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.fName[0];
                }
              }
            }
            else {
              scope.suggestionTwo.photo = '';
              if (scope.suggestionTwo.lName) {
                scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.lName[0];
              }
              else {
                if (scope.suggestionTwo.fName)
                  scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.fName[0];
              }
            }

            scope.update(scope.suggestionTwo);

            secondSuggestionBlockId.style.display = 'block';
          }
          countOfFound++;
        }
        else if (!check) {
          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
        }
      });
    };

    firstSuggestionBlockTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      firstSuggestionChooseTouchStartX = event.changedTouches[0].pageX;
      firstSuggestionChooseTouchStartY = event.changedTouches[0].pageY;

    };

    firstSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      firstSuggestionChooseTouchEndX = event.changedTouches[0].pageX;
      firstSuggestionChooseTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(firstSuggestionChooseTouchStartX - firstSuggestionChooseTouchEndX) <= 20 && Math.abs(firstSuggestionChooseTouchStartY - firstSuggestionChooseTouchEndY) <= 20) {
        var phone = inputVerification.telVerification(scope.suggestionOne.phoneNumber);
        scope.suggestionOne.phoneNumber = phone;
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(scope.suggestionOne.phoneNumber.substring(scope.suggestionOne.phoneNumber.length - 9, scope.suggestionOne.phoneNumber.length));


        if (scope.suggestionOne.displayName)
          contactNameId.value = scope.suggestionOne.displayName;
        else {
          if (scope.suggestionOne.fName)
            contactNameId.value = scope.suggestionOne.fName;
          else {
            contactNameId.value = scope.suggestionOne.lName;
          }
        }

        scope.update()
      }
    };

    secondSuggestionBlockTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      secondSuggestionChooseTouchStartX = event.changedTouches[0].pageX;
      secondSuggestionChooseTouchStartY = event.changedTouches[0].pageY;
    };

    secondSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      secondSuggestionChooseTouchEndX = event.changedTouches[0].pageX;
      secondSuggestionChooseTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(secondSuggestionChooseTouchStartX - secondSuggestionChooseTouchEndX) <= 20 && Math.abs(secondSuggestionChooseTouchStartY - secondSuggestionChooseTouchEndY) <= 20) {
        var phone = inputVerification.telVerification(scope.suggestionTwo.phoneNumber);
        scope.suggestionTwo.phoneNumber = phone;

        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(scope.suggestionTwo.phoneNumber.substring(scope.suggestionTwo.phoneNumber.length - 9, scope.suggestionTwo.phoneNumber.length));


        if (scope.suggestionTwo.displayName)
          contactNameId.value = scope.suggestionTwo.displayName;
        else {
          if (scope.suggestionTwo.fName)
            contactNameId.value = scope.suggestionTwo.fName;
          else {
            contactNameId.value = scope.suggestionTwo.lName;
          }
        }

        scope.update()
      }
    };

    //    searchContactsForAdding = function (number) {
    //
    //      var index = -1;
    //      arrayOfContacts.filter(function (wordOfFunction) {
    //        var objectPos = '';
    //        if (wordOfFunction.phoneNumbers) {
    //          for (var i in wordOfFunction.phoneNumbers) {
    //            index = wordOfFunction.phoneNumbers[i].value.indexOf(number);
    //            if (index != -1) {
    //              objectPos = i;
    //              break;
    //            }
    //          }
    //        }
    //        else
    //          index = -1;
    //
    //        if (index != -1) {
    ////            scope.suggestionOne.phoneNumber = wordOfFunction.phoneNumbers[objectPos].value;
    ////            scope.suggestionOne.fName = wordOfFunction.name.givenName;
    ////            scope.suggestionOne.lName = wordOfFunction.name.familyName;
    //
    //          if (wordOfFunction.photos != null) {
    //            if (wordOfFunction.photos[0] != null) {
    //              return wordOfFunction.photos[0].value;
    //            }
    //          }
    //        }
    //      });
    //    }

    addFriendTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = 'scale(0.8)';

      addButtonStartX = event.changedTouches[0].pageX;
      addButtonStartY = event.changedTouches[0].pageY;
    };

    addFriendTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = 'scale(1)';

      addButtonEndX = event.changedTouches[0].pageX;
      addButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(addButtonStartX - addButtonEndX) <= 20 && Math.abs(addButtonStartY - addButtonEndY) <= 20) {

        if (JSON.parse(localStorage.getItem('click_client_friends')) === null) {
          arrayOfFriends = []
        }
        else {
          arrayOfFriends = JSON.parse(localStorage.getItem('click_client_friends'));
        }
        var object = {};
        object.name = contactNameId.value.toString();
        object.number = window.languages.CodeOfCountry + inputVerification.spaceDeleter(contactPhoneNumberId.value);
        object.firstLetterOfName = '';
        object.id = object.number + Math.floor((Math.random() * 1000) + 1);

        var index = -1;
        arrayOfContacts.filter(function (wordOfFunction) {
          var objectPos = '';
          if (wordOfFunction.phoneNumbers) {
            for (var i in wordOfFunction.phoneNumbers) {
              index = wordOfFunction.phoneNumbers[i].value.indexOf(contactPhoneNumberId.value);
              if (index != -1) {
                objectPos = i;
                break;
              }
            }
          }
          else
            index = -1;

          if (index != -1) {
//            scope.suggestionOne.phoneNumber = wordOfFunction.phoneNumbers[objectPos].value;
//            scope.suggestionOne.fName = wordOfFunction.name.givenName;
//            scope.suggestionOne.lName = wordOfFunction.name.familyName

            if (wordOfFunction.photos != null) {
              if (wordOfFunction.photos[0] != null) {
                object.photo = wordOfFunction.photos[0].value;
              }
            }
          }
        });

        if (!object.photo && object.name[0]) {
          object.firstLetterOfName = object.name[0].toUpperCase();
        }
        arrayOfFriends.unshift(object);

        localStorage.setItem('click_client_friends', JSON.stringify(arrayOfFriends));
        onBackKeyDown()
      }
    }


  </script>
</view-add-friend>

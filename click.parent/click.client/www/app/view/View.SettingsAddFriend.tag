<view-add-friend>
  <div class="riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">

      <div id="contactPhoneFieldId" class="settings-add-friend-contact-phone-field">
        <div class="settings-add-friend-contact-phone-icon" ontouchend="pickContactFromNative()"></div>
        <p class="settings-add-friend-contact-text-field">{window.languages.ViewSettingsAddFriendPhoneNumberTitle}</p>
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
        <p class="settings-add-friend-add-title">{window.languages.ViewSettingsAddFriendNameTitle}</p>
        <div id="namePhoneFieldId" class="settings-add-friend-name-phone-field">
          <p class="settings-add-friend-contact-text-field"></p>
          <p class="settings-add-friend-contact-number-first-part"></p>
          <input maxlength="20" id="contactNameId" ontouchend="namePhoneFieldTouchEnd()" autofocus="true"
                 class="settings-add-friend-name-number-input-part"
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

      <button id="nextButtonId" class="settings-add-friend-next-button-inner-container"
              ontouchstart="addFriendTouchStart()" ontouchend="addFriendTouchEnd()">{window.languages.ViewPayTransferNext}
      </button>
    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = window.languages.ViewSettingsAddFriendTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-add-friend') {
      history.arrayOfHistory.push(
        {
          "view": 'view-add-friend',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    this.on('mount', function () {

      namePhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff"
      contactPhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb"
      if (contactPhoneNumberId.value.length != 9) {
        nextButtonId.style.display = 'none'
      }
      scope.update();

//      firstSuggestionBlockId.style.display = 'block';
//      secondSuggestionBlockId.style.display = 'block';
    })

    namePhoneFieldTouchEnd = function () {

      namePhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff"
      contactPhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb"
      scope.update();

    }

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

    var maskOne = /[0-9]/g;
    arrayOfContacts = [];

    var checkFirstBlock = false;
    var checkSecondBlock = false;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    contactPhoneBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      if (scope.onPaste) {
        contactPhoneNumberId.value = inputVerification.telVerification(contactPhoneNumberId.value)
        scope.onPaste = false;
      }

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
      }
      else {
        nextButtonId.style.display = 'none'
      }

      namePhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb"
      contactPhoneFieldId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff"

      scope.update();
    }

    var contactStopChanging = false;

    contactTelVerificationKeyDown = function (input) {
//      console.log(event.target.value)
      if (input.value.length >= 9 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
//        contactPhoneNumberId.value = event.target.value.substring(0, event.target.value.length - 1);
        contactStopChanging = true;
      }
      else{
        contactStopChanging = false;
      }
    }

    pickContactFromNative = function () {

      window.plugins.PickContact.chooseContact(function (contactInfo) {
        window.pickContactFromNativeChecker = true;
        console.log('CONTACTINFO', contactInfo)
        setTimeout(function () {
          var phoneNumber
          if (device.platform == 'iOS') {
            phoneNumber = contactInfo.phoneNr;
            contactNameId.value = contactInfo.displayName
          }

          if (device.platform == 'Android') {
            phoneNumber = contactInfo.nameFormated
            contactNameId.value = contactInfo.displayName
          }
          var digits = phoneNumber.match(maskOne);
          var phone = '';
          for (var i in digits) {
            phone += digits[i]
          }
          contactPhoneNumberId.value = phone.substring(phone.length - 9, phone.length);
          if (contactPhoneNumberId.value.length != 0) {
//            console.log('contactPhoneNumberId.value', contactPhoneNumberId.value.length)
            if (contactPhoneNumberId.value.length == 9) {
              nextButtonId.style.display = 'block'

              firstSuggestionBlockId.style.display = 'none';
              secondSuggestionBlockId.style.display = 'none';
            }
            else
              nextButtonId.style.display = 'none'

          }// use time-out to fix iOS alert problem
        }, 0);
      }, function (error) {
        console.log('error', error)
      });


    }

    findContacts = function () {

      var options = new ContactFindOptions();
      var fields = [''];
      options.filter = "";
      options.multiple = true;
      options.desiredFields=[navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.phoneNumbers];
//
      navigator.contacts.find(fields, success, error, options);

      function success(contacts) {
        for (var i = 0; i < contacts.length; i++) {
          if (contacts[i].name)
          if ((contacts[i].name.familyName != null || contacts[i].name.givenName != null) && contacts[i].phoneNumbers != null) {
            for (var j = 0; j < contacts[i].phoneNumbers.length; j++) {
              var digits = contacts[i].phoneNumbers[j].value.match(maskOne);
              var phone = '';
              for (var k in digits) {
                phone += digits[k]
              }
              contacts[i].phoneNumbers[j].value = phone;
            }
            arrayOfContacts.push(contacts[i])
          }
        }
      }

      function error(message) {
        scope.clickPinError = false;
        scope.errorNote = 'Failed because: ' + message;
        scope.showError = true;
        scope.update();
      }
    }
    if (device.platform != 'BrowserStand') {
      try {
        findContacts();
      }
      catch(e){
        console.log(e)
      }
    }

    scope.onPaste = false;

    onPasteTriggered = function () {

      scope.onPaste = true;
    }

    var cursorPositionSelectionStart, cursorPositionSelectionEnd, oldValueOfNumber;
    searchContacts = function () {

      if(contactStopChanging){
        contactPhoneNumberId.value = event.target.value.substring(0, event.target.value.length - 1);
      }

      cursorPositionSelectionStart = contactPhoneNumberId.selectionStart;
      cursorPositionSelectionEnd = contactPhoneNumberId.selectionEnd;
      oldValueOfNumber = contactPhoneNumberId.value

      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        contactPhoneNumberId.value = inputVerification.telVerification(contactPhoneNumberId.value)
        if (oldValueOfNumber != contactPhoneNumberId.value) {
          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart - 1
          contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd - 1
        }
        else {
          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart
          contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd
        }
      }

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'


        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        return

      }
      else {
        nextButtonId.style.display = 'none'

        if (contactPhoneNumberId.value.length == 0) {
          console.log('I AM HERE')

          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
          scope.update();
          return
        }
      }

      event.preventDefault();
      event.stopPropagation();

      var countOfFound = 0;
      var check = false;
      var index = -1;
      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = event.target.value;

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


            scope.update(scope.suggestionOne)

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

            scope.update(scope.suggestionTwo)

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


    var firstSuggestionChooseTouchStartX, firstSuggestionChooseTouchStartY, firstSuggestionChooseTouchEndX, firstSuggestionChooseTouchEndY;
    firstSuggestionBlockTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      firstSuggestionChooseTouchStartX = event.changedTouches[0].pageX
      firstSuggestionChooseTouchStartY = event.changedTouches[0].pageY

    }


    firstSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      firstSuggestionChooseTouchEndX = event.changedTouches[0].pageX
      firstSuggestionChooseTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(firstSuggestionChooseTouchStartX - firstSuggestionChooseTouchEndX) <= 20 && Math.abs(firstSuggestionChooseTouchStartY - firstSuggestionChooseTouchEndY) <= 20) {
        var digits = scope.suggestionOne.phoneNumber.match(maskOne);
        var phone = '';
        for (var i in digits) {
          phone += digits[i]
        }
        scope.suggestionOne.phoneNumber = phone;
        contactPhoneNumberId.value = scope.suggestionOne.phoneNumber.substring(scope.suggestionOne.phoneNumber.length - 9, scope.suggestionOne.phoneNumber.length);


        if (scope.suggestionOne.displayName)
          contactNameId.value = scope.suggestionOne.displayName
        else {
          if (scope.suggestionOne.fName)
            contactNameId.value = scope.suggestionOne.fName
          else {
            contactNameId.value = scope.suggestionOne.lName
          }
        }

        if (contactPhoneNumberId.value.length == 9) {
          nextButtonId.style.display = 'block'

          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
        }
        else
          nextButtonId.style.display = 'none'

        scope.update()
      }
    }


    var secondSuggestionChooseTouchStartX, secondSuggestionChooseTouchStartY, secondSuggestionChooseTouchEndX, secondSuggestionChooseTouchEndY;

    secondSuggestionBlockTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      secondSuggestionChooseTouchStartX = event.changedTouches[0].pageX
      secondSuggestionChooseTouchStartY = event.changedTouches[0].pageY
    }

    secondSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      secondSuggestionChooseTouchEndX = event.changedTouches[0].pageX
      secondSuggestionChooseTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(secondSuggestionChooseTouchStartX - secondSuggestionChooseTouchEndX) <= 20 && Math.abs(secondSuggestionChooseTouchStartY - secondSuggestionChooseTouchEndY) <= 20) {
        var digits = scope.suggestionTwo.phoneNumber.match(maskOne);
        var phone = '';
        for (var i in digits) {
          phone += digits[i]
        }
        scope.suggestionTwo.phoneNumber = phone;

        contactPhoneNumberId.value = scope.suggestionTwo.phoneNumber.substring(scope.suggestionTwo.phoneNumber.length - 9, scope.suggestionTwo.phoneNumber.length);


        if (scope.suggestionTwo.displayName)
          contactNameId.value = scope.suggestionTwo.displayName
        else {
          if (scope.suggestionTwo.fName)
            contactNameId.value = scope.suggestionTwo.fName
          else {
            contactNameId.value = scope.suggestionTwo.lName
          }
        }


        if (contactPhoneNumberId.value.length == 9) {
          nextButtonId.style.display = 'block'
          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
        }
        else
          nextButtonId.style.display = 'none'

        scope.update()
      }
    }

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

    var arrayOfFriends = [];

    var addButtonStartX, addButtonEndX, addButtonStartY, addButtonEndY;

    addFriendTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = 'scale(0.8)'

      addButtonStartX = event.changedTouches[0].pageX;
      addButtonStartY = event.changedTouches[0].pageY;
    }

    addFriendTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = 'scale(1)'

      addButtonEndX = event.changedTouches[0].pageX;
      addButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(addButtonStartX - addButtonEndX) <= 20 && Math.abs(addButtonStartY - addButtonEndY) <= 20) {

      if (localStorage.getItem('click_client_friends') === null) {
        arrayOfFriends = []
      }
      else {
        arrayOfFriends = JSON.parse(localStorage.getItem('click_client_friends'));
      }
      var object = {};
      object.name = contactNameId.value.toString();
      object.number = window.languages.CodeOfCountry + contactPhoneNumberId.value;
      object.firstLetterOfName = '';

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

      if (!object.photo) {
        object.firstLetterOfName = object.name[0].toUpperCase();
      }
      arrayOfFriends.unshift(object)

      localStorage.setItem('click_client_friends', JSON.stringify(arrayOfFriends))
      onBackKeyDown()
    }
    }


  </script>
</view-add-friend>

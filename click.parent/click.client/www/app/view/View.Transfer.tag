<view-transfer>
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()"
         class="{transfer-back-button: backbuttoncheck}">

    </div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"
         ontouchend="openBanksListPage()"></div>
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
    <div id="contactInputFieldId" class="transfer-contact-body-container">
      <div class="transfer-contact-phone-field">
        <p class="transfer-contact-text-field">{window.languages.ViewPayTransferContactTextField}</p>
        <p class="transfer-contact-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input onchange="contactPhoneBlurAndChange()" onfocus="contactPhoneBlurAndChange()"
               id="contactPhoneNumberId"
               class="transfer-contact-number-input-part" type="tel"
               maxlength="9" onkeyup="searchContacts()"/>
        <div class="transfer-contact-phone-icon" ontouchend="pickContactFromNative()"></div>
      </div>
      <div id="firstSuggestionBlockId" class="transfer-contact-found-container-one"
           ontouchend="firstSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionOne.photo})">
          {suggestionOne.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionOne.fName} {suggestionOne.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionOne.phoneNumber}</div>
      </div>
      <div id="secondSuggestionBlockId" class="transfer-contact-found-container-two"
           ontouchend="secondSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionTwo.photo})">
          {suggestionTwo.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionTwo.fName} {suggestionTwo.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionTwo.phoneNumber}</div>
      </div>


      <div id="thirdSuggestionBlockId" class="transfer-contact-found-container-three"
           ontouchend="thirdSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionThree.photo})">
          {suggestionThree.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionThree.fName} {suggestionThree.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionThree.phoneNumber}</div>
      </div>


      <div id="fourthSuggestionBlockId" class="transfer-contact-found-container-four"
           ontouchend="fourthSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionFour.photo})">
          {suggestionFour.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionFour.fName} {suggestionFour.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionFour.phoneNumber}</div>
      </div>


      <div id="fifthSuggestionBlockId" class="transfer-contact-found-container-five"
           ontouchend="fifthSuggestionBlock()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionFive.photo})">
          {suggestionFive.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionFive.fName} {suggestionFive.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionFive.phoneNumber}</div>
      </div>

    </div>

    <div id="cardInputFieldId" class="transfer-contact-body-container">
      <div class="transfer-contact-phone-field">
        <p class="transfer-contact-text-field">{window.languages.ViewPayTransferCardTextField}</p>
        <input onchange="cardPhoneBlurAndChange()" onfocus="cardPhoneBlurAndChange()"
               id="cardInputId" class="transfer-card-number-input-part" type="tel"
               maxlength="19" onkeydown="searchCard()" onkeyup="cardOnKeyUp()"/>
      </div>

      <div id="firstCardSuggestionId" class="transfer-contact-found-container-one"
           ontouchend="firstCardSuggestionBlock()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionOne.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionOne.fName} {cardSuggestionOne.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionOne.cardNumber.substring(0,4)} **** ****
          {cardSuggestionOne.cardNumber.substring(cardSuggestionOne.cardNumber.length-4,cardSuggestionOne.cardNumber.length)}
        </div>
      </div>

      <div id="secondCardSuggestionId" class="transfer-contact-found-container-two"
           ontouchend="secondCardSuggestionBlock()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionTwo.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionTwo.fName} {cardSuggestionTwo.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionTwo.cardNumber.substring(0,4)} **** ****
          {cardSuggestionTwo.cardNumber.substring(cardSuggestionTwo.cardNumber.length-4,cardSuggestionTwo.cardNumber.length)}
        </div>
      </div>

      <div id="thirdCardSuggestionId" class="transfer-contact-found-container-three"
           ontouchend="thirdCardSuggestionBlock()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionThree.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionThree.fName} {cardSuggestionThree.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionThree.cardNumber.substring(0,4)} **** ****
          {cardSuggestionThree.cardNumber.substring(cardSuggestionThree.cardNumber.length-4,cardSuggestionThree.cardNumber.length)}
        </div>
      </div>

      <div id="fourthCardSuggestionId" class="transfer-contact-found-container-four"
           ontouchend="fourthCardSuggestionBlock()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionFour.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionFour.fName} {cardSuggestionFour.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionFour.cardNumber.substring(0,4)} **** ****
          {cardSuggestionFour.cardNumber.substring(cardSuggestionFour.cardNumber.length-4,cardSuggestionFour.cardNumber.length)}
        </div>
      </div>

      <div id="fifthCardSuggestionId" class="transfer-contact-found-container-five"
           ontouchend="fifthCardSuggestionBlock()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionFive.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionFive.fName} {cardSuggestionFive.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionFive.cardNumber.substring(0,4)} **** ****
          {cardSuggestionFive.cardNumber.substring(cardSuggestionFive.cardNumber.length-4,cardSuggestionFive.cardNumber.length)}
        </div>
      </div>

    </div>

    <div id="nextButtonId" class="transfer-next-button-inner-container" ontouchend="goToTransferStepTwo()">
      <p class="transfer-next-button-label">{window.languages.ViewPayTransferNext}</p>
    </div>

  </div>

  <div id="componentBankListId" class="component-bank-list">
    <div class="page-title" style="border: none;">
      <p class="component-banklist-name-title">{window.languages.ViewBankListTitleName}</p>
      <div id="rightButton" type="button" class="component-banklist-close-button" ontouchend="closeComponent()"></div>
    </div>
    <div id="bankListContainerId" class="component-banklist-container">
      <div class="component-banklist-card" each="{i in bankList}">
        <div class="component-banklist-bank-logo" style="background-image: url({i.image});"></div>
        <div class="component-banklist-bank-limit-container">
          <div class="component-banklist-bank-limit-text">{window.languages.ViewBankListLimitText}</div>
          <div class="component-banklist-bank-limit">{i.amount}</div>
          <div class="component-banklist-bank-limit-currency">{window.languages.ViewBankListLimitForMonthText}</div>
        </div>
      </div>
    </div>
  </div>
  <script>

    this.on('mount', function () {

//      firstSuggestionBlockId.style.display = 'block';
//      secondSuggestionBlockId.style.display = 'block';
//      thirdSuggestionBlockId.style.display = 'block';
//      fourthSuggestionBlockId.style.display = 'block';
//      fifthSuggestionBlockId.style.display = 'block';

      if (viewTransfer.type == 2) {
//        console.log('ON MOUNT')
        contact();
        if (checkFirstBlock) {
          firstSuggestionBlockId.style.display = 'block';
        }

        if (checkSecondBlock) {
          secondSuggestionBlockId.style.display = 'block';
        }

        if (checkThirdBlock) {
          thirdSuggestionBlockId.style.display = 'block';
        }

        if (checkFourthBlock) {
          fourthSuggestionBlockId.style.display = 'block';
        }

        if (checkFifthBlock) {
          fifthSuggestionBlockId.style.display = 'block';
        }

        if (contactPhoneNumberId.value.length == 9) {
          nextButtonId.style.display = 'block'
          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
          thirdSuggestionBlockId.style.display = 'none';
          fourthSuggestionBlockId.style.display = 'none';
          fifthSuggestionBlockId.style.display = 'none';
        }


      }
      else {
        checkCardMenu = false;

        if (cardInputId.value.length != 19) {
          if (checkCardFirstBlock) {
            scope.cardSuggestionOne = JSON.parse(JSON.stringify(scope.cardSuggestionOneCopy));
            firstCardSuggestionId.style.display = 'block';
          }

          if (checkCardSecondBlock) {
            scope.cardSuggestionTwo = JSON.parse(JSON.stringify(scope.cardSuggestionTwoCopy));
            secondCardSuggestionId.style.display = 'block';
          }

          if (checkCardThirdBlock) {
            thirdCardSuggestionId.style.display = 'block';
          }

          if (checkCardFourthBlock) {
            fourthCardSuggestionId.style.display = 'block';
          }

          if (checkCardFifthBlock) {
            fifthCardSuggestionId.style.display = 'block';
          }
        }

        if (cardInputId.value.length == 19) {
          nextButtonId.style.display = 'block'
          firstCardSuggestionId.style.display = 'none';
          secondCardSuggestionId.style.display = 'none';
          thirdCardSuggestionId.style.display = 'none';
          fourthCardSuggestionId.style.display = 'none';
          fifthCardSuggestionId.style.display = 'none';
        }

        riot.update();
        card();
      }
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

    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');


    openBanksListPage = function () {
      if (JSON.parse(localStorage.getItem("click_client_p2p_bank_list"))) {
        scope.bankList = JSON.parse(localStorage.getItem("click_client_p2p_bank_list"));
//        console.log("bank list", scope.bankList);
        riot.update(scope.bankList);
      }
      componentBankListId.style.display = 'block';
      riot.update(componentBankListId);
    };

    closeComponent = function () {
      bankListContainerId.scrollTop = 0;
      componentBankListId.style.display = 'none';
    }

    if (!JSON.parse(localStorage.getItem('click_client_p2p_bank_list'))) {
      window.api.call({
        method: 'p2p.bank.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            for (var i in result[1]) {
              result[1][i].amount = result[1][i].p2p_max_limit.toString();


              if (result[1][i].amount.length == 7) {
                result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
                  result[1][i].amount.substring(1, 4) + ' ' + result[1][i].amount.substring(4, result[1][i].amount.length)

              }

              if (result[1][i].amount.length == 6) {
                result[1][i].amount = result[1][i].amount.substring(0, 3) + ' ' +
                  result[1][i].amount.substring(3, result[1][i].amount.length)

              }

              if (result[1][i].amount.length == 5) {
                result[1][i].amount = result[1][i].amount.substring(0, 2) + ' ' +
                  result[1][i].amount.substring(2, result[1][i].amount.length)

              }

              if (result[1][i].amount.length == 4) {
                result[1][i].amount = result[1][i].amount.substring(0, 1) + ' ' +
                  result[1][i].amount.substring(1, result[1][i].amount.length)

              }
              console.log("!!!!!", result[1][i].p2p_max_limit);
            }
//            console.log("result of P2P BANK LIST ", result[1]);
            localStorage.setItem('click_client_p2p_bank_list', JSON.stringify(result[1]))
          }
          else
            alert(result[0][0].error_note);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    var maskOne = /[0-9]/g;

    pickContactFromNative = function () {

      window.plugins.PickContact.chooseContact(function (contactInfo) {
//        console.log('CONTACTINFO', contactInfo)
        setTimeout(function () {
          var phoneNumber
          if (device.platform == 'iOS')
            phoneNumber = contactInfo.phoneNr;

          if (device.platform == 'Android') {
            phoneNumber = contactInfo.nameFormated
          }
          var digits = phoneNumber.match(maskOne);
          var phone = '';
          for (var i in digits) {
            phone += digits[i]
          }
          contactPhoneNumberId.value = phone.substring(phone.length - 9, phone.length);
          if (contactPhoneNumberId.value.length != 0) {
            checkPhoneForTransfer = true;
            checkCardForTransfer = false;
//            console.log('contactPhoneNumberId.value', contactPhoneNumberId.value.length)
            if (contactPhoneNumberId.value.length == 9) {
              nextButtonId.style.display = 'block'

              firstSuggestionBlockId.style.display = 'none';
              secondSuggestionBlockId.style.display = 'none';
              thirdSuggestionBlockId.style.display = 'none';
              fourthSuggestionBlockId.style.display = 'none';
              fifthSuggestionBlockId.style.display = 'none';

            }
            else
              nextButtonId.style.display = 'none'

          }// use time-out to fix iOS alert problem
        }, 0);
      }, function (error) {
//        console.log('error', error)
        checkPhoneForTransfer = false;
        checkCardForTransfer = false;
      });


    }

    contactPhoneBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      scope.contactMode = true
      scope.cardMode = false
      riot.update(scope.contactMode);
      riot.update(scope.cardMode);
      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
      }
      else {
        nextButtonId.style.display = 'none'
      }
    }

    cardPhoneBlurAndChange = function () {
      event.preventDefault();
      event.stopPropagation();

      scope.cardMode = true
      scope.contactMode = false

      if (cardInputId.value.replace(/\s/g, '').length == 16) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'

      riot.update();
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
    scope.suggestionOne.phoneNumber = '';
    scope.suggestionOne.firstLetterOfName = '';

    scope.suggestionOneCopy = {};
    scope.suggestionOneCopy.photo = '';
    scope.suggestionOneCopy.fName = '';
    scope.suggestionOneCopy.lName = '';
    scope.suggestionOneCopy.phoneNumber = '';
    scope.suggestionOneCopy.firstLetterOfName = '';

    scope.suggestionTwo = {};
    scope.suggestionTwo.photo = '';
    scope.suggestionTwo.fName = '';
    scope.suggestionTwo.lName = '';
    scope.suggestionTwo.phoneNumber = '';
    scope.suggestionTwo.firstLetterOfName = '';

    scope.suggestionTwoCopy = {};
    scope.suggestionTwoCopy.photo = '';
    scope.suggestionTwoCopy.fName = '';
    scope.suggestionTwoCopy.lName = '';
    scope.suggestionTwoCopy.phoneNumber = '';
    scope.suggestionTwoCopy.firstLetterOfName = '';

    scope.suggestionThree = {};
    scope.suggestionThree.photo = '';
    scope.suggestionThree.fName = '';
    scope.suggestionThree.lName = '';
    scope.suggestionThree.phoneNumber = '';
    scope.suggestionThree.firstLetterOfName = '';

    scope.suggestionFour = {};
    scope.suggestionFour.photo = '';
    scope.suggestionFour.fName = '';
    scope.suggestionFour.lName = '';
    scope.suggestionFour.phoneNumber = '';
    scope.suggestionFour.firstLetterOfName = '';

    scope.suggestionFive = {};
    scope.suggestionFive.photo = '';
    scope.suggestionFive.fName = '';
    scope.suggestionFive.lName = '';
    scope.suggestionFive.phoneNumber = '';
    scope.suggestionFive.firstLetterOfName = '';


    //CARD SUGGESTION OBJECTS
    scope.cardSuggestionOne = {};
    scope.cardSuggestionOne.photo = '';
    scope.cardSuggestionOne.fName = '';
    scope.cardSuggestionOne.lName = '';
    scope.cardSuggestionOne.cardNumber = '';

    scope.cardSuggestionOneCopy = {};
    scope.cardSuggestionOneCopy.photo = '';
    scope.cardSuggestionOneCopy.fName = '';
    scope.cardSuggestionOneCopy.lName = '';
    scope.cardSuggestionOneCopy.cardNumber = '';

    scope.cardSuggestionTwo = {};
    scope.cardSuggestionTwo.photo = '';
    scope.cardSuggestionTwo.fName = '';
    scope.cardSuggestionTwo.lName = '';
    scope.cardSuggestionTwo.cardNumber = '';

    scope.cardSuggestionTwoCopy = {};
    scope.cardSuggestionTwoCopy.photo = '';
    scope.cardSuggestionTwoCopy.fName = '';
    scope.cardSuggestionTwoCopy.lName = '';
    scope.cardSuggestionTwoCopy.cardNumber = '';

    scope.cardSuggestionThree = {};
    scope.cardSuggestionThree.photo = '';
    scope.cardSuggestionThree.fName = '';
    scope.cardSuggestionThree.lName = '';
    scope.cardSuggestionThree.cardNumber = '';

    scope.cardSuggestionFour = {};
    scope.cardSuggestionFour.photo = '';
    scope.cardSuggestionFour.fName = '';
    scope.cardSuggestionFour.lName = '';
    scope.cardSuggestionFour.cardNumber = '';

    scope.cardSuggestionFive = {};
    scope.cardSuggestionFive.photo = '';
    scope.cardSuggestionFive.fName = '';
    scope.cardSuggestionFive.lName = '';
    scope.cardSuggestionFive.cardNumber = '';

    var checkFirstBlock = false;
    var checkSecondBlock = false;
    var checkThirdBlock = false;
    var checkFourthBlock = false;
    var checkFifthBlock = false;

    var checkCardFirstBlock = false;
    var checkCardSecondBlock = false;
    var checkCardThirdBlock = false;
    var checkCardFourthBlock = false;
    var checkCardFifthBlock = false;
    var checkCardMenu = false;


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

    searchCard = function () {

      checkPhoneForTransfer = false;
      checkCardForTransfer = true;

      if ((cardInputId.value.length == 4 || cardInputId.value.length == 9 || cardInputId.value.length == 14) && event.keyCode != 8) {
        cardInputId.value += ' ';

      }

    }

    cardOnKeyUp = function () {
      var arrayOfCards = [];
      if (JSON.parse(localStorage.getItem('transferCards'))) {
        arrayOfCards = JSON.parse(localStorage.getItem('transferCards'));
      }

      if (cardInputId.value.replace(/\s/g, '').length == 16) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
        return
      }
      else {

        nextButtonId.style.display = 'none'


        if (cardInputId.value.length == 0) {

          if (checkCardFirstBlock) {
            scope.cardSuggestionOne = JSON.parse(JSON.stringify(scope.cardSuggestionOneCopy));
            firstCardSuggestionId.style.display = 'block';
          }

          if (checkCardSecondBlock) {
            scope.cardSuggestionTwo = JSON.parse(JSON.stringify(scope.cardSuggestionTwoCopy));
            secondCardSuggestionId.style.display = 'block';
          }

          if (checkCardThirdBlock) {
            thirdCardSuggestionId.style.display = 'block';
          }

          if (checkCardFourthBlock) {
            fourthCardSuggestionId.style.display = 'block';
          }

          if (checkCardFifthBlock) {
            fifthCardSuggestionId.style.display = 'block';
          }
          riot.update();
          return
        }
      }

      thirdCardSuggestionId.style.display = 'none';
      fourthCardSuggestionId.style.display = 'none';
      fifthCardSuggestionId.style.display = 'none';

      checkPhoneForTransfer = false;
      checkCardForTransfer = true;
      event.preventDefault();
      event.stopPropagation();

      var countOfFound = 0;
      var check = false;

      if (event.keyCode != 16 && event.keyCode != 18)
        scope.searchWord = event.target.value.replace(/\s/g, '');

      arrayOfCards.filter(function (wordOfFunction) {

        var index = wordOfFunction.cardNumber.replace(/\s/g, '').indexOf(scope.searchWord);
        if (index != -1 && countOfFound < 2) {

          check = true;

          if (countOfFound == 0) {

            scope.cardSuggestionOne.cardNumber = wordOfFunction.cardNumber;
//            scope.cardSuggestionOne.fName = wordOfFunction;
//            scope.cardSuggestionOne.lName = wordOfFunction;

            if (wordOfFunction.image != null) {
              scope.cardSuggestionOne.photo = wordOfFunction.image;
            }
            else
              scope.cardSuggestionOne.photo = '';


            riot.update(scope.cardSuggestionOne)

            firstCardSuggestionId.style.display = 'block';
            secondCardSuggestionId.style.display = 'none';
          }

          if (countOfFound == 1) {

            scope.cardSuggestionTwo.cardNumber = wordOfFunction.cardNumber;
//            scope.cardSuggestionTwo.fName = wordOfFunction;
//            scope.cardSuggestionTwo.lName = wordOfFunction;

            if (wordOfFunction.image != null) {
              scope.cardSuggestionTwo.photo = wordOfFunction.image;
            }
            else
              scope.cardSuggestionTwo.photo = '';

            riot.update(scope.cardSuggestionTwo)

            secondCardSuggestionId.style.display = 'block';
          }
          countOfFound++;
          if (countOfFound == 2)
            return;
        }
        else if (!check) {
          firstCardSuggestionId.style.display = 'none';
          secondCardSuggestionId.style.display = 'none';
        }
      });


    }

    cardSuggestionFunction = function () {

      if (JSON.parse(localStorage.getItem('transferCards'))) {
        var transferCards = JSON.parse(localStorage.getItem('transferCards'));
      }
      else {
        return;
      }

      var j = 0;

      for (var i = 0; i < transferCards.length; i++) {

        if (j == 4) {
          if (transferCards[i] != null && transferCards[i].cardNumber) {
            checkCardFifthBlock = true
            scope.cardSuggestionFive.cardNumber = transferCards[i].cardNumber;
            if (transferCards[i].image != null) {
              scope.cardSuggestionFive.photo = transferCards[i].image;
            }
            else {
              scope.cardSuggestionFive.photo = '';
            }
            j++;
          }
          else {
            scope.cardSuggestionFive = {};
          }
        }

        if (j == 3) {
          if (transferCards[i] != null && transferCards[i].cardNumber) {
            checkCardFourthBlock = true
            scope.cardSuggestionFour.cardNumber = transferCards[i].cardNumber;
            if (transferCards[i].image != null) {
              scope.cardSuggestionFour.photo = transferCards[i].image;
            }
            else {
              scope.cardSuggestionFour.photo = '';
            }
            j++;
          }
          else {
            scope.cardSuggestionFour = {};
          }
        }

        if (j == 2) {
          if (transferCards[i] != null && transferCards[i].cardNumber) {
            checkCardThirdBlock = true
            scope.cardSuggestionThree.cardNumber = transferCards[i].cardNumber;
            if (transferCards[i].image != null) {
//              console.log("PHOTO", transferCards[i].image)
              scope.cardSuggestionThree.photo = transferCards[i].image;
            }
            else {
              scope.cardSuggestionThree.photo = '';
            }
            j++;
          }
          else {
            scope.cardSuggestionThree = {};
          }
        }

        if (j == 1) {
          if (transferCards[i] != null && transferCards[i].cardNumber) {
            checkCardSecondBlock = true
            scope.cardSuggestionTwo.cardNumber = transferCards[i].cardNumber;
            if (transferCards[i].image != null) {
//              console.log("PHOTO", transferCards[i].image)
              scope.cardSuggestionTwo.photo = transferCards[i].image;
            }
            else {
              scope.cardSuggestionTwo.photo = '';
            }
            j++;

            scope.cardSuggestionTwoCopy = JSON.parse(JSON.stringify(scope.cardSuggestionTwo));
          }
          else {
            scope.cardSuggestionTwo = {};
          }
        }

        if (j == 0) {
          if (transferCards[i] != null && transferCards[i].cardNumber) {
            checkCardFirstBlock = true
            scope.cardSuggestionOne.cardNumber = transferCards[i].cardNumber;
            if (transferCards[i].image != null) {
//              console.log("PHOTO", transferCards[i].image)
              scope.cardSuggestionOne.photo = transferCards[i].image;
            }
            else {
              scope.cardSuggestionOne.photo = '';
            }
            j++;

            scope.cardSuggestionOneCopy = JSON.parse(JSON.stringify(scope.cardSuggestionOne));
          }
          else {
            scope.cardSuggestionOne = {};
          }
        }
      }

      if (!checkCardMenu) {

        if (checkCardFirstBlock) {
          firstCardSuggestionId.style.display = 'block';
        }

        if (checkCardSecondBlock) {
          secondCardSuggestionId.style.display = 'block';
        }

        if (checkCardThirdBlock) {
          thirdCardSuggestionId.style.display = 'block';
        }

        if (checkCardFourthBlock) {
          fourthCardSuggestionId.style.display = 'block';
        }

        if (checkCardFifthBlock) {
          fifthCardSuggestionId.style.display = 'block';
        }
      }

      j = 0;
      riot.update();

    }

    contact = function () {

      contactInputFieldId.style.display = 'block'
      cardInputFieldId.style.display = 'none'
      cardInputId.value = '';
      viewTransfer.type = 2;
      scope.cardMode = false;
      scope.contactMode = true;
      this.menuContainerId.style.backgroundImage = 'url(resources/icons/ViewTransfer/contactMenu.png)';
      this.contactLabelId.style.color = 'black';
      this.cardLabelId.style.color = 'gray';
      this.contactIconId.style.opacity = '1'
      this.cardIconId.style.opacity = '0.5';
      riot.update();

      if (viewTransfer.phoneNumber)
        this.contactPhoneNumberId.value = viewTransfer.phoneNumber;

      if (!contactPhoneNumberId.value) {
        nextButtonId.style.display = 'none'
      }

      contactSuggestionFunction();

    }

    card = function () {
      contactInputFieldId.style.display = 'none'
      cardInputFieldId.style.display = 'block'
      viewTransfer.type = 1;
      contactPhoneNumberId.value = '';
      scope.cardMode = true;
      scope.contactMode = false;
      riot.update();
      this.menuContainerId.style.backgroundImage = 'url(resources/icons/ViewTransfer/cardMenu.png)';
      this.cardLabelId.style.color = 'black';
      this.contactLabelId.style.color = 'gray';
      this.cardIconId.style.opacity = '1'
      this.contactIconId.style.opacity = '0.5'

      if (viewTransfer.cardNumber) {
        this.cardInputId.value = viewTransfer.cardNumber
      }
//      console.log('LENGTH ', cardInputId.value.length)

      if (!cardInputId.value) {
        nextButtonId.style.display = 'none'
      }

      if (cardInputId.value.length != 19) {
        cardSuggestionFunction();
      }

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
          var transferCards = [];
          var codeOfBank = cardInputId.value.replace(/\s/g, '').substring(3, 6);
          var checkOfCode = false;
//          console.log('CODE OF BANK', codeOfBank)

          var bankList = JSON.parse(localStorage.getItem('click_client_p2p_bank_list'))
          var percentOfBank = 0;
          for (var i = 0; i < bankList.length; i++) {
            if (codeOfBank == bankList[i].code) {
              checkOfCode = true;
              percentOfBank = bankList[i].p2p_percent
              break;
            }
            else {
              checkOfCode = false;
            }
          }
          if (!checkOfCode) {
            alert('Неверный код банка');
            return;
          }
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
//                  console.log("result of P2P CARD INFO ", result);
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
                "type": 1,
                "percent": percentOfBank,
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
        alert('Failed because: ' + message);
      }
    }
    if (device.platform != 'BrowserStand')
      findContacts();

    searchContacts = function () {

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'


        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
        return

      }
      else {
        nextButtonId.style.display = 'none'
//        console.log('INPUT CONTACT VALUE', contactPhoneNumberId.value.length)

        if (contactPhoneNumberId.value.length == 0) {

          if (checkFirstBlock) {
            scope.suggestionOne = JSON.parse(JSON.stringify(scope.suggestionOneCopy));
            firstSuggestionBlockId.style.display = 'block';
          }

          if (checkSecondBlock) {
            scope.suggestionTwo = JSON.parse(JSON.stringify(scope.suggestionTwoCopy));
            secondSuggestionBlockId.style.display = 'block';
          }

          if (checkThirdBlock) {
            thirdSuggestionBlockId.style.display = 'block';
          }

          if (checkFourthBlock) {
            fourthSuggestionBlockId.style.display = 'block';
          }

          if (checkFifthBlock) {
            fifthSuggestionBlockId.style.display = 'block';
          }
          riot.update();
          return
        }
      }

      thirdSuggestionBlockId.style.display = 'none';
      fourthSuggestionBlockId.style.display = 'none';
      fifthSuggestionBlockId.style.display = 'none';

      checkPhoneForTransfer = true;
      checkCardForTransfer = false;
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

            if (wordOfFunction.photos != null) {
              if (wordOfFunction.photos[0] != null) {
                scope.suggestionOne.photo = wordOfFunction.photos[0].value;
                scope.suggestionOne.firstLetterOfName = '';
              }
              else {
                scope.suggestionOne.photo = '';
                if (scope.suggestionOne.lName) {
                  scope.suggestionOne.firstLetterOfName = scope.suggestionOne.lName[0].toUpperCase();
                }
                else {
                  if (scope.suggestionOne.fName)
                    scope.suggestionOne.firstLetterOfName = scope.suggestionOne.fName[0].toUpperCase();
                }
              }
            }
            else {
              scope.suggestionOne.photo = '';
              if (scope.suggestionOne.lName) {
                scope.suggestionOne.firstLetterOfName = scope.suggestionOne.lName[0].toUpperCase();
              }
              else {
                if (scope.suggestionOne.fName)
                  scope.suggestionOne.firstLetterOfName = scope.suggestionOne.fName[0].toUpperCase();
              }
            }


            riot.update(scope.suggestionOne)

            firstSuggestionBlockId.style.display = 'block';
            secondSuggestionBlockId.style.display = 'none';
          }

          if (countOfFound == 1) {

            scope.suggestionTwo.phoneNumber = wordOfFunction.phoneNumbers[objectPos].value;
            scope.suggestionTwo.fName = wordOfFunction.name.givenName;
            scope.suggestionTwo.lName = wordOfFunction.name.familyName;

            if (wordOfFunction.photos != null) {
              if (wordOfFunction.photos[0] != null) {
                scope.suggestionTwo.photo = wordOfFunction.photos[0].value;
                scope.suggestionTwo.firstLetterOfName = '';
              }
              else {
                scope.suggestionTwo.photo = '';
                if (scope.suggestionTwo.lName) {
                  scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.lName[0].toUpperCase();
                }
                else {
                  if (scope.suggestionTwo.fName)
                    scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.fName[0].toUpperCase();
                }
              }
            }
            else {
              scope.suggestionTwo.photo = '';
              if (scope.suggestionTwo.lName) {
                scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.lName[0].toUpperCase();
              }
              else {
                if (scope.suggestionTwo.fName)
                  scope.suggestionTwo.firstLetterOfName = scope.suggestionTwo.fName[0].toUpperCase();
              }
            }

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

    contactSuggestionFunction = function () {


//      console.log("JSON.parse(localStorage.getItem('transferContacts'))", JSON.parse(localStorage.getItem('transferContacts')))
      if (JSON.parse(localStorage.getItem('transferContacts'))) {
//        console.log("IN TRANSFER CONTACTS")
        var transferContacts = JSON.parse(localStorage.getItem('transferContacts'));
      }
      else {
//        console.log("RETURN")
        return;
      }

      var j = 0;
      for (var i = 0; i < transferContacts.length; i++) {

        if (j == 4) {
          if (transferContacts[i] != null && transferContacts[i].phoneNumbers != null && transferContacts[i].phoneNumbers[0] != null && transferContacts[i].phoneNumbers[0].value != null) {
            checkFifthBlock = true;
            scope.suggestionFive.phoneNumber = transferContacts[i].phoneNumbers[0].value;
            if (transferContacts[i].photos != null && transferContacts[i].photos[0] != null && transferContacts[i].photos[0].value != null) {
              scope.suggestionFive.photo = transferContacts[i].photos[0].value;
              scope.suggestionFive.firstLetterOfName = '';
            }
            else {
              scope.suggestionFive.photo = '';
              if (transferContacts[i].name != null) {
                if (transferContacts[i].name.familyName != null) {
                  scope.suggestionFive.firstLetterOfName = transferContacts[i].name.familyName[0];
                }
                else {
                  if (transferContacts[i].name.givenName != null)
                    scope.suggestionFive.firstLetterOfName = transferContacts[i].name.givenName[0];
                }
              }
            }

            if (transferContacts[i].name != null) {
              if (transferContacts[i].name.givenName != null) {
                scope.suggestionFive.fName = transferContacts[i].name.givenName;
              }
              else {
                scope.suggestionFive.fName = '';
              }
              if (transferContacts[i].name.familyName != null) {
                scope.suggestionFive.lName = transferContacts[i].name.familyName;
              }
              else {
                scope.suggestionFive.lName = '';
              }
            }
            j++;
          }
          else {
            scope.suggestionFive = {}

          }
        }

        if (j == 3) {
          if (transferContacts[i] != null && transferContacts[i].phoneNumbers != null && transferContacts[i].phoneNumbers[0] != null && transferContacts[i].phoneNumbers[0].value != null) {
            checkFourthBlock = true;
            scope.suggestionFour.phoneNumber = transferContacts[i].phoneNumbers[0].value;
            if (transferContacts[i].photos != null && transferContacts[i].photos[0] != null && transferContacts[i].photos[0].value != null) {
              scope.suggestionFour.photo = transferContacts[i].photos[0].value;
              scope.suggestionFour.firstLetterOfName = '';
            }
            else {
              scope.suggestionFour.photo = '';
              if (transferContacts[i].name != null) {
                if (transferContacts[i].name.familyName != null) {
                  scope.suggestionFour.firstLetterOfName = transferContacts[i].name.familyName[0].toUpperCase();
                }
                else {
                  if (transferContacts[i].name.givenName != null)
                    scope.suggestionFour.firstLetterOfName = transferContacts[i].name.givenName[0].toUpperCase();
                }
              }
            }

            if (transferContacts[i].name != null) {
              if (transferContacts[i].name.givenName != null) {
                scope.suggestionFour.fName = transferContacts[i].name.givenName;
              }
              else {
                scope.suggestionFour.fName = '';
              }
              if (transferContacts[i].name.familyName != null) {
                scope.suggestionFour.lName = transferContacts[i].name.familyName;
              }
              else {
                scope.suggestionFour.lName = '';
              }
            }
            j++;
          }
          else {
            scope.suggestionFour = {}

          }
        }

        if (j == 2) {
          if (transferContacts[i] != null && transferContacts[i].phoneNumbers != null && transferContacts[i].phoneNumbers[0] != null && transferContacts[i].phoneNumbers[0].value != null) {
            checkThirdBlock = true;
            scope.suggestionThree.phoneNumber = transferContacts[i].phoneNumbers[0].value;
            if (transferContacts[i].photos != null && transferContacts[i].photos[0] != null && transferContacts[i].photos[0].value != null) {
              scope.suggestionThree.photo = transferContacts[i].photos[0].value;
              scope.suggestionThree.firstLetterOfName = '';
            }
            else {
              scope.suggestionThree.photo = '';
              if (transferContacts[i].name != null) {
                if (transferContacts[i].name.familyName != null) {
                  scope.suggestionThree.firstLetterOfName = transferContacts[i].name.familyName[0].toUpperCase();
                }
                else {
                  if (transferContacts[i].name.givenName != null)
                    scope.suggestionThree.firstLetterOfName = transferContacts[i].name.givenName[0].toUpperCase();
                }
              }
            }

            if (transferContacts[i].name != null) {
              if (transferContacts[i].name.givenName != null) {
                scope.suggestionThree.fName = transferContacts[i].name.givenName;
              }
              else {
                scope.suggestionThree.fName = '';
              }
              if (transferContacts[i].name.familyName != null) {
                scope.suggestionThree.lName = transferContacts[i].name.familyName;
              }
              else {
                scope.suggestionThree.lName = '';
              }
            }
            j++
          }
          else {
            scope.suggestionThree = {}

          }
        }

        if (j == 1) {
          if (transferContacts[i] != null && transferContacts[i].phoneNumbers != null && transferContacts[i].phoneNumbers[0] != null && transferContacts[i].phoneNumbers[0].value != null) {
            checkSecondBlock = true;
            scope.suggestionTwo.phoneNumber = transferContacts[i].phoneNumbers[0].value;
            if (transferContacts[i].photos != null && transferContacts[i].photos[0] != null && transferContacts[i].photos[0].value != null) {
              scope.suggestionTwo.photo = transferContacts[i].photos[0].value;
              scope.suggestionTwo.firstLetterOfName = '';
            }
            else {
              scope.suggestionTwo.photo = '';
              if (transferContacts[i].name != null) {
                if (transferContacts[i].name.familyName != null) {
                  scope.suggestionTwo.firstLetterOfName = transferContacts[i].name.familyName[0].toUpperCase();
                }
                else {
                  if (transferContacts[i].name.givenName != null)
                    scope.suggestionTwo.firstLetterOfName = transferContacts[i].name.givenName[0].toUpperCase();
                }
              }
            }

            if (transferContacts[i].name != null) {
              if (transferContacts[i].name.givenName != null) {
                scope.suggestionTwo.fName = transferContacts[i].name.givenName;
              }
              else {
                scope.suggestionTwo.fName = '';
              }
              if (transferContacts[i].name.familyName != null) {
                scope.suggestionTwo.lName = transferContacts[i].name.familyName;
              }
              else {
                scope.suggestionTwo.lName = '';
              }
            }
            j++;

            scope.suggestionTwoCopy = JSON.parse(JSON.stringify(scope.suggestionTwo));
          }
          else {
            scope.suggestionTwo = {}

          }
        }

        if (j == 0)
          if (transferContacts[i] != null && transferContacts[i].phoneNumbers != null && transferContacts[i].phoneNumbers[0] != null && transferContacts[i].phoneNumbers[0].value != null) {
            checkFirstBlock = true
            scope.suggestionOne.phoneNumber = transferContacts[i].phoneNumbers[0].value;
            if (transferContacts[i].photos != null && transferContacts[i].photos[0] != null && transferContacts[i].photos[0].value != null) {
//              console.log("PHOTO", transferContacts[i].photos[0])
              scope.suggestionOne.photo = transferContacts[i].photos[0].value;
              scope.suggestionOne.firstLetterOfName = '';
            }
            else {
              scope.suggestionOne.photo = '';
              if (transferContacts[i].name != null) {
                if (transferContacts[i].name.familyName != null) {
                  scope.suggestionOne.firstLetterOfName = transferContacts[i].name.familyName[0].toUpperCase();
                }
                else {
                  if (transferContacts[i].name.givenName != null)
                    scope.suggestionOne.firstLetterOfName = transferContacts[i].name.givenName[0].toUpperCase();
                }
              }
            }

            if (transferContacts[i].name != null) {
              if (transferContacts[i].name.givenName != null) {
                scope.suggestionOne.fName = transferContacts[i].name.givenName;
              }
              else {
                scope.suggestionOne.fName = '';
              }
              if (transferContacts[i].name.familyName != null) {
                scope.suggestionOne.lName = transferContacts[i].name.familyName;
              }
              else {
                scope.suggestionOne.lName = '';
              }
            }
            j++;

            scope.suggestionOneCopy = JSON.parse(JSON.stringify(scope.suggestionOne));
          }
          else {
            scope.suggestionOne = {};
          }
      }

      j = 0;
      riot.update();

    }
    if (viewTransfer.type == 2)
      contactSuggestionFunction()
    else {
      checkCardMenu = true;
      if (viewTransfer.cardNumber.length != 19)
        cardSuggestionFunction()
    }


    firstSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      var digits = scope.suggestionOne.phoneNumber.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      scope.suggestionOne.phoneNumber = phone;
//      console.log(scope.suggestionOne.phoneNumber)
      contactPhoneNumberId.value = scope.suggestionOne.phoneNumber.substring(scope.suggestionOne.phoneNumber.length - 9, scope.suggestionOne.phoneNumber.length);

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'

        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
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

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    thirdSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      var digits = scope.suggestionThree.phoneNumber.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      scope.suggestionThree.phoneNumber = phone;

      contactPhoneNumberId.value = scope.suggestionThree.phoneNumber.substring(scope.suggestionThree.phoneNumber.length - 9, scope.suggestionThree.phoneNumber.length);

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    fourthSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      var digits = scope.suggestionFour.phoneNumber.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      scope.suggestionFour.phoneNumber = phone;

      contactPhoneNumberId.value = scope.suggestionFour.phoneNumber.substring(scope.suggestionFour.phoneNumber.length - 9, scope.suggestionFour.phoneNumber.length);

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    fifthSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      var digits = scope.suggestionFive.phoneNumber.match(maskOne);
      var phone = '';
      for (var i in digits) {
        phone += digits[i]
      }
      scope.suggestionFive.phoneNumber = phone;

      contactPhoneNumberId.value = scope.suggestionFive.phoneNumber.substring(scope.suggestionFive.phoneNumber.length - 9, scope.suggestionFive.phoneNumber.length);

      if (contactPhoneNumberId.value.length == 9) {
        nextButtonId.style.display = 'block'
        firstSuggestionBlockId.style.display = 'none';
        secondSuggestionBlockId.style.display = 'none';
        thirdSuggestionBlockId.style.display = 'none';
        fourthSuggestionBlockId.style.display = 'none';
        fifthSuggestionBlockId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }


    firstCardSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      cardInputId.value = scope.cardSuggestionOne.cardNumber;

      if (cardInputId.value.length == 19) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    secondCardSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      cardInputId.value = scope.cardSuggestionTwo.cardNumber;

      if (cardInputId.value.length == 19) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    thirdCardSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      cardInputId.value = scope.cardSuggestionThree.cardNumber;

      if (cardInputId.value.length == 19) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    fourthCardSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      cardInputId.value = scope.cardSuggestionFour.cardNumber;

      if (cardInputId.value.length == 19) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }

    fifthCardSuggestionBlock = function () {
      event.preventDefault();
      event.stopPropagation();

      cardInputId.value = scope.cardSuggestionFive.cardNumber;

      if (cardInputId.value.length == 19) {
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';
      }
      else
        nextButtonId.style.display = 'none'
    }


  </script>
</view-transfer>

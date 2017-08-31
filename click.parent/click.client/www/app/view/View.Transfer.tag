<view-transfer class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBackFromTransferTouchEnd()" ontouchstart="goToBackFromTransferTouchStart()"
         class="{transfer-back-button: backbuttoncheck}">

    </div>
    <div if="{modeOfApp.onlineMode}" id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"
         ontouchend="openBanksListPageTouchEnd()" ontouchstart="openBanksListPageTouchStart()"></div>
  </div>

  <div class="transfer-body-container">
    <div id="menuContainerId" class="transfer-menus-container">
      <div class="transfer-menu-container-contact" ontouchend="contactTouchEnd()" ontouchstart="contactTouchStart()">
        <div id="contactIconId" class="transfer-menu-contact-icon"></div>
        <p id="contactLabelId" class="transfer-menu-contact-label">
          {window.languages.ViewPayTransferMenuNameContact}</p>
      </div>
      <div class="transfer-menu-container-card" ontouchend="cardTouchEnd()" ontouchstart="cardTouchStart()">
        <div id="cardIconId" class="transfer-menu-card-icon"></div>
        <p id="cardLabelId" class="transfer-menu-card-label">{window.languages.ViewPayTransferMenuNameCard}</p>
      </div>
    </div>
    <div id="contactInputFieldId" class="transfer-contact-body-container">
      <div class="transfer-contact-phone-field">
        <p class="transfer-contact-text-field">{window.languages.ViewPayTransferContactTextField}</p>
        <p class="transfer-contact-number-first-part">+{window.languages.CodeOfCountry}</p>
        <input onpaste="onPasteTrigger()"
               oninput="contactPhoneBlurAndChange('onInput')"
               onchange="contactPhoneBlurAndChange()"
               onfocus="contactPhoneBlurAndChange()"
               id="contactPhoneNumberId"
               class="transfer-contact-number-input-part" type="tel"
               onkeyup="searchContacts()"
               onkeydown="telTransferVerificationKeyDown(this)"/>
        <div class="transfer-contact-phone-icon" ontouchstart="pickContactFromNativeTouchStart()"
             ontouchend="pickContactFromNativeTouchEnd()"></div>
      </div>
      <div id="firstSuggestionBlockId" class="transfer-contact-found-container-one"
           ontouchend="firstSuggestionBlockTouchEnd()" ontouchstart="firstSuggestionBlockTouchStart()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionOne.photo})">
          {suggestionOne.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionOne.fName} {suggestionOne.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionOne.phoneNumber}</div>
      </div>
      <div id="secondSuggestionBlockId" class="transfer-contact-found-container-two"
           ontouchend="secondSuggestionBlockTouchEnd()" ontouchstart="secondSuggestionBlockTouchStart()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionTwo.photo})">
          {suggestionTwo.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionTwo.fName} {suggestionTwo.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionTwo.phoneNumber}</div>
      </div>


      <div id="thirdSuggestionBlockId" class="transfer-contact-found-container-three"
           ontouchend="thirdSuggestionBlockTouchEnd()" ontouchstart="thirdSuggestionBlockTouchStart()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionThree.photo})">
          {suggestionThree.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionThree.fName} {suggestionThree.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionThree.phoneNumber}</div>
      </div>


      <div id="fourthSuggestionBlockId" class="transfer-contact-found-container-four"
           ontouchend="fourthSuggestionBlockTouchEnd()" ontouchstart="fourthSuggestionBlockTouchStart()">
        <div class="transfer-contact-found-photo" style="background-image: url({suggestionFour.photo})">
          {suggestionFour.firstLetterOfName}
        </div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{suggestionFour.fName} {suggestionFour.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{suggestionFour.phoneNumber}</div>
      </div>


      <div id="fifthSuggestionBlockId" class="transfer-contact-found-container-five"
           ontouchend="fifthSuggestionBlockTouchEnd()" ontouchstart="fifthSuggestionBlockTouchStart()">
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
        <input onpaste="onPasteTrigger()"
               oninput="cardPhoneBlurAndChange('onInput')"
               onchange="cardPhoneBlurAndChange()"
               onfocus="cardPhoneBlurAndChange()"
               id="cardInputId" class="transfer-card-number-input-part" type="tel"
               onkeydown="searchCard(this)" onkeyup="cardOnKeyUp()"
        />
      </div>
      <div hidden id="ownerCardDsiplayId" class="transfer-card-owner-container">
        <p class="transfer-card-owner-title">{window.languages.ViewPayTransferCardOwnerTitle}</p>
        <p class="transfer-card-owner-info">{cardOwner}</p>
      </div>

      <div id="firstCardSuggestionId" class="transfer-contact-found-container-one"
           ontouchend="firstCardSuggestionBlockTouchEnd()" ontouchstart="firstCardSuggestionBlockTouchStart()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionOne.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionOne.fName} {cardSuggestionOne.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionOne.cardNumber.substring(0,4)} **** ****
          {cardSuggestionOne.cardNumber.substring(cardSuggestionOne.cardNumber.length-5,cardSuggestionOne.cardNumber.length)}
        </div>
      </div>

      <div id="secondCardSuggestionId" class="transfer-contact-found-container-two"
           ontouchend="secondCardSuggestionBlockTouchEnd()" ontouchstart="secondCardSuggestionBlockTouchStart()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionTwo.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionTwo.fName} {cardSuggestionTwo.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionTwo.cardNumber.substring(0,4)} **** ****
          {cardSuggestionTwo.cardNumber.substring(cardSuggestionTwo.cardNumber.length-5,cardSuggestionTwo.cardNumber.length)}
        </div>
      </div>

      <div id="thirdCardSuggestionId" class="transfer-contact-found-container-three"
           ontouchend="thirdCardSuggestionBlockTouchEnd()" ontouchstart="thirdCardSuggestionBlockTouchStart()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionThree.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionThree.fName} {cardSuggestionThree.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionThree.cardNumber.substring(0,4)} **** ****
          {cardSuggestionThree.cardNumber.substring(cardSuggestionThree.cardNumber.length-5,cardSuggestionThree.cardNumber.length)}
        </div>
      </div>

      <div id="fourthCardSuggestionId" class="transfer-contact-found-container-four"
           ontouchend="fourthCardSuggestionBlockTouchEnd()" ontouchstart="fourthCardSuggestionBlockTouchStart()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionFour.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionFour.fName} {cardSuggestionFour.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionFour.cardNumber.substring(0,4)} **** ****
          {cardSuggestionFour.cardNumber.substring(cardSuggestionFour.cardNumber.length-5,cardSuggestionFour.cardNumber.length)}
        </div>
      </div>

      <div id="fifthCardSuggestionId" class="transfer-contact-found-container-five"
           ontouchend="fifthCardSuggestionBlockTouchEnd()" ontouchstart="fifthCardSuggestionBlockTouchStart()">
        <div class="transfer-card-found-photo" style="background-image: url({cardSuggestionFive.photo})"></div>
        <div class="transfer-contact-found-text-container">
          <div class="transfer-contact-found-text-one">{cardSuggestionFive.fName} {cardSuggestionFive.lName}</div>
        </div>
        <div class="transfer-contact-found-text-two">{cardSuggestionFive.cardNumber.substring(0,4)} **** ****
          {cardSuggestionFive.cardNumber.substring(cardSuggestionFive.cardNumber.length-5,cardSuggestionFive.cardNumber.length)}
        </div>
      </div>

    </div>

    <button id="nextButtonId" class="transfer-next-button-inner-container"
            ontouchstart="goToTransferStepTwoTouchStart()"
            ontouchend="goToTransferStepTwoTouchEnd()">
      {window.languages.ViewPayTransferNext}
    </button>

  </div>

  <div hidden="{!showComponent}" id="componentBankListId" class="component-bank-list">
    <div class="page-title" style="border: none;">
      <p class="component-banklist-name-title">{window.languages.ViewBankListTitleName}</p>
      <div id="closeBankListButtonId" type="button" class="component-banklist-close-button"
           ontouchend="closeComponentBankListTouchEnd()" ontouchstart="closeComponentBankListTouchStart()"></div>
    </div>
    <div id="bankListContainerId" class="component-banklist-container" onscroll="bankListTouchMove()">
      <div class="component-banklist-card" each="{i in bankList}">
        <div class="component-banklist-bank-logo" style="background-image: url({i.image});"></div>
        <div class="component-banklist-bank-limit-container">
          <div class="component-banklist-bank-limit-receipt">{window.languages.ViewBankListReceiveLimitText}</div>
          <div class="component-banklist-bank-limit-currency-receipt">{i.p2p_receipt_max_limit_text}
          </div>

          <div class="component-banklist-bank-limit-transfer">{window.languages.ViewBankListTransferLimitText}</div>
          <div class="component-banklist-bank-limit-currency-transfer">
            {i.p2p_max_limit_text}
          </div>
        </div>
      </div>
    </div>
  </div>
  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <component-tour view="transfer"></component-tour>
  <script>

    viewTransfer.check = true;
    var scope = this;
    scope.numberLength = 10;
    this.on('mount', function () {

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).transfer) {
        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#004663");
      }

      if (opts && opts.number) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(opts.number)
        console.log('opts number with space=', contactPhoneNumberId.value)
        if (contactPhoneNumberId.value == scope.numberLength) {
          firstSuggestionBlockId.style.display = 'none';
          secondSuggestionBlockId.style.display = 'none';
          thirdSuggestionBlockId.style.display = 'none';
          fourthSuggestionBlockId.style.display = 'none';
          fifthSuggestionBlockId.style.display = 'none';
        }
      }

      if (viewTransfer.type == 2) {
//        console.log('ON MOUNT')
        contactTouchEnd(true);
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

        if (contactPhoneNumberId.value.length == scope.numberLength) {
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

        console.log("TRANSFER SSSSSSS", cardInputId.value.length)

        if (cardInputId.value.replace(/\s/g, '').length != 16) {
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

        if (cardInputId.value.replace(/\s/g, '').length == 16) {
          console.log('WQEQEWQEQW')
          nextButtonId.style.display = 'block'
          firstCardSuggestionId.style.display = 'none';
          secondCardSuggestionId.style.display = 'none';
          thirdCardSuggestionId.style.display = 'none';
          fourthCardSuggestionId.style.display = 'none';
          fifthCardSuggestionId.style.display = 'none';
        }
        cardTouchEnd(true);
      }


    })

    var contactStopChanging = false;
    var cardStopChanging = false;

    telTransferVerificationKeyDown = function (input) {
//      console.log(event.target.value)
      console.log("INPUT", event)
      if (input.value.length >= scope.numberLength && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
//        contactPhoneNumberId.value = event.target.value.substring(0, event.target.value.length - 1);
        contactStopChanging = true;

      }
      else {
        contactStopChanging = false;
      }
    }

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }
    //    console.log('OPTS', opts)

    if (localStorage.getItem('click_client_loginInfo')) {
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

//      console.log('LOGIN INFO', logi)
    }

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    var openBankListTouchStartX, openBankListTouchStartY, openBankListTouchEndX, openBankListTouchEndY;
    openBanksListPageTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(0.8)'

      openBankListTouchStartX = event.changedTouches[0].pageX
      openBankListTouchStartY = event.changedTouches[0].pageY

    }

    bankListTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
    }


    openBanksListPageTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(1)'

      openBankListTouchEndX = event.changedTouches[0].pageX
      openBankListTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(openBankListTouchStartX - openBankListTouchEndX) <= 20 && Math.abs(openBankListTouchStartY - openBankListTouchEndY) <= 20) {

        if (modeOfApp.offlineMode)return

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
          scope.showError = true;
          scope.errorNote = question;
          scope.confirmType = 'local';
          scope.update();

          return
        }

        if (JSON.parse(localStorage.getItem("click_client_p2p_bank_list"))) {
          scope.bankList = JSON.parse(localStorage.getItem("click_client_p2p_bank_list"));
//        console.log("bank list", scope.bankList);
        }
        scope.showComponent = true
        window.checkShowingComponent = scope;

        scope.update();
      }
    };

    //    console.log('BANK UPDATE', loginInfo.update_bank_list)
    if (loginInfo)
      if (!localStorage.getItem("click_client_p2p_bank_list") || loginInfo.update_bank_list) {
        if (modeOfApp.onlineMode)
          window.api.call({
            method: 'p2p.bank.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,

            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                var bankListAvailable = [];
                for (var i in result[1]) {
//                  result[1][i].amount = result[1][i].p2p_max_limit.toString();
//                  console.log('result[1][i]', result[1][i])
//
//                  result[1][i].amount = window.amountTransform(result[1][i].amount);
//                  result[1][i].p2p_receipt_max_limit_transform = window.amountTransform(result[1][i].p2p_receipt_max_limit);
//                  result[1][i].p2p_max_limit_transform = window.amountTransform(result[1][i].p2p_max_limit);
                  console.log('BANK LIST', result[1][i])

                  if (result[1][i].p2p_status == 1)
                    bankListAvailable.push(result[1][i]);

//              console.log("!!!!!", result[1][i].p2p_max_limit);
                }
//            console.log("result of P2P BANK LIST ", result[1]);
                if (localStorage.getItem('click_client_p2p_all_bank_list') != JSON.stringify(result[1])) {
                  localStorage.setItem('click_client_p2p_bank_list', JSON.stringify(bankListAvailable));
                  localStorage.setItem('click_client_p2p_all_bank_list', JSON.stringify(result[1]));
                }

              }
              else {
                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;
                scope.showError = true;
                scope.update();
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
      }

    var closeBankListTouchStartX, closeBankListTouchStartY, closeBankListTouchEndX, closeBankListTouchEndY;

    closeComponentBankListTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      closeBankListButtonId.style.webkitTransform = 'scale(0.8)'

      closeBankListTouchStartX = event.changedTouches[0].pageX
      closeBankListTouchStartY = event.changedTouches[0].pageY
    }

    closeComponentBankListTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      closeBankListButtonId.style.webkitTransform = 'scale(1)'

      closeBankListTouchEndX = event.changedTouches[0].pageX
      closeBankListTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(closeBankListTouchStartX - closeBankListTouchEndX) <= 20 && Math.abs(closeBankListTouchStartY - closeBankListTouchEndY) <= 20) {
        bankListContainerId.scrollTop = 0;
        scope.showComponent = false
        window.checkShowingComponent = null;
        scope.update()
      }
    }


    var maskOne = /[0-9]/g;

    var pickFromNativeTouchStartX, pickFromNativeTouchStartY, pickFromNativeTouchEndX, pickFromNativeTouchEndY;

    pickContactFromNativeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      pickFromNativeTouchStartX = event.changedTouches[0].pageX
      pickFromNativeTouchStartY = event.changedTouches[0].pageY
    }

    pickContactFromNativeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      pickFromNativeTouchEndX = event.changedTouches[0].pageX
      pickFromNativeTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(pickFromNativeTouchStartX - pickFromNativeTouchEndX) <= 20 && Math.abs(pickFromNativeTouchStartY - pickFromNativeTouchEndY) <= 20) {
        window.pickContactFromNativeChecker = true;

        try {
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
                if (contactPhoneNumberId.value.length == scope.numberLength) {
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
        catch (e) {
          console.log(e)
        }
      }
    }

    var onPaste = false;
    contactPhoneBlurAndChange = function (from) {
      event.preventDefault();
      event.stopPropagation();
      console.log('from', from)
      if (onPaste) {

        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(contactPhoneNumberId.value)
        onPaste = false;
      }

      scope.contactMode = true
      scope.cardMode = false
      scope.update();
      if (contactPhoneNumberId.value.length == scope.numberLength) {
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
      console.log('event.keyCode', event)
      if (onPaste) {
        var cardWithouSpace = inputVerification.spaceDeleter(event.target.value)
        console.log('cardWithouSpace', cardWithouSpace)
        console.log('cardInputId.value', cardInputId.value)
        cardInputId.value = inputVerification.cardVerification(cardWithouSpace)
        onPaste = false;
      }

      if (cardInputId.value.replace(/\s/g, '').length == 16) {
        cardOwnerFunction();
        nextButtonId.style.display = 'block'
        firstCardSuggestionId.style.display = 'none';
        secondCardSuggestionId.style.display = 'none';
        thirdCardSuggestionId.style.display = 'none';
        fourthCardSuggestionId.style.display = 'none';
        fifthCardSuggestionId.style.display = 'none';

      }
      else
        nextButtonId.style.display = 'none'

      scope.update();
    }

    onPasteTrigger = function () {
      onPaste = true;
    }


    this.titleName = window.languages.ViewPayTransferTitle;
    var scope = this,
      phoneNumberForTransfer = '',
      cardNumberForTransfer = '',
      arrayOfContacts = [];

    scope.showError = false;
    scope.showComponent = false;

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

    var goToBackTransferTouchStartX, goToBackTransferTouchStartY, goToBackTransferTouchEndX, goToBackTransferTouchEndY;

    goToBackFromTransferTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.8)'

      goToBackTransferTouchStartX = event.changedTouches[0].pageX
      goToBackTransferTouchStartY = event.changedTouches[0].pageY
    }

    goToBackFromTransferTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goToBackTransferTouchEndX = event.changedTouches[0].pageX
      goToBackTransferTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToBackTransferTouchStartX - goToBackTransferTouchEndX) <= 20 && Math.abs(goToBackTransferTouchStartY - goToBackTransferTouchEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    }

    searchCard = function (input) {

      checkPhoneForTransfer = false;
      checkCardForTransfer = true;

//      if ((cardInputId.value.length == 4 || cardInputId.value.length == 9 || cardInputId.value.length == 14) && event.keyCode != input_codes.BACKSPACE_CODE) {
//        cardInputId.value += ' ';
//
//      }

      if (input.value.length >= 19 && event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
//        cardInputId.value = event.target.value.substring(0, event.target.value.length - 1);
        cardStopChanging = true;
      }
      else {
        cardStopChanging = false;
      }

    }

    scope.cardOwner = '';

    cardOwnerFunction = function () {

      if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');

      window.api.call({
        method: 'p2p.card.info',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          card_number: cardInputId.value.replace(/\s/g, ''),

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
//              console.log("result of P2P CARD INFO ", result[1][0].card_owner)
            try {
              if (result[1] && result[1][0]) {
                scope.cardOwner = result[1][0].card_owner;
                if (scope.cardOwner)
                  ownerCardDsiplayId.style.display = 'block'
              }
              scope.update()
            }
            catch (error) {
              console.log(error)
            }
//            riot.update()
          }
          else {
//              alert(result[0][0].error_note);
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    cardOnKeyUp = function () {
      console.log('cardInputId.value.length', cardInputId.value.length)

      if (cardStopChanging) {
        cardInputId.value = event.target.value.substring(0, event.target.value.length - 1);
      }

      if (cardInputId.value.length <= 19 && (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT))
        cardInputId.value = inputVerification.cardVerification(cardInputId.value);

      var arrayOfCards = [];
      if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
        arrayOfCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
      }

      if (cardInputId.value.replace(/\s/g, '').length == 16) {
        cardOwnerFunction();
        console.log(cardInputId.value.replace(/\s/g, '').length)
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
        ownerCardDsiplayId.style.display = 'none'


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
//          riot.update();
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


//            riot.update(scope.cardSuggestionOne)

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

//            riot.update(scope.cardSuggestionTwo)

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

      scope.update()

    }

    cardSuggestionFunction = function () {

      if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
        var transferCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
      }
      else {
        return;
      }

      var j = 0;

      for (var i = 0; i < transferCards.length; i++) {
        console.log('transferCards', transferCards[i])

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
            if (transferCards[i].owner.firstName != null) {
              scope.cardSuggestionFive.fName = transferCards[i].owner.firstName;
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
            if (transferCards[i].owner.firstName != null) {
              scope.cardSuggestionFour.fName = transferCards[i].owner.firstName;
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
            if (transferCards[i].owner.firstName != null) {
              scope.cardSuggestionThree.fName = transferCards[i].owner.firstName;
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
            if (transferCards[i].owner.firstName != null) {
              scope.cardSuggestionTwo.fName = transferCards[i].owner.firstName;
            }
            j++;

            scope.cardSuggestionTwoCopy = JSON.parse(JSON.stringify(scope.cardSuggestionTwo));
          }
          else {
            scope.cardSuggestionTwo = {};
          }
        }

        console.log("CHECK CARD MENU", checkCardMenu)
        console.log("CHECK J", j)
        if (j == 0) {
          console.log("CHECK CARD MENU", checkCardMenu)
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
            if (transferCards[i].owner.firstName != null) {
              scope.cardSuggestionOne.fName = transferCards[i].owner.firstName;
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
      scope.update();

    }

    var contactChooseTouchStartX, contactChooseTouchStartY, contactChooseTouchEndX, contactChooseTouchEndY;

    contactTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      contactChooseTouchStartX = event.changedTouches[0].pageX
      contactChooseTouchStartY = event.changedTouches[0].pageY
    }

    contactTouchEnd = function (bool) {

      if (!bool) {
        contactChooseTouchEndX = event.changedTouches[0].pageX
        contactChooseTouchEndY = event.changedTouches[0].pageY
      }

      console.log('Contact transfer')
      console.log(contactChooseTouchStartX, contactChooseTouchStartY)
      console.log(contactChooseTouchStartX, contactChooseTouchStartY)

      if ((Math.abs(contactChooseTouchStartX - contactChooseTouchEndX) <= 20 && Math.abs(contactChooseTouchStartY - contactChooseTouchEndY) <= 20) || bool) {
        viewTransferStepTwo.sum = 0;
        viewTransferStepTwo.sumWithoutSpace = 0;

        if (device.platform == 'iOS') {
          contactPhoneNumberId.autofocus;
          contactPhoneNumberId.focus();
        }
        else {
          setTimeout(function () {
            contactPhoneNumberId.focus();
          }, 0)
        }

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
        scope.update();

        if (viewTransfer.phoneNumber)
          this.contactPhoneNumberId.value = viewTransfer.phoneNumber;

        if (!contactPhoneNumberId.value) {
          nextButtonId.style.display = 'none'
        }

        contactSuggestionFunction();
      }

    }


    var cardChooseTouchStartX, cardChooseTouchStartY, cardChooseTouchEndX, cardChooseTouchEndY;

    cardTouchStart = function () {
      event.preventDefault()
      event.stopPropagation()

      cardChooseTouchStartX = event.changedTouches[0].pageX
      cardChooseTouchStartY = event.changedTouches[0].pageY
    }


    cardTouchEnd = function (bool) {


      if (!bool) {
        cardChooseTouchEndX = event.changedTouches[0].pageX
        cardChooseTouchEndY = event.changedTouches[0].pageY
      }
      console.log('Card transfer')

      if ((Math.abs(cardChooseTouchStartX - cardChooseTouchEndX) <= 20 && Math.abs(cardChooseTouchStartY - cardChooseTouchEndY) <= 20) || bool) {
        viewTransferStepTwo.sum = 0;
        viewTransferStepTwo.sumWithoutSpace = 0;

        if (device.platform == 'iOS') {
          cardInputId.autofocus;
          cardInputId.focus();
        }
        else {
          setTimeout(function () {
            cardInputId.focus();
          }, 0)
        }

        contactInputFieldId.style.display = 'none'
        cardInputFieldId.style.display = 'block'
        viewTransfer.type = 1;
        contactPhoneNumberId.value = '';
        scope.cardMode = true;
        scope.contactMode = false;
        scope.update();
        this.menuContainerId.style.backgroundImage = 'url(resources/icons/ViewTransfer/cardMenu.png)';
        this.cardLabelId.style.color = 'black';
        this.contactLabelId.style.color = 'gray';
        this.cardIconId.style.opacity = '1'
        this.contactIconId.style.opacity = '0.5'

        if (viewTransfer.cardNumber) {
          this.cardInputId.value = viewTransfer.cardNumber

          if (cardInputId.value.replace(/\s/g, '').length == 16) {
            cardOwnerFunction();
          }
        }
//      console.log('LENGTH ', cardInputId.value.length)

        if (!cardInputId.value) {
          nextButtonId.style.display = 'none'
        }

        if (cardInputId.value.replace(/\s/g, '').length != 16) {

          cardSuggestionFunction();
        }
      }

    }

    var goToTransferStepTwoTouchStartX, goToTransferStepTwoTouchStartY, goToTransferStepTwoTouchEndX,
      goToTransferStepTwoTouchEndY;

    goToTransferStepTwoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = "scale(0.8)"

      goToTransferStepTwoTouchStartX = event.changedTouches[0].pageX
      goToTransferStepTwoTouchStartY = event.changedTouches[0].pageY


    }


    goToTransferStepTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      nextButtonId.style.webkitTransform = "scale(1)"

      goToTransferStepTwoTouchEndX = event.changedTouches[0].pageX
      goToTransferStepTwoTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToTransferStepTwoTouchStartX - goToTransferStepTwoTouchEndX) <= 20 && Math.abs(goToTransferStepTwoTouchStartY - goToTransferStepTwoTouchEndY) <= 20) {

        if (!checkPhoneForTransfer && !checkCardForTransfer) {
          scope.clickPinError = false;
          scope.errorNote = 'Введите номер телефона или номер карты';
          scope.showError = true;
          scope.update();
//        alert('Write phone number or card number for transfer')
        }
        else {
          if (viewTransfer.type == 2) {
            phoneNumberForTransfer = inputVerification.spaceDeleter(contactPhoneNumberId.value);
            viewTransfer.phoneNumber = phoneNumberForTransfer;
            viewTransfer.type = 2;
            if (phoneNumberForTransfer.length != 9) {
              contactPhoneNumberId.blur();
              scope.clickPinError = false;
              scope.errorNote = 'Неверный номер телефона';
              scope.showError = true;
              scope.update();
//            alert('Incorrect phone number')
              return
            }
            else {
              phoneNumberForTransfer = window.languages.CodeOfCountry + phoneNumberForTransfer
              this.riotTags.innerHTML = "<view-transfer-steptwo>";
              if (JSON.parse(localStorage.getItem('click_client_loginInfo')))
                var tax = JSON.parse(localStorage.getItem('click_client_loginInfo')).p2p_comission
              else
                var tax = 0;
              riot.mount('view-transfer-steptwo', [
                {
                  "name": phoneNumberForTransfer,
                  "type": 2,
                  "percent": tax,
                }
              ]);

              scope.unmount()
              return
            }
          }

          if (viewTransfer.type == 1) {
            if (modeOfApp.onlineMode) {
              var transferCards = [];
              var firstFourSymbols = cardInputId.value.replace(/\s/g, '').substring(0, 4);
              console.log('firstFourSymbols', firstFourSymbols)
              if (firstFourSymbols != '8600') {
                cardInputId.blur()
                scope.clickPinError = false;
                scope.errorNote = 'Неверные данные о карте';
                scope.showError = true;
                scope.update();
//            alert('Неверный код банка');
                return;
              }
              var codeOfBank = cardInputId.value.replace(/\s/g, '').substring(3, 6);
              var checkOfCode = false;
              var statusOfBankToP2P = false;
              var nameOfBank = '';
              console.log('CODE OF BANK', codeOfBank)

              var bankList = JSON.parse(localStorage.getItem('click_client_p2p_all_bank_list'))
              console.log("BANKLIST", bankList);
              var percentOfBank = 0;
              for (var i = 0; i < bankList.length; i++) {
                console.log('BANK LIST', bankList[i])
                if (codeOfBank == bankList[i].code) {
                  checkOfCode = true;
                  nameOfBank = bankList[i].bank_name;
                  if (bankList[i].p2p_status == 1) {
                    statusOfBankToP2P = true
                  }
                  percentOfBank = bankList[i].p2p_percent
                  break;
                }
                else {
                  checkOfCode = false;
                }
              }
              if (!checkOfCode) {
                cardInputId.blur()
                scope.clickPinError = false;
                scope.errorNote = 'Неверный номер карты';
                scope.showError = true;
                scope.update();
//            alert('Неверный код банка');
                return;
              }

              if (checkOfCode && !statusOfBankToP2P) {
                cardInputId.blur()
                scope.clickPinError = false;
                scope.errorNote = 'Карта "' + nameOfBank + '" банка временно недоступна для перевода средств';
                scope.showError = true;
                scope.update();
//            alert('Неверный код банка');
                return;
              }

            }
            cardNumberForTransfer = cardInputId.value;
            viewTransfer.cardNumber = cardNumberForTransfer
            viewTransfer.type = 1;
            if (cardNumberForTransfer.replace(/\s/g, '').length != 16) {
              cardInputId.blur()
              scope.clickPinError = false;
              scope.errorNote = 'Неверный номер карты';
              scope.showError = true;
              scope.update();
//            alert('Incorrect card number')
              return
            }
            else {
              this.riotTags.innerHTML = "<view-transfer-steptwo>";
              riot.mount('view-transfer-steptwo', [
                {
                  "name": cardNumberForTransfer,
                  "type": 1,
                  "percent": percentOfBank,
                  "owner": scope.cardOwner
                }
              ]);

              scope.unmount()
              return
            }
          }
        }
      }
    }

    findContacts = function () {

      var options = new ContactFindOptions();
      var fields = [''];
      options.filter = "";
      options.multiple = true;
      options.desiredFields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.phoneNumbers];
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
        scope.errorNote = 'Отсутствует доступ';
        scope.showError = true;
        scope.update();
//        alert('Failed because: ' + message);
      }
    }
    if (device.platform != 'BrowserStand') {
      try {
        findContacts();
      }
      catch (e) {
        console.log(e)
      }
    }

    var cursorPositionSelectionStart, cursorPositionSelectionEnd, oldValueOfNumber;
    searchContacts = function () {
      if (contactStopChanging) {
        contactPhoneNumberId.value = event.target.value.substring(0, event.target.value.length - 1);
      }
      cursorPositionSelectionStart = contactPhoneNumberId.selectionStart;
      cursorPositionSelectionEnd = contactPhoneNumberId.selectionEnd;
      oldValueOfNumber = contactPhoneNumberId.value
      if (event.keyCode != input_codes.BACKSPACE_CODE && event.keyCode != input_codes.NEXT) {
        contactPhoneNumberId.value = inputVerification.telVerificationWithSpace(contactPhoneNumberId.value)
        console.log("after with space changing=", contactPhoneNumberId.value)

        contactPhoneNumberId.selectionStart = cursorPositionSelectionStart
        contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd

        if (oldValueOfNumber != contactPhoneNumberId.value && cursorPositionSelectionStart == 3)
          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart + 1;

//        if (oldValueOfNumber != contactPhoneNumberId.value) {
//          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart - 1
//          contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd - 1
//        }
//        else {
//          contactPhoneNumberId.selectionStart = cursorPositionSelectionStart
//          contactPhoneNumberId.selectionEnd = cursorPositionSelectionEnd
//        }
      }

      if (contactPhoneNumberId.value.length == scope.numberLength) {
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
          scope.update()
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
      console.log("before", event.target.value)
      console.log('spaces deleted for searchWord', inputVerification.spaceDeleter(event.target.value))
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

      scope.update()
    }

    contactSuggestionFunction = function () {


//      console.log("JSON.parse(localStorage.getItem('transferContacts'))", JSON.parse(localStorage.getItem('transferContacts')))
      if (JSON.parse(localStorage.getItem('p2pTransferContacts'))) {
//        console.log("IN TRANSFER CONTACTS")
        var transferContacts = JSON.parse(localStorage.getItem('p2pTransferContacts'));
      }
      else {
//        console.log("RETURN")
        return;
      }

      var j = 0;
      for (var i = 0; i < transferContacts.length; i++) {
        console.log("CONTACT IN TRANSFER", transferContacts[i])

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

    }
    if (viewTransfer.type == 2)
      contactSuggestionFunction()
    else {
      checkCardMenu = true;
      if (viewTransfer.cardNumber)
        if (viewTransfer.cardNumber.replace(/\s/g, '').length != 16)
          cardSuggestionFunction()
    }


    var firstSuggestionBlockTouchStartX, firstSuggestionBlockTouchStartY, firstSuggestionBlockTouchEndX,
      firstSuggestionBlockTouchEndY;

    firstSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      firstSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      firstSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    firstSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      firstSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      firstSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(firstSuggestionBlockTouchEndX - firstSuggestionBlockTouchStartX) <= 20 && Math.abs(firstSuggestionBlockTouchStartY - firstSuggestionBlockTouchEndY) <= 20) {

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
    }

    var secondSuggestionBlockTouchStartX, secondSuggestionBlockTouchStartY, secondSuggestionBlockTouchEndX,
      secondSuggestionBlockTouchEndY;

    secondSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      secondSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      secondSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    secondSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      secondSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      secondSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(secondSuggestionBlockTouchEndX - secondSuggestionBlockTouchStartX) <= 20 && Math.abs(secondSuggestionBlockTouchStartY - secondSuggestionBlockTouchEndY) <= 20) {

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
    }

    var thirdSuggestionBlockTouchStartX, thirdSuggestionBlockTouchStartY, thirdSuggestionBlockTouchEndX,
      thirdSuggestionBlockTouchEndY;

    thirdSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      thirdSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      thirdSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    thirdSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      thirdSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      thirdSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(thirdSuggestionBlockTouchEndX - thirdSuggestionBlockTouchStartX) <= 20 && Math.abs(thirdSuggestionBlockTouchStartY - thirdSuggestionBlockTouchEndY) <= 20) {

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
    }

    var fourthSuggestionBlockTouchStartX, fourthSuggestionBlockTouchStartY, fourthSuggestionBlockTouchEndX,
      fourthSuggestionBlockTouchEndY;

    fourthSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      fourthSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      fourthSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    fourthSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      fourthSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      fourthSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(fourthSuggestionBlockTouchEndX - fourthSuggestionBlockTouchStartX) <= 20 && Math.abs(fourthSuggestionBlockTouchStartY - fourthSuggestionBlockTouchEndY) <= 20) {

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
    }

    var fifthSuggestionBlockTouchStartX, fifthSuggestionBlockTouchStartY, fifthSuggestionBlockTouchEndX,
      fifthSuggestionBlockTouchEndY;

    fifthSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      fifthSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      fifthSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    fifthSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      fifthSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      fifthSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(fifthSuggestionBlockTouchEndX - fifthSuggestionBlockTouchStartX) <= 20 && Math.abs(fifthSuggestionBlockTouchStartY - fifthSuggestionBlockTouchEndY) <= 20) {

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
    }

    var firstCardSuggestionBlockTouchStartX, firstCardSuggestionBlockTouchStartY, firstCardSuggestionBlockTouchEndX,
      firstCardSuggestionBlockTouchEndY;

    firstCardSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      firstCardSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      firstCardSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    firstCardSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      firstCardSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      firstCardSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(firstCardSuggestionBlockTouchEndX - firstCardSuggestionBlockTouchStartX) <= 20 && Math.abs(firstCardSuggestionBlockTouchStartY - firstCardSuggestionBlockTouchEndY) <= 20) {

        cardInputId.value = scope.cardSuggestionOne.cardNumber;

        if (cardInputId.value.replace(/\s/g, '').length == 16) {
          cardOwnerFunction();
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
    }

    var secondCardSuggestionBlockTouchStartX, secondCardSuggestionBlockTouchStartY, secondCardSuggestionBlockTouchEndX,
      secondCardSuggestionBlockTouchEndY;

    secondCardSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      secondCardSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      secondCardSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    secondCardSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      secondCardSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      secondCardSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(secondCardSuggestionBlockTouchEndX - secondCardSuggestionBlockTouchStartX) <= 20 && Math.abs(secondCardSuggestionBlockTouchStartY - secondCardSuggestionBlockTouchEndY) <= 20) {

        cardInputId.value = scope.cardSuggestionTwo.cardNumber;

        if (cardInputId.value.replace(/\s/g, '').length == 16) {
          cardOwnerFunction();
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
    }

    var thirdCardSuggestionBlockTouchStartX, thirdCardSuggestionBlockTouchStartY, thirdCardSuggestionBlockTouchEndX,
      thirdCardSuggestionBlockTouchEndY;

    thirdCardSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      thirdCardSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      thirdCardSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    thirdCardSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      thirdCardSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      thirdCardSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(thirdCardSuggestionBlockTouchEndX - thirdCardSuggestionBlockTouchStartX) <= 20 && Math.abs(thirdCardSuggestionBlockTouchStartY - thirdCardSuggestionBlockTouchEndY) <= 20) {

        cardInputId.value = scope.cardSuggestionThree.cardNumber;

        if (cardInputId.value.replace(/\s/g, '').length == 16) {
          cardOwnerFunction();
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
    }

    var fourthCardSuggestionBlockTouchStartX, fourthCardSuggestionBlockTouchStartY, fourthCardSuggestionBlockTouchEndX,
      fourthCardSuggestionBlockTouchEndY;

    fourthCardSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      fourthCardSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      fourthCardSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    fourthCardSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      fourthCardSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      fourthCardSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(fourthCardSuggestionBlockTouchEndX - fourthCardSuggestionBlockTouchStartX) <= 20 && Math.abs(fourthCardSuggestionBlockTouchStartY - fourthCardSuggestionBlockTouchEndY) <= 20) {

        cardInputId.value = scope.cardSuggestionFour.cardNumber;

        if (cardInputId.value.replace(/\s/g, '').length == 16) {
          cardOwnerFunction();
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
    }

    var fifthCardSuggestionBlockTouchStartX, fifthCardSuggestionBlockTouchStartY, fifthCardSuggestionBlockTouchEndX,
      fifthCardSuggestionBlockTouchEndY;

    fifthCardSuggestionBlockTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      fifthCardSuggestionBlockTouchStartX = event.changedTouches[0].pageX
      fifthCardSuggestionBlockTouchStartY = event.changedTouches[0].pageY
    }

    fifthCardSuggestionBlockTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      fifthCardSuggestionBlockTouchEndX = event.changedTouches[0].pageX
      fifthCardSuggestionBlockTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(fifthCardSuggestionBlockTouchEndX - fifthCardSuggestionBlockTouchStartX) <= 20 && Math.abs(fifthCardSuggestionBlockTouchStartY - fifthCardSuggestionBlockTouchEndY) <= 20) {

        cardInputId.value = scope.cardSuggestionFive.cardNumber;

        if (cardInputId.value.replace(/\s/g, '').length == 16) {
          cardOwnerFunction();
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
    }


  </script>
</view-transfer>

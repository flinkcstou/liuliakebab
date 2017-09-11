<view-transfer-stepfour class="riot-tags-main-container">
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
         class="transfer-back-button">

    </div>
    <div id="rightButton" type="button" class="{transfer-i-button: rightbuttoncheck}"></div>
  </div>

  <div class="transferfour-body-container">
    <div class="transferfour-data-container">
      <div class="transferfour-phone-field" if="{viewServicePage.formType!=2}">
        <p class="transferfour-text-field">{cardOrPhone}</p>
        <p class="transferfour-phone-input">{plus}{objectTypeForTransfer.name}</p>
      </div>

      <div id="ownerContainerId" class="transferfour-owner-container" if="{cardType}">
        <p class="transferfour-owner-field">{window.languages.ViewTransferFourOwner}</p>
        <p if={opts[0][0].owner} class="transferfour-owner-input">{opts[0][0].owner}</p>
      </div>

      <div class="transferfour-field-sum">
        <p class="transferfour-amount-field">{window.languages.ViewTransferFourAmountOfPay}</p>
        <p class="transferfour-amount-input">{maskSum} {objectCardForTransfer.currency}</p>
        <p class="transferfour-tax-field">{window.languages.ViewTransferFourTax} {tax}
          {objectCardForTransfer.currency}</p>
      </div>
      <div id="categoryContainerId" class="transferfour-category-container">
        <p class="transferfour-text-field">{window.languages.ViewTransferFourCategory}</p>
        <p class="transferfour-phone-input" style="text-decoration: underline"></p>
      </div>
      <div class="transferfour-card-field">
        <div class="transferfour-card-info-container">
          <p class="transferfour-text-one">{window.languages.ViewTransferFourTransferInformation}</p>
          <p class="transferfour-text-two">{objectCardForTransfer.name}</p>
          <p class="transferfour-detail-text">{objectCardForTransfer.numberPartOne} ****
            {objectCardForTransfer.numberPartTwo}</p>
          <p class="transferfour-detail-text">Доступно:{objectCardForTransfer.salary}
            {objectCardForTransfer.currency}</p>
        </div>
        <div class="transferfour-card-logo-container"
             style="background-image: url({objectCardForTransfer.url})">
        </div>
      </div>
    </div>

    <div class="transferfour-bottom-container">
      <div class="transferfour-action-containter">
        <div class="transferfour-action-icon-one"
             style="background-image: url('resources/icons/ViewService/addfavorite.png');"></div>
        <div class="transferfour-action-text">{window.languages.ViewTransferFourAddToFavouritePartOne}<br>{window.languages.ViewTransferFourAddToFavouritePartTwo}
        </div>
      </div>
    </div>

    <button id="transferButtonId" class="transferfour-button-enter" ontouchstart="transferStepTouchStart()"
            ontouchend="transferStepTouchEnd()">
      {window.languages.ViewTransferFourPay}
    </button>

  </div>

  <code-confirm id="blockCodeConfirmId" class="code-confirm">
    <div class="code-confirm-title-container">
      <p class="code-confirm-title-name">{window.languages.ComponentCodeConfirmTitle}</p>
      <div class="code-confirm-cancel-icon" ontouchend="closeSecretCodePage()"></div>
    </div>
    <div class="code-confirm-code-container">
      <input readonly value="{secretCode}" class="code-confirm-code-text"/>
      <p class="code-confirm-message-text">Передайте код получателю для завершения перевода</p>

      <button class="code-confirm-button-enter" ontouchend="closeSecretCodePage()">
        OK
      </button>
    </div>
  </code-confirm>
  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessage}"
                     viewpage="view-transfer" step_amount="{3}"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{errorMessageFromTransfer}"
  ></component-unsuccess>

  <component-in-processing id="componentInProcessingId"
                           operationmessagepartone="{window.languages.ComponentInProcessingPartOne}"
                           operationmessageparttwo="{window.languages.ComponentInProcessingPartTwo}"
                           step_amount="{3}"></component-in-processing>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>
    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-stepfour') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-stepfour',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = false;
    scope.showError = false;

    console.log("TRANSFER STEP FOUR OPTS", opts)
    scope.tax = opts[1];
    scope.errorMessageFromTransfer = '';

    scope.objectTypeForTransfer = opts[0][0];
    if (scope.objectTypeForTransfer.type == 1) {
      scope.cardType = true;
      scope.plus = '';
    }
    else {
      scope.phoneType = false;
      scope.plus = '+';
    }


    scope.objectSumForTransfer = opts[0][1];
    scope.objectComment = opts[0][2];
    scope.objectCardForTransfer = opts[0][3];

    scope.maskSum = window.amountTransform(scope.objectSumForTransfer.sum);

    var transferTitle;

    var objectForTransfer = opts[0][0];


    if (objectForTransfer.type == 1) {
      transferTitle = objectForTransfer.name.substring(0, 4) + ' **** ' + objectForTransfer.name.substring(15, objectForTransfer.name.length)
      scope.cardOrPhone = window.languages.ViewTransferFourEnterCard;
    }
    else {
      transferTitle = objectForTransfer.name;
      scope.cardOrPhone = window.languages.ViewTransferFourEnterPhone;
    }

    if (objectForTransfer.type == 2)
      this.titleName = window.languages.ViewTransferFourTitle + ' +' + transferTitle;
    else
      this.titleName = window.languages.ViewTransferFourTitle + ' ' + transferTitle;


    if (localStorage.getItem('settings_block_payAndTransfer'))
      var payTransferBlocked = JSON.parse(localStorage.getItem('settings_block_payAndTransfer'));

    console.log("CONFIRMED=", sessionStorage.getItem('payTransferConfirmed'))
    console.log("BLOCKED=", payTransferBlocked)

    if (payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) === true) {
      console.log("payTransferConfirmed=", sessionStorage.getItem('payTransferConfirmed'))
      transfer();
      sessionStorage.setItem('payTransferConfirmed', null);
    }

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

    findContacts = function (saveNumber) {
      var maskOne = /[0-9]/g;
      var searchNumber = saveNumber.substring(3, saveNumber.length);
      var transferContacts = JSON.parse(localStorage.getItem('transferContacts'));
      var searchedIndex = -1;
      var checkInBottomContacts = false;

      if (transferContacts)
        for (var i = 0; i < transferContacts.length; i++) {
          var phone = '';
          var digits = '';
          if (transferContacts[i].phoneNumbers != null)
            if (transferContacts[i].phoneNumbers[0] != null)
              if (transferContacts[i].phoneNumbers[0].value != null) {
                digits = transferContacts[i].phoneNumbers[0].value.match(maskOne)
                for (var k in digits) {
                  phone += digits[k]
                }
                searchedIndex = phone.indexOf(searchNumber);
                if (searchedIndex != -1) {
                  checkInBottomContacts = true;
//                  console.log('CHECK', transferContacts[i])
                  transferContacts.splice(i, 1);
//                  console.log('TRANSFER CONTACTS', transferContacts)
                  localStorage.setItem('transferContacts', JSON.stringify(transferContacts));
                  break;
                }
                else {
                  checkInBottomContacts = false;
                }
              }
        }

      transferContacts = JSON.parse(localStorage.getItem('transferContacts'));
//      console.log('searchNumber', searchNumber)

      var options = new ContactFindOptions();
      options.filter = '';
      options.multiple = true;
      var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
      navigator.contacts.find(fields, success, error, options);

      function success(contacts) {
        var searchedIndex = -1;
        for (var i = 0; i < contacts.length; i++) {
          var phone = '';
          var digits = '';
          if (contacts[i].phoneNumbers != null)
            if (contacts[i].phoneNumbers[0] != null)
              if (contacts[i].phoneNumbers[0].value != null) {
//                console.log('contacts[i].phoneNumbers[0].value', contacts[i].phoneNumbers[0].value)
                digits = contacts[i].phoneNumbers[0].value.match(maskOne)
                for (var k in digits) {
                  phone += digits[k]
                }
                searchedIndex = phone.indexOf(searchNumber);
                if (searchedIndex != -1) {
                  transferContacts.unshift(contacts[i]);
                  localStorage.setItem('transferContacts', JSON.stringify(transferContacts))
                  return;
                }
              }


        }
      }

      function error(message) {
        console.log('Failed because: ' + JSON.parse(message));
      }
    }

    transferFindCards = function (saveCard) {
      console.log('SAVE CARD', saveCard)

      var transferCards = [];
      var codeOfBank = saveCard.replace(/\s/g, '').substring(3, 6);
      var card = {};
      card.image = '';
      card.name = '';
      card.cardNumber = '';
      card.owner = {};
      if (opts[2])
        card.owner.firstName = opts[2];
      card.owner.secondName = '';
      var bankList = JSON.parse(localStorage.getItem('click_client_p2p_bank_list'))
//      console.log('CODE OF BANK', codeOfBank)
      if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
        transferCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
        for (var j = 0; j < transferCards.length; j++) {

          if (transferCards[j].cardNumber == saveCard) {
            transferCards.splice(j, 1);
            localStorage.setItem('p2pTransferCards', JSON.stringify(transferCards));
          }

        }
      }

      for (var i = 0; i < bankList.length; i++) {
        if (codeOfBank == bankList[i].code) {
          if (JSON.parse(localStorage.getItem('p2pTransferCards'))) {
            transferCards = JSON.parse(localStorage.getItem('p2pTransferCards'));
            card.image = bankList[i].image
            card.name = bankList[i].name
            card.cardNumber = saveCard;
            transferCards.unshift(card)

            localStorage.setItem('p2pTransferCards', JSON.stringify(transferCards));
          }
          else {
            card.image = bankList[i].image
            card.name = bankList[i].name
            card.cardNumber = saveCard;
            transferCards.unshift(card)
            localStorage.setItem('p2pTransferCards', JSON.stringify(transferCards));

          }

        }
      }

      viewTransfer.phoneNumber = 0
      viewTransfer.cardNumber = 0
      viewTransfer.cardNumber = 0
      viewTransferStepTwo.sum = 0;
      viewTransferStepTwo.sumWithoutSpace = 0;
    }

    var transferStepTouchStartX, transferStepTouchStartY, transferStepTouchEndX, transferStepTouchEndY;

    transferStepTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      transferButtonId.style.webkitTransform = 'scale(0.8)'

      transferStepTouchStartX = event.changedTouches[0].pageX
      transferStepTouchStartY = event.changedTouches[0].pageY
    }

    transferStepTouchEnd = function () {

      transferButtonId.style.webkitTransform = 'scale(1)'

      transferStepTouchEndX = event.changedTouches[0].pageX
      transferStepTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(transferStepTouchStartX - transferStepTouchEndX) <= 20 && Math.abs(transferStepTouchStartY - transferStepTouchEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;

//        confirm(question)
//        scope.confirmShowBool = true;
//        scope.confirmNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//          else{
//            scope.confirmShowBool = false;
//            return
//          }
//        };
          scope.update();

          return
        }

        if (payTransferBlocked && JSON.parse(sessionStorage.getItem('payTransferConfirmed')) != true) {
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-transfer-stepfour']);
          return
        }

        transfer();


      }
    }

    transfer = function () {

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      if (!objectForTransfer.transactionId)
        objectForTransfer.transactionId = parseInt(Date.now() / 1000);

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      var answerFromServer = false;

      console.log("TRANSACTION_ID", objectForTransfer.transactionId)

      window.api.call({
        method: 'p2p.payment',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          account_id: scope.objectCardForTransfer.card_id,
          receiver_data: scope.objectTypeForTransfer.name.replace(/\s/g, ''),
          amount: parseInt(scope.objectSumForTransfer.sum),
          type: scope.objectTypeForTransfer.type,
          transaction_id: objectForTransfer.transactionId
//                                card_number: cardNumberForTransfer.replace(/\s/g, ''),

        },

        scope: this,

        onSuccess: function (result) {
          answerFromServer = true;
          if (result[0][0].error == 0) {
            viewTransferStepTwo.sum = 0;
            viewTransferStepTwo.sumWithoutSpace = 0;
            console.log("result of TRANSFER ", result);
            if (result[1])
              if (result[1][0]) {
                if (result[1][0].secret_code && scope.objectTypeForTransfer.type == 2) {

                  if (device.platform != 'BrowserStand') {
                    SpinnerPlugin.activityStop();
                  }

                  blockCodeConfirmId.style.display = 'block';
                  this.secretCode = result[1][0].secret_code;
                  viewTransfer.phoneNumber = 0
                  viewTransfer.cardNumber = 0
                  viewTransfer.cardNumber = 0
                  viewTransferStepTwo.sum = 0;
                  viewTransferStepTwo.sumWithoutSpace = 0;
                  window.updateBalanceGlobalFunction();

                  scope.update();

                }
                if (result[1][0].secret_code == 0) {

//                  if (device.platform != 'BrowserStand') {
//                    var options = {dimBackground: true};
//
//                    SpinnerPlugin.activityStart(languages.Downloading, options, function () {
//                      console.log("Started");
//                    }, function () {
//                      console.log("closed");
//                    });
//                  }

                  setTimeout(function () {
                    checkTransferStatus(result[1][0].payment_id);
                  }, 2000);

                }
              }

          }
          else {
            scope.errorMessageFromTransfer = result[0][0].error_note
            componentUnsuccessId.style.display = 'block';
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      setTimeout(function () {
        if (!answerFromServer) {
          if (device.platform != 'BrowserStand') {
            SpinnerPlugin.activityStop();
          }
          return
        }
      }, 20000)

    }

    var counter = 0;
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    function checkTransferStatus(payment_id) {

      console.log("check transfer status");

      window.api.call({
        method: 'get.payment',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          payment_id: payment_id
        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0 && result[1][0]) {


            if (result[1][0].state == -1) {

              window.languages.tempText = JSON.stringify(result[1][0].error);
              scope.errorMessageFromTransfer = result[1][0].error;
              if (device.platform != 'BrowserStand') {
                SpinnerPlugin.activityStop();
              }
              componentUnsuccessId.style.display = 'block';
              riot.update()


            } else if (result[1][0].state == 2) {

              if (device.platform != 'BrowserStand') {
                SpinnerPlugin.activityStop();
              }

              window.updateBalanceGlobalFunction();
              componentSuccessId.style.display = 'block';
              transferFindCards(scope.objectTypeForTransfer.name);


            } else if (result[1][0].state == 1) {

              counter++;

              if (counter < 5) {

                setTimeout(function () {
                  checkTransferStatus(result[1][0].payment_id);
                }, 2000);

              } else {

                if (device.platform != 'BrowserStand') {
                  SpinnerPlugin.activityStop();
                }

                componentInProcessingId.style.display = 'block';
              }

            }
            window.api.spinnerOn = false;

          }
          else {
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            componentUnsuccessId.style.display = 'block';
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    closeSecretCodePage = function () {
      blockCodeConfirmId.style.display = 'none';
      componentInProcessingId.style.display = 'block';
    }
  </script>
</view-transfer-stepfour>

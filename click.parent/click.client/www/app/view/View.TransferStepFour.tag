<view-transfer-stepfour>
  <div class="transfer-page-title">
    <p class="transfer-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()"
         class="{transfer-back-button: backbuttoncheck}">

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
        <p class="transferfour-owner-input"></p>
      </div>

      <div class="transferfour-field-sum">
        <p class="transferfour-amount-field">{window.languages.ViewTransferFourAmountOfPay}</p>
        <p class="transferfour-amount-input">{maskSum} {objectCardForTransfer.currency}</p>
        <p class="transferfour-tax-field">{window.languages.ViewTransferFourTax}</p>
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
      <div class="transferfour-button-enter" ontouchend="transferStep()">
        <p class="transferfour-button-enter-label">{window.languages.ViewTransferFourPay}</p>
      </div>
    </div>
  </div>

  <code-confirm id="blockCodeConfirmId" class="code-confirm">
    <div class="code-confirm-title-container">
      <p class="code-confirm-title-name">{window.languages.ComponentCodeConfirmTitle}</p>
      <div class="code-confirm-cancel-icon" ontouchend="closeSecretCodePage()"></div>
    </div>
    <div class="code-confirm-code-container">
      <p class="code-confirm-code-text">{secretCode}</p>
      <p class="code-confirm-message-text">Передайте код получателю для завершения перевода</p>

      <div class="code-confirm-button-enter" ontouchend="closeSecretCodePage()">
        <p class="code-confirm-button-enter-label">OK</p>
      </div>
    </div>
  </code-confirm>
  <component-success id="componentSuccessId"
                     operationmessage="{window.languages.ComponentSuccessMessage}"
                     viewpage="view-transfer"></component-success>
  <component-unsuccess id="componentUnsuccessId"
                       operationmessagepartone="{window.languages.ComponentUnsuccessMessagePart1}"
                       operationmessageparttwo="{window.languages.ComponentUnsuccessMessagePart2}"
                       operationmessagepartthree="{window.languages.ComponentUnsuccessMessagePart3}"></component-unsuccess>

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

    if (scope.objectSumForTransfer.sum.length == 8) {
      scope.maskSum = scope.objectSumForTransfer.sum.substring(0, 2) + ' ' +
        scope.objectSumForTransfer.sum.substring(2, 5) + ' ' + scope.objectSumForTransfer.sum.substring(5, scope.objectSumForTransfer.sum.length)
    }

    if (scope.objectSumForTransfer.sum.length == 7) {
      scope.maskSum = scope.objectSumForTransfer.sum.substring(0, 1) + ' ' +
        scope.objectSumForTransfer.sum.substring(1, 4) + ' ' + scope.objectSumForTransfer.sum.substring(4, scope.objectSumForTransfer.sum.length)
    }

    if (scope.objectSumForTransfer.sum.length == 6) {
      scope.maskSum = scope.objectSumForTransfer.sum.substring(0, 3) + ' ' + scope.objectSumForTransfer.sum.substring(3, scope.objectSumForTransfer.sum.length)
    }

    if (scope.objectSumForTransfer.sum.length == 5) {
      scope.maskSum = scope.objectSumForTransfer.sum.substring(0, 2) + ' ' + scope.objectSumForTransfer.sum.substring(2, scope.objectSumForTransfer.sum.length)
    }

    if (scope.objectSumForTransfer.sum.length == 4) {
      scope.maskSum = scope.objectSumForTransfer.sum.substring(0, 1) + ' ' + scope.objectSumForTransfer.sum.substring(1, scope.objectSumForTransfer.sum.length)
    }





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
                  console.log('CHECK', transferContacts[i])
                  transferContacts.splice(i, 1);
                  console.log('TRANSFER CONTACTS', transferContacts)
                  localStorage.setItem('transferContacts', JSON.stringify(transferContacts));
                  break;
                }
                else {
                  checkInBottomContacts = false;
                }
              }
        }

      transferContacts = JSON.parse(localStorage.getItem('transferContacts'));
      console.log('searchNumber', searchNumber)

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
                console.log('contacts[i].phoneNumbers[0].value', contacts[i].phoneNumbers[0].value)
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

    findCards = function (saveCard) {

      var transferCards = [];
      var codeOfBank = saveCard.replace(/\s/g, '').substring(3, 6);
      var card = {};
      card.image = '';
      card.name = '';
      card.cardNumber = '';
      card.owner = {};
      card.owner.firstName = '';
      card.owner.secondName = '';
      var bankList = JSON.parse(localStorage.getItem('click_client_p2p_bank_list'))
      console.log('CODE OF BANK', codeOfBank)
      if (JSON.parse(localStorage.getItem('transferCards'))) {
        transferCards = JSON.parse(localStorage.getItem('transferCards'));
        for (var j = 0; j < transferCards.length; j++) {

          if (transferCards[j].cardNumber == saveCard) {
            transferCards.splice(j, 1);
            localStorage.setItem('transferCards', JSON.stringify(transferCards));
          }

        }
      }

      for (var i = 0; i < bankList.length; i++) {
        if (codeOfBank == bankList[i].code) {
          if (JSON.parse(localStorage.getItem('transferCards'))) {
            transferCards = JSON.parse(localStorage.getItem('transferCards'));
            card.image = bankList[i].image
            card.name = bankList[i].name
            card.cardNumber = saveCard;
            transferCards.unshift(card)

            localStorage.setItem('transferCards', JSON.stringify(transferCards));
          }
          else {
            card.image = bankList[i].image
            card.name = bankList[i].name
            card.cardNumber = saveCard;
            transferCards.unshift(card)
            localStorage.setItem('transferCards', JSON.stringify(transferCards));

          }

        }
      }

    }

    transferStep = function () {

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');

      if (!modeOfflineMode.check) {
        window.api.call({
          method: 'p2p.payment',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: scope.objectCardForTransfer.card_id,
            receiver_data: scope.objectTypeForTransfer.name.replace(/\s/g, ''),
            amount: parseInt(scope.objectSumForTransfer.sum),
            type: scope.objectTypeForTransfer.type,
            transaction_id: parseInt(Date.now() / 1000)
//                                card_number: cardNumberForTransfer.replace(/\s/g, ''),

          },

          scope: this,

          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              console.log("result of TRANSFER ", result);
              if (result[1])
                if (result[1][0]) {
                  if (result[1][0].secret_code && scope.objectTypeForTransfer.type == 2) {
                    blockCodeConfirmId.style.display = 'block';
                    scope.secretCode = result[1][0].secret_code;
                    riot.update(scope.secretCode);

                    findContacts(scope.objectTypeForTransfer.name.replace(/\s/g, ''));
                  }
                  if (result[1][0].secret_code == 0) {
                    componentSuccessId.style.display = 'block';
                    findCards(scope.objectTypeForTransfer.name);
                  }
                }
            }
            else {
              componentUnsuccessId.style.display = 'block';
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
      else {

        if (scope.objectTypeForTransfer.type == 2) {
          phonedialer.dial(
            "*880*3*" + scope.objectTypeForTransfer.name.replace(/\s/g, '') + "*" + parseInt(scope.objectSumForTransfer.sum) + "%23",
            function (err) {
              if (err == "empty") alert("Unknown phone number");
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
        }
        else {
          phonedialer.dial(
            "*880*" + scope.objectTypeForTransfer.name.replace(/\s/g, '') + "*" + parseInt(scope.objectSumForTransfer.sum) + "%23",
            function (err) {
              if (err == "empty") alert("Unknown phone number");
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
        }
      }
    }

    closeSecretCodePage = function () {
      blockCodeConfirmId.style.display = 'none';
      componentSuccessId.style.display = 'block';
    }
  </script>
</view-transfer-stepfour>

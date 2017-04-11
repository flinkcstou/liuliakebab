<view-my-cards class="view-my-cards">
  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="backButton" ontouchend="touchStartTitle()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{settings-button: rightbuttoncheck}" ontouchend="editCard()"></div>
  </div>

  <div class="my-cards-carousel">
    <component-card-carousel>
    </component-card-carousel>
  </div>

  <div class="my-cards-button-container">
    <div class="my-cards-button-field my-cards-button-field-transfer" ontouchend="goToTransferView()">
      <div class="my-cards-button-icon my-cards-button-icon-transfer">
      </div>

      <div class="my-cards-button-label">{window.languages.ViewMyCardTransfer}
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-payment">
      <div class="my-cards-button-icon my-cards-button-icon-payment">
      </div>

      <div class="my-cards-button-label" ontouchend="goToPayView()">{window.languages.ViewMyCardPay}
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-report">
      <div class="my-cards-button-icon my-cards-button-icon-report">
      </div>

      <div class="my-cards-button-label" style="border: none;" ontouchend="goToReports()">
        {window.languages.ViewMyCardReports}
      </div>
    </div>
  </div>

  <div class="my-cards-button-block-card" ontouchend="confirmToDeleteCardTouchEnd()">
    <div class="my-cards-button-icon my-cards-button-icon-block"></div>
    <div class="my-cards-button-block-card-label">{window.languages.ViewMyCardBlock}</div>
  </div>

  <div class="my-cards-last-operations">
    <div class="my-cards-last-operations-container-label">
      <p class="my-cards-last-operations-label">{window.languages.ViewMyCardLastOperations}</p>

      <div id="lastOperationContainerId" class="my-cards-last-operations-container">
        <div class="my-cards-last-operations-info" each="{i in arrayOfOperationsByAccount}"
             style="top: {i.count*top}px">
          <div class="my-cards-operation-amount">- {i.amount}</div>
          <div class="my-cards-operation-currency">{i.lang_amount_currency}</div>
          <div class="my-cards-firm-name">{i.service_name}</div>
          <div class="my-cards-operation-date">{i.created}</div>
        </div>
      </div>

    </div>


  </div>

  <component-delete-card id="deleteCardComponentId"></component-delete-card>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    viewMainPage.atMainPage = false;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-my-cards') {
      history.arrayOfHistory.push(
          {
            "view": 'view-my-cards',
            "params": opts
          }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    this.on('mount', function () {
      scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
      riot.update();
    })

    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    }

    editCard = function () {
//      console.log("card for edit=", scope.card);
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-card-edit>";
      riot.mount('view-card-edit', [scope.card]);
    };

    goToReports = function () {

      event.preventDefault();
      event.stopPropagation();

      var cardNumber = localStorage.getItem("cardNumber"),
          cards = scope.tags["component-card-carousel"].cardsarray;
      cardNumber = JSON.parse(cardNumber);

//      console.log("ASDASDASDASDASD", cards);

      for (card in cards) {

//        console.log("ASDASDASDASDASD", card, cards[card], cards[card].countCard, cardNumber);

        if (cards[card].countCard == cardNumber) {

          riotTags.innerHTML = "<view-report>";
          riot.mount('view-report', {
            show_graph: true,
            account_id: card
          });
        }
      }
    };

    confirmToDeleteCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      deleteCardComponentId.style.display = 'block'

      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var account_id = scope.card.card_id;
      var removable = scope.card.removable;

      if (removable == 1)
        componentDeleteCard.getInformation(sessionKey, phoneNumber, account_id);
      else {
        scope.clickPinError = false;
        scope.errorNote = 'You cant delete this card';
        scope.showError = true;
        riot.update();
      }
    }

    //    updateCard = function () {
    //
    //      var arrayAccountInfo = [];
    //      localStorage.removeItem('click_client_accountInfo')
    //      localStorage.removeItem('click_client_cards')
    //      localStorage.removeItem('cardNumber')
    //      localStorage.removeItem('click_client_countCard')
    //
    //      console.log('ACCOUNT INFO', JSON.parse(localStorage.getItem('click_client_accountInfo')))
    //      console.log('ACCOUNT INFO')
    //
    //      if (!localStorage.getItem("click_client_accountInfo")) {
    //        window.api.call({
    //          method: 'get.accounts',
    //          input: {
    //            session_key: sessionKey,
    //            phone_num: phoneNumber
    //          },
    //
    //          scope: this,
    //
    //          onSuccess: function (result) {
    //
    //            if (result[0][0].error == 0) {
    //
    //              if (device.platform != 'BrowserStand') {
    //                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
    //                  var j = -1;
    //                  for (var i = 0; i < result[1].length; i++) {
    //
    //                    j++;
    //                    arrayAccountInfo.push(result[1][i]);
    //
    //                    var icon = result[1][i].card_background_url;
    //                    console.log();
    //                    var filename = icon.substr(icon.lastIndexOf('/') + 1);
    //                    console.log("filename=" + filename);
    //
    //                    var newIconBool = checkImageURL;
    //                    newIconBool('www/resources/icons/cards/', 'cards', filename, icon, j, function (bool, index, fileName) {
    //
    //                      if (bool) {
    //                        arrayAccountInfo[index].card_background_url = cordova.file.dataDirectory + 'cards' + fileName;
    //                      } else {
    //                        arrayAccountInfo[index].card_background_url = cordova.file.applicationDirectory + 'www/resources/icons/cards/' + fileName;
    //                      }
    //
    //                      var icon2 = arrayAccountInfo[index].image_url;
    //                      var filename2 = icon2.substr(icon2.lastIndexOf('/') + 1);
    //                      var newIcon = checkImageURL;
    //                      newIcon('www/resources/icons/cards/logo/', 'logo', filename2, icon2, index, function (bool2, index2, fileName2) {
    //
    //                        if (bool2) {
    //                          arrayAccountInfo[index2].image_url = cordova.file.dataDirectory + 'cards' + fileName2;
    //                        } else {
    //                          arrayAccountInfo[index2].image_url = cordova.file.applicationDirectory + 'www/resources/icons/cards/logo/' + fileName2;
    //                        }
    //
    //                        if (result[1].length == arrayAccountInfo.length) {
    //                          console.log("save into localstorage");
    //                          var accountInfo = JSON.stringify(arrayAccountInfo);
    //                          localStorage.setItem("click_client_accountInfo", accountInfo);
    //                          this.riotTags.innerHTML = "<view-my-cards>";
    //                          riot.mount('view-my-cards');
    //                        }
    //                      });
    //
    //                    });
    //
    //                  }
    //                }, onErrorLoadFs);
    //              } else {
    //                for (var i = 0; i < result[1].length; i++)
    //                  arrayAccountInfo.push(result[1][i])
    //                var accountInfo = JSON.stringify(arrayAccountInfo);
    //                localStorage.setItem("click_client_accountInfo", accountInfo);
    //                this.riotTags.innerHTML = "<view-my-cards>";
    //                riot.mount('view-my-cards');
    //              }
    //            }
    //            else
    //              alert(result[0][0].error_note);
    //          },
    //
    //
    //          onFail: function (api_status, api_status_message, data) {
    //            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //            console.error(data);
    //          }
    //        })
    //      }
    //
    //
    //    }
    var scope = this,
        sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key,
        phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.showError = false;

    if (opts[0]) {
      scope.cardId = opts[0];
//      console.log('scope.cardId', scope.cardId)
    }

    scope.top = 160 * widthK;
    viewMyCards.check = true;
    viewMainPage.myCards = true;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));


    this.titleName = window.languages.ViewMyCardTitleName;

    if (scope.cardId) {
      scope.card = scope.cardsArray[scope.cardId];
    }
    //    console.log('scope.cardId', scope.cardId)
    //    console.log('scope.cardsArray', scope.cardsArray)


    scope.arrayOfOperationsByAccount = [];

    scope.cardInformation = cardInformation = function (cardIdFromCarousel) {

      history.arrayOfHistory[history.arrayOfHistory.length - 1].params[0] = cardIdFromCarousel;
      history.arrayOfHistory[history.arrayOfHistory.length - 1].view = 'view-my-cards';
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      if (cardIdFromCarousel) {
        scope.card = scope.cardsArray[cardIdFromCarousel];
      }

      console.log("You clicked on card - ", cardIdFromCarousel);

      scope.arrayOfOperationsByAccount = [];
      riot.update()
//      console.log(scope.card)

      if (scope.card)
        window.api.call({
          method: 'get.payments.by.account',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: scope.card.card_id
          },

          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              if (result[1][0]) {
                var j = 0;
                for (var i in result[1]) {
                  if (result[1][i].account_id == scope.card.card_id && result[1][i].state == 0) {
                    result[1][i].count = j;
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());

                    j++;
                    scope.arrayOfOperationsByAccount.push(result[1][i]);
                  }
                }
//                this.lastOperationContainerId.style.height = j * 160 * widthK + 'px';
                riot.update(scope.arrayOfOperationsByAccount);
                console.log('scope.arrayOfOperationsByAccount', scope.arrayOfOperationsByAccount)
              }
            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;
              scope.showError = true;
              riot.update();
            }

          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
    }

    scope.cardInformation(scope.cardId);

    goToPayView = function () {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].card_id == scope.card.card_id) {
          scope.cardsArray[i].chosenCard = true;
        }
        else
          scope.cardsArray[i].chosenCard = false;
      }
      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

      event.preventDefault();
      event.stopPropagation();


      if (scope.card.access == 2) {
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay');
      }
      else {
        scope.clickPinError = false;
        scope.errorNote = 'Извининте, вы не можете произвести оплату с этой карты';
        scope.showError = true;
        riot.update();
      }
    }

    goToTransferView = function () {
      for (var i in scope.cardsArray) {
        if (scope.cardsArray[i].card_id == scope.card.card_id && scope.cardsArray[i].access == 2) {
          scope.cardsArray[i].chosenCard = true;
        }
        else
          scope.cardsArray[i].chosenCard = false;
      }
      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

      event.preventDefault();
      event.stopPropagation();

//      console.log(scope.card)
      if (scope.card.access == 2) {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer');
      }
      else {
        scope.clickPinError = false;
        scope.errorNote = 'Извининте, вы не можете произвести перевод с этой карты';
        scope.showError = true;
        riot.update();
      }
    }

  </script>
</view-my-cards>
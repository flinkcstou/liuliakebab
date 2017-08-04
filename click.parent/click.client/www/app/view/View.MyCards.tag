<view-my-cards class="view-my-cards riot-tags-main-container">
  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
         class="{back-button: backbuttoncheck}">
    </div>
    <div id="rightButton" type="button" class="{settings-button: rightbuttoncheck}" ontouchstart="editCardStart()"
         ontouchend="editCardEnd()"></div>
  </div>

  <div class="my-cards-carousel">
    <component-card-carousel>
    </component-card-carousel>
  </div>

  <div class="my-cards-button-container">
    <div id="transferButtonId" class="my-cards-button-field my-cards-button-field-transfer"
         ontouchstart="transferOnTouchStart()"
         ontouchend="goToTransferView()">
      <div class="my-cards-button-icon my-cards-button-icon-transfer">
      </div>

      <div class="my-cards-button-label">{window.languages.ViewMyCardTransfer}
      </div>
    </div>

    <div id="payButtonId" class="my-cards-button-field my-cards-button-field-payment" ontouchstart="payOnTouchStart()"
         ontouchend="goToPayView()">
      <div class="my-cards-button-icon my-cards-button-icon-payment">
      </div>

      <div class="my-cards-button-label">
        {window.languages.ViewMyCardPay}
      </div>
    </div>

    <div id="reportButtonId" class="my-cards-button-field my-cards-button-field-report"
         ontouchstart="reportsOnTouchStart()"
         ontouchend="goToReports()">
      <div class="my-cards-button-icon my-cards-button-icon-report">
      </div>

      <div class="my-cards-button-label" style="border: none;">
        {window.languages.ViewMyCardReports}
      </div>
    </div>
  </div>

  <div class="my-cards-button-block-card" ontouchstart="deleteOnTouchStart()"
       ontouchend="confirmToDeleteCardTouchEnd()">
    <div class="my-cards-button-icon my-cards-button-icon-block"></div>
    <div class="my-cards-button-block-card-label">{window.languages.ViewMyCardBlock}</div>
  </div>

  <div id="lastOperationMainContainerId" class="my-cards-last-operations">
    <div class="my-cards-last-operations-container-label" ontouchstart="lastOperationsTouchStart()"
         ontouchend="lastOperationsTouchEnd()">
      <div id="myCardLastOperationContainerIconId" class="my-cards-last-operations-container-icon"></div>
      <p class="my-cards-last-operations-label">{window.languages.ViewMyCardLastOperations}</p>
    </div>

    <div id="lastOperationContainerId" class="my-cards-last-operations-container">
      <div class="my-cards-last-operations-inner-container" each="{j in lastOperationsDates}">
        <div class="my-cards-last-operations-date">
          <p class="my-cards-last-operation-info-date-name">{j}</p>
        </div>
        <div class="my-cards-last-operations-info" each="{i in lastOperationsMap[j]}">
          <div class="my-cards-operation-amount">- {i.amount}</div>
          <div class="my-cards-operation-currency">{i.lang_amount_currency}</div>
          <div class="my-cards-firm-name">{i.service_name}</div>
          <div class="my-cards-operation-date">{i.created}</div>
          <p class="my-cards-last-operation-info-time">{i.paymentTime}</p>
          <div class="my-cards-last-operations-info-state-image" style="background-image: url({i.state_image})"></div>
        </div>
      </div>
    </div>


  </div>

  <component-delete-card id="deleteCardComponentId"></component-delete-card>

  <component-alert if="{showError}" carddelete="{cardDelete}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>

    var scope = this;
    scope.cardDelete = false;
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
      console.log('scope.parent', scope)


//      scope.update(scope.tags['component-card-carousel']);
      riot.update()
    });

    var lastOperationButtonStartX, lastOperationButtonEndX, lastOperationButtonStartY, lastOperationButtonEndY;
    var lastOperationTimeStart, lastOperationTimeEnd
    var lastOperationCheck = false;
    lastOperationsTouchStart = function () {
      lastOperationButtonStartX = event.changedTouches[0].pageX;
      lastOperationButtonStartY = event.changedTouches[0].pageY;
      lastOperationTimeStart = event.timeStamp.toFixed(0);
    }

    lastOperationsTouchEnd = function () {
      console.log('scope', scope)

      lastOperationButtonEndX = event.changedTouches[0].pageX;
      lastOperationButtonEndY = event.changedTouches[0].pageY;
      lastOperationTimeEnd = event.timeStamp.toFixed(0);

      if (Math.abs(lastOperationButtonStartX - lastOperationButtonEndX) <= 100 && lastOperationButtonStartY > lastOperationButtonEndY && !lastOperationCheck) {

        lastOperationMainContainerId.style.webkitTransform = "translate3d(0,0,0)"
//          lastOperationMainContainerId.top = "0"
        lastOperationContainerId.style.height = 1155 * widthK + "px";
        document.getElementById('containerCard').style.webkitTransform = "scale(0.2)"
        document.getElementById('myCardLastOperationContainerIconId').style.webkitTransform = "rotate(180deg)"
        lastOperationCheck = true;

      }
      else {
        if (Math.abs(lastOperationButtonStartX - lastOperationButtonEndX) <= 100 && lastOperationButtonStartY < lastOperationButtonEndY && lastOperationCheck) {
          lastOperationMainContainerId.style.webkitTransform = "translate3d(0," + 835 * widthK + "px,0)"
//          lastOperationMainContainerId.top = "0"
          lastOperationContainerId.style.height = 325 * widthK + "px";
          document.getElementById('containerCard').style.webkitTransform = "scale(1)"
          document.getElementById('myCardLastOperationContainerIconId').style.webkitTransform = "rotate(0)"
          lastOperationCheck = false;
        }
      }
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

    var editButtonStartX, editButtonEndX, editButtonStartY, editButtonEndY;

    editCardStart = function () {
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(0.7)'

      editButtonStartX = event.changedTouches[0].pageX;
      editButtonStartY = event.changedTouches[0].pageY;

    }

    editCardEnd = function () {
//      console.log("card for edit=", scope.card);
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(1)'

      editButtonEndX = event.changedTouches[0].pageX;
      editButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(editButtonStartX - editButtonEndX) <= 20 && Math.abs(editButtonStartY - editButtonEndY) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
          scope.showError = true;
          scope.errorNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//          else {
//            scope.confirmShowBool = false;
//            return
//          }
//        };
          scope.update();

          return
        }

        riotTags.innerHTML = "<view-card-edit>";
        riot.mount('view-card-edit', [scope.card]);

        scope.unmount()
      }
    };

    reportsOnTouchStart = function () {
      event.stopPropagation();

      reportButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      myCardsOnTouchStartY = event.changedTouches[0].pageY;
      myCardsOnTouchStartX = event.changedTouches[0].pageX;
    }

    goToReports = function () {
      event.stopPropagation();

      reportButtonId.style.backgroundColor = ''

      myCardsOnTouchEndY = event.changedTouches[0].pageY;
      myCardsOnTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if (Math.abs(myCardsOnTouchStartY - myCardsOnTouchEndY) <= 20 && Math.abs(myCardsOnTouchStartX - myCardsOnTouchEndX) <= 20) {

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
              account_id: card,
              card_name: cards[card].name
            });
            scope.unmount()
          }
        }
      }
    };

    deleteOnTouchStart = function () {
      event.stopPropagation();
      myCardsOnTouchStartY = event.changedTouches[0].pageY;
      myCardsOnTouchStartX = event.changedTouches[0].pageX;
    }

    confirmToDeleteCardTouchEnd = function () {
      event.stopPropagation();

      myCardsOnTouchEndY = event.changedTouches[0].pageY;
      myCardsOnTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if (Math.abs(myCardsOnTouchStartY - myCardsOnTouchEndY) <= 20 && Math.abs(myCardsOnTouchStartX - myCardsOnTouchEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
          scope.confirmShowBool = true;
          scope.confirmNote = question;
          scope.confirmType = 'local';
          scope.result = function (bool) {
            if (bool) {
              localStorage.clear();
              window.location = 'index.html'
              scope.unmount()
              return
            }
            else {
              scope.confirmShowBool = false;
              return
            }
          };
          scope.update();

          return
        }

        deleteCardComponentId.style.display = 'block'

        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        var account_id = scope.card.card_id;
        var removable = scope.card.removable;

        if (removable == 1)
          componentDeleteCard.getInformation(sessionKey, phoneNumber, account_id);
        else {
          scope.clickPinError = false;
          scope.errorNote = 'Вы не можете удалить эту карту!';
          scope.showError = true;
          scope.update();
        }
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
    //                        arrayAccountInfo[index].card_background_url = 'resources/icons/cards/' + fileName;
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
    //                          arrayAccountInfo[index2].image_url = url('resources/icons/cards/logo/' + fileName2);
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
      phoneNumber = localStorage.getItem('click_client_phoneNumber'),
      myCardsOnTouchStartY, myCardsOnTouchStartX, myCardsOnTouchEndY, myCardsOnTouchEndX;

    scope.showError = false;
    console.log("MY CARDS VIEW, OPTS=", opts);

    if (opts[0]) {
      scope.cardId = opts[0];
      console.log('scope.cardId', scope.cardId)
    }

    scope.top = 200 * widthK;
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
    scope.lastOperationsDates = [];
    scope.lastOperationsMap = {};

    scope.cardInformation = cardInformation = function (cardIdFromCarousel) {

      history.arrayOfHistory[history.arrayOfHistory.length - 1].params[0] = cardIdFromCarousel;
      history.arrayOfHistory[history.arrayOfHistory.length - 1].view = 'view-my-cards';
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

      if (cardIdFromCarousel) {
        scope.card = scope.cardsArray[cardIdFromCarousel];
      }

      console.log("You clicked on card - ", cardIdFromCarousel);
      console.log("You clicked scope.cardsArray - ", scope.cardsArray);
      console.log("You clicked on scope.card - ", scope.card);

      scope.arrayOfOperationsByAccount = [];
      scope.lastOperationsDates = [];
      scope.lastOperationsMap = {};
      scope.update()
      console.log("Scope.Card=", scope.card)

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
                  if (result[1][i].account_id == scope.card.card_id) {
                    result[1][i].count = j;
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                    if (result[1][i].created)
                      if (result[1][i].created.split(" ")[1])
                        if (result[1][i].created.split(" ")[1].substr(0, 5))
                          result[1][i].paymentTime = result[1][i].created.split(" ")[1].substr(0, 5);

                    var date = new Date(result[1][i].created_timestamp * 1000);

                    var dateStr = date.getUTCDate() + ' ' + window.languages.ViewReportMonthsArrayTwo[date.getUTCMonth()] + ' ' + date.getUTCFullYear();

                    if (date.getUTCDate() == new Date().getUTCDate() && date.getUTCMonth() == new Date().getUTCMonth() && date.getUTCFullYear() == new Date().getUTCFullYear())
                      dateStr = 'сегодня'

                    if (date.getUTCDate() == new Date().getUTCDate() - 1 && date.getUTCMonth() == new Date().getUTCMonth() && date.getUTCFullYear() == new Date().getUTCFullYear())
                      dateStr = 'вчера'

                    if (result[1][i].state == -1) {
                      result[1][i].state_image = "resources/icons/ViewReport/report_status_error.png"
                    }

                    if (result[1][i].state == 2) {
                      result[1][i].state_image = "resources/icons/ViewReport/report_status_ok.png"
                    }

                    if (result[1][i].state == 1) {
                      result[1][i].state_image = "resources/icons/ViewReport/report_status_processing.png"
                    }

                    result[1][i].show_date = dateStr

                    console.log("DATE DATE", dateStr)
                    if (!scope.lastOperationsMap[dateStr]) {
                      scope.lastOperationsMap[dateStr] = [];
                      scope.lastOperationsDates.push(dateStr);
                      scope.lastOperationsMap[dateStr].push(result[1][i]);
                    }
                    else {
                      scope.lastOperationsMap[dateStr].push(result[1][i]);
                    }

                    j++;
                    scope.arrayOfOperationsByAccount.push(result[1][i]);
                  }
                }
//                this.lastOperationContainerId.style.height = j * 160 * widthK + 'px';
                scope.update();
                console.log('scope.arrayOfOperationsByAccount', scope.arrayOfOperationsByAccount)
                console.log('scope.lastOperationsDates', scope.lastOperationsDates)
                console.log('scope.lastOperationsMap', scope.lastOperationsMap)
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

    scope.cardInformation(scope.cardId);

    payOnTouchStart = function () {
      event.stopPropagation();

      payButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      myCardsOnTouchStartY = event.changedTouches[0].pageY;
      myCardsOnTouchStartX = event.changedTouches[0].pageX;
    }

    goToPayView = function () {
      event.stopPropagation();

      payButtonId.style.backgroundColor = 'transparent'

      myCardsOnTouchEndY = event.changedTouches[0].pageY;
      myCardsOnTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if (Math.abs(myCardsOnTouchStartY - myCardsOnTouchEndY) <= 20 && Math.abs(myCardsOnTouchStartX - myCardsOnTouchEndX) <= 20) {
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

          scope.unmount()
        }
        else {
          scope.clickPinError = false;
          scope.errorNote = 'Извининте, вы не можете произвести оплату с этой карты';
          scope.showError = true;
          scope.update();
        }
      }
    }

    transferOnTouchStart = function () {
      event.stopPropagation();

      transferButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      myCardsOnTouchStartY = event.changedTouches[0].pageY;
      myCardsOnTouchStartX = event.changedTouches[0].pageX;
    }

    goToTransferView = function () {
      event.stopPropagation();

      transferButtonId.style.backgroundColor = 'transparent'

      myCardsOnTouchEndY = event.changedTouches[0].pageY;
      myCardsOnTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if (Math.abs(myCardsOnTouchStartY - myCardsOnTouchEndY) <= 20 && Math.abs(myCardsOnTouchStartX - myCardsOnTouchEndX) <= 20) {

        for (var i in scope.cardsArray) {
//          console.log('scope.cardsArray[i].card_id', scope.cardsArray[i].card_id, 'scope.cardsArray[i].access', scope.cardsArray[i].access)
          if (scope.cardsArray[i].card_id == scope.card.card_id && scope.cardsArray[i].access == 2) {
            scope.cardsArray[i].chosenCard = true;
          }
          else
            scope.cardsArray[i].chosenCard = false;
        }
        localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

        event.preventDefault();
        event.stopPropagation();

        console.log('CARD CHOSEN ', JSON.parse(localStorage.getItem('click_client_cards')))
        if (scope.card.access == 2) {
          riotTags.innerHTML = "<view-transfer>";
          riot.mount('view-transfer');

          scope.unmount()
        }
        else {
          scope.clickPinError = false;
          scope.errorNote = 'Извининте, вы не можете произвести перевод с этой карты';
          scope.showError = true;
          scope.update();
        }
      }
    }

  </script>
</view-my-cards>
<view-my-cards class="view-my-cards riot-tags-main-container">
  <div class="page-title">
    <p class="name-title">{titleName}</p>
    <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
         class="{back-button: backbuttoncheck}" role="button" aria-label="{window.languages.Back}">
    </div>
    <div id="rightButton" type="button" class="{settings-button: rightbuttoncheck}" ontouchstart="editCardStart()"
         ontouchend="editCardEnd()" role="button" aria-label="{window.languages.ViewMyCardAriaLabelCardSettings}"></div>
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
         ontouchend="lastOperationsTouchEnd()" role="button" aria-label="{window.languages.ViewMyCardLastOperations}">
      <div id="myCardLastOperationContainerIconId" class="my-cards-last-operations-container-icon"></div>
      <p class="my-cards-last-operations-label">{window.languages.ViewMyCardLastOperations}</p>
    </div>

    <div id="lastOperationContainerId" class="my-cards-last-operations-container">
      <div class="my-cards-last-operations-inner-container" each="{j in lastOperationsDates}">
        <div class="my-cards-last-operations-date">
          <p class="my-cards-last-operation-info-date-name">{j}</p>
        </div>
        <div class="my-cards-last-operations-info" each="{i in lastOperationsMap[j]}" id="{i.payment_id}"
             ontouchstart="onTouchStartOfOperation(this.id)" onclick="onTouchEndOfOperation(this.id)" role="button"
             aria-label="{i.service_name}">
          <div class="my-cards-operation-service-icon"
               style="background-image: url({i.image})"></div>
          <div class="my-cards-operation-amount">- {i.amount}</div>
          <div class="my-cards-operation-currency">{i.lang_amount_currency}</div>
          <div class="my-cards-firm-name">{i.service_name}</div>
          <div class="my-cards-operation-date">{i.cntrg_info_param2}</div>
          <p class="my-cards-last-operation-info-time">{i.paymentTime}</p>

        </div>
      </div>
    </div>


  </div>

  <component-delete-card id="deleteCardComponentId"></component-delete-card>

  <script>

    var scope = this;
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

      scope.lastOperationsHidden = true;

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

      if (Math.abs(lastOperationButtonStartX - lastOperationButtonEndX) <= 20) {

        if (scope.lastOperationsHidden) {

          lastOperationMainContainerId.style.webkitTransform = "translate3d(0," + 85 * widthK + "px,0)"
//          lastOperationMainContainerId.top = "0"
          lastOperationContainerId.style.height = 1070 * widthK + "px";
          document.getElementById('containerCard').style.webkitTransform = "scale(0.2)"
          document.getElementById('myCardLastOperationContainerIconId').style.webkitTransform = "rotate(180deg)"
          lastOperationCheck = true;
        } else {

          lastOperationMainContainerId.style.webkitTransform = "translate3d(0," + 835 * widthK + "px,0)"
//          lastOperationMainContainerId.top = "0"
          lastOperationContainerId.style.height = 325 * widthK + "px";
          document.getElementById('containerCard').style.webkitTransform = "scale(1)"
          document.getElementById('myCardLastOperationContainerIconId').style.webkitTransform = "rotate(0)"
          lastOperationCheck = false;
        }

        scope.lastOperationsHidden = !scope.lastOperationsHidden;

        return;
      }

      if (Math.abs(lastOperationButtonStartX - lastOperationButtonEndX) <= 100 && lastOperationButtonStartY > lastOperationButtonEndY && !lastOperationCheck) {

        lastOperationMainContainerId.style.webkitTransform = "translate3d(0," + 85 * widthK + "px,0)"
//          lastOperationMainContainerId.top = "0"
        lastOperationContainerId.style.height = 1070 * widthK + "px";
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
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
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
          window.common.alert.show("componentConfirmId", {
            parent: scope,
            "confirmnote": question,
            "confirmtype": 'local'
          });
          scope.result = function (bool) {
            if (bool) {
              localStorage.clear();
              window.location = 'index.html'
              scope.unmount()
              return
            }
            else {
              window.common.alert.hide("componentConfirmId");
              return
            }
          };
          scope.update();

          return
        }


        var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
        var phoneNumber = localStorage.getItem('click_client_phoneNumber');
        var account_id = scope.card.card_id;
        var removable = scope.card.removable;

        if (removable == 1) {
          deleteCardComponentId.style.display = 'block';
          componentDeleteCard.getInformation(sessionKey, phoneNumber, account_id);
        }
        else {
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: 'Вы не можете удалить эту карту!',
          });
          scope.update();
        }
      }
    }


    var scope = this,
      sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key,
      phoneNumber = localStorage.getItem('click_client_phoneNumber'),
      myCardsOnTouchStartY, myCardsOnTouchStartX, myCardsOnTouchEndY, myCardsOnTouchEndX;

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
              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: result[0][0].error_note
              });
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
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: 'Извининте, вы не можете произвести оплату с этой карты'
          });
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
          params = {
            countCardFromMain: scope.card.countCard,
          };
          riotTags.innerHTML = "<view-transfer-new>";
          riot.mount('view-transfer-new', params);

          scope.unmount()
        }
        else {
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: false,
            errornote: 'Извининте, вы не можете произвести перевод с этой карты'
          });
          scope.update();
        }
      }
    }

    var operationInfoTouchStartY, operationInfoTouchEndY;
    scope.onTouchStartOfOperation = onTouchStartOfOperation = function (paymentId) {
      console.log('Start')
      operationInfoTouchStartY = event.changedTouches[0].pageY;
    }

    scope.onTouchEndOfOperation = onTouchEndOfOperation = function (paymentId) {

      document.getElementById(paymentId).style.backgroundColor = 'rgba(231,231,231,0.8)'

      setTimeout(function () {
        document.getElementById(paymentId).style.backgroundColor = 'transparent'
      }, 300)


      operationInfoTouchEndY = event.pageY;

      setTimeout(function () {


        if (Math.abs(operationInfoTouchStartY - operationInfoTouchEndY) < 20) {

          if (modeOfApp.demoVersion) {
            var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
            window.common.alert.show("componentConfirmId", {
              parent: scope,
              "confirmnote": question,
              "confirmtype": 'local'
            });
            scope.result = function (bool) {
              if (bool) {
                localStorage.clear();
                window.location = 'index.html'
                scope.unmount()
                return
              }
              else {
                window.common.alert.hide("componentConfirmId");
                return
              }
            };
            scope.update();

            return
          }

          console.log("Time to open");
          for (var i = 0; i < scope.arrayOfOperationsByAccount.length; i++) {
            if (scope.arrayOfOperationsByAccount[i].payment_id == paymentId) {
              var servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
//            console.log("FROM VIEW INFO service report for=", scope.arrayOfOperationsByAccount[i]);

              var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));

              console.log(" starting check", favoritePaymentsList)
              if (favoritePaymentsList) {
                for (var j in favoritePaymentsList) {
                  console.log("fav payment j ", favoritePaymentsList[j].params)
                  if (favoritePaymentsList[j].params.paymentId && favoritePaymentsList[j].params.paymentId == paymentId) {
                    console.log("found ", favoritePaymentsList[j].params.paymentId)
                    scope.arrayOfOperationsByAccount[i].isInFavorites = true;
                    scope.favoriteId = favoritePaymentsList[j].id;
                    break;
                  }
                  scope.arrayOfOperationsByAccount[i].isInFavorites = false;
                }
                //console.log(" not found ")

              } else {
                scope.arrayOfOperationsByAccount[i].isInFavorites = false;
                console.log(" NO FAV ")
              }

              if (servicesMap[scope.arrayOfOperationsByAccount[i].service_id])
                scope.arrayOfOperationsByAccount[i].canAddToFavorite = true;
              else
                scope.arrayOfOperationsByAccount[i].canAddToFavorite = false;

              scope.arrayOfOperationsByAccount[i].favoriteId = scope.favoriteId;
              riotTags.innerHTML = "<view-report-service-new>";
              riot.mount("view-report-service-new", scope.arrayOfOperationsByAccount[i]);

              scope.unmount()
              break;
            }
          }
        }
      }, 100)

    }

  </script>
</view-my-cards>
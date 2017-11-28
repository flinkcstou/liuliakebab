<view-mycard-list>
  <div class="view-mycard-list riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div id="myCardListButtonAddId" role="button" aria-label="{window.languages.ViewMyCardListVoiceOverAddCard}"
           class="mycardlist-add-button" ontouchstart="addCardTouchStart()"
           ontouchend="addCardTouchEnd()"></div>
    </div>

    <div class="mycardlist-container">
      <div class="mycardlist-card" each="{i in cardsArray}" id="{i.card_id}"
           style="background-image: url({i.card_background_url}); color: rgb({i.font_color});"
           ontouchstart="goToCardPageTouchStart(this.id)" ontouchend="goToCardPageTouchEnd({i.card_id}, this.id)">

        <div class="mycardlist-card-bank-name"></div>
        <div class="mycardlist-card-salary-title">{i.name}</div>

        <div if="{!modeOfApp.offlineMode}" class="mycardlist-card-balance-currency-container">
          <p class="mycardlist-card-balance">{i.salary}</p>
          <p class="mycardlist-card-currency">{i.currency}</p>
        </div>

        <div class="mycardlist-card-number">
          <div class="mycardlist-card-number-part-one">{i.numberPartOne}</div>
          <p class="mycardlist-number-stars">**** ****</p>
          <div class="mycardlist-card-number-part-two">{i.numberPartTwo}</div>
        </div>
      </div>
    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewMyCardListTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-mycard-list') {
      history.arrayOfHistory.push(
        {
          "view": 'view-mycard-list',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var getAccountsCards = []

    if (JSON.parse(localStorage.getItem("click_client_cards")))
      scope.cardsArray = JSON.parse(localStorage.getItem("click_client_cards"));

    console.log('CARDS', scope.cardsArray)
    scope.update();


    addCard = function (withoutBalance) {


      if (modeOfApp.offlineMode) return;

      if (localStorage.getItem('click_client_accountInfo') && !scope.checkSumOfHash) {
        console.log('STEP', 0)
        getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));
        var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'))
        for (var i = 0; i < getAccountsCards.length; i++) {
          if (getAccountsCards[i].id == loginInfo.default_account) {
            var tmp = getAccountsCards[0];
            getAccountsCards[0] = getAccountsCards[i];
            getAccountsCards[i] = tmp;
          }
        }

        if (JSON.parse(localStorage.getItem("click_client_cards"))) {
//          localStorage.removeItem("click_client_cards")
          scope.cardsarray = {};
        }
      }

      if (!scope.cardsarray && !scope.checkSumOfHash) {

        scope.cardsarray = {};
      }
      else {
        if (scope.checkSumOfHash) {
          scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));

          if (scope.invoiceCheck && viewMainPage.atMainPage) {
            count = 1;

            for (var i in scope.cardsarray) {
              scope.cardsarray[i].countCard = count;
              count++;
            }

            localStorage.setItem('click_client_countCard', count)
//            localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray))

            console.log('CARD NUMBER', scope.cardNumber)

          }
          else {
            if (!viewMainPage.atMainPage)
              count = 0;
            else {
              if (viewMainPage.atMainPage && !scope.invoiceCheck) {
                count = 0

              }
            }

            for (var i in scope.cardsarray) {
              scope.cardsarray[i].countCard = count;
              count++;
            }
          }
//          scope.update()
        }
        else {
          if (!viewMainPage.atMainPage)
            count = 0;
        }
      }

//      if (scope.invoiceCheck && viewMainPage.atMainPage && !scope.checkSumOfHash) {
//        count = 1;
////        scope.update()
//      }
//      else {
//        if(!scope.invoiceCheck && viewMainPage.atMainPage)
//          count = 0;
//      }

      var numberOfCardPartOne;
      var numberOfCardPartTwo;
      var typeOfCard;

      if (!scope.checkSumOfHash) {
        for (var i = 0; i < getAccountsCards.length; i++) {


          if (getAccountsCards[i].access == 0) break;
          if (loginInfo.default_account == getAccountsCards[i].id) {
            var defaultAccount = true;
          }
          else
            defaultAccount = false;

          numberOfCardPartOne = getAccountsCards[i].accno.substring(0, 4)
          numberOfCardPartTwo = getAccountsCards[i].accno.substring(getAccountsCards[i].accno.length - 4, getAccountsCards[i].accno.length);


          card = {
            card_id: getAccountsCards[i].id,
            id: getAccountsCards[i].id,
            card_num_hash: getAccountsCards[i].card_num_hash,
            card_num_crypted: getAccountsCards[i].card_num_crypted,
            checksum: getAccountsCards[i].checksum,
            bankName: typeOfCard,
            name: getAccountsCards[i].description,
            salary: getAccountsCards[i].salary,
            currency: getAccountsCards[i].currency_name.trim(),
            numberPartOne: numberOfCardPartOne,
            numberPartTwo: numberOfCardPartTwo,
            url: getAccountsCards[i].image_url,
            card_background_url: getAccountsCards[i].card_background_url,
            countCard: count,
            chosenCard: false,
            default_account: defaultAccount,
            access: getAccountsCards[i].access,
            background_color_bottom: getAccountsCards[i].background_color_bottom,
            background_color_top: getAccountsCards[i].background_color_top,
            font_color: getAccountsCards[i].font_color,
            removable: getAccountsCards[i].removable,
          };

          scope.cardsarray[getAccountsCards[i].id] = card;

          console.log('scope.cardsarray', scope.cardsarray)

          localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));

          count++;
//        cardNumber %= count;
          localStorage.setItem('click_client_countCard', count);
//        localStorage.setItem('cardNumber', cardNumber);
        }
      }

      console.log('CARDSARRAY', scope.cardsarray)

//      scope.update(scope.cardsarray);
      if (!modeOfApp.offlineMode && localStorage.getItem('click_client_accountInfo') && !withoutBalance) {
        writeBalance();
      } else {

//        scope.update();
      }
    };

    writeBalance = function () {

      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var arrayAccountInfo = [];
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var sessionKey = info.session_key;

      if (getAccountsCards.length == 0) {
        if (localStorage.getItem('click_client_cards'))
          getAccountsCards = JSON.parse(localStorage.getItem('click_client_cards'))

        console.log("JSON.parse(localStorage.getItem('click_client_cards'))", JSON.parse(localStorage.getItem('click_client_cards')))
      }


      for (var i in getAccountsCards) {
        console.log('getAccountsCards', getAccountsCards[i])
        console.log('Balance request')
        window.api.call({
          method: 'get.balance',
          stopSpinner: false,
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: getAccountsCards[i].id,
            card_num_hash: getAccountsCards[i].card_num_hash,
            card_num_crypted: getAccountsCards[i].card_num_crypted
          },
          //TODO: DO CARDS
          scope: this,
          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              if (result[1][0]) {
                try {
                  console.log('SCOPE.CARDSARRAY', scope.cardsarray)

                  if (scope.cardsarray[result[1][0].account_id])
                    scope.cardsarray[result[1][0].account_id].salaryOriginal = result[1][0].balance.toFixed(0);


                  result[1][0].balance = result[1][0].balance.toFixed(0).toString();

                  if (result[1][0].balance != 0)
                    result[1][0].balance = window.amountTransform(result[1][0].balance.toString());

                  scope.cardsarray[result[1][0].account_id].salary = result[1][0].balance;
                  console.log('SCOPE.CARDSARRAY', scope.cardsarray)
                  localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));
                  scope.update();
                }
                catch (error) {
                  console.log(error)
                }
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
    };

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

    var goToCardTouchStartX, goToCardTouchStartY, goToCardTouchEndX, goToCardTouchEndY;
    goToCardPageTouchStart = function (id) {
//      event.preventDefault();
//      event.stopPropagation();

      goToCardTouchStartX = event.changedTouches[0].pageX
      goToCardTouchStartY = event.changedTouches[0].pageY

      document.getElementById(id).style.webkitTransform = 'scale(0.9)'

    }

    goToCardPageTouchEnd = function (cardId, id) {
      if (modeOfApp.offlineMode) return
//      event.preventDefault();
//      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      goToCardTouchEndX = event.changedTouches[0].pageX
      goToCardTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(goToCardTouchStartX - goToCardTouchEndX) <= 20 && Math.abs(goToCardTouchStartY - goToCardTouchEndY) <= 20) {

        console.log('cardId', cardId);
        for (var i in scope.cardsArray) {
          if (scope.cardsArray[i] == scope.cardsArray[cardId]) {
            scope.cardsArray[cardId].chosenCard = true;
            console.log('scope.cardsArray[cardId]', scope.cardsArray[cardId])
            console.log('scope.cardsArray[i]', scope.cardsArray[i])
            localStorage.setItem('cardNumber', scope.cardsArray[cardId].countCard);
          }
          else
            scope.cardsArray[cardId].chosenCard = false;
        }

        scope.update();

        riotTags.innerHTML = "<view-my-cards>";
        riot.mount('view-my-cards', [cardId]);

        scope.unmount()
      }
    }

    var addTouchStartX, addTouchStartY, addTouchEndX, addTouchEndY;

    addCardTouchStart = function () {

      event.preventDefault();
      event.stopPropagation();

      myCardListButtonAddId.style.webkitTransform = 'scale(0.7)'

      addTouchStartX = event.changedTouches[0].pageX
      addTouchStartY = event.changedTouches[0].pageY

    }

    addCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      myCardListButtonAddId.style.webkitTransform = 'scale(1)'

      addTouchEndX = event.changedTouches[0].pageX
      addTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(addTouchStartX - addTouchEndX) <= 20 && Math.abs(addTouchStartY - addTouchEndY) <= 20) {

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
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
//          else {
//            scope.confirmShowBool = false;
//            return
//          }
//        };
          scope.update();

          return
        }

        riotTags.innerHTML = "<view-add-card>";
        riot.mount('view-add-card');

        scope.unmount()
      }
    }


  </script>
</view-mycard-list>

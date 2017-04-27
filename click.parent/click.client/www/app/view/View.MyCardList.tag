<view-mycard-list>
  <div class="view-mycard-list">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToMainPage()"
           class="back-button">
      </div>
      <div class="mycardlist-add-button" ontouchend="addCardTouchEnd()"></div>
    </div>

    <div class="mycardlist-container">
      <div class="mycardlist-card" each="{i in cardsArray}"
           style="background-image: url({i.card_background_url}); color: rgb({i.font_color});"
           ontouchend="goToCardPage({i.card_id})">

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
    riot.update(scope.cardsArray);

    refreshCards = function () {


      if (modeOfApp.onlineMode) {
        if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
          var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var arrayAccountInfo = [];
          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var sessionKey = info.session_key;

          window.api.call({
            method: 'get.accounts',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },

            scope: this,

            onSuccess: function (result) {

              arrayAccountInfo = [];

              if (result[0][0].error == 0) {

                if (device.platform != 'BrowserStand') {
                  window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                    var j = -1, count = 0;
                    for (var i = 0; i < result[1].length; i++) {

                      j++;
                      arrayAccountInfo.push(result[1][i]);

                      var icon = result[1][i].card_background_url;

                      var filename = icon.substr(icon.lastIndexOf('/') + 1);
//                      alert("filename=" + filename);

                      var newIconBool = checkImageURL;
                      newIconBool('www/resources/icons/cards/', 'cards', filename, icon, j, function (bool, index, fileName) {

                        if (bool) {
                          count++;
//                          alert("(1)new file name=" + fileName + "," + count);
                          arrayAccountInfo[index].card_background_url = cordova.file.dataDirectory + fileName;
                        } else {
                          count++;
//                          alert("(2)new file name=" + fileName + "," + count);
                          arrayAccountInfo[index].card_background_url = 'resources/icons/cards/' + fileName;
                        }

                        var icon2 = arrayAccountInfo[index].image_url;
                        var filename2 = icon2.substr(icon2.lastIndexOf('/') + 1);
                        var newIcon = checkImageURL;
                        newIcon('www/resources/icons/cards/logo/', 'logo', filename2, icon2, index, function (bool2, index2, fileName2) {

                          if (bool2) {
                            count++;
//                            alert("(11)new file name=" + fileName2 + "," + count);
                            arrayAccountInfo[index2].image_url = cordova.file.dataDirectory + fileName2;
                          } else {
                            count++;
//                            alert("(12)new file name=" + fileName2 + "," + count);
                            arrayAccountInfo[index2].image_url = url('resources/icons/cards/logo/' + fileName2);
                          }

                          if (count == (result[1].length * 2)) {
//                            alert("GHVCHGFUIHOI:JIJsave into localstorage");
                            var accountInfo = JSON.stringify(arrayAccountInfo);
                            if (JSON.parse(localStorage.getItem("click_client_accountInfo"))) {
                              localStorage.removeItem("click_client_accountInfo")
                            }
                            localStorage.setItem("click_client_accountInfo", accountInfo);
                            addCard()
                          }

                        });

                      });

                    }
                  }, onErrorLoadFs);
                } else {
                  for (var i = 0; i < result[1].length; i++)
                    arrayAccountInfo.push(result[1][i])
                  var accountInfo = JSON.stringify(arrayAccountInfo);
                  if (JSON.parse(localStorage.getItem("click_client_accountInfo"))) {
                    localStorage.removeItem("click_client_accountInfo")
                  }
                  localStorage.setItem("click_client_accountInfo", accountInfo);
                  addCard()
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
      } else {

        addCard(true);
      }
    };

    addCard = function (withoutBalance) {

      if (localStorage.getItem('click_client_accountInfo')) {
        getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));
        var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'))

        for (var i = 0; i < getAccountsCards.length; i++) {
          console.log('AAAAAAAAa')

          if (getAccountsCards[i].id == loginInfo.default_account) {
            var tmp = getAccountsCards[0];
            getAccountsCards[0] = getAccountsCards[i];
            getAccountsCards[i] = tmp;

          }
        }


        if (JSON.parse(localStorage.getItem("click_client_cards"))) {
          scope.cardsArray = {};
        }
      }

      if (!scope.cardsArray) {

        scope.cardsArray = {};
      }

      count = 0;

      var numberOfCardPartOne;
      var numberOfCardPartTwo;
      var typeOfCard;

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
          bankName: typeOfCard,
          name: getAccountsCards[i].description,
          salary: '',
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

        scope.cardsArray[getAccountsCards[i].id] = card;

        console.log('scope.cardsArray', scope.cardsArray);

        localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsArray));

        count++;
        localStorage.setItem('click_client_countCard', count);
      }

      riot.update(scope.cardsArray);

      if (!modeOfApp.offlineMode && localStorage.getItem('click_client_accountInfo') && !withoutBalance) {
        writeBalance();
      }
    };

    writeBalance = function () {

      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var arrayAccountInfo = [];
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var sessionKey = info.session_key;

      for (var i = 0; i < getAccountsCards.length; i++) {
        window.api.call({
          method: 'get.balance',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            account_id: getAccountsCards[i].id,
            card_num_hash: getAccountsCards[i].card_num_hash,
            card_num_crypted: getAccountsCards[i].card_num_crypted
          },
          scope: this,
          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              if (result[1][0]) {
                scope.cardsArray[result[1][0].account_id].salaryOriginal = result[1][0].balance.toFixed(0);

                result[1][0].balance = result[1][0].balance.toFixed(0).toString();

                result[1][0].balance = window.amountTransform(result[1][0].balance.toString());

                scope.cardsArray[result[1][0].account_id].salary = result[1][0].balance;
                localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsArray));

                riot.update();
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
    };

    refreshCards();

    goToMainPage = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown();
      scope.unmount()
    };

    goToCardPage = function (cardId) {
      event.preventDefault();
      event.stopPropagation();
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

      riot.update(scope.cardsArray);

      riotTags.innerHTML = "<view-my-cards>";
      riot.mount('view-my-cards', [cardId]);

      scope.unmount()
    }

    addCardTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-add-card>";
      riot.mount('view-add-card');

      scope.unmount()
    }


  </script>
</view-mycard-list>

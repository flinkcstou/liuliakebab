<component-card-carousel>

  <div id="containerCard" class="card-carousel" ontouchend="endTouchCarousel()" ontouchmove="moveTouchCarousel()"
       ontouchstart="startTouchCarousel()">
    <div id="cards" class="cards">
      <div if="{viewMainPage.atMainPage && invoiceList[0] && modeOfApp.onlineMode}" class="bills-holder">
        <div each="{invoice in invoiceList}" title="{JSON.stringify(invoice)}"
             class="{invoice-card-part-one: invoice == invoiceList[0], invoice-card-part-two: invoice == invoiceList[1]}"
             style="left: {invoiceLeft}px;"
             ontouchend="invoiceBlockTouchEnd(this.title)" ontouchstart="invoiceBlockTouchStart()">
          <div id="transfer-container" class="invoice-card-info-holder" if="{invoice.is_p2p}">
            <p class="invoice-card-from-label">{invoice.description}</p>
            <p class="invoice-card-date">{invoice.time} {invoice.date}</p>
            <div class="invoice-card-transfer-sum-holder">
              <p class="invoice-card-sum">{invoice.amount}</p>
              <mark class="invoice-card-sum-marked">{invoice.currency}
              </mark>
            </div>
          </div>
          <div id="payment-container" class="invoice-card-info-holder" if="{!invoice.is_p2p}">
            <p class="invoice-card-from-label">{invoice.description}</p>
            <p class="invoice-card-date">{invoice.time} {invoice.date}</p>
            <div class="invoice-card-payment-sum-holder">
              <p class="invoice-card-sum">{invoice.amount}</p>
              <mark class="invoice-card-sum-marked">{invoice.currency}
              </mark>
            </div>
          </div>
          <div class="invoice-card-transfer" if="{invoice.is_p2p}"></div>
          <div class="invoice-card-payment" if="{!invoice.is_p2p}"></div>
        </div>
      </div>

      <div class="add-card-carousel" if="{viewMainPage.addFirstCardBool}" ontouchend="addFirstCardTouchEnd()"
           ontouchstart="addFirstCardTouchStart()">
        <div class="add-card-carousel-icon">
        </div>
        <div class="add-card-carousel-text">
          {window.languages.ComponentCardCarouselAddFirstCardtext}
        </div>
      </div>

      <component-card each="{i in cardsarray}"
                      countcard="{i.countCard}"
                      name="{i.name}"
                      salary="{i.salary}"
                      salary_fractional="{i.salary_fractional}"
                      currency="{i.currency}"
                      numberpartone="{i.numberPartOne}"
                      numbermiddletwo="{i.numberMiddleTwo}"
                      numberparttwo="{i.numberPartTwo}"
                      bankname="{i.bankName}" url="{i.url}"
                      background="{(checkSumOfHash || i.card_cached)?(i.card_background_url):(i.card_background_local)}"
                      fontcolor="{i.font_color}" fontopacity="{i.font_opacity}"
                      error_message="{i.error_message}"></component-card>


    </div>
  </div>

  <script>

    var scope = this;
    scope.invoiceLeft = 100 * widthK;
    scope.invoiceList = [];

    var arrayOfPhones = [];

    scope.checkSumOfHash = true;
    scope.addFirstCardBool = false;

    if (localStorage.getItem("click_client_servicesMap")
      && JSON.parse(localStorage.getItem("click_client_servicesMap"))) {
      scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    }

    if (localStorage.getItem('click_client_cards')) {
      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
      if (Object.keys(scope.cardsarray).length < 1) {
        scope.addFirstCardBool = true;
        viewMainPage.addFirstCardBool = true;
        localStorage.removeItem('click_client_cards');
//        scope.parent.update();
      } else {

        for (var i in scope.cardsarray) {
          if (scope.cardsarray[i].card_id == JSON.parse(localStorage.getItem("click_client_loginInfo")).default_account) {
            scope.cardsarray[i].chosenCard = true;
          }
          else
            scope.cardsarray[i].chosenCard = false;
        }
        localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));

      }
      scope.update();
    }


    var touchStartAddFirstCardX, touchEndAddFirstCardX, touchStartAddFirstCardY, touchEndAddFirstCardY;

    addFirstCardTouchStart = function () {
      touchStartAddFirstCardX = event.changedTouches[0].pageX;
      touchStartAddFirstCardY = event.changedTouches[0].pageY;
      console.log('touchStartInvoiceOne', touchStartInvoiceOne)
    };


    addFirstCardTouchEnd = function () {

      touchEndAddFirstCardX = event.changedTouches[0].pageX;
      touchEndAddFirstCardY = event.changedTouches[0].pageY;

      if (Math.abs(touchStartAddFirstCardX - touchEndAddFirstCardX) < 20 && Math.abs(touchStartAddFirstCardY - touchEndAddFirstCardY) < 20) {

        event.preventDefault();
        event.stopPropagation();

        console.log("add card page open");

        riotTags.innerHTML = "<view-add-card>";
        riot.mount('view-add-card');

        scope.unmount()

      }
    };

    var touchStartInvoiceOne;
    var touchEndInvoiceOne;

    invoiceBlockTouchStart = function () {
      touchStartInvoiceOne = event.changedTouches[0].pageX;
      console.log('touchStartInvoiceOne', touchStartInvoiceOne)
    };


    invoiceBlockTouchEnd = function (invoice) {

      invoice = JSON.parse(invoice);

      touchEndInvoiceOne = event.changedTouches[0].pageX;

      if (Math.abs(touchStartInvoiceOne - touchEndInvoiceOne) < 20) {
        event.stopPropagation();
        event.preventDefault();

        var params = {};

        if (invoice.is_p2p) {

          params = {
            phoneNumber: invoice.parameter,
            amount: invoice.amount,
            invoiceId: invoice.invoice_id,
            time: invoice.time,
            date: invoice.date,
            description: invoice.description
          };

          history.arrayOfHistory.push({view: "view-transfer-detail"});
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
          riotTags.innerHTML = "<view-transfer-detail>";
          riot.mount('view-transfer-detail', params);
        }
        else {
          params = {
            amount: invoice.amount,
            invoiceId: invoice.invoice_id,
            phoneNumber: invoice.merchant_phone,
            accountNumber: invoice.parameter,
            parameter: invoice.parameter,
            serviceName: invoice.service_name,
            is_friend_help: invoice.is_friend_help,
            friend_name: invoice.friend_name,
            commission_percent: invoice.commission_percent,
            service_id: invoice.service_id,
            description: invoice.description,
            nds: invoice.nds,
            rate: invoice.rate,
            low_ratio: invoice.low_ratio,
            category_id: invoice.category_id,
            currency: invoice.currency
          }
          ;

          history.arrayOfHistory.push({view: "view-payment-detail"});
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
          riotTags.innerHTML = "<view-payment-detail>";
          riot.mount('view-payment-detail', params);
        }
      }
    };


    scope.addCard = addCard = function (withoutBalance, invoice) {

      if (modeOfApp.offlineMode) return;

      if (localStorage.getItem('click_client_accountInfo') && !scope.checkSumOfHash) {

        getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));

        if (getAccountsCards.length < 1) {
          scope.addFirstCardBool = true;
          viewMainPage.addFirstCardBool = true;
          localStorage.removeItem('click_client_cards');
          scope.parent.update();
        } else {
          viewMainPage.addFirstCardBool = false;
          scope.parent.update();
        }
        var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'))
      }

      if (scope.checkSumOfHash) {

        scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
        var writeBalanceBool = !modeOfApp.offlineMode && localStorage.getItem('click_client_accountInfo') && !withoutBalance && Object.keys(scope.cardsarray).length != 0 &&
          !(sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true);

        console.log("write balance request", writeBalanceBool);

        console.log("CHECK SUM OF HASH = true");

//        for (var i in scope.cardsarray) {
//          scope.cardsarray[i].font_opacity = writeBalanceBool ? 0.5 : 1;
//        }

      } else if (!scope.checkSumOfHash) {

        console.log("CHECK SUM OF HASH = false");

        if (!loginInfo.update_account_cache) {
          scope.cardImageCachedLinks = {};
          for (var j in scope.cardsarray) {
            scope.cardImageCachedLinks[j] = {
              "cardId": j,
              "cardBackgroundUrl": scope.cardsarray[j].card_background_url,
              "url": scope.cardsarray[j].url
            };
          }
        }

        scope.cardsarray = {};

        var numberOfCardPartOne;
        var numberOfCardMiddleTwo;
        var numberOfCardPartTwo;
        var typeOfCard;
        var writeBalanceBool = !modeOfApp.offlineMode && localStorage.getItem('click_client_accountInfo') && !withoutBalance && getAccountsCards.length != 0 &&
          !(sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true);

        console.log("write balance request", writeBalanceBool);

        count = 1;
        if (viewMainPage.addFirstCardBool) count = 2;
        for (var i = 0; i < getAccountsCards.length; i++) {

          if (getAccountsCards[i].access == 0) break;
          if (loginInfo.default_account == getAccountsCards[i].id) {
            var defaultAccount = true;
          }
          else
            defaultAccount = false;

          numberOfCardPartOne = getAccountsCards[i].accno.substring(0, 4);
          numberOfCardMiddleTwo = getAccountsCards[i].accno.substring(5, 7);
          numberOfCardPartTwo = getAccountsCards[i].accno.substring(getAccountsCards[i].accno.length - 4, getAccountsCards[i].accno.length);


          card = {
            card_id: getAccountsCards[i].id,
            id: getAccountsCards[i].id,
            card_num_hash: getAccountsCards[i].card_num_hash,
            card_num_crypted: getAccountsCards[i].card_num_crypted,
            checksum: getAccountsCards[i].checksum,
            bankName: typeOfCard,
            name: getAccountsCards[i].description,
            salary: '',
            error_message: null,
            countCard: getAccountsCards[i].countCard,
            currency: getAccountsCards[i].currency_name.trim(),
            numberPartOne: numberOfCardPartOne,
            numberMiddleTwo: numberOfCardMiddleTwo,
            numberPartTwo: numberOfCardPartTwo,
            url: getAccountsCards[i].image_url,
            card_background_url: getAccountsCards[i].card_background_url,
            card_background_local: 'resources/icons/cards/' + getAccountsCards[i].card_background_url.substr(getAccountsCards[i].card_background_url.lastIndexOf('/') + 1),
            card_cached: device.platform == "BrowserStand" ? true : false,
            chosenCard: defaultAccount,
            default_account: defaultAccount,
            access: getAccountsCards[i].access,
            background_color_bottom: getAccountsCards[i].background_color_bottom,
            background_color_top: getAccountsCards[i].background_color_top,
            font_color: getAccountsCards[i].font_color,
//            font_opacity: writeBalanceBool ? 0.5 : 1,
            font_opacity: 1,
            removable: getAccountsCards[i].removable,
            payment_allowed: getAccountsCards[i].payment_allowed,
            p2p_allowed: getAccountsCards[i].p2p_allowed,
          };

          scope.cardsarray[getAccountsCards[i].id] = card;

          localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));

          count++;

          localStorage.setItem('click_client_countCard', count);
        }

        if (loginInfo.update_account_cache) {

          cardImagesCaching(true);
          loginInfo.update_account_cache = false;
          localStorage.setItem('click_client_loginInfo', JSON.stringify(loginInfo));

        } else {
          cardImagesCaching(false);
        }

      }

      if (writeBalanceBool) {
        console.log("write balance request");
        writeBalance();
      }

      scope.update();

    }
    ;

    scope.invoiceCheck = false;

    invoiceCheckFunction = function () {
      scope.invoiceList = [];
      scope.update();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      if (loginInfo)
        var sessionKey = loginInfo.session_key;

      window.api.call({
        method: 'invoice.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error == 0 && viewMainPage.atMainPage) {
            if (result[1] && result[1][0]) {
              if (result[1].length != 0) {

                scope.invoiceCheck = true;

                var arrayOfInvoice = [];
                for (var i = 0; i < result[1].length; i++) {
                  var invoice = result[1][i];
                  if (scope.servicesMap != null &&
                    scope.servicesMap[result[1][i].service_id] != null &&
                    scope.servicesMap[result[1][i].service_id].length > 0) {
                    invoice.nds = scope.servicesMap[result[1][i].service_id][0].nds;
                    invoice.rate = scope.servicesMap[result[1][i].service_id][0].rate;
                    invoice.low_ratio = scope.servicesMap[result[1][i].service_id][0].low_ratio;
                    invoice.category_id = scope.servicesMap[result[1][i].service_id][0].category_id;
                    invoice.currency = scope.servicesMap[result[1][i].service_id][0].lang_amount_currency;
                  }
                  arrayOfInvoice.push(invoice);
                }

                localStorage.setItem('click_client_invoice_list', JSON.stringify(arrayOfInvoice));

                if (scope.invoiceList) {
                  if (arrayOfInvoice[0]) {
                    scope.invoiceList.push(arrayOfInvoice[0]);
                  }

                  if (arrayOfInvoice[1]) {
                    scope.invoiceList.push(arrayOfInvoice[1]);
                  }
                  console.log('invoices', scope.invoiceList);
                }

                scope.update();

              }

              console.log("invoices processed");

            }
            else {
              scope.invoiceCheck = false;
              scope.update();
            }
          }
          else {
            if (result[0][0].error != 0) {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote
              });
            }
            scope.update();
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    //TODO: FIX THIS BUG WITH MANY CONTACTS ON PHONE !!!!!!
    //    function onSuccess(contacts) {
    //
    //      for (var i = 0; i < contacts.length; i++) {
    //        if (contacts[i].name)
    //          if ((contacts[i].name.familyName != null || contacts[i].name.givenName != null) && contacts[i].phoneNumbers != null) {
    //            for (var j = 0; j < contacts[i].phoneNumbers.length; j++) {
    //              var phone = inputVerification.spaceDeleter(contacts[i].phoneNumbers[j].value);
    //
    //              contacts[i].phoneNumbers[j].value = phone;
    //            }
    //            arrayOfPhones.push(contacts[i])
    //            sessionStorage.setItem('arrayOfPhones', JSON.stringify(arrayOfPhones));
    //          }
    //      }
    //
    //    }
    //
    //
    //    function onError(contactError) {
    //      console.log('error', contactError)
    //    }
    //
    //
    //    if (device.platform != 'BrowserStand' && !sessionStorage.getItem('arrayOfPhones')) {
    //      var options = new ContactFindOptions();
    //      options.multiple = true;
    //      options.hasPhoneNumber = true;
    //      navigator.contacts.find(["phoneNumbers"], onSuccess, onError, options);
    //    }

    cardImagesCaching = function (full) {

      if (device.platform != 'BrowserStand') {

        window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
          var count = 0;
          for (var i in scope.cardsarray) {

            if (!full && scope.cardImageCachedLinks[i]) {

              scope.cardsarray[i].card_background_url = scope.cardImageCachedLinks[i].cardBackgroundUrl;
              scope.cardsarray[i].url = scope.cardImageCachedLinks[i].url;
              scope.cardsarray[i].card_cached = true;
              console.log("CACHED CARD " + scope.cardsarray[i].countCard);
              count = count + 2;

              if (count == (Object.keys(scope.cardsarray).length * 2)) {

                localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));
//                scope.update();

              }

            } else {

              var icon = scope.cardsarray[i].card_background_url;
              var filename = icon.substr(icon.lastIndexOf('/') + 1);
//              document.getElementById('cardNumber' + scope.cardsarray[i].countCard).style.backgroundImage = "url(resources/icons/cards/" + filename + ")";
              scope.cardsarray[i].card_background_url = 'resources/icons/cards/' + filename;
              console.log("START CACHE CARD " + scope.cardsarray[i].countCard, icon);
              var newIconBool = checkImageURL;
              newIconBool('www/resources/icons/cards/', 'cards', filename, icon, i, function (bool, index, fileName) {

                if (bool) {
                  count++;
                  scope.cardsarray[index].card_background_url = cordova.file.dataDirectory + fileName;
                } else {
                  count++;
                  scope.cardsarray[index].card_background_url = 'resources/icons/cards/' + fileName;
                }

                console.log("START CACHE CARD " + scope.cardsarray[i].countCard, icon);

                scope.cardsarray[index].card_cached = true;

                var icon2 = scope.cardsarray[index].url;
                var filename2 = icon2.substr(icon2.lastIndexOf('/') + 1);
                var newIcon = checkImageURL;
                newIcon('www/resources/icons/cards/logo/', 'logo', filename2, icon2, index, function (bool2, index2, fileName2) {

                  if (bool2) {
                    count++;
                    scope.cardsarray[index2].url = cordova.file.dataDirectory + fileName2;
                  } else {
                    count++;
                    scope.cardsarray[index2].url = 'resources/icons/cards/logo/' + fileName2;
                  }

                  if (count == (Object.keys(scope.cardsarray).length * 2)) {

                    localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));
//                    scope.update();

                  }
                });
              });
            }
          }
        }, onErrorLoadFs);
      }
    };


    var arrayAccountInfo = [];

    scope.onComponentCreated = onComponentCreated = function (cardNumberParameter) {

      if (modeOfApp.onlineMode && !(sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true)) {
        if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
          var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
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

              if (result[0][0].error == 0) {
                if (JSON.parse(localStorage.getItem('click_client_cards')) && !info.update_account_cache) {
                  var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
                  var countLocalStorageCard = Object.keys(cardsArray).length;

                  if (countLocalStorageCard == result[1].length) {
                    for (var i in result[1]) {
                      if (cardsArray[result[1][i].id]) {
                        if (cardsArray[result[1][i].id].checksum != result[1][i].checksum) {
                          window.startSpinner();
                          scope.checkSumOfHash = false;
                          break;
                        }
                      }
                      else {
                        window.startSpinner();
                        scope.checkSumOfHash = false;
                        break;
                      }
                    }
                  }
                  else {
                    window.startSpinner();
                    scope.checkSumOfHash = false;
                  }
                }
                else {
                  scope.checkSumOfHash = false;
                }

                if (!scope.checkSumOfHash) {

                  var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
                  arrayAccountInfo = [];
                  var countCard;

                  if (loginInfo.default_account && loginInfo.default_account != 0) {
                    countCard = 2;

                    for (var i = 0; i < result[1].length; i++) {
                      if (result[1][i].id == loginInfo.default_account) {
                        result[1][i].countCard = 1;
                      }
                      else {
                        result[1][i].countCard = countCard;
                        countCard++;
                      }
                      arrayAccountInfo.push(result[1][i])
                    }
                  } else {
                    countCard = 1;

                    for (var i = 0; i < result[1].length; i++) {
                      result[1][i].countCard = countCard;
                      countCard++;
                      arrayAccountInfo.push(result[1][i])
                    }
                  }
                  var accountInfo = JSON.stringify(arrayAccountInfo);
                  if (JSON.parse(localStorage.getItem("click_client_accountInfo"))) {
                    localStorage.removeItem("click_client_accountInfo")
                  }
                  localStorage.setItem("click_client_accountInfo", accountInfo);

                  setTimeout(function () {
                    addCard()
                  }, 0);

                  window.stopSpinner();
                }
                else {
                  setTimeout(function () {
                    window.stopSpinner();
                    addCard()
                  }, 0);
                }
              }
              else {

                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote
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
      }
    };


    if (viewMainPage.atMainPage && !modeOfApp.demoVersion && modeOfApp.onlineMode && !(sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true)) {
      invoiceCheckFunction();
    }


    onComponentCreated();

    scope.switchToOfflineMode = function () {

      scope.invoiceList = [];
      scope.invoiceCheck = false;

      if (!localStorage.getItem('click_client_cards')) {
        scope.cardNumber = 1;
        count = 1;
        scope.cardsarray = window.offlineCard;
        localStorage.setItem("cardNumber", scope.cardNumber);
        localStorage.setItem("click_client_countCard", count);
      }
      changePositionCardCarousel()


      scope.update();
    };

    this.on("mount", function () {

      if (document.getElementById("cards")) {
        cards.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        cards.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';

        cards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        cards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }

      if (modeOfApp.offlineMode) {
        setTimeout(scope.switchToOfflineMode, 10);
      }
    });


    writeBalance = function () {

      if (getAccountsCards.length == 0) {
        if (localStorage.getItem('click_client_cards'))
          getAccountsCards = JSON.parse(localStorage.getItem('click_client_cards'))
      }

      for (var j in getAccountsCards) {
        objectAccount.account_id = getAccountsCards[j].id;
        objectAccount.card_num_hash = getAccountsCards[j].card_num_hash;
        objectAccount.card_num_crypted = getAccountsCards[j].card_num_crypted;
        accountsForBalance.push(objectAccount);
        objectAccount = {};
      }

      window.api.call({
        method: 'get.balance.multiple',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          accounts: accountsForBalance
        },
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1]) {
              try {

                var balances = {};
                for (var i in result[1]) {
                  balances[result[1][i].account_id] = result[1][i];
                }

                for (var i in scope.cardsarray) {
                  if (balances[i]) {
                    scope.cardsarray[balances[i].account_id].salaryOriginal = balances[i].balance.toFixed(0);
                    balances[i].balance_fractional = window.getFractionalPart(balances[i].balance.toString());
                    balances[i].balance = Math.floor(balances[i].balance).toFixed(0).toString();

                    if (balances[i].balance !== 0)
                      balances[i].balance = window.amountTransform(balances[i].balance.toString());

                    scope.cardsarray[balances[i].account_id].salary = balances[i].balance;
                    scope.cardsarray[balances[i].account_id].salary_fractional = balances[i].balance_fractional;
                  } else {
                    scope.cardsarray[i].salary = null;
                    scope.cardsarray[i].salary_fractional = '';
                    scope.cardsarray[i].error_message = window.languages.ComponentCardCarouselBalanceError;
                  }
                  scope.cardsarray[i].font_opacity = 1;
                }

                localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));
                scope.update();

              } catch (Error) {
                console.log("Error on parse result fro get.balance.multiple", Error);
              }
            }
          }
          else {
            for (var i in scope.cardsarray) {
              scope.cardsarray[i].salary = null;
              scope.cardsarray[i].error_message = window.languages.ComponentCardCarouselBalanceError;
            }
            localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));
            scope.update();
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    var getAccountsCards = [];
    var objectAccount = {};
    var accountsForBalance = [];

    var defaultAccountId;

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    if (info)
      var sessionKey = info.session_key;

    var carouselTouchStartX, carouselTouchEndX, carouselTouchStartY, carouselTouchEndY;

    var card;
    scope.cardNumber = JSON.parse(localStorage.getItem('cardNumber'));

    if (!scope.cardNumber) {
      scope.cardNumber = 1;
    }

    var pos = 0;
    var count = localStorage.getItem('click_client_countCard');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    if (!count)
      count = 1;


    startTouchCarousel = function () {

      carouselTouchStartX = event.changedTouches[0].pageX;
      carouselTouchStartY = event.changedTouches[0].pageY;
      left = -((540 * scope.cardNumber) * widthK) - carouselTouchStartX;
      delta = left;

    };


    endTouchCarousel = function () {
      event.preventDefault()
      event.stopPropagation()

      carouselTouchEndX = event.changedTouches[0].pageX;
      carouselTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(carouselTouchStartX - carouselTouchEndX) < 20 && Math.abs(carouselTouchStartY - carouselTouchEndY) < 20
        && !viewMainPage.myCards && !(scope.invoiceCheck && scope.cardNumber == 0)) {
        if (!modeOfApp.offlineMode.balance && modeOfApp.onlineMode) {


          if (scope.invoiceCheck && scope.cardNumber == 0) {
            scope.cardNumber = 1;
            console.log("cardNumber set to 1")
          }

          localStorage.setItem("cardNumber", scope.cardNumber);

          pos = (scope.cardNumber) * 540 * widthK;
          var sendChosenCardId;

          for (var i in scope.cardsarray) {
            if (scope.cardsarray[i].countCard == scope.cardNumber) {
              sendChosenCardId = i;
              break;
            }
          }

          if (sendChosenCardId !== undefined) {
            riotTags.innerHTML = "<view-my-cards>";
            riot.mount("view-my-cards", [sendChosenCardId]);
            document.getElementById('cards').style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
            document.getElementById('cards').style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
            document.getElementById('cards').style.transform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
            document.getElementById('cards').style.webkitTransform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
          }
        }
        else
          modeOfApp.offlineMode.balance = false;
      }
      else {
        changePositionCardCarousel()
      }
    };

    moveTouchCarousel = function () {
      event.preventDefault();
      event.stopPropagation();


      document.getElementById('cards').style.transition = '0s';
      document.getElementById('cards').style.webkitTransition = '0s';
      document.getElementById('cards').style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
      document.getElementById('cards').style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";

    };


    scope.changePositionCardCarousel = changePositionCardCarousel = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }

      if (scope.invoiceCheck) {
        var invoiceVar = 0;
      }
      else {
        var invoiceVar = 1;
      }

      console.log(carouselTouchEndX, carouselTouchStartX, count, scope.cardNumber);
      console.log(carouselTouchEndY, carouselTouchStartY, count, scope.cardNumber);

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumber < count - 1) {

        console.log("Move Touch Carousel1", scope.cardNumber);
        if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 40) {
          console.log("touch!!!");
          ++scope.cardNumber;
        }

        document.getElementById('cards').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        document.getElementById('cards').style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumber == invoiceVar) {

        console.log("Move Touch Carousel2", scope.cardNumber);

        document.getElementById('cards').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        document.getElementById('cards').style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumber >= count - 1) {

        console.log("Move Touch Carousel3", scope.cardNumber);

        document.getElementById('cards').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        document.getElementById('cards').style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumber > invoiceVar) {

        console.log("Move Touch Carousel4", scope.cardNumber);

        if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 40) {
          --scope.cardNumber;
        }

        document.getElementById('cards').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        document.getElementById('cards').style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }

      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 40) {
        if (viewMainPage.myCards) {
          for (var i in scope.cardsarray) {
            if (scope.cardsarray[i].countCard == scope.cardNumber) {
              console.log("card information");
              scope.parent.cardInformation(scope.cardsarray[i].card_id);
            }
          }
        }
      }


      console.log("cardNumber changed", scope.cardNumber.toString());
      localStorage.setItem('cardNumber', scope.cardNumber);

    }

  </script>
</component-card-carousel>


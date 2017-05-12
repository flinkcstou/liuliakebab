<component-card-carousel>

  <div id="containerCard" class="card-carousel" ontouchend="endTouchCarousel()" ontouchmove="moveTouchCarousel()"
       ontouchstart="startTouchCarousel()">
    <div></div>
    <div id="cards" class="cards">
      <div if="{viewMainPage.atMainPage && invoiceList[0] && modeOfApp.onlineMode}" class="bills-holder"
           ontouchend="stopPropagation()">
        <div each="{invoice in invoiceList}" title="{JSON.stringify(invoice)}"
             class="{invoice-card-part-one: invoice == invoiceList[0], invoice-card-part-two: invoice == invoiceList[1]}"
             style="left: {invoiceLeft}px;"
             ontouchend="invoiceBlockTouchEnd(this.title)" ontouchstart="invoiceBlockTouchStart()">
          <div id="transfer-container" class="invoice-card-info-holder" if="{invoice.is_p2p}">
            <p class="invoice-card-from-label">Получен перевод стредств от:</p>
            <div class="invoice-card-from-sender-holder">{(invoice.service_id == -4)?("+"):("")} {invoice.parameter}
            </div>
            <p class="invoice-card-date">{invoice.time} {invoice.date}</p>
            <div class="invoice-card-transfer-sum-holder">
              <p class="invoice-card-sum">{invoice.amount}</p>
              <mark class="invoice-card-sum-marked">сум</mark>
            </div>
          </div>
          <div id="payment-container" class="invoice-card-info-holder" if="{!invoice.is_p2p}">
            <p class="invoice-card-from-label">Вам выставлен счёт:</p>
            <div class="invoice-card-from-sender-holder">
              <p class="invoice-card-from-sender-service-name">{invoice.service_name}</p>
              <p class="invoice-card-from-sender-number"> {(invoice.service_id == -4)?("+"):("")}
                {invoice.parameter}</p>
            </div>
            <p class="invoice-card-date">{invoice.time} {invoice.date}</p>
            <div class="invoice-card-payment-sum-holder">
              <p class="invoice-card-sum">{invoice.amount}</p>
              <mark class="invoice-card-sum-marked">сум</mark>
            </div>
          </div>
          <div class="invoice-card-transfer" if="{invoice.is_p2p}"></div>
          <div class="invoice-card-payment" if="{!invoice.is_p2p}"></div>
        </div>
      </div>

      <component-card each="{i in cardsarray}"
                      countcard="{i.countCard}"
                      name="{i.name}" salary="{i.salary}" currency="{i.currency}"
                      numberpartone="{i.numberPartOne}"
                      numberparttwo="{i.numberPartTwo}"
                      bankname="{i.bankName}" url="{i.url}"
                      background="{i.card_background_url}"
                      fontcolor="{i.font_color}"></component-card>
    </div>
  </div>
  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var scope = this;
    scope.invoiceLeft = 100 * widthK;
    scope.invoiceList = [];

    scope.showError = false;

    scope.checkSumOfHash = true;

//    if (localStorage.getItem('click_client_cards')) {
//      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'))
////      scope.update();
//    }

    //    this.on('mount', function () {
    //      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
    //
    //      if (!scope.invoiceCheck) {
    //        count = 0;
    //        for (var i in scope.cardsarray) {
    //          scope.cardsarray[i].countCard = count;
    //          count++;
    //        }
    //      }
    //      scope.update()
    //
    //    })

    //    scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
    //    scope.cardsarray = (scope.cardsarray) ? (scope.cardsarray) : ({});
    //    riot.update(scope.cardsarray);

    stopPropagation = function () {

      billsHolderTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - billsHolderTouchEndX) < 20) {
        event.stopPropagation();
        event.preventDefault();
      }
    };

    var touchStartInvoiceOne;
    var touchEndInvoiceOne;

    invoiceBlockTouchStart = function () {
      touchStartInvoiceOne = event.changedTouches[0].pageX;
    };

    invoiceBlockTouchEnd = function (invoice) {

      invoice = JSON.parse(invoice);

      touchEndInvoiceOne = event.changedTouches[0].pageX;

      console.log('START', touchStartInvoiceOne)
      console.log('END', touchEndInvoiceOne)

      if (Math.abs(touchStartInvoiceOne - touchEndInvoiceOne) < 20) {

        var params = {};

        if (invoice.is_p2p) {

          params = {

            phoneNumber: invoice.parameter,
            amount: invoice.amount,
            invoiceId: invoice.invoice_id,
            time: invoice.time,
            date: invoice.date,
          };

          history.arrayOfHistory.push({view: "view-transfer-detail"});
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
          riotTags.innerHTML = "<view-transfer-detail>";
          riot.mount('view-transfer-detail', params);
        } else {

          params = {

            amount: invoice.amount,
            invoiceId: invoice.invoice_id,
            phoneNumber: invoice.merchant_phone,
            accountNumber: invoice.parameter,
            serviceName: invoice.service_name,
            is_friend_help: invoice.is_friend_help
          };

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
        if(invoice)
        riot.update();
      }
    };

    scope.invoiceCheck = false;

    invoiceCheckFunction = function () {

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
            if (result[1]) {
              if (result[1][0]) {
                console.log('invoice', result[1])

                try {
                  cards.style.transition = '0s';
                  cards.style.webkitTransition = '0s';

                  cards.style.transform = "translate3d(" + (-540) * widthK + 'px' + ", 0, 0)";
                  cards.style.webkitTransform = "translate3d(" + (-540) * widthK + 'px' + ", 0, 0)";
                } catch (error) {
                  console.log("INVOICE LIST ERROR", error);
                }

                scope.invoiceCheck = true;
                scope.cardNumber = 1;

//                scope.update(scope.invoiceCheck);
//                scope.update(scope.cardNumber);
                var arrayOfInvoice = [];
                for (var i = 0; i < result[1].length; i++) {

                  //TODO: FIX
                  try {
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                  } catch (error) {

                    console.log(error);
                  }

                  arrayOfInvoice.push(result[1][i]);
                }

                console.log("arrayOfInvoice", arrayOfInvoice);

                localStorage.setItem('click_client_invoice_list', JSON.stringify(arrayOfInvoice));

                if (scope.invoiceList) {

                  if (arrayOfInvoice[0]) {
                    scope.invoiceList.push(arrayOfInvoice[0]);
                  }

                  if (arrayOfInvoice[1]) {
                    scope.invoiceList.push(arrayOfInvoice[1]);
                  }
                }

                setTimeout(function () {
                  addCard(true, true)
//                  scope.update()
                }, 0);
              }
              else {
                scope.invoiceCheck = false;
                scope.update();
              }
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        }
        ,

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    scope.onComponentCreated = onComponentCreated = function (cardNumberParameter) {

      console.log("onComponentCreated STARTED");

//    this.on('mount', function () {
//      clearInterval(changingColor);

//      console.log(scope.cardsarray);
//      localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));
      if (modeOfApp.onlineMode) {
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

              var arrayAccountInfo = [];


              if (result[0][0].error == 0) {
                if (localStorage.getItem('click_client_cards')) {
                  var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'))
                  for (var i in result[1]) {
                    console.log('cardsArray[result[1].id]', cardsArray[result[1][i].id])
                    if (cardsArray[result[1][i].id]) {

                      console.log('HASH SUM CHECKING', cardsArray[result[1][i].id].checksum, result[1][i].checksum)

                      if (cardsArray[result[1][i].id].checksum != result[1][i].checksum) {
                        scope.checkSumOfHash = false;
                      }
                    }
                    else {
                      scope.checkSumOfHash = false;
                    }
                  }

                  console.log("CARDS RESULT", result[1], cardsArray)

                }
                else {
                  scope.checkSumOfHash = false;
                }

                console.log('HASH SUM CHECK', scope.checkSumOfHash)

//                console.log('CARDS UPDATE()', result[1])
//                console.log(result[1])
                if (!scope.checkSumOfHash) {
                  if (device.platform != 'BrowserStand') {
                    window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                      var j = -1, count = 0;
                      for (var i = 0; i < result[1].length; i++) {

                        j++;

                        console.log('arrayAccountInfo_1' + " " + i.toString(), JSON.stringify(arrayAccountInfo));

                        arrayAccountInfo.push(result[1][i]);

                        console.log('arrayAccountInfo_2' + " " + i.toString(), JSON.stringify(arrayAccountInfo));

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
                              arrayAccountInfo[index2].image_url = 'resources/icons/cards/logo/' + fileName2;
                            }

                            if (count == (result[1].length * 2)) {
//                            alert("GHVCHGFUIHOI:JIJsave into localstorage");
                              var accountInfo = JSON.stringify(arrayAccountInfo);
                              if (JSON.parse(localStorage.getItem("click_client_accountInfo"))) {
                                localStorage.removeItem("click_client_accountInfo")
                              }

                              console.log('arrayAccountInfo_1232131' + " " + i.toString(), JSON.stringify(arrayAccountInfo));

                              console.log('accountInfo', accountInfo);

                              localStorage.setItem("click_client_accountInfo", accountInfo);
                              setTimeout(function () {

                                addCard()
                              }, 0);
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

                    console.log('accountInfo BROWSER STAND', accountInfo);
                    localStorage.setItem("click_client_accountInfo", accountInfo);
                    setTimeout(function () {

                      addCard()
                    }, 0);
                  }
                }
                else {
                  setTimeout(function () {

                    addCard(false)
                  }, 0);
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
      }
//      copyCardsArray = JSON.parse(JSON.stringify(scope.cardsarray));
//      console.log(copyCardsArray, defaultAccountId)
//
//      var splitTop = copyCardsArray[defaultAccountId].background_color_top.split(',')
//
//      cMount1 = splitTowp[0]
//      cMount2 = splitTop[1]
//      cMount3 = splitTop[2]
//
//      var splitBottom = copyCardsArray[defaultAccountId].background_color_bottom.split(',')
//
//      vMount1 = splitBottom[0]
//      vMount2 = splitBottom[1]
//      vMount3 = splitBottom[2]
//      console.log('splitTop', splitTop)
//      console.log('splitBottom', splitBottom)
//
//      if (!viewMainPage.myCards) {
//        htmlId.style.background = '-webkit-linear-gradient(rgb(' + cMount1 + ',' + cMount2 + ',' + cMount3 + '),' +
//          'rgb(' + vMount1 + ',' + vMount2 + ',' + vMount3 + ')150%)';
//
//        contacts.style.backgroundColor = 'rgb(' + cMount1 + ',' + cMount2 + ',' + cMount3 + ')';
//        circleMenuId.style.border = '' + 8 * widthK + 'px solid rgb(' + cMount1 + ',' + cMount2 + ',' + cMount3 + ')';
//
//        contactsId.style.backgroundColor = 'rgb(' + cMount1 + ',' + cMount2 + ',' + cMount3 + ')';
//        contactsId.style.border = '' + 2 * widthK + 'px solid rgb(' + cMount1 + ',' + cMount2 + ',' + cMount3 + ')';
//      }
//      console.log(modeOfApp.offlineMode)
//    })
    };

    if (viewMainPage.atMainPage) {
      invoiceCheckFunction();
    }


    onComponentCreated();

    scope.switchToOfflineMode = function () {

      scope.invoiceList = [];

      var cardsTemp = localStorage.getItem("click_client_cards");

      console.log("CARDS IN LOCALSTORAGE", cardsTemp);

      if (cardsTemp) {

        var cardNumber = 0;

        cardsTemp = JSON.parse(cardsTemp);
        scope.cardsarray = cardsTemp;
        count = 0;
        scope.cardNumber = 0;
        localStorage.setItem("cardNumber", scope.cardNumber);

        if (scope.invoiceCheck) {

          scope.invoiceCheck = false;


          for (var index in scope.cardsarray) {
            count++;

            scope.cardsarray[index].countCard--;
          }

          localStorage.setItem("click_client_countCard", count);

//          console.log("CardNumber", scope.cardNumber);
//          console.log("ASDASDASD", JSON.stringify(scope.cardsarray), JSON.stringify(scope.cardNumber));
//
          console.log(scope.cardNumber, count);
        } else {


          var isThereElementAtZero = false;

          for (var index in scope.cardsarray) {
            count++;

            if (scope.cardsarray[index].countCard == 0) {

              isThereElementAtZero = true;
            }
          }

          if (!isThereElementAtZero) {

            for (var index in scope.cardsarray) {

              scope.cardsarray[index].countCard--;
            }
          }

          localStorage.setItem("click_client_countCard", count);
        }

        localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));

      } else {

        console.log("THERE IS NO CARDS IN LOCALSTORAGE");
        scope.cardNumber = 0;
        count = 1;
        scope.cardsarray = window.offlineCard;
        localStorage.setItem("cardNumber", scope.cardNumber);
        localStorage.setItem("click_client_countCard", count);
      }

      cards.style.transform = "translate3d(0, 0, 0)";
      cards.style.webkitTransform = "translate3d(0, 0, 0)";

      scope.update();
    };

    this.on("mount", function () {
//      console.log("CARDS", JSON.parse(localStorage.getItem("click_client_cards")))

//      if (!scope.invoiceCheck) {
//        count = 0;
//        scope.cardNumber = 1;
//        for (var i in scope.cardsarray) {
//          scope.cardsarray[i].countCard = count;
//          count++;
//        }
//      }
      scope.update()

      cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';

      cards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      cards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      if (modeOfApp.offlineMode) {

        console.log("scope.switchToOfflineMode");

        setTimeout(scope.switchToOfflineMode, 10);
      }
    });

    //
    writeBalance = function () {

      console.log("BALANCE STARTED");
      console.log("BALANCE STARTED", getAccountsCards);

      if (getAccountsCards.length == 0) {
        if (localStorage.getItem('click_client_cards'))
          getAccountsCards = JSON.parse(localStorage.getItem('click_client_cards'))

        console.log("JSON.parse(localStorage.getItem('click_client_cards'))", JSON.parse(localStorage.getItem('click_client_cards')))
      }

      console.log('getAccountsCards', getAccountsCards)

      for (var i in getAccountsCards) {
        console.log('getAccountsCards', getAccountsCards[i])
        console.log('Balance request')
        window.api.call({
          method: 'get.balance',
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

                  if (!viewMainPage.atMainPage)
                    scope.update();

                  if (!scope.checkSumOfHash)
                    scope.update(scope.cardsarray[result[1][0].account_id].salary);

                }
                catch (error) {
                  console.log(error)
                }
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
    }

    var getAccountsCards = [];


    var defaultAccountId;


    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    if (info)
      var sessionKey = info.session_key;

    var carouselTouchStartX, carouselTouchEndX;
    //    scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));

    //    if (!scope.cardsarray) {
    //      scope.cardsarray = {};
    //    }


    var card;
    scope.cardNumber = JSON.parse(localStorage.getItem('cardNumber'));

    if (!scope.cardNumber) {
      scope.cardNumber = 0;
    }
    //    riot.update(scope.cardNumber);

    var pos = 0;
    var count = localStorage.getItem('click_client_countCard');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    //    console.log('DDDDDDDD', loginInfo)
    if (!count)
      count = 0;

    var cNow1, cNow2, cNow3, vNow1, vNow2, vNow3;
    var cNext1, cNext2, cNext3, vNext1, vNext2, vNext3;
    var cPrivious1, cPrivious2, cPrivious3, vPrivious1, vPrivious2, vPrivious3;
    var fromChangableColor1, fromChangableColor2, fromChangableColor3, toChangableColor1, toChangableColor2, toChangableColor3;
    var cNowOriginal1, cNowOriginal2, cNowOriginal3, vNowOriginal1, vNowOriginal2, vNowOriginal3;
    var firstEnter = false;

    startTouchCarousel = function () {

      //
      //Test
//      scope.direction = 0;
//      scope.whereWasX = event.changedTouches[0].pageX;
//      //
//      //
//      clearInterval(changingColor)
//
//      firstEnter = true;

      console.log("Start Touch Carousel", scope.cardNumber);

      carouselTouchStartX = event.changedTouches[0].pageX;
      left = -((540 * scope.cardNumber) * widthK) - carouselTouchStartX;
      delta = left;
//
//      for (var i in scope.cardsarray) {
//        if (scope.cardsarray[i].countCard == cardNumber) {
//          console.log('SPLIT SPLIT ', scope.cardsarray[i].background_color_top.split(','))
//          var splitTop = scope.cardsarray[i].background_color_top.split(',');
//
//          cNow1 = splitTop[0]
//          cNow2 = splitTop[1]
//          cNow3 = splitTop[2]
//
//          var splitBottom = scope.cardsarray[i].background_color_bottom.split(',')
//
//          vNow1 = splitBottom[0]
//          vNow2 = splitBottom[1]
//          vNow3 = splitBottom[2]
//        }
//
//        if (scope.cardsarray[i].countCard == cardNumber - 1) {
//          console.log('PRIVIOUS', scope.cardsarray[i])
//          var splitTopPrivious = scope.cardsarray[i].background_color_top.split(',');
//          cPrivious1 = splitTopPrivious[0]
//          cPrivious2 = splitTopPrivious[1]
//          cPrivious3 = splitTopPrivious[2]
//
//          var splitBottomPrivious = scope.cardsarray[i].background_color_bottom.split(',');
//          vPrivious1 = splitBottomPrivious[0]
//          vPrivious2 = splitBottomPrivious[1]
//          vPrivious3 = splitBottomPrivious[2]
//        }
//
//        if (scope.cardsarray[i].countCard == cardNumber + 1) {
//
//          var splitTopNext = scope.cardsarray[i].background_color_top.split(',');
//          cNext1 = splitTopNext[0]
//          cNext2 = splitTopNext[1]
//          cNext3 = splitTopNext[2]
//
//          var splitBottomNext = scope.cardsarray[i].background_color_bottom.split(',');
//          vNext1 = splitBottomNext[0]
//          vNext2 = splitBottomNext[1]
//          vNext3 = splitBottomNext[2]
//        }
//      }
//      scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
//      cNowOriginal1 = cNow1
//      cNowOriginal2 = cNow2
//      cNowOriginal3 = cNow3
//
//      vNowOriginal1 = vNow1
//      vNowOriginal2 = vNow2
//      vNowOriginal3 = vNow3
    }

    //    var leftCard = false, rightCard = false;

    endTouchCarousel = function () {

//      clearInterval(changingColor)

      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 20) {
        changePosition();
      }
      else if (!viewMainPage.myCards) {
        if (!modeOfApp.offlineMode.balance && modeOfApp.onlineMode) {

          console.log("End Touch Carousel", scope.cardNumber);

          scope.cardNumber = (scope.invoiceCheck && scope.cardNumber) ? (scope.cardNumber - 1) : (scope.cardNumber);

          localStorage.setItem("cardNumber", scope.cardNumber);

          pos = (scope.cardNumber) * 540 * widthK;
          var sendChosenCardId;
          console.log("ASD", scope.cardsarray, scope.cardNumber);
          for (var i in scope.cardsarray) {

            if (scope.invoiceCheck) {
              scope.cardsarray[i].countCard--;
            }

            if (scope.cardsarray[i].countCard == scope.cardNumber) {
              scope.cardsarray[i].chosenCard = true;

              sendChosenCardId = scope.cardsarray[i].card_id
              localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));
            }
            else {
              scope.cardsarray[i].chosenCard = false;
            }
          }
          htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + '),' +
            'rgb(' + vNow1 + ',' + vNow2 + ',' + vNow3 + ')150%)';
          riotTags.innerHTML = "<view-my-cards>";
          riot.mount("view-my-cards", [sendChosenCardId]);
          this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.cards.style.transform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
          this.cards.style.webkitTransform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
        }
        else
          modeOfApp.offlineMode.balance = false;
      }
      else
        changePosition()
    }

    moveTouchCarousel = function () {
      event.preventDefault();
      event.stopPropagation();

//      if (scope.whereWasX < event.changedTouches[0].pageX && scope.direction == 1
//        || scope.whereWasX > event.changedTouches[0].pageX && scope.direction == -1) {
//
//
//        if (fromChangableColor1 == cNowOriginal1 && fromChangableColor2 == cNowOriginal2 && fromChangableColor3 == cNowOriginal3 &&
//          toChangableColor1 == vNowOriginal1 && toChangableColor2 == vNowOriginal2 && toChangableColor3 == vNowOriginal3) {
//
//          console.log("ASD", fromChangableColor1, cNext1, cPrivious1, cNowOriginal1);
//
//          if (scope.direction == -1) {
//
//            fromChangableColor1 = cNext1
//            fromChangableColor2 = cNext2
//            fromChangableColor3 = cNext3
//
//            toChangableColor1 = vNext1
//            toChangableColor2 = vNext2
//            toChangableColor3 = vNext3
//
//            console.log("BBB");
//
//          } else {
//
//            fromChangableColor1 = cPrivious1
//            fromChangableColor2 = cPrivious2
//            fromChangableColor3 = cPrivious3
//
//            toChangableColor1 = vPrivious1
//            toChangableColor2 = vPrivious2
//            toChangableColor3 = vPrivious3
//            console.log("GGG");
//          }
//        } else {
//
//          if (fromChangableColor1 == cNext1 || fromChangableColor1 == cPrivious1) {
//            fromChangableColor1 = cNowOriginal1
//            fromChangableColor2 = cNowOriginal2
//            fromChangableColor3 = cNowOriginal3
//
//            toChangableColor1 = vNowOriginal1
//            toChangableColor2 = vNowOriginal2
//            toChangableColor3 = vNowOriginal3
//          }
//        }
//
//        scope.direction *= -1;
//
//        console.log('QQQQ')
//      }
//
//      if (carouselTouchStartX > event.changedTouches[0].pageX && firstEnter) {
//        //to RIGHT
//        scope.direction = 1;
//        rightCard = true;
//        leftCard = false;
//        firstEnter = false;
//        fromChangableColor1 = cNext1
//        fromChangableColor2 = cNext2
//        fromChangableColor3 = cNext3
//
//        toChangableColor1 = vNext1
//        toChangableColor2 = vNext2
//        toChangableColor3 = vNext3
//      }
//
//      if (carouselTouchStartX < event.changedTouches[0].pageX && firstEnter) {
//        //to LEFT
//        scope.direction = -1;
//        rightCard = false;
//        leftCard = true;
//        firstEnter = false;
//        fromChangableColor1 = cPrivious1
//        fromChangableColor2 = cPrivious2
//        fromChangableColor3 = cPrivious3
//
//        toChangableColor1 = vPrivious1
//        toChangableColor2 = vPrivious2
//        toChangableColor3 = vPrivious3
//      }
//
//      if (cNow1 > fromChangableColor1) cNow1--;
//      if (cNow1 < fromChangableColor1) cNow1++;
//      if (cNow2 > fromChangableColor2) cNow2--;
//      if (cNow2 < fromChangableColor2) cNow2++;
//      if (cNow3 > fromChangableColor3) cNow3--;
//      if (cNow3 < fromChangableColor3) cNow3++;
//      if (vNow1 > toChangableColor1) vNow1--;
//      if (vNow1 < toChangableColor1) vNow1++;
//      if (vNow2 > toChangableColor2) vNow2--;
//      if (vNow2 < toChangableColor2) vNow2++;
//      if (vNow3 > toChangableColor3) vNow3--;
//      if (vNow3 < toChangableColor3) vNow3++;
//
//      htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + '),' +
//        'rgb(' + vNow1 + ',' + vNow2 + ',' + vNow3 + ')150%)';
//
//      if (!viewMainPage.myCards) {
//        contacts.style.backgroundColor = 'rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
//        circleMenuId.style.border = '' + 8 * widthK + 'px solid rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
//
//        contactsId.style.backgroundColor = 'rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
//        contactsId.style.border = '' + 2 * widthK + 'px solid rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
//      }


      this.cards.style.transition = '0s';
      this.cards.style.webkitTransition = '0s';
      this.cards.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
      this.cards.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";

      //Test
      //
      //scope.whereWasX = event.changedTouches[0].pageX;
    }

    //    if (modeOfApp.offlineMode) {
    //
    ////        scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
    //      addCard();
    //    }

    //    changeColor = function (index) {
    //      console.log('sss')
    //      var splitTop = scope.cardsarray[index].background_color_top.split(',');
    //      fromChangableColor1 = splitTop[0]
    //      fromChangableColor2 = splitTop[1]
    //      fromChangableColor3 = splitTop[2]
    //
    //      var splitBottom = scope.cardsarray[index].background_color_bottom.split(',');
    //      toChangableColor1 = splitBottom[0]
    //      toChangableColor2 = splitBottom[1]
    //      toChangableColor3 = splitBottom[2]
    //
    //      if (cNow1 != fromChangableColor1)
    //        if (cNow1 > fromChangableColor1) cNow1--;
    //
    //      if (cNow1 != fromChangableColor1)
    //        if (cNow1 < fromChangableColor1) cNow1++;
    //
    //      if (cNow2 != fromChangableColor2)
    //        if (cNow2 > fromChangableColor2) cNow2--;
    //
    //      if (cNow2 != fromChangableColor2)
    //        if (cNow2 < fromChangableColor2) cNow2++;
    //
    //      if (cNow3 != fromChangableColor3)
    //        if (cNow3 > fromChangableColor3) cNow3--;
    //
    //      if (cNow3 != fromChangableColor3)
    //        if (cNow3 < fromChangableColor3) cNow3++;
    //
    //      if (vNow1 != toChangableColor1)
    //        if (vNow1 > toChangableColor1) vNow1--;
    //
    //      if (vNow1 != toChangableColor1)
    //        if (vNow1 < toChangableColor1) vNow1++;
    //
    //      if (vNow2 != toChangableColor2)
    //        if (vNow2 > toChangableColor2) vNow2--;
    //
    //      if (vNow2 != toChangableColor2)
    //        if (vNow2 < toChangableColor2) vNow2++;
    //
    //      if (vNow3 != toChangableColor3)
    //        if (vNow3 > toChangableColor3) vNow3--;
    //
    //      if (vNow3 != toChangableColor3)
    //        if (vNow3 < toChangableColor3) vNow3++;
    //
    //      htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + '),' +
    //        'rgb(' + vNow1 + ',' + vNow2 + ',' + vNow3 + ')150%)';
    //
    //      if (!viewMainPage.myCards) {
    //        contacts.style.backgroundColor = 'rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
    //        circleMenuId.style.border = '' + 8 * widthK + 'px solid rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
    //
    //        contactsId.style.backgroundColor = 'rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
    //        contactsId.style.border = '' + 2 * widthK + 'px solid rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + ')';
    //      }
    //
    //      if (cNow1 == fromChangableColor1 && cNow2 == fromChangableColor2 && cNow3 == fromChangableColor3 &&
    //        vNow1 == toChangableColor1 && vNow2 == toChangableColor2 && vNow3 == toChangableColor3)
    //        clearInterval(changingColor)
    //
    //      if (!fromChangableColor1 || !fromChangableColor2 || !fromChangableColor3 || !toChangableColor1 || !toChangableColor2 || !toChangableColor3)
    //        clearInterval(changingColor)
    ////
    ////      console.log('cNow1', cNow1, 'fromChangableColor1', fromChangableColor1)
    ////      console.log('cNow2', cNow2, 'fromChangableColor2', fromChangableColor2)
    ////      console.log('cNow3', cNow3, 'fromChangableColor3', fromChangableColor3)
    ////      console.log('vNow1', vNow1, 'toChangableColor1', toChangableColor1)
    ////      console.log('vNow2', vNow2, 'toChangableColor2', toChangableColor2)
    ////      console.log('vNow3', vNow3, 'toChangableColor3', toChangableColor3)
    //
    //
    //    }

    //    var changingColor;

    function changePosition() {
//      clearInterval(changingColor);

//      if (!scope.invoiceCheck && count != 0)
//        count -= 1;

      console.log(carouselTouchEndX, carouselTouchStartX, count, count)

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumber < count - 1) {

        console.log("Move Touch Carousel1", scope.cardNumber);

        ++scope.cardNumber;
//        riot.update(scope.cardNumber);
        this.cards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumber == 0) {

        console.log("Move Touch Carousel2", scope.cardNumber);

        this.cards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumber == count - 1) {

        console.log("Move Touch Carousel3", scope.cardNumber);

        this.cards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumber > 0) {

        console.log("Move Touch Carousel4", scope.cardNumber);

        --scope.cardNumber;
//        riot.update(scope.cardNumber);
        this.cards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }


//      for (i in scope.cardsarray) {
//        if (scope.cardsarray[i].countCard == cardNumber)
//          var index = i;
//      }

//      changingColor = setInterval(function () {
//        changeColor(index)
//      }, 4);


      if (viewMainPage.myCards) {
        for (i in scope.cardsarray) {
          if (scope.cardsarray[i].countCard == scope.cardNumber)
            scope.parent.cardInformation(scope.cardsarray[i].card_id);
        }
      }

      localStorage.setItem('cardNumber', scope.cardNumber);
    }

    setTimeout(function () {

      addCard(true)
    }, 0);


  </script>
</component-card-carousel>


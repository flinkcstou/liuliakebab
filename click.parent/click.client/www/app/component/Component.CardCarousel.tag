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
                      background="{(i.card_background_url)?(i.card_background_url):('resources/icons/cards/all.png')}"
                      fontcolor="{i.font_color}"
                      error_message="{i.error_message}"></component-card>
    </div>
  </div>
  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var scope = this;
    scope.invoiceLeft = 100 * widthK;
    scope.invoiceList = [];

    scope.arrayOfPhoneNumbers = [];
    scope.arrayOfFriends = (JSON.parse(localStorage.getItem('click_client_friends')) === null) ? [] : JSON.parse(localStorage.getItem('click_client_friends'));

    scope.showError = false;

    scope.checkSumOfHash = true;

    if (localStorage.getItem('click_client_cards')) {
      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
      scope.update();
      console.log("first card link", JSON.stringify(scope.cardsarray[0]));
    }

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


    //    stopPropagation = function () {
    //
    //      billsHolderTouchEndX = event.changedTouches[0].pageX;
    //
    //      console.log('billsHolderTouchEndX', billsHolderTouchEndX)
    //      console.log('carouselTouchStartX', billsHolderTouchEndX)
    //      if (Math.abs(carouselTouchStartX - billsHolderTouchEndX) < 20) {
    //        event.stopPropagation();
    //        event.preventDefault();
    //        stopPropagationInvoice = true;
    ////        return
    //      }
    //    };

    var touchStartInvoiceOne;
    var touchEndInvoiceOne;

    invoiceBlockTouchStart = function () {
      touchStartInvoiceOne = event.changedTouches[0].pageX;
      console.log('touchStartInvoiceOne', touchStartInvoiceOne)
    };

    invoiceBlockTouchEnd = function (invoice) {

      invoice = JSON.parse(invoice);

      touchEndInvoiceOne = event.changedTouches[0].pageX;

      console.log('touchEndInvoiceOne', touchEndInvoiceOne)

      console.log('START', touchStartInvoiceOne)
      console.log('END', touchEndInvoiceOne)

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
            serviceName: invoice.service_name,
            is_friend_help: invoice.is_friend_help,
            friend_name: invoice.friend_name,
            commission_percent: invoice.commission_percent,
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
        getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));
        var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'))
      }

      if (!scope.checkSumOfHash) {

        scope.cardsarray = {};
      }
      else {
        if (scope.checkSumOfHash) {
          scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
//          var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
//          var idTMP;
//          var countFromDefault;
//          for (var j in scope.cardsarray) {
//            console.log('IN CYCLE SEARCH DEFAULT', scope.cardsarray[j].countCard, scope.cardsarray[j].default_account)
//            if (scope.cardsarray[j].countCard == 0 && scope.cardsarray[j].default_account === false) {
//              idTMP = j;
//              console.log('idTMP', idTMP)
//              countFromDefault = scope.cardsarray[loginInfo.default_account].countCard;
//
//            }
//          }
//
//          if (idTMP) {
//            console.log('idTMP', idTMP)
//            scope.cardsarray[loginInfo.default_account].countCard = 0;
//            console.log('FOUND', scope.cardsarray[loginInfo.default_account])
//            scope.cardsarray[idTMP].countCard = countFromDefault;
//            console.log('FOUND', scope.cardsarray[idTMP])
//            localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));
//          }
//
//          scope.cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
//
//          console.log('DEFAULT PROBLEM ', JSON.parse(localStorage.getItem("click_client_cards")))


//          console.log("CARDS ARRAY AFTER HASH SUM", scope.cardsarray)
//
//          if (scope.invoiceCheck && viewMainPage.atMainPage) {
//            count = 1;
//            var tmpCount = count;
//
//            for (var i in scope.cardsarray) {
//              scope.cardsarray[i].countCard = scope.cardsarray[i].countCard + count;
//              if (scope.cardsarray[i].countCard >= tmpCount)
//                tmpCount = scope.cardsarray[i].countCard;
//            }
//            count = tmpCount + 1;
//
//            localStorage.setItem('click_client_countCard', count)
//            localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray))
//
//            console.log('CARD NUMBER', scope.cardNumber)
//
//          }
//          else {
//            if (!viewMainPage.atMainPage)
//              count = 1;
//            else {
//              if (viewMainPage.atMainPage && !scope.invoiceCheck) {
//                count = 1
//              }
//            }
//            var tmpCount = count;
//
//            for (var i in scope.cardsarray) {
//              scope.cardsarray[i].countCard = scope.cardsarray[i].countCard + count;
//              if (scope.cardsarray[i].countCard >= tmpCount)
//                tmpCount = scope.cardsarray[i].countCard;
//            }
//            count = tmpCount + 1;
//          }
//          scope.update()
        }
//        else {
//          if (!viewMainPage.atMainPage)
//            count = 1;
//        }
//        localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray))
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
        count = 1;
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
            salary: '',
            error_message: null,
            countCard: getAccountsCards[i].countCard,
            currency: getAccountsCards[i].currency_name.trim(),
            numberPartOne: numberOfCardPartOne,
            numberPartTwo: numberOfCardPartTwo,
            url: getAccountsCards[i].image_url,
            card_background_url: getAccountsCards[i].card_background_url,
            chosenCard: defaultAccount,
            default_account: defaultAccount,
            access: getAccountsCards[i].access,
            background_color_bottom: getAccountsCards[i].background_color_bottom,
            background_color_top: getAccountsCards[i].background_color_top,
            font_color: getAccountsCards[i].font_color,
            removable: getAccountsCards[i].removable,
          };

          scope.cardsarray[getAccountsCards[i].id] = card;


          localStorage.setItem("click_client_cards", JSON.stringify(scope.cardsarray));

          count++;

//        cardNumber %= count;
          localStorage.setItem('click_client_countCard', count);
//        localStorage.setItem('cardNumber', cardNumber);
        }
      }

      scope.update()

//      scope.update(scope.cardsarray);
      if (!modeOfApp.offlineMode && localStorage.getItem('click_client_accountInfo') && !withoutBalance) {
        writeBalance();
        scope.update()
      } else {
        if (invoice)
          scope.update();
      }
    };

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
            if (result[1]) {
              if (result[1][0]) {
                if (result[1].length != 0) {
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
                }

//                scope.update(scope.invoiceCheck);
//                scope.update(scope.cardNumber);
                var arrayOfInvoice = [];
                for (var i = 0; i < result[1].length; i++) {

                  //TODO: FIX
                  try {
                    result[1][i].amount = window.amountTransform(result[1][i].amount.toString());
                    if (result[1][i].is_friend_help && scope.arrayOfFriends.length != 0) {
                      for (var j = 0; j < scope.arrayOfFriends.length; j++) {
                        if (scope.arrayOfFriends[j].number === result[1][i].merchant_phone) {
                          console.log("friend name assigning", result[1][i].friend_name)
                          result[1][i].friend_name = scope.arrayOfFriends[j].name;
                        }
                      }
                    }


                  } catch (error) {

                    console.log(error);
                  }

                  arrayOfInvoice.push(result[1][i]);
                }

                localStorage.setItem('click_client_invoice_list', JSON.stringify(arrayOfInvoice));

                if (scope.invoiceList) {

                  if (arrayOfInvoice[0]) {
                    scope.invoiceList.push(arrayOfInvoice[0]);
                  }

                  if (arrayOfInvoice[1]) {
                    scope.invoiceList.push(arrayOfInvoice[1]);
                  }
                }

                if (scope.invoiceList)
                  setTimeout(function () {
                    addCard()
//                  scope.update()
                  }, 0);
              }
              else {
                scope.invoiceCheck = false;
                scope.cardNumber = 1;
                scope.update();
              }
            }
            else {
              scope.invoiceCheck = false;
              scope.cardNumber = 1;
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


    function onSuccess(contacts) {
      //      alert('Found ' + contacts.length + ' contacts.');

//      for (var i in contacts) {
//        var personObj = {};
//        if (contacts[i].phoneNumbers) {
//          personObj.phone = [];
//          for (var k in contacts[i].phoneNumbers) {
//            //console.log("phoneNumber", window.inputVerification.spaceDeleter(contacts[i].phoneNumbers[k].value));
//
//            personObj.phone.push(window.inputVerification.spaceDeleter(contacts[i].phoneNumbers[k].value))
//          }
//        }
//        else {
//          continue
//        }
//        if (contacts[i].name && contacts[i].name.familyName)
//          personObj.lastname = contacts[i].name.familyName
//
//        if (contacts[i].name && contacts[i].name.givenName)
//          personObj.firstname = contacts[i].name.givenName
//
//        //console.log("personObj=", JSON.stringify(personObj))
//        scope.arrayOfPhoneNumbers.push(personObj)
//      }

//      if (typeof scope.arrayOfPhoneNumbers === 'undefined' || scope.arrayOfPhoneNumbers.length < 1) return
//
//
//      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
//      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
//      var sessionKey = info.session_key;

//      window.api.call({
//        method: 'check.contact.list',
//        input: {
//          phone_num: phoneNumber,
//          phone_list: scope.arrayOfPhoneNumbers,
//          session_key: sessionKey,
//
//        },
//
//        scope: this,
//
//        onSuccess: function (result) {
//          if (result[0][0].error == 0) {
//            console.log("contact list checker method", result);
//            var object = {};
//            var counter = 0;
//
//            if (result[1][0])
//              for (var i in result[1][0].phone_list) {
//                object = {}
//                if (!result[1][0].phone_list[i].phone) {
//                  continue
//                }
//                if (result[1][0].phone_list[i].firstname && result[1][0].phone_list[i].lastname)
//                  object.name = result[1][0].phone_list[i].firstname + " " + result[1][0].phone_list[i].lastname;
//                else {
//                  if (result[1][0].phone_list[i].firstname)
//                    object.name = result[1][0].phone_list[i].firstname;
//                  else {
//                    if (result[1][0].phone_list[i].lastname) {
//                      object.name = result[1][0].phone_list[i].lastname
//                    }
//                    else {
//                      object.name = 'Неизвестно'
//                    }
//                  }
//                }
//                object.number = result[1][0].phone_list[i].phone;
//                if (object.name)
//                  object.firstLetterOfName = object.name[0].toUpperCase();
//                object.photo = null;
//                counter++;
//
//                scope.arrayOfFriends.push(object);
//              }
//
//            localStorage.setItem('click_client_friends', JSON.stringify(scope.arrayOfFriends))
//            localStorage.setItem('click_client_friendsOuter_count', counter);
//            scope.update();
//          }
//          else {
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//            scope.showError = true;
//            scope.viewPage = ''
//            scope.update();
//          }
//        },
//
//        onFail: function (api_status, api_status_message, data) {
//          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//          console.error(data);
//        }
//      });
    }


    function onError(contactError) {
      //      alert('onError!');
      console.log('error', contactError)
    }


    // if (!localStorage.getItem('click_client_friendsOuter_count')) {

//    if (device.platform != 'BrowserStand') {
//      var options = new ContactFindOptions();
//      options.multiple = true;
//      options.hasPhoneNumber = true;
//      navigator.contacts.find(["phoneNumbers"], onSuccess, onError, options);
//    }
    //}


    cardImagesCaching = function () {
      if (device.platform != 'BrowserStand') {

        window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
          var j = -1, count = 0;
          for (var i = 0; i < arrayAccountInfo.length; i++) {
            j++;

            var icon = arrayAccountInfo[i].card_background_url;
            var filename = icon.substr(icon.lastIndexOf('/') + 1);

            var newIconBool = checkImageURL;
            newIconBool('www/resources/icons/cards/', 'cards', filename, icon, j, function (bool, index, fileName) {
              if (bool) {
                count++;
                arrayAccountInfo[index].card_background_url = cordova.file.dataDirectory + fileName;
              } else {
                count++;
                arrayAccountInfo[index].card_background_url = 'resources/icons/cards/' + fileName;
              }

              var icon2 = arrayAccountInfo[index].image_url;
              var filename2 = icon2.substr(icon2.lastIndexOf('/') + 1);
              var newIcon = checkImageURL;
              newIcon('www/resources/icons/cards/logo/', 'logo', filename2, icon2, index, function (bool2, index2, fileName2) {
                if (bool2) {
                  count++;
                  arrayAccountInfo[index2].image_url = cordova.file.dataDirectory + fileName2;
                } else {
                  count++;
                  arrayAccountInfo[index2].image_url = 'resources/icons/cards/logo/' + fileName2;
                }

                if (count == (arrayAccountInfo.length * 2)) {
                  console.log("Caching card images");
                  localStorage.setItem("click_client_accountInfo", JSON.stringify(arrayAccountInfo));
                }
              });
            });
          }
        }, onErrorLoadFs);
      }
    };

    var arrayAccountInfo = [];

    scope.onComponentCreated = onComponentCreated = function (cardNumberParameter) {

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

              if (result[0][0].error == 0) {
                if (localStorage.getItem('click_client_cards')) {
                  var cardsArray = JSON.parse(localStorage.getItem('click_client_cards'));
                  var countLocalStorageCard = 0;
                  for (var k in cardsArray) {
                    countLocalStorageCard++;
                  }
                  if (countLocalStorageCard == result[1].length) {
                    for (var i in result[1]) {
                      if (cardsArray[result[1][i].id]) {
                        if (cardsArray[result[1][i].id].checksum != result[1][i].checksum) {
                          if (device.platform != 'BrowserStand') {
                            var options = {dimBackground: true};

                            SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                              console.log("Spinner start in card carousel");
                            }, function () {
                              console.log("Spinner stop in card carousel");
                            });
                          }
                          scope.checkSumOfHash = false;
                        }
                      }
                      else {
                        if (device.platform != 'BrowserStand') {
                          var options = {dimBackground: true};

                          SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                            console.log("Started");
                          }, function () {
                            console.log("closed");
                          });
                        }
                        scope.checkSumOfHash = false;
                      }
                    }
                  }
                  else {
                    if (device.platform != 'BrowserStand') {
                      var options = {dimBackground: true};

                      SpinnerPlugin.activityStart(languages.Downloading, options, function () {
                        console.log("Started");
                      }, function () {
                        console.log("closed");
                      });
                    }
                    scope.checkSumOfHash = false;
                  }
                }
                else {
                  scope.checkSumOfHash = false;
                }

                if (!scope.checkSumOfHash || info.update_account_cache) {
                  var countCard = 2;
                  var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));

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
                  var accountInfo = JSON.stringify(arrayAccountInfo);
                  if (JSON.parse(localStorage.getItem("click_client_accountInfo"))) {
                    localStorage.removeItem("click_client_accountInfo")
                  }

                  localStorage.setItem("click_client_accountInfo", accountInfo);

                  cardImagesCaching();

                  setTimeout(function () {
                    addCard()
                  }, 0);

                  info.update_account_cache = false;
                  localStorage.setItem('click_client_loginInfo', info);

                  if (device.platform != 'BrowserStand') {
                    console.log("Spinner Stop Component Card Carousel 650");
                    SpinnerPlugin.activityStop();
                  }
                }
                else {
                  setTimeout(function () {
                    if (device.platform != 'BrowserStand') {
                      console.log("Spinner Stop Component Card Carousel 657");
                      SpinnerPlugin.activityStop();
                    }
                    addCard()
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


    if (viewMainPage.atMainPage && !modeOfApp.demoVersion && modeOfApp.onlineMode) {
      invoiceCheckFunction();
    }


    onComponentCreated();

    scope.switchToOfflineMode = function () {

      scope.invoiceList = [];
      scope.invoiceCheck = false;

      console.log("THERE IS NO CARDS IN LOCALSTORAGE");
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
//      console.log("CARDS", JSON.parse(localStorage.getItem("click_client_cards")))

//      if (!scope.invoiceCheck) {
//        count = 0;
//        scope.cardNumber = 1;
//        for (var i in scope.cardsarray) {
//          scope.cardsarray[i].countCard = count;
//          count++;
//        }
//      }

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

      if (getAccountsCards.length == 0) {
        if (localStorage.getItem('click_client_cards'))
          getAccountsCards = JSON.parse(localStorage.getItem('click_client_cards'))
      }

      for (var i in getAccountsCards) {
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

                  if (scope.cardsarray[result[1][0].account_id])
                    scope.cardsarray[result[1][0].account_id].salaryOriginal = result[1][0].balance.toFixed(0);

                  result[1][0].balance = result[1][0].balance.toFixed(0).toString();

                  if (result[1][0].balance != 0)
                    result[1][0].balance = window.amountTransform(result[1][0].balance.toString());

                  scope.cardsarray[result[1][0].account_id].salary = result[1][0].balance;
                  localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));

                  scope.update();

                }
                catch (error) {
                  console.log(error)
                }

              }
            }
            else {

              console.log("STOP STOP STOP")

              if (scope.cardsarray[result[1][0].account_id]) {
                scope.cardsarray[result[1][0].account_id].salary = null;
                scope.cardsarray[result[1][0].account_id].error_message = "Ошибка баланса";
                localStorage.setItem('click_client_cards', JSON.stringify(scope.cardsarray));
              }
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
      scope.cardNumber = 1;
    }
    //    riot.update(scope.cardNumber);

    var pos = 0;
    var count = localStorage.getItem('click_client_countCard');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    if (!count)
      count = 1;

    //    if (!viewMainPage.atMainPage) {
    //      scope.cardNumber = 0;
    ////      count = 0;
    //    }

    var cNow1, cNow2, cNow3, vNow1, vNow2, vNow3;
    var cNext1, cNext2, cNext3, vNext1, vNext2, vNext3;
    var cPrivious1, cPrivious2, cPrivious3, vPrivious1, vPrivious2, vPrivious3;
    var fromChangableColor1, fromChangableColor2, fromChangableColor3, toChangableColor1, toChangableColor2,
      toChangableColor3;
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
      event.preventDefault()
      event.stopPropagation()

      console.log('Carousel Touch End', event)

//      clearInterval(changingColor)

      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 20) {
        changePositionCardCarousel();
      }
      else if (!viewMainPage.myCards && !(scope.invoiceCheck && scope.cardNumber == 0)) {
        if (!modeOfApp.offlineMode.balance && modeOfApp.onlineMode) {

          if (scope.invoiceCheck && scope.cardNumber == 0)
            scope.cardNumber = 1;
          console.log("End Touch Carousel", scope.cardNumber);

//          scope.cardNumber = (scope.invoiceCheck && scope.cardNumber) ? (scope.cardNumber - 2) : (scope.cardNumber);

          localStorage.setItem("cardNumber", scope.cardNumber);

          pos = (scope.cardNumber) * 540 * widthK;
          var sendChosenCardId;
          console.log("CARD CARD CARD", scope.cardsarray);

          for (var i in scope.cardsarray) {
            if (scope.cardsarray[i].countCard == scope.cardNumber) {
              sendChosenCardId = i;
              break;
            }

          }

//          htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + '),' +
//            'rgb(' + vNow1 + ',' + vNow2 + ',' + vNow3 + ')150%)';
          riotTags.innerHTML = "<view-my-cards>";
          riot.mount("view-my-cards", [sendChosenCardId]);
          document.getElementById('cards').style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          document.getElementById('cards').style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          document.getElementById('cards').style.transform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
          document.getElementById('cards').style.webkitTransform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
        }
        else
          modeOfApp.offlineMode.balance = false;
      }
      else
        changePositionCardCarousel()
    }

    moveTouchCarousel = function () {
      event.preventDefault()
      event.stopPropagation()

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


      document.getElementById('cards').style.transition = '0s';
      document.getElementById('cards').style.webkitTransition = '0s';
      document.getElementById('cards').style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
      document.getElementById('cards').style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";

      //Test
      //
      //scope.whereWasX = event.changedTouches[0].pageX;
    };

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

    scope.changePositionCardCarousel = changePositionCardCarousel = function () {
      if (event) {
        event.preventDefault()
        event.stopPropagation()
      }
//      clearInterval(changingColor);
//      if (!scope.invoiceCheck && count != 0)
//        count -= 1;

      if (scope.invoiceCheck) {
        var invoiceVar = 0;
      }
      else {
        var invoiceVar = 1;
      }

      console.log(carouselTouchEndX, carouselTouchStartX, count, scope.cardNumber)

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumber < count - 1) {

        console.log("Move Touch Carousel1", scope.cardNumber);

        ++scope.cardNumber;
//        riot.update(scope.cardNumber);
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

        --scope.cardNumber;
//        riot.update(scope.cardNumber);
        document.getElementById('cards').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById('cards').style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        document.getElementById('cards').style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }

//      for (i in scope.cardsarray) {
//        if (scope.cardsarray[i].countCard == cardNumber)
//          var index = i;
//      }
//      changingColor = setInterval(function () {
//        changeColor(index)
//      }, 4);

      if (viewMainPage.myCards) {
        for (var i in scope.cardsarray) {
          if (scope.cardsarray[i].countCard == scope.cardNumber) {
            scope.parent.cardInformation(scope.cardsarray[i].card_id);
          }
        }
      }

      localStorage.setItem('cardNumber', scope.cardNumber);

    }

  </script>
</component-card-carousel>


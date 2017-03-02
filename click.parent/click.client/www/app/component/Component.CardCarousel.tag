<component-card-carousel>

  <div id="containerCard" class="card-carousel" ontouchend="endTouchCarousel()" ontouchmove="moveTouchCarousel()"
       ontouchstart="startTouchCarousel()">
    <div id="cards" class="cards">

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

  <script>


    this.on('mount', function () {
//      clearInterval(changingColor);

      console.log('cardsarray', cardsarray)
      localStorage.setItem('click_client_cards', JSON.stringify(cardsarray));
//      copyCardsArray = JSON.parse(JSON.stringify(cardsarray));
//      console.log(copyCardsArray, defaultAccountId)
//
//      var splitTop = copyCardsArray[defaultAccountId].background_color_top.split(',')
//
//      cMount1 = splitTop[0]
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
      console.log(modeOfApp.offlineMode)

      cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      if (!modeOfApp.offlineMode) {
        writeBalance();
      }
    })

    //
    writeBalance = function () {
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
          //TODO: DO CARDS
          scope: this,
          onSuccess: function (result) {
            if (result[0][0].error == 0) {
              if (result[1][0]) {
                cardsarray[result[1][0].account_id].salaryOriginal = result[1][0].balance.toFixed(0);

                result[1][0].balance = result[1][0].balance.toFixed(0).toString();

                if (result[1][0].balance.length == 9) {
                  result[1][0].balance = result[1][0].balance.substring(0, 3) + ' ' +
                    result[1][0].balance.substring(3, 6) + ' ' + result[1][0].balance.substring(6, result[1][0].balance.length)
                }

                if (result[1][0].balance.length == 8) {
                  result[1][0].balance = result[1][0].balance.substring(0, 2) + ' ' +
                    result[1][0].balance.substring(2, 5) + ' ' + result[1][0].balance.substring(5, result[1][0].balance.length)
                }

                if (result[1][0].balance.length == 7) {
                  result[1][0].balance = result[1][0].balance.substring(0, 1) + ' ' +
                    result[1][0].balance.substring(1, 4) + ' ' + result[1][0].balance.substring(4, result[1][0].balance.length)
                }

                if (result[1][0].balance.length == 6) {
                  result[1][0].balance = result[1][0].balance.substring(0, 3) + ' ' +
                    result[1][0].balance.substring(3, result[1][0].balance.length)

                }

                if (result[1][0].balance.length == 5) {
                  result[1][0].balance = result[1][0].balance.substring(0, 2) + ' ' +
                    result[1][0].balance.substring(2, result[1][0].balance.length)

                }

                if (result[1][0].balance.length == 4) {
                  result[1][0].balance = result[1][0].balance.substring(0, 1) + ' ' +
                    result[1][0].balance.substring(1, result[1][0].balance.length)

                }
                cardsarray[result[1][0].account_id].salary = result[1][0].balance;
                localStorage.setItem('click_client_cards', JSON.stringify(cardsarray));
                riot.update();
              }
            }
            else
              alert(result[0][0].error_note);
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    }

    var scope = this;
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));
    var defaultAccountId;

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = info.session_key;

    var carouselTouchStartX, carouselTouchEndX;
    cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));

    if (!cardsarray) {
      cardsarray = {};
    }


    var card;
    var cardNumber = JSON.parse(localStorage.getItem('cardNumber'));


    if (!cardNumber) {
      cardNumber = 0;
    }


    var pos = 0;
    var count = localStorage.getItem('click_client_countCard');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    console.log('DDDDDDDD', loginInfo)
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
      carouselTouchStartX = event.changedTouches[0].pageX;
      left = -((540 * cardNumber) * widthK) - carouselTouchStartX;
      delta = left;
//
//      for (var i in cardsarray) {
//        if (cardsarray[i].countCard == cardNumber) {
//          console.log('SPLIT SPLIT ', cardsarray[i].background_color_top.split(','))
//          var splitTop = cardsarray[i].background_color_top.split(',');
//
//          cNow1 = splitTop[0]
//          cNow2 = splitTop[1]
//          cNow3 = splitTop[2]
//
//          var splitBottom = cardsarray[i].background_color_bottom.split(',')
//
//          vNow1 = splitBottom[0]
//          vNow2 = splitBottom[1]
//          vNow3 = splitBottom[2]
//        }
//
//        if (cardsarray[i].countCard == cardNumber - 1) {
//          console.log('PRIVIOUS', cardsarray[i])
//          var splitTopPrivious = cardsarray[i].background_color_top.split(',');
//          cPrivious1 = splitTopPrivious[0]
//          cPrivious2 = splitTopPrivious[1]
//          cPrivious3 = splitTopPrivious[2]
//
//          var splitBottomPrivious = cardsarray[i].background_color_bottom.split(',');
//          vPrivious1 = splitBottomPrivious[0]
//          vPrivious2 = splitBottomPrivious[1]
//          vPrivious3 = splitBottomPrivious[2]
//        }
//
//        if (cardsarray[i].countCard == cardNumber + 1) {
//
//          var splitTopNext = cardsarray[i].background_color_top.split(',');
//          cNext1 = splitTopNext[0]
//          cNext2 = splitTopNext[1]
//          cNext3 = splitTopNext[2]
//
//          var splitBottomNext = cardsarray[i].background_color_bottom.split(',');
//          vNext1 = splitBottomNext[0]
//          vNext2 = splitBottomNext[1]
//          vNext3 = splitBottomNext[2]
//        }
//      }
//      cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
//      cNowOriginal1 = cNow1
//      cNowOriginal2 = cNow2
//      cNowOriginal3 = cNow3
//
//      vNowOriginal1 = vNow1
//      vNowOriginal2 = vNow2
//      vNowOriginal3 = vNow3
    }

    var leftCard = false, rightCard = false;

    endTouchCarousel = function () {

//      clearInterval(changingColor)

      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 20) {
        changePosition();
      }
      else if (!viewMainPage.myCards) {
        if (!modeOfApp.offlineMode.balance) {
          pos = (cardNumber) * 540 * widthK;
          var sendChosenCardId;
          for (var i in cardsarray) {
            if (cardsarray[i].countCard == cardNumber) {
              cardsarray[i].chosenCard = true;
              sendChosenCardId = cardsarray[i].card_id
              localStorage.setItem('click_client_cards', JSON.stringify(cardsarray));
            }
            else {
              cardsarray[i].chosenCard = false;
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

    addCard(getAccountsCards)
    {
      var numberOfCardPartOne;
      var numberOfCardPartTwo;
      var typeOfCard;

      if (count == 0)
        for (var i = 0; i < getAccountsCards.length; i++) {


          if (getAccountsCards[i].access == 0) break;
          if (loginInfo.default_account == getAccountsCards[i].id) {
            var defaultAccount = true;
          }
          else
            defaultAccount = false;


          numberOfCardPartOne = getAccountsCards[i].accno[0] + getAccountsCards[i].accno[1]
            + getAccountsCards[i].accno[2] + getAccountsCards[i].accno[3]
          numberOfCardPartTwo = getAccountsCards[i].accno[getAccountsCards[i].accno.length - 4] + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 3] + +getAccountsCards[i].accno[getAccountsCards[i].accno.length - 2] + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 1];

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


          cardsarray[getAccountsCards[i].id] = card;

          localStorage.setItem("click_client_cards", JSON.stringify(cardsarray));

          count++;
          localStorage.setItem('click_client_countCard', count);
        }

    }
    if (localStorage.getItem('click_client_accountInfo')) {
      for (var i = 0; i < getAccountsCards.length; i++) {
        console.log(getAccountsCards[i].id, loginInfo.default_account)
        if (getAccountsCards[i].id == loginInfo.default_account) {
          defaultAccountId = getAccountsCards[i].id;
          var tmp = getAccountsCards[0];
          getAccountsCards[0] = getAccountsCards[i];
          getAccountsCards[i] = tmp;
        }
      }
      scope.addCard(getAccountsCards);
    }

//    changeColor = function (index) {
//      console.log('sss')
//      var splitTop = cardsarray[index].background_color_top.split(',');
//      fromChangableColor1 = splitTop[0]
//      fromChangableColor2 = splitTop[1]
//      fromChangableColor3 = splitTop[2]
//
//      var splitBottom = cardsarray[index].background_color_bottom.split(',');
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

      if (carouselTouchEndX < carouselTouchStartX && cardNumber < count - 1) {
        ++cardNumber;
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && cardNumber == 0) {
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX < carouselTouchStartX && cardNumber == count - 1) {
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && cardNumber > 0) {
        --cardNumber;
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      }


//      for (i in cardsarray) {
//        if (cardsarray[i].countCard == cardNumber)
//          var index = i;
//      }

//      changingColor = setInterval(function () {
//        changeColor(index)
//      }, 4);


      if (viewMainPage.myCards) {
        for (i in cardsarray) {
          if (cardsarray[i].countCard == cardNumber)
            scope.parent.cardInformation(cardsarray[i].card_id);
        }
      }

      localStorage.setItem('cardNumber', cardNumber);
    }


  </script>
</component-card-carousel>


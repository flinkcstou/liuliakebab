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
                      background="{i.card_background_url}"></component-card>
    </div>
  </div>

  <script>


    this.on('mount', function () {
      console.log('cardsarray', cardsarray)
      localStorage.setItem('click_client_cards', JSON.stringify(cardsarray));
      copyCardsArray = JSON.parse(JSON.stringify(cardsarray));

      var nn, nn2;
      var vv, vv2;

      nn = copyCardsArray[defaultAccountId].background_color_top.indexOf(',') + 1;
      cNow1 = copyCardsArray[defaultAccountId].background_color_top.substring(0, nn - 1);
      copyCardsArray[defaultAccountId].background_color_top = copyCardsArray[defaultAccountId].background_color_top.substring(nn, copyCardsArray[defaultAccountId].background_color_top.length)
      nn2 = copyCardsArray[defaultAccountId].background_color_top.indexOf(',') + 1;
      cNow2 = copyCardsArray[defaultAccountId].background_color_top.substring(0, nn2 - 1);
      copyCardsArray[defaultAccountId].background_color_top = copyCardsArray[defaultAccountId].background_color_top.substring(nn2, copyCardsArray[defaultAccountId].background_color_top.length)
      cNow3 = copyCardsArray[defaultAccountId].background_color_top.substring(0, copyCardsArray[defaultAccountId].background_color_top.length);

      vv = copyCardsArray[defaultAccountId].background_color_bottom.indexOf(',') + 1;
      vNow1 = copyCardsArray[defaultAccountId].background_color_bottom.substring(0, vv - 1);
      copyCardsArray[defaultAccountId].background_color_bottom = copyCardsArray[defaultAccountId].background_color_bottom.substring(vv, copyCardsArray[defaultAccountId].background_color_bottom.length)
      vv2 = copyCardsArray[defaultAccountId].background_color_bottom.indexOf(',') + 1;
      vNow2 = copyCardsArray[defaultAccountId].background_color_bottom.substring(0, vv2 - 1);
      copyCardsArray[defaultAccountId].background_color_bottom = copyCardsArray[defaultAccountId].background_color_bottom.substring(vv2, copyCardsArray[defaultAccountId].background_color_bottom.length)
      vNow3 = copyCardsArray[defaultAccountId].background_color_bottom.substring(0, copyCardsArray[defaultAccountId].background_color_bottom.length);

      htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + '),' +
        'rgb(' + vNow1 + ',' + vNow2 + ',' + vNow3 + '))';

      cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      cards.style.transform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      cards.style.webkitTransform = "translate3d(" + (-cardNumber * 540) * widthK + 'px' + ", 0, 0)";
      console.log(modeOfflineMode.check)

      if (!modeOfflineMode.check) {
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
    if (!count)
      count = 0;

    var cNow1, cNow2, cNow3, vNow1, vNow2, vNow3;
    var cNext1, cNext2, cNext3, vNext1, vNext2, vNext3;
    var cPrivious1, cPrivious2, cPrivious3, vPrivious1, vPrivious2, vPrivious3;
    var formChangableColor1, formChangableColor2, formChangableColor3, toChangableColor1, toChangableColor2, toChangableColor3;

    var firstEnter;

    startTouchCarousel = function () {
      firstEnter = true;
      carouselTouchStartX = event.changedTouches[0].pageX;
      left = -((540 * cardNumber) * widthK) - carouselTouchStartX;
      delta = left;

      var n, n1, n2;

      for (var i in cardsarray) {
        if (cardsarray[i].countCard == cardNumber) {
          n = cardsarray[i].background_color_top.indexOf(',') + 1;
          cNow1 = cardsarray[i].background_color_top.substring(0, n - 1);
          cardsarray[i].background_color_top = cardsarray[i].background_color_top.substring(n, cardsarray[i].background_color_top.length)
          n2 = cardsarray[i].background_color_top.indexOf(',') + 1;
          cNow2 = cardsarray[i].background_color_top.substring(0, n2 - 1);
          cardsarray[i].background_color_top = cardsarray[i].background_color_top.substring(n2, cardsarray[i].background_color_top.length)
          cNow3 = cardsarray[i].background_color_top.substring(0, cardsarray[i].background_color_top.length);

          v = cardsarray[i].background_color_bottom.indexOf(',') + 1;
          vNow1 = cardsarray[i].background_color_bottom.substring(0, v - 1);
          cardsarray[i].background_color_bottom = cardsarray[i].background_color_bottom.substring(v, cardsarray[i].background_color_bottom.length)
          v2 = cardsarray[i].background_color_bottom.indexOf(',') + 1;
          vNow2 = cardsarray[i].background_color_bottom.substring(0, v2 - 1);
          cardsarray[i].background_color_bottom = cardsarray[i].background_color_bottom.substring(v2, cardsarray[i].background_color_bottom.length)
          vNow3 = cardsarray[i].background_color_bottom.substring(0, cardsarray[i].background_color_bottom.length);
        }

        if (cardsarray[i].countCard == cardNumber - 1) {
          console.log('PRIVIOUS', cardsarray[i])
          n = cardsarray[i].background_color_top.indexOf(',') + 1;
          cPrivious1 = cardsarray[i].background_color_top.substring(0, n - 1);
          cardsarray[i].background_color_top = cardsarray[i].background_color_top.substring(n, cardsarray[i].background_color_top.length)
          n2 = cardsarray[i].background_color_top.indexOf(',') + 1;
          cPrivious2 = cardsarray[i].background_color_top.substring(0, n2 - 1);
          cardsarray[i].background_color_top = cardsarray[i].background_color_top.substring(n2, cardsarray[i].background_color_top.length)
          cPrivious3 = cardsarray[i].background_color_top.substring(0, cardsarray[i].background_color_top.length);

          v = cardsarray[i].background_color_bottom.indexOf(',') + 1;
          vPrivious1 = cardsarray[i].background_color_bottom.substring(0, v - 1);
          cardsarray[i].background_color_bottom = cardsarray[i].background_color_bottom.substring(v, cardsarray[i].background_color_bottom.length)
          v2 = cardsarray[i].background_color_bottom.indexOf(',') + 1;
          vPrivious2 = cardsarray[i].background_color_bottom.substring(0, v2 - 1);
          cardsarray[i].background_color_bottom = cardsarray[i].background_color_bottom.substring(v2, cardsarray[i].background_color_bottom.length)
          vPrivious3 = cardsarray[i].background_color_bottom.substring(0, cardsarray[i].background_color_bottom.length);
        }

        if (cardsarray[i].countCard == cardNumber + 1) {
          console.log('NEXT', cardsarray[i])
          n = cardsarray[i].background_color_top.indexOf(',') + 1;
          cNext1 = cardsarray[i].background_color_top.substring(0, n - 1);
          cardsarray[i].background_color_top = cardsarray[i].background_color_top.substring(n, cardsarray[i].background_color_top.length)
          console.log('BEFORE N2', cardsarray[i].background_color_top)
          n2 = cardsarray[i].background_color_top.indexOf(',') + 1;
          cNext2 = cardsarray[i].background_color_top.substring(0, n2 - 1);
          cardsarray[i].background_color_top = cardsarray[i].background_color_top.substring(n2, cardsarray[i].background_color_top.length)
          cNext3 = cardsarray[i].background_color_top.substring(0, cardsarray[i].background_color_top.length);

          v = cardsarray[i].background_color_bottom.indexOf(',') + 1;
          vNext1 = cardsarray[i].background_color_bottom.substring(0, v - 1);
          cardsarray[i].background_color_bottom = cardsarray[i].background_color_bottom.substring(v, cardsarray[i].background_color_bottom.length)
          v2 = cardsarray[i].background_color_bottom.indexOf(',') + 1;
          vNext2 = cardsarray[i].background_color_bottom.substring(0, v2 - 1);
          cardsarray[i].background_color_bottom = cardsarray[i].background_color_bottom.substring(v2, cardsarray[i].background_color_bottom.length)
          vNext3 = cardsarray[i].background_color_bottom.substring(0, cardsarray[i].background_color_bottom.length);
        }
      }
      cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));
    }

    var leftCard = false, rightCard = false;

    endTouchCarousel = function () {

      console.log('cNext1', cNext1)
      console.log('cNext2', cNext2)
      console.log('cNext3', cNext3)
      console.log('vNext1', vNext1)
      console.log('vNext2', vNext2)
      console.log('vNext3', vNext3)

      console.log('cPrivious1', cPrivious1)
      console.log('cPrivious2', cPrivious2)
      console.log('cPrivious3', cPrivious3)
      console.log('vPrivious1', vPrivious1)
      console.log('vPrivious2', vPrivious2)
      console.log('vPrivious3', vPrivious3)

      if (rightCard)
        htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNext1 + ',' + cNext2 + ',' + cNext3 + '),rgb(' + vNext1 + ',' + vNext2 + ',' + vNext3 + '))';
      if (leftCard)
        htmlId.style.background = '-webkit-linear-gradient(rgb(' + cPrivious1 + ',' + cPrivious2 + ',' + cPrivious3 + '),rgb(' + vPrivious1 + ',' + vPrivious2 + ',' + vPrivious3 + '))';
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 20) {
        changePosition();
      }
      else if (!viewMainPage.myCards) {
        if (!modeOfflineMode.balance) {
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
          riotTags.innerHTML = "<view-my-cards>";
          riot.mount("view-my-cards", [sendChosenCardId]);
          this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.cards.style.transform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
          this.cards.style.webkitTransform = "translate3d(" + (-pos) + 'px' + ", 0, 0)";
        }
        else
          modeOfflineMode.balance = false;
      }
      else
        changePosition()
    }

    moveTouchCarousel = function () {
      event.preventDefault();
      event.stopPropagation();
      if (carouselTouchStartX > event.changedTouches[0].pageX && firstEnter) {
        //to RIGHT
        rightCard = true;
        leftCard = false;
        formChangableColor1 = cNext1
        formChangableColor2 = cNext2
        formChangableColor3 = cNext3

        toChangableColor1 = vNext1
        toChangableColor2 = vNext2
        toChangableColor3 = vNext3
        firstEnter = false;

      }
      if (carouselTouchStartX < event.changedTouches[0].pageX && firstEnter) {
        //to LEFT
        rightCard = false;
        leftCard = true;
        formChangableColor1 = cPrivious1
        formChangableColor2 = cPrivious2
        formChangableColor3 = cPrivious3

        toChangableColor1 = vPrivious1
        toChangableColor2 = vPrivious2
        toChangableColor3 = vPrivious3
        firstEnter = false;
      }
      if (cNow1 > formChangableColor1) cNow1--;
      if (cNow1 < formChangableColor1) cNow1++;
      if (cNow2 > formChangableColor2) cNow2--;
      if (cNow2 < formChangableColor2) cNow2++;
      if (cNow3 > formChangableColor3) cNow3--;
      if (cNow3 < formChangableColor3) cNow3++;
      if (vNow1 > toChangableColor1) vNow1--;
      if (vNow1 < toChangableColor1) vNow1++;
      if (vNow2 > toChangableColor2) vNow2--;
      if (vNow2 < toChangableColor2) vNow2++;
      if (vNow3 > toChangableColor3) vNow3--;
      if (vNow3 < toChangableColor3) vNow3++;

      htmlId.style.background = '-webkit-linear-gradient(rgb(' + cNow1 + ',' + cNow2 + ',' + cNow3 + '),' +
        'rgb(' + vNow1 + ',' + vNow2 + ',' + vNow3 + '))';
      this.cards.style.transition = '0s';
      this.cards.style.webkitTransition = '0s';
      this.cards.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
      this.cards.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
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
            font_color: getAccountsCards[i].font_color
          };


          cardsarray[getAccountsCards[i].id] = card;

          localStorage.setItem("click_client_cards", JSON.stringify(cardsarray));

          count++;
          localStorage.setItem('click_client_countCard', count);
        }

    }
    if (localStorage.getItem('click_client_accountInfo')) {

      for (var i = 0; i < getAccountsCards.length; i++) {
        if (getAccountsCards[i].id == loginInfo.default_account) {
          defaultAccountId = getAccountsCards[i].id;
          var tmp = getAccountsCards[0];
          getAccountsCards[0] = getAccountsCards[i];
          getAccountsCards[i] = tmp;
        }
      }
      scope.addCard(getAccountsCards);
    }

    animation = function () {
    }

    function changePosition() {


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


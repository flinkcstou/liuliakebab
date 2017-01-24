<component-old-card-carousel>
  <div id="containerCard" class="card-carousel" ontouchend="endTouch()" ontouchmove="moveTouch()"
       ontouchstart="startTouch()" onscroll="{onScroll}">
    <div id="cards" class="cards">
      <component-card each="{i in cardsarray}"
                      style="left:{260*i.countCard+60}px"
                      name="{i.name}" salary="{i.salary}" currency="{i.currency}" number="{i.number}"
                      bankname="{i.bankName}"></component-card>
    </div>
  </div>

  <script>
    var scope = this;
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));

    var touchStartX, touchEndX;
    scope.cards.style.width = localStorage.getItem('containerCardsWidth');
    cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));

    if (!cardsarray) {
      cardsarray = [];
    }


    var card;
    var cardNumber = 0;
    var pos = 0;
    var changed = false;
    var count = localStorage.getItem('click_client_countCard');
    if (!count)
      count = 0;

    moveTouch = function () {
      //event.preventDefault();
    }

    startTouch = function () {
      scope.containerCard.style.overflow = "auto";
      touchStartX = event.changedTouches[0].pageX;
      changed = true;
    }

    endTouch = function () {
      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX)
        changePosition(scope.containerCard.scrollLeft);
      changed = false;
      scope.containerCard.style.overflow = "hidden";
    }

    addCard(getAccountsCards)
    {
      if (count == 0)
        for (var i = 0; i < getAccountsCards.length; i++) {
          scope.leftPosition = count * 260;
          card = {
            bankName : getAccountsCards[i].bank_name,
            name     : getAccountsCards[i].description,
            salary   : '1 798 222',
            currency : getAccountsCards[i].currency_code,
            number   : getAccountsCards[i].card_num,
            countCard: count
          };

          cardsarray.push(card);
//          console.log(cardsarray);
          localStorage.setItem("click_client_cards", JSON.stringify(cardsarray));
          var parsedCards = localStorage.getItem('click_client_cards');
//          console.log(parsedCards);

          count++;
          localStorage.setItem('click_client_countCard', count);
          localStorage.setItem('containerCardsWidth', scope.leftPosition + 360 + 'px');
          scope.cards.style.width = localStorage.getItem('containerCardsWidth');

          riot.mount("component-card");
        }

    }
    if (localStorage.getItem('click_client_accountInfo'))
      scope.addCard(getAccountsCards);

    function changePosition(position) {
      if (touchEndX < touchStartX && cardNumber < count - 1)
        ++cardNumber;


      if (touchEndX > touchStartX && cardNumber > 0)
        --cardNumber;
      if (!viewMainPage.myCards) {
        localStorage.setItem('cardNumber', cardNumber)
        pos = cardNumber * 260;
        scope.containerCard.scrollLeft = pos;
      }
      else{
        if(viewMainPage.myCards && viewMyCards.check) {
          pos = (JSON.parse(localStorage.getItem('click_client_cards'))[localStorage.getItem('cardNumber')].countCard) * 260;
          scope.containerCard.scrollLeft = pos;
          viewMyCards.check = false;
          cardNumber = localStorage.getItem('cardNumber');
          return;
        }
        if(viewMainPage.myCards && !viewMyCards.check){
          pos = cardNumber * 260;
          scope.containerCard.scrollLeft = pos;
        }
      }

    }
//    console.log("CARD NUMBER ", cardNumber);

    onScroll = function (e) {
      if (!changed) {
        scope.containerCard.scrollLeft = pos;
      }

    }


  </script>
</component-old-card-carousel>


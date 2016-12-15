<component-card-carousel>

  <div id="containerCard" class="card-carousel" ontouchend="endTouchCarousel()" ontouchmove="moveTouchCarousel()"
       ontouchstart="startTouchCarousel()">
    <div id="cards" class="cards">
      <component-card each="{i in cardsarray}"
                      countcard="{i.countCard}"
                      name="{i.name}" salary="{i.salary}" currency="{i.currency}" number="{i.number}"
                      bankname="{i.bankName}" url="{i.url}"
                      background="{i.background}"></component-card>
    </div>
  </div>

  <script>

    var scope = this;
    var getAccountsCards = JSON.parse(localStorage.getItem('click_client_accountInfo'));

    var touchStartX, touchEndX;
    cardsarray = JSON.parse(localStorage.getItem("click_client_cards"));

    if (!cardsarray) {
      cardsarray = [];
    }


    var card;
    var cardNumber = 0;
    var pos = 0;
    var count = localStorage.getItem('click_client_countCard');
    if (!count)
      count = 0;


    startTouchCarousel = function () {
      touchStartX = event.changedTouches[0].pageX;
      delta = this.cards.getBoundingClientRect().left - touchStartX;
    }

    endTouchCarousel = function () {
      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX)
        changePosition();
    }

    moveTouchCarousel = function () {
      this.cards.style.transition = '0s';
      this.cards.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.cards.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.cards.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    }

    addCard(getAccountsCards)
    {
      var numberOfCard;
      var typeOfCard;

      if (count == 0)
        for (var i = 0; i < getAccountsCards.length; i++) {

          if (getAccountsCards[i].access == 0) break;

          if (getAccountsCards[i].acc_abs.trim() == 'SMARTV')
            typeOfCard = 'resources/icons/cards/typeOfCards/uzcard.png';
          if (getAccountsCards[i].acc_abs == 'DUET')
            typeOfCard = 'resources/icons/cards/typeOfCards/duet.png';


          numberOfCard = getAccountsCards[i].accno[0] + ' ' + getAccountsCards[i].accno[1] +
            ' ' + getAccountsCards[i].accno[2] + ' ' + getAccountsCards[i].accno[3] + '  **** ' + '  **** ' +
            getAccountsCards[i].accno[getAccountsCards[i].accno.length - 4] + ' ' + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 3] +
            ' ' + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 2] + ' ' + getAccountsCards[i].accno[getAccountsCards[i].accno.length - 1];

          card = {
            bankName  : typeOfCard,
            name      : getAccountsCards[i].description,
            salary    : '1 798 222',
            currency  : getAccountsCards[i].currency_name,
            number    : numberOfCard,
            url       : getAccountsCards[i].image_url,
            background: getAccountsCards[i].background_url,
            countCard : count
          };

          cardsarray.push(card);
          console.log(cardsarray);
          localStorage.setItem("click_client_cards", JSON.stringify(cardsarray));
          var parsedCards = localStorage.getItem('click_client_cards');
          console.log(parsedCards);

          count++;
          localStorage.setItem('click_client_countCard', count);
          scope.cards.style.width = localStorage.getItem('containerCardsWidth');

          riot.mount("component-card");
        }
    }
    if (localStorage.getItem('click_client_accountInfo'))
      scope.addCard(getAccountsCards);

    function changePosition() {

      if (touchEndX < touchStartX && cardNumber < count - 1) {
        ++cardNumber;
        // second parameter FROM TO
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";

      }

      if (touchEndX > touchStartX && cardNumber == 0) {
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
      }

      if (touchEndX < touchStartX && cardNumber == count - 1) {
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";

      }

      if (touchEndX > touchStartX && cardNumber > 0) {
        --cardNumber;
        this.cards.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.cards.style.transform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.cards.style.webkitTransform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
      }

      if (!viewMainPage.myCards) {
        localStorage.setItem('cardNumber', cardNumber)


      }
      else {
        if (viewMainPage.myCards && viewMyCards.check) {
          pos = (JSON.parse(localStorage.getItem('click_client_cards'))[localStorage.getItem('cardNumber')].countCard) * 260;

          viewMyCards.check = false;
          cardNumber = localStorage.getItem('cardNumber');
          return;
        }
        if (viewMainPage.myCards && !viewMyCards.check) {


        }
      }
    }


  </script>
</component-card-carousel>


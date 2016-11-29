<component-card-carousel>
  <div id="containerCard" class="card-carousel" ontouchend="endTouch()" ontouchmove="moveTouch()"
       ontouchstart="startTouch()" onscroll="{onScroll}">
    <div id="cards" class="cards">
      <component-card each="{i in cardsarray}"
                      style="left:{260*i.countCard+60}px"
                      name="{i.name}" salary="{i.salary}" valyuta="{i.valyuta}" number="{i.number}"></component-card>
    </div>
    <input style="position: static" type="button" value="Add card" onclick={addCard}>
  </div>

  <script>
    var touchStartX, touchEndX;

    var scope = this;
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
      event.preventDefault();

      console.log(event.changedTouches[0].screenX);
      //scope.containerCard.style.left = event.changedTouches[0].screenX + 'px';
      console.log(scope.containerCard.style.left)
      console.log(event);
    }

    startTouch = function () {
      scope.containerCard.style.overflow = "auto";
      touchStartX = event.changedTouches[0].screenX;
      console.log(touchStartX);
      changed = true;
    }

    endTouch = function () {
      touchEndX = event.changedTouches[0].screenX;
      console.log(touchEndX);
      if (touchStartX != touchEndX)
        changePosition(scope.containerCard.scrollLeft);
    }

    addCard(e)
    {
      scope.leftPosition = count * 260;
      card = {
        name     : 'Зарплатная карта',
        salary   : '1 798 222',
        valyuta  : 'сум',
        number   : '8723     ****     ****     4276',
        countCard: count
      };
      console.log(card);

      cardsarray.push(card);
      console.log(cardsarray);
      localStorage.setItem("click_client_cards", JSON.stringify(cardsarray));
      var parsedCards = localStorage.getItem('click_client_cards');
      console.log(parsedCards);

      count++;
      localStorage.setItem('click_client_countCard', count);
      localStorage.setItem('containerCardsWidth', scope.leftPosition + 360 + 'px');
      scope.cards.style.width = localStorage.getItem('containerCardsWidth');
      //console.log(this.containerCard.innerHTML); //TODO:SAVE COMPONENTS IN LOCALSTORAGE
      console.log(scope.leftPosition);
      riot.mount("component-card");

    }

    function changePosition(position) {
      console.log("START AND END ", touchStartX, ' ', touchEndX)
      if (touchEndX < touchStartX && cardNumber < count - 1) {
        console.log(cardNumber)
        ++cardNumber;
        console.log(cardNumber)
      }
      if (touchEndX > touchStartX && cardNumber > 0) {
        console.log(cardNumber)
        --cardNumber;
        console.log(cardNumber)
      }
      pos = cardNumber * 260;
      console.log("POSITION ", pos)

      scope.containerCard.scrollLeft = pos;

      changed = false;
    }
    onScroll = function (e) {
      if (!changed) {
        scope.containerCard.scrollLeft = pos;
        scope.containerCard.style.overflow = "hidden";
      }
    }

  </script>
</component-card-carousel>


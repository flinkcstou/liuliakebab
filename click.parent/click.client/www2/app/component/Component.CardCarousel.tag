<component-card-carousel>
  <div id="containerCard" class="card-carousel" style="transition:all 5s ease-in;" ontouchend="endTouch()"
       ontouchstart="startTouch()" onscroll="{onScroll}">
    <div id="cards" class="cards">
      <component-card each="{i in cardsarray}"
                      style="left:{i.position}"
                      name="{i.name}" salary="{i.salary}" valyuta="{i.valyuta}" number="{i.number}"></component-card>
    </div>
    <input style="position: static" type="button" value="Add card" onclick={addCard}>
  </div>

  <script>

    var scope = this;
    scope.cards.style.width = localStorage.getItem('containerCardsWidth');
    cardsarray = JSON.parse(localStorage.getItem("cards"));


    if (!cardsarray) {

      cardsarray = [];
    }


    var card;
    var cardNumber;
    var pos = 0;
    var changed = false;
    var count = localStorage.getItem('countCard');

    endTouch = function () {
      changePosition(scope.containerCard.scrollLeft);
      scope.containerCard.style.overflow = "hidden";
    }

    startTouch = function () {
      scope.containerCard.style.overflow = "auto";
      changed = true;
    }

    addCard(e)
    {
      scope.left = count * 260 + 60;
      card = {
        name    : 'Зарплатная карта',
        salary  : '1 798 222',
        valyuta : 'сум',
        number  : '8723     ****     ****     4276',
        position: (scope.left + 'px')
      };
      console.log(card);

      cardsarray.push(card);
      console.log(cardsarray);
      localStorage.setItem("cards", JSON.stringify(cardsarray));
      var parsedCards = localStorage.getItem('cards');
      console.log(parsedCards);

      count++;
      localStorage.setItem('countCard', count);
      localStorage.setItem('containerCardsWidth', scope.left + 300 + 'px');
      //console.log(this.containerCard.innerHTML); //TODO:SAVE COMPONENTS IN LOCALSTORAGE
      console.log(scope.left);
      riot.mount("component-card");

    }

    function changePosition(position) {
      cardNumber = Math.round(position / 240);
      if (cardNumber > position / 240)
        cardNumber = Math.round((position - 60) / 240);

      pos = cardNumber * 260;
      scope.containerCard.scrollLeft = pos;

      changed = false;
    }

    onScroll(e)
    {
      if (!changed) {
        scope.containerCard.scrollLeft = pos;
      }
    }

  </script>
</component-card-carousel>


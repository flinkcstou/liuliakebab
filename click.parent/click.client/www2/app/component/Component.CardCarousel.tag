<component-card-carousel>
  <div id="containerCard" class="card-carousel" style="transition:all 5s ease-in;" ontouchend="endTouch()"
       ontouchstart="startTouch()" onscroll="{onScroll}">
    <div id="cards" class="cards">
      <component-card style="left:{left}px"
                      each="{i in cardsArray}"
                      name="{i.name}" salary="{i.salary}" valyuta="{i.valyuta}" number="{i.number}"></component-card>
    </div>
    <input style="position: static" type="button" value="Add card" onclick={addCard}>
  </div>

  <script>
    var scope = this;
    scope.cardsArray = [];
    var card;
    var pos = 0;
    scope.cards.style.marginRight = '60px';
    var changed = false;
    var count = 0;

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
      card = {
        name   : 'Зарплатная карта',
        salary : '1 798 222',
        valyuta: 'сум',
        number : '8723     ****     ****     4276'
      };

      scope.cardsArray.push(card);
      scope.left = count * 260 + 60;
      count++;
      scope.cards.style.width = (scope.left + 300) + 'px';
      //console.log(this.containerCard.innerHTML); //TODO:SAVE COMPONENTS IN LOCALSTORAGE
      console.log(scope.left);
      console.log(scope.cards.style.width);
      riot.mount("component-card");

    }


    function changePosition(position) {
      var card = Math.round(position / 240);
      scope.containerCard.scrollLeft = card * 260;

      pos = card * 260;
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


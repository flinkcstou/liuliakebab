<component-card-carousel>
  <div id="containerCard" class="card-carousel" style="transition:all 5s ease-in;" ontouchend="endTouch()" ontouchstart="startTouch()" onscroll="{onScroll}">
    <div id="cards" class="cards">
    </div>
  </div>
  <input style="position: static" type="button" value="Add card" onclick={addCard}>
  <script>

    console.log(window);
    this.cards.style.width = "360px";
    window.pos = 0;
    window.changed = false;

    var left = 80;
    var count = 0;
    var timer = null;

    endTouch = function () {
      changePosition(this.containerCard.scrollLeft);
      this.containerCard.style.overflow = "hidden";
    }

    startTouch = function () {
      this.containerCard.style.overflow = "auto";
      window.changed = true;
    }

    addCard(e)
    {
      count++;
      this.cards.innerHTML += "<component-card style='left:" + left + "px'></component-card>";
      //console.log(this.containerCard.innerHTML); //TODO:SAVE COMPONENTS IN LOCALSTORAGE
      left += 240;
      this.cards.style.width = (left + 40) + 'px';
      console.log(this.cards.style.width);
      riot.mount("component-card");
    }


    function changePosition(position) {
      console.log("POSITION SEND ", position);
      var card = Math.round(position / 200);
      console.log(parseFloat(position / 200));
      console.log("NUMBER OF CARD ", card);
      this.containerCard.scrollLeft = card * 240;
      console.log("REAL POSITION ", card * 240);
      console.log("NEW POSITION ", this.containerCard.scrollLeft);

      window.pos = card * 240;

      window.changed = false;
    }

    onScroll(e)
    {
      console.log(e.target.scrollLeft);

      if (!window.changed) {
        this.containerCard.scrollLeft = window.pos;
      }
    }

  </script>
</component-card-carousel>


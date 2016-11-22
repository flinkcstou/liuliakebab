<component-card-carousel class="">
  <div id="containerCard" class="card-carousel" onscroll={scrollCard}>
    <div id="cards" class="cards">

    </div>
  </div>
  <input style="position: static" type="button" value="Add card" onclick={addCard}>
  <script>

    var asd = 80;
    var count = 0;
    var arrayCenter = [];

    addCard(e)
    {
      setTimeout(detectCenter, 1000);
      //console.log('width ', this.cards.offsetWidth);
      count++;
      this.cards.innerHTML += "<component-card style='left:" + asd + "px'></component-card>";
      //console.log(this.containerCard.innerHTML); //TODO:SAVE COMPONENTS IN LOCALSTORAGE
      asd += 240;
      riot.mount("component-card");
      console.log(count, asd / 2);
      detectCenter(count, asd/2);
      for (var i = 0; i < count; i++) {
        console.log(arrayCenter[i]);
      }
    }
    function detectCenter(count, center) {
      arrayCenter.push(center);
    }
    scrollCard(e)
    {
      console.log(e);
      console.log(e);
//      console.log(this.containerCard.scrollLeft);
//      if (this.containerCard.scrollLeft > 180 && this.containerCard.scrollLeft < 200 && card2 == false) {
//        this.containerCard.style = "background-color: black;";
//        this.containerCard.scrollLeft = 260;
//        card2 = true;
//      }
//      if (this.containerCard.scrollLeft < 320 && this.containerCard.scrollLeft > 300 && card2 == false) {
//        this.containerCard.style = "background-color: black;";
//        this.containerCard.scrollLeft = 260;
//      }
    }

  </script>
</component-card-carousel>


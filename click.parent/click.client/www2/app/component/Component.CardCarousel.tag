<component-card-carousel>
  <div id="containerCard" class="card-carousel" onscroll={scrollCard}>
    <component-card id="card1" style="left: 80px;"></component-card>
    <component-card id="card2" style="left: 340px;"></component-card>
    <component-card id="card3" style="left: 600px;" style="right: 80px"></component-card>
  </div>

  <script>
    window.card1 = false;
    window.card2 = false;
    window.card3 = false;

    scrollCard(e)
    {
      console.log(this.containerCard.scrollLeft);
      if (this.containerCard.scrollLeft > 160 && card2 == false) {
        this.containerCard.style = "background-color: black;";
        this.containerCard.scrollLeft = 260;
        card2 = true;
      }
      if (this.containerCard.scrollLeft < 320 && this.containerCard.scrollLeft > 300 && card2 == false) {
        this.containerCard.style = "background-color: black;";
        this.containerCard.scrollLeft = 260;
      }
    }
  </script>
</component-card-carousel>


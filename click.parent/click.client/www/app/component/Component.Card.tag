<component-card class="card" style="background-image: url({opts.background}); left:{260*opts.countcard+60}px" ontouchstart="touchStartCard()"
                ontouchend="touchEndCard()">

    <div class="card-bank-name-url" style="background-image: url({opts.url})"></div>
    <div class="card-bank-name" style="background-image: url({opts.bankname})"></div>
    <div class="card-salary-title">{opts.name}</div>
    <div class="card-balance">{opts.salary}</div>
    <div class="card-currency">{opts.currency}</div>
    <div class="card-number">{opts.number}</div>


  <script>
    console.log(opts.background);

    var scope = this;
    scope.position = 260*opts.countcard+60 +'px';
    console.log(scope.position )
    var touchStartX, touchEndX;
    touchStartCard = function () {
      touchStartX = event.changedTouches[0].pageX;
    }

    touchEndCard = function () {

      touchEndX = event.changedTouches[0].pageX;

      if (touchStartX == touchEndX)
        openCard();
    }
    openCard = function () {

      if (!viewMainPage.myCards) {
        this.riotTags.innerHTML = "<view-my-cards>";
        riot.mount("view-my-cards");
      }
      return;
    }
  </script>
</component-card>
<component-card class="card" ontouchstart="touchStartCard()" ontouchend="touchEndCard()">
  <div class="card-bank-name">{opts.bankname}</div>
  <div class="card-salary-title">{opts.name}</div>
  <div class="card-balance">{opts.salary}</div>
  <div class="card-currency">{opts.currency}</div>
  <div class="card-number">{opts.number}</div>

  <script>
    console.log('ASDSAD', opts.currency)
    var touchStartX, touchEndX;
    touchStartCard = function(){
      touchStartX = event.changedTouches[0].pageX;
    }

    touchEndCard = function(){

      touchEndX = event.changedTouches[0].pageX;

      if(touchStartX == touchEndX)
      openCard();
    }
     openCard = function () {

       if(!window.myCards) {
         this.riotTags.innerHTML = "<view-my-cards>";
         riot.mount("view-my-cards");
       }
       return;
   }
  </script>
</component-card>
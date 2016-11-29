<component-card class="card" ontouchstart="touchStartCard()" ontouchend="touchEndCard()">
  <div class="salary-title">{opts.name}</div>
  <div class="balance-of-card">{opts.salary}</div>
  <div class="valyuta-of-card">{opts.valyuta}</div>
  <div class="number-of-card">{opts.number}</div>

  <script>
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
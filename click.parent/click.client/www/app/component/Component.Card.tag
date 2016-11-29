<component-card class="card" ontouchstart="touchStart()" ontouchend="touchEnd()">
  <div class="salary-title">{opts.name}</div>
  <div class="balance-of-card">{opts.salary}</div>
  <div class="valyuta-of-card">{opts.valyuta}</div>
  <div class="number-of-card">{opts.number}</div>

  <script>
    var touchStartX, touchEndX;
    touchStart = function(){
      touchStartX = event.changedTouches[0].screenX;
    }

    touchEnd = function(){
      touchEndX = event.changedTouches[0].screenX;

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
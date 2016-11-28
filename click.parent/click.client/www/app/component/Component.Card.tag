<component-card class="card" ontouchstart="openCard()">
  <div class="salary-title">{opts.name}</div>
  <div class="balance-of-card">{opts.salary}</div>
  <div class="valyuta-of-card">{opts.valyuta}</div>
  <div class="number-of-card">{opts.number}</div>

  <script>
     openCard = function () {
       if(!window.myCards) {
         this.riotTags.innerHTML = "<view-my-cards>";
         riot.mount("view-my-cards");
       }
       return;
   }
  </script>
</component-card>
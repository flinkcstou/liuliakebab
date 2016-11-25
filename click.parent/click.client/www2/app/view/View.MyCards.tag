<view-my-cards>
  <component-page-title title="{titleName}">
  </component-page-title>
  <component-card-carousel>
  </component-card-carousel>


  <script>
    scope = this;
    console.log(localStorage.getItem('cards'));
    scope.cardsArray = JSON.parse(localStorage.getItem('cards'));
    console.log(JSON.parse(localStorage.getItem('cards')))
    window.myCards = true;

    this.titleName = 'ЗАРПЛАТНАЯ КАРТА';
  </script>
</view-my-cards>
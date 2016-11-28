<view-my-cards>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>
  <div class="my-cards-carousel">
  <component-card-carousel>
  </component-card-carousel>
  </div>

  <div class="my-card-button-container">
    <div>

    </div>

    <div>

    </div>

    <div>

    </div>
  </div>

  <script>
    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('cards'));
    window.myCards = true;


    this.titleName = 'ЗАРПЛАТНАЯ КАРТА';
  </script>
</view-my-cards>
<view-main-page >
  <component-menu></component-menu>
  <div id="mainPageId" class="view-main-page">
  <component-toolbar></component-toolbar>
  <component-bank-operations></component-bank-operations>
  <component-service-carousel></component-service-carousel>
  <component-footer></component-footer>
  <component-card-carousel>
  </component-card-carousel>
    <div class="bank-operation-button-my-cards">
      <div class="bank-operation-button-my-cards-container">
        <div class="bank-operation-button-my-cards-icon"></div>
        <div class="bank-operation-button-my-cards-label">МОИ КАРТЫ</div>
      </div>
    </div>
  </div>
  <script>
    var scope = this;
    localStorage.setItem('cardNumber', 0);
    history.arrayOfHistory.push('view-main-page');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    viewMainPage.myCards = false;

  </script>
</view-main-page>


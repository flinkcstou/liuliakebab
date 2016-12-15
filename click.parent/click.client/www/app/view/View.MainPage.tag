<view-main-page >
  <component-menu id="SideMenuId"></component-menu>
  <div id="mainPageId" class="view-main-page">
  <component-toolbar></component-toolbar>
  <div>
    <p class="common-balance-label">Общий баланс:</p>
    <div>
      <p class="common-balance">5 520 000</p>
      <p class="valuta">сум</p>
    </div>
  </div>
  <component-bank-operations></component-bank-operations>
  <component-service-carousel></component-service-carousel>
  <component-footer></component-footer>
  <component-card-carousel></component-card-carousel>
  </div>
  <script>
    history.arrayOfHistory.push('view-main-page');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    var scope = this;
    viewMainPage.myCards = false;

  </script>
</view-main-page>


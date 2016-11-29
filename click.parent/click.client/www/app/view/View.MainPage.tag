<view-main-page id="mainPageId" class="view-main-page">
  <component-toolbar></component-toolbar>
  <div>
    <p class="common-balance-label">Общий баланс:</p>
    <div>
      <p class="common-balance">5 520 000</p>
      <p class="valuta">сум</p>
    </div>
  </div>
  <component-card-carousel></component-card-carousel>
  <component-bank-operations></component-bank-operations>
  <component-service-carousel></component-service-carousel>
  <component-footer></component-footer>
  <script>
    var scope = this;
    console.log(JSON.parse(localStorage.getItem("accountInfo")));
    window.myCards = false;
    api.init();



  </script>
</view-main-page>


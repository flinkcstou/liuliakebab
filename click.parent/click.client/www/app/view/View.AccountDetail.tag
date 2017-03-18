<view-account-detail>
  <div>
    <div class="account-detail-title-container">

      <div class="page-title account-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>
      <div class="account-detail-transfer-icon"></div>
      <p class="account-detail-transfer-icon-title-part-one">
        {window.languages.ViewTransferDetailTransferIconTitleOne}</p>

      <p class="account-detail-transfer-icon-title-part-two">
        {window.languages.ViewTransferDetailTransferIconTitleTwo}</p>

      <p class="account-detail-transfer-icon-title-phone">
        +99890974322344</p>

    </div>

    <div class="account-detail-container">
      <div class="account-detail-transfer-container">
        <p class="account-detail-title">{window.languages.ViewTransferDetailTitleSum}</p>
        <p class="account-detail-sum">115 000 сум</p>
      </div>
      <div class="account-detail-transfer-container">
        <p class="account-detail-title">{window.languages.ViewTransferDetailTitleNumber}</p>
        <p class="account-detail-number">6497 9863</p>
      </div>

      <component-pincards></component-pincards>

      <div class="account-detail-buttons-container">
        <p class="account-detail-button-accept">ПРИНЯТЬ</p>
        <p class="account-detail-button-cancel">ОТКЛОНИТЬ</p>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewTransferDetailTitle;

    this.on('mount', function () {

    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-account-detail') {
      history.arrayOfHistory.push(
        {
          "view": 'view-account-detail',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


  </script>
</view-account-detail>

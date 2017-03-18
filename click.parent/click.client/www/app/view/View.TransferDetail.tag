<view-transfer-detail>
  <div>
    <div class="transfer-detail-title-container">

      <div class="page-title transfer-detail-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>
      <div class="transfer-detail-transfer-icon"></div>
      <p class="transfer-detail-transfer-icon-title-part-one">
        {window.languages.ViewTransferDetailTransferIconTitleOne}</p>

      <p class="transfer-detail-transfer-icon-title-part-two">
        {window.languages.ViewTransferDetailTransferIconTitleTwo}</p>

      <p class="transfer-detail-transfer-icon-title-phone">
        +99890974322344</p>

    </div>

    <div class="transfer-detail-container">
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleSum}</p>
        <p class="transfer-detail-sum">115 000 сум</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleNumber}</p>
        <p class="transfer-detail-number">6497 9863</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleDate}</p>
        <p class="transfer-detail-date">12:38 01.03.2017</p>
      </div>
      <div class="transfer-detail-transfer-container">
        <p class="transfer-detail-title">{window.languages.ViewTransferDetailTitleStatus}</p>
        <p class="transfer-detail-status">Ожидает подтверждения</p>
      </div>

      <div class="transfer-detail-buttons-container">
        <p class="transfer-detail-button-accept">{window.languages.ViewTransferDetailTitleAccept}</p>
        <p class="transfer-detail-button-cancel">{window.languages.ViewTransferDetailTitleDecline}</p>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewTransferDetailTitle;

    this.on('mount', function () {

    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-detail') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-detail',
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
</view-transfer-detail>

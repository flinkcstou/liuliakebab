<view-transfer-to-card>
  <div>
    <div class="transfer-to-card-title-container">

      <p class="transfer-to-card-transfer-title-part-one">
        {window.languages.ViewTransferToCardTitleOne}</p>

      <p class="transfer-to-card-transfer-title-part-two">
        115 000 сум</p>

      <p class="transfer-to-card-transfer-title-phone">
        {window.languages.ViewTransferToCardTitleTwo}</p>

    </div>

    <div class="transfer-to-card-container">

      <component-pincards></component-pincards>

      <div class="account-detail-buttons-container">
        <p class="account-detail-button-accept">{window.languages.ViewAccountDetailTitlePay}</p>
        <p class="account-detail-button-cancel">{window.languages.ViewAccountDetailTitleDecline}</p>
      </div>
    </div>


  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewAccountDetailTitle;

    this.on('mount', function () {

    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-transfer-to-card') {
      history.arrayOfHistory.push(
        {
          "view": 'view-transfer-to-card',
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
</view-transfer-to-card>

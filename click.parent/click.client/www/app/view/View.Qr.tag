<view-qr>
  <div class="view-qr-blue-container">
    <div class="view-qr-page-title">
      <p class="view-qr-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="view-qr-company-icon"></div>
    <p class="view-qr-company-name">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartOne}</p>
    <p class="view-qr-address-name">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartTwo}</p>
  </div>
  <div class="settings-container view-qr-container">

  </div>


  <script>
    var scope = this;
    this.titleName = window.languages.ViewQrTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-qr') {
      history.arrayOfHistory.push(
        {
          "view": 'view-qr',
          "params": opts
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
</view-qr>

<view-qr>
  <div class="settings-about-program-blue-container">
    <div class="settings-about-program-page-title">
      <p class="settings-about-program-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="settings-about-program-click-icon"></div>
    <p class="settings-about-program-version-title-part-one">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartOne}</p>
    <p class="settings-about-program-version-title-part-two">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartTwo}</p>
  </div>
  <div class="settings-container settings-about-program-container">
    <div class="settings-about-program-user-agreement-container" ontouchend="userAgreementTouchEnd()">
      <p class="settings-about-program-user-agreement-title">
        {window.languages.ViewSettingsAboutProgramUserAgreementTitleName}</p>
      <div class="settings-about-program-user-agreement-icon"></div>
    </div>
    <div class="settings-about-program-rank-container" ontouchend="rankInGooglePlayTouchEnd()">
      <p class="settings-about-program-rank-title">{window.languages.ViewSettingsAboutProgramRankTitleName}</p>
      <div class="settings-about-program-rank-icon"></div>
    </div>
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

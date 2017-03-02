<view-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="pay-category-container">
      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewMainSettingsTitle}</div>
      </div>

      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewSecuritySettingsTitle}</div>
      </div>

      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewFriendHelpSettingsTitle}</div>
      </div>

      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewInviteFriendSettingsTitle}</div>
      </div>

      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewAboutSettingsTitle}</div>
      </div>

      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewSupportSettingsTitle}</div>
      </div>

      <div class="pay-service-block-containter">
        <div class="pay-category-name-field">{window.languages.ViewCallCenterSettingsTitle}</div>
      </div>
    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-settings',
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
</view-settings>

<view-security-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTrustedDevicesTitle}</div>
      </div>

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsPinChangeTitle}</div>
      </div>

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTouchScanUseTitle}</div>
      </div>

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsBlockTitle}</div>
      </div>

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsMyNumberHideTitle}</div>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSecuritySettingsTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-security-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-security-settings',
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
</view-security-settings>

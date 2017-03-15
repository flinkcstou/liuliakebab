<view-security-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" type="button" class="settings-security-check-button"
           ontouchend="saveEditedNameToucEnd()"></div>
    </div>
    <div class="settings-container">

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_devices.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTrustedDevicesTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_changepin.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsPinChangeTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter settings-security-scanner-block" ontouchend="">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_fingerprint.png')"></div>
        <div class="settings-block-name-field settings-security-scanner-block-name">
          {window.languages.ViewSecuritySettingsTouchScanUseTitle}
        </div>
        <div class="settings-security-check-icon"></div>
      </div>

      <div class="settings-block-containter settings-security-block" ontouchend="">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_block.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsBlockTitle}</div>
        <div class="settings-security-block-detail-text" style="width: 70%;">
          {window.languages.ViewSecuritySettingsBlockText}
        </div>
        <div class="settings-security-check-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_visibility.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsMyNumberHideTitle}</div>
        <div class="settings-security-check-icon"></div>
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

<view-security-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" type="button" class="settings-security-check-button"
           ontouchend="saveEditedSecuritySettings()"></div>
    </div>
    <div class="settings-container">

      <div class="settings-block-containter" ontouchend="" if="{false}">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_devices.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTrustedDevicesTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="changeClickPin()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_changepin.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsPinChangeTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter settings-security-scanner-block" ontouchend="" if="{false}">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_fingerprint.png')"></div>
        <div class="settings-block-name-field settings-security-scanner-block-name">
          {window.languages.ViewSecuritySettingsTouchScanUseTitle}
        </div>
        <div class="settings-security-check-icon"></div>
      </div>

      <div class="settings-block-containter settings-security-block">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_block.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsBlockTitle}</div>
        <div class="settings-security-block-detail-text" style="width: 70%;">
          {window.languages.ViewSecuritySettingsBlockText}
        </div>
        <div id="blockWithPinIconId" class="settings-security-check-icon" ontouchend="blockWithPin()"></div>
      </div>

      <div class="settings-block-containter">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_visibility.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsMyNumberHideTitle}</div>
        <div id="hideMyNumberIconId" class="settings-security-check-icon" ontouchend="hideMyNumber()"></div>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSecuritySettingsTitle;
    var isVisible = true;
    var isBlocked = true;
    this.on('mount', function () {
      if (isVisible) {
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }
      if (isBlocked) {
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }
    });

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

    hideMyNumber = function () {

      if (isVisible) {
        console.log("false!!!");
        isVisible = false;
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
      } else {
        console.log("true!!!");
        isVisible = true;
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }
      riot.update(hideMyNumberIconId);
    }

    changeClickPin = function () {

      riotTags.innerHTML = "<view-pin-code>";
      riot.mount('view-pin-code', ['view-security-settings']);
    }

    blockWithPin = function () {

      if (isBlocked) {
        console.log("false!!!");
        isBlocked = false;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
      } else {
        console.log("true!!!");
        isBlocked = true;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }
      riot.update(hideMyNumberIconId);
    }

    saveEditedSecuritySettings = function () {
      alert("save edits")
    }


  </script>
</view-security-settings>

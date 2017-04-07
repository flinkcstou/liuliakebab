<view-security-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">

      <div class="settings-block-containter" ontouchend="goToTrustedDevices()">
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

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;

    scope.showError = false;
    this.titleName = window.languages.ViewSecuritySettingsTitle;
    sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    if (!localStorage.getItem('click_client_block')) {
      localStorage.setItem('click_client_block', false)
    }

    var isVisible = localStorage.getItem('click_client_loginInfo').visibility;
    var isBlocked = JSON.parse(localStorage.getItem('click_client_block'));

    this.on('mount', function () {
      if (isVisible) {
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }

      if (isBlocked) {
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }
      else {
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
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

      window.api.call({
        method: 'settings.change.visibility',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          visibility: isVisible
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            scope.clickPinError = false;
            scope.errorNote = ("Изменена видимость номера");
            scope.showError = true;
            riot.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            riot.update();
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };


    changeClickPin = function () {

      riotTags.innerHTML = "<view-pin-code>";
      riot.mount('view-pin-code', ['view-security-settings']);
    };

    blockWithPin = function () {

      if (isBlocked) {
        console.log("false!!!");
        isBlocked = false;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
        localStorage.setItem('click_client_block', false)

      } else {
        console.log("true!!!");
        isBlocked = true;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
        localStorage.setItem('click_client_block', true)
      }
      riot.update(hideMyNumberIconId);
    };


    goToTrustedDevices = function () {

      history.arrayOfHistory.push({view: "view-trusted-devices"});
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
      riotTags.innerHTML = "<view-trusted-devices>";
      riot.mount("view-trusted-devices");
    };

  </script>
</view-security-settings>

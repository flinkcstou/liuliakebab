<view-security-settings>
  <div class="riot-tags-main-container">
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

      <div hidden="{!window.fingerPrint.check}" class="settings-block-containter settings-security-scanner-block"
           ontouchend="fingerPrintTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_fingerprint.png')"></div>
        <div class="settings-block-name-field settings-security-scanner-block-name">
          {window.languages.ViewSecuritySettingsTouchScanUseTitle}
        </div>
        <div id="securityFingerPrintIconId" class="settings-security-check-icon"></div>
      </div>

      <div class="settings-block-containter settings-security-block" ontouchend="blockWithPin()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_block.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsBlockTitle}</div>
        <div class="settings-security-block-detail-text" style="width: 70%;">
          {window.languages.ViewSecuritySettingsBlockText}
        </div>
        <div id="blockWithPinIconId" class="settings-security-check-icon"></div>
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

    if (localStorage.getItem('click_client_loginInfo'))
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

    if (localStorage.getItem('click_client_phoneNumber'))
      var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    if (localStorage.getItem('click_client_loginInfo'))
      var isVisible = localStorage.getItem('click_client_loginInfo').visibility;

    if (localStorage.getItem('settings_block'))
      var isBlocked = JSON.parse(localStorage.getItem('settings_block'));

    if (localStorage.getItem("settings_finger_print"))
      var fingerPrint = JSON.parse(localStorage.getItem("settings_finger_print"))

    if (localStorage.getItem("settings_finger_print_enrolled"))
      var fingerPrintEnrolled = JSON.parse(localStorage.getItem("settings_finger_print_enrolled"))

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

      if (fingerPrint) {
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      }
      else {
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
      }
      scope.update()
    });


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-security-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-security-settings',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
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
      scope.update(hideMyNumberIconId);

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
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
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

      scope.unmount()
    };

    blockWithPin = function () {

      if (isBlocked) {
        console.log("false!!!");
        isBlocked = false;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
        localStorage.setItem('settings_block', false)

      } else {
        console.log("true!!!");
        isBlocked = true;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
        localStorage.setItem('settings_block', true)
      }
      scope.update();
    };


    goToTrustedDevices = function () {

      history.arrayOfHistory.push({view: "view-trusted-devices"});
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
      riotTags.innerHTML = "<view-trusted-devices>";
      riot.mount("view-trusted-devices");

      scope.unmount()
    };

    fingerPrintTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!fingerPrintEnrolled && fingerPrintEnrolled !== null) {
        scope.showError = true;
        scope.errorNote = 'Опция не включена на устройстве!'
        scope.clickPinError = false
        scope.update()
        return
      }
      console.log("QQQ")
      if (!fingerPrint) {
        console.log()
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)"
        fingerPrint = true
        console.log("true")
        localStorage.setItem("settings_finger_print", true)
      }
      else {
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
        fingerPrint = false
        localStorage.setItem("settings_finger_print", false)
      }
      scope.update()
    }


  </script>
</view-security-settings>

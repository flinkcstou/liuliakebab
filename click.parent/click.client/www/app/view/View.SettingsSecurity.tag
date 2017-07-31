<view-security-settings>
  <div class="riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchstart="securityGoToBackStart()" ontouchend="securityGoToBackEnd()"
           class="pay-back-button"></div>
    </div>
    <div class="settings-container">

      <div id="trustedDevicesButtonId" class="settings-block-containter" ontouchstart="goToTrustedDevicesStart()"
           ontouchend="goToTrustedDevicesEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_devices.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTrustedDevicesTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="changePinButtonId" class="settings-block-containter" ontouchstart="changeClickPinStart()"
           ontouchend="changeClickPinEnd()">
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

      <div class="settings-block-containter settings-security-block" ontouchend="blockPayAndTransfer()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_lock_payments.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsBlockPayTitle}</div>
        <div class="settings-security-block-detail-text" style="width: 70%;">
          {window.languages.ViewSecuritySettingsBlockPayText}
        </div>
        <div id="blockPayTransferIconId" class="settings-security-check-icon"></div>
      </div>

      <div hidden class="settings-block-containter" ontouchend="hideMyNumber()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettingsSecurity/security_visibility.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsMyNumberHideTitle}</div>
        <div id="hideMyNumberIconId" class="settings-security-check-icon"></div>
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
      var isVisible = JSON.parse(localStorage.getItem('click_client_loginInfo')).visibility;

    if (localStorage.getItem('settings_block'))
      var isBlocked = JSON.parse(localStorage.getItem('settings_block'));

    if (localStorage.getItem('settings_block_payAndTransfer'))
      var payTransferBlocked = JSON.parse(localStorage.getItem('settings_block_payAndTransfer'));

    if (localStorage.getItem("settings_finger_print"))
      var fingerPrint = JSON.parse(localStorage.getItem("settings_finger_print"))

    if (localStorage.getItem("settings_finger_print_enrolled"))
      var fingerPrintEnrolled = JSON.parse(localStorage.getItem("settings_finger_print_enrolled"))

    this.on('mount', function () {

      if (isVisible) {
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
      }
      else {
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
      }

      if (isBlocked) {
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
      }
      else {
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
      }

      if (payTransferBlocked) {
        blockPayTransferIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
      }
      else {
        blockPayTransferIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
      }

      if (fingerPrint) {
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
      }
      else {
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
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

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    securityGoToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    }

    securityGoToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {

        onBackKeyDown()
      }
    };

    hideMyNumber = function () {

      if (isVisible) {
        console.log("false!!!");
        isVisible = false;
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
      } else {
        console.log("true!!!");
        isVisible = true;
        hideMyNumberIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
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

    var changePinButtonStartX, changePinButtonEndX, changePinButtonStartY, changePinButtonEndY;

    changeClickPinStart = function () {

      changePinButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      changePinButtonStartX = event.changedTouches[0].pageX;
      changePinButtonStartY = event.changedTouches[0].pageY;
    };

    changeClickPinEnd = function () {

      changePinButtonId.style.backgroundColor = 'transparent'

      changePinButtonEndX = event.changedTouches[0].pageX;
      changePinButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(changePinButtonStartX - changePinButtonEndX) <= 20 && Math.abs(changePinButtonStartY - changePinButtonEndY) <= 20) {

        riotTags.innerHTML = "<view-pin-code>";
        riot.mount('view-pin-code', ['view-security-settings']);

        scope.unmount()
      }
    };

    blockWithPin = function () {

      if (isBlocked) {
        console.log("false!!!");
        isBlocked = false;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
        localStorage.setItem('settings_block', false)

      } else {
        console.log("true!!!");
        isBlocked = true;
        blockWithPinIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
        localStorage.setItem('settings_block', true)
      }
      scope.update();
    };

    blockPayAndTransfer = function () {

      if (payTransferBlocked) {
        console.log("false!!!");
        payTransferBlocked = false;
        blockPayTransferIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
        localStorage.setItem('settings_block_payAndTransfer', false)

      } else {
        console.log("true!!!");
        payTransferBlocked = true;
        blockPayTransferIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
        localStorage.setItem('settings_block_payAndTransfer', true)
      }
      scope.update();
    };

    var goTrustedStartX, goTrustedEndX, goTrustedStartY, goTrustedEndY;

    goToTrustedDevicesStart = function () {

      trustedDevicesButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      goTrustedStartX = event.changedTouches[0].pageX;
      goTrustedStartY = event.changedTouches[0].pageY;
    };

    goToTrustedDevicesEnd = function () {

      trustedDevicesButtonId.style.backgroundColor = 'transparent'

      goTrustedEndX = event.changedTouches[0].pageX;
      goTrustedEndY = event.changedTouches[0].pageY;

      if (Math.abs(goTrustedStartX - goTrustedEndX) <= 20 && Math.abs(goTrustedStartY - goTrustedEndY) <= 20) {
        history.arrayOfHistory.push({view: "view-trusted-devices"});
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
        riotTags.innerHTML = "<view-trusted-devices>";
        riot.mount("view-trusted-devices");

        scope.unmount()
      }
    };

    fingerPrintTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (!fingerPrintEnrolled && localStorage.getItem("settings_finger_print_enrolled") != null && device.platform == 'Android') {
        if (JSON.parse(localStorage.getItem("settings_finger_print_enrolled")) === false) {
          scope.showError = true;
          scope.errorNote = 'Опция не включена на устройстве!'
          scope.clickPinError = false
          scope.update()
          return
        }
      }
      console.log("QQQ")
      if (!fingerPrint) {
        console.log()
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
        fingerPrint = true
        console.log("true")
        localStorage.setItem("settings_finger_print", true)
      }
      else {
        securityFingerPrintIconId.style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
        fingerPrint = false
        localStorage.setItem("settings_finger_print", false)
      }
      scope.update()
    }


  </script>
</view-security-settings>

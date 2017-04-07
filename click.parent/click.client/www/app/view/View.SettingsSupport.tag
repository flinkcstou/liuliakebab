<view-settings-support id="settingsSupportId" class="view-settings-support">
  <div class="settings-support-blue-container">

    <div class="settings-support-page-title">
      <div class="settings-support-x-button" ontouchend="closeSettingsSupportTouchEnd()"></div>
    </div>

    <div class="settings-support-help-icon"></div>

    <p class="settings-support-help-title">{window.languages.VewSettingsSupportMessage}</p>
  </div>
  <div class="settings-support-container">
    <p class="settings-support-container-title">{window.languages.VewSettingsSupportTheme}</p>

    <div class="settings-support-buttons-container">

      <div class="settings-support-buttons settings-support-buttons-registration"
           ontouchend="goToSettingsStepTwo(window.languages.VewSettingsSupportRegistration, 'REGISTRATION')">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportRegistration}</p>
      </div>

      <div class="settings-support-buttons settings-support-buttons-pay"
           ontouchend="goToSettingsStepTwo(window.languages.VewSettingsSupportPay, 'PAY')">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportPay}</p>
      </div>

      <div class="settings-support-buttons settings-support-buttons-balance"
           ontouchend="goToSettingsStepTwo(window.languages.VewSettingsSupportBalance, 'BALANS')">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportBalance}</p>
      </div>

      <div class="settings-support-buttons settings-support-buttons-other"
           ontouchend="goToSettingsStepTwo(window.languages.VewSettingsSupportOther, 'OTHER')">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportOther}</p>
      </div>

    </div>

  </div>


  <script>
    var scope = this;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-settings-support') {
      history.arrayOfHistory.push(
        {
          "view": 'view-settings-support',
          "params": opts,
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    closeSettingsSupportTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsSupportId.style.display = 'none'
    }

    goToSettingsStepTwo = function (titleOfHelp, keyOfHelp) {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-settings-support-part-two>";
      riot.mount('view-settings-support-part-two', {title: titleOfHelp, key: keyOfHelp});
    }


  </script>
</view-settings-support>

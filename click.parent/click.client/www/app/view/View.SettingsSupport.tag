<view-settings-support id="settingsSupportId" class="view-settings-support riot-tags-main-container">
  <div class="settings-support-blue-container">

    <div class="settings-support-page-title">
      <div id="closeButtonId" role="button" aria-label="{window.languages.Close}" class="settings-support-x-button"
           ontouchstart="closeSettingsSupportTouchStart()" ontouchend="closeSettingsSupportTouchEnd()"></div>
    </div>

    <div class="settings-support-help-icon"></div>

    <p class="settings-support-help-title">{window.languages.VewSettingsSupportMessage}</p>
  </div>
  <div class="settings-support-container">
    <p class="settings-support-container-title">{window.languages.VewSettingsSupportTheme}</p>

    <div class="settings-support-buttons-container">

      <div id="registrationButtonId" class="settings-support-buttons settings-support-buttons-registration"
           ontouchstart="goToSettingsStepTwoStart(this.id)"
           ontouchend="goToSettingsStepTwoEnd(window.languages.VewSettingsSupportRegistration, 'REGISTRATION', this.id)">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportRegistration}</p>
      </div>

      <div id="payButtonId" class="settings-support-buttons settings-support-buttons-pay"
           ontouchstart="goToSettingsStepTwoStart(this.id)"
           ontouchend="goToSettingsStepTwoEnd(window.languages.VewSettingsSupportPay, 'PAY', this.id)">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportPay}</p>
      </div>

      <div id="balanceButtonId" class="settings-support-buttons settings-support-buttons-balance"
           ontouchstart="goToSettingsStepTwoStart(this.id)"
           ontouchend="goToSettingsStepTwoEnd(window.languages.VewSettingsSupportBalance, 'BALANS', this.id)">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportBalance}</p>
      </div>

      <div id="otherButtonId" class="settings-support-buttons settings-support-buttons-other"
           ontouchstart="goToSettingsStepTwoStart(this.id)"
           ontouchend="goToSettingsStepTwoEnd(window.languages.VewSettingsSupportOther, 'OTHER', this.id)">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">{window.languages.VewSettingsSupportOther}</p>
      </div>

    </div>

  </div>


  <script>
    var scope = this;

    var closeButtonStartX, closeButtonEndX, closeButtonStartY, closeButtonEndY;

    closeSettingsSupportTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      closeButtonId.style.webkitTransform = 'scale(0.8)'

      closeButtonStartX = event.changedTouches[0].pageX;
      closeButtonStartY = event.changedTouches[0].pageY;

    };

    closeSettingsSupportTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      closeButtonId.style.webkitTransform = 'scale(1)'

      closeButtonEndX = event.changedTouches[0].pageX;
      closeButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(closeButtonStartX - closeButtonEndX) <= 20 && Math.abs(closeButtonStartY - closeButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    var goToButtonStartX, goToButtonEndX, goToButtonStartY, goToButtonEndY;

    goToSettingsStepTwoStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.2)'

      goToButtonStartX = event.changedTouches[0].pageX;
      goToButtonStartY = event.changedTouches[0].pageY;
    }

    goToSettingsStepTwoEnd = function (titleOfHelp, keyOfHelp, id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.backgroundColor = 'transparent'

      goToButtonEndX = event.changedTouches[0].pageX;
      goToButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToButtonStartX - goToButtonEndX) <= 20 && Math.abs(goToButtonStartY - goToButtonEndY) <= 20) {
        riotTags.innerHTML = "<view-settings-support-part-two>";
        riot.mount('view-settings-support-part-two', {title: titleOfHelp, key: keyOfHelp});

        scope.unmount()
      }
    }


  </script>
</view-settings-support>

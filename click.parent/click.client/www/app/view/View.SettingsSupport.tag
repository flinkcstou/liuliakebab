<view-settings-support id="settingsSupportId" class="view-settings-support">
  <div class="settings-support-blue-container">

    <div class="settings-support-page-title">
      <div class="settings-support-x-button" ontouchend="closeSettingsSupportTouchEnd()"></div>
    </div>

    <div class="settings-support-help-icon"></div>

    <p class="settings-support-help-title">Если вы обнаружили ошибку, хотите получить помощь или внести предложение,
      пожалуйста, сообщите нам об этом</p>
  </div>
  <div class="settings-support-container">
    <p class="settings-support-container-title">ВЫБЕРИТЕ ТЕМУ ДЛЯ ОБРАЩЕНИЯ</p>

    <div class="settings-support-buttons-container">

      <div class="settings-support-buttons settings-support-buttons-registration">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">РЕГИСТРАЦИЯ</p>
      </div>

      <div class="settings-support-buttons settings-support-buttons-pay">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">ОПЛАТА</p>
      </div>

      <div class="settings-support-buttons settings-support-buttons-balance">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">БАЛАНС</p>
      </div>

      <div class="settings-support-buttons settings-support-buttons-other">
        <div class="settings-support-open-icon"></div>
        <p class="settings-support-buttons-title">ДРУГОЕ</p>
      </div>

    </div>

  </div>


  <script>
    var scope = this;

    closeSettingsSupportTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsSupportId.style.display = 'none'
    }


  </script>
</view-settings-support>

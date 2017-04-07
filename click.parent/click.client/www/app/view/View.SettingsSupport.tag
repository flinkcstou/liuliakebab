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

<view-settings-support-part-two class="view-settings-support-part-two">
  <div class="settings-support-part-two-page-title">
    <div class="settings-support-part-two-x-button" ontouchend="closeSettingsSupportTouchEnd()"></div>
  </div>

  <div class="settings-support-part-two-container">
    <p class="settings-support-part-two-container-title">ОБРАЩЕНИЕ НА ТЕМУ РЕГИСТРАЦИИ</p>
    <div class="settings-support-part-two-input-container">
      <textarea id="commentTextId" maxlength="255" class="settings-support-part-two-input"
                type="text" placeholder={comment}></textarea>
    </div>
    <div class="settings-support-part-two-send-button">ОТПРАВИТЬ</div>
  </div>


  <script>
    var scope = this;

    scope.comment = 'Опишите вашу проблему';

    closeSettingsSupportTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsSupportId.style.display = 'none'
    }


  </script>
</view-settings-support-part-two>

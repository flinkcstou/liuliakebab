<view-settings-support-part-two class="view-settings-support-part-two">

  <div class="settings-support-part-two-container">
    <div class="settings-support-part-two-page-title">
      <div class="settings-support-part-two-x-button" ontouchend="closeSettingsSupportPartTwoTouchEnd()"></div>
    </div>

    <p class="settings-support-part-two-container-title">{window.languages.VewSettingsSupportPartTwoTheme}
      {opts.title}</p>
    <div class="settings-support-part-two-input-container">
      <textarea id="commentTextId" maxlength="255" class="settings-support-part-two-input"
                type="text" placeholder={comment}></textarea>
    </div>
    <div class="settings-support-part-two-send-button">{window.languages.VewSettingsSupportPartTwoSend}</div>
  </div>


  <script>
    var scope = this;

    history.arrayOfHistory = history.arrayOfHistory.splice(history.arrayOfHistory.length - 1, 1);

    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


    scope.comment = 'Опишите вашу проблему';

    closeSettingsSupportPartTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-settings>";
      riot.mount('view-settings');
    }


  </script>
</view-settings-support-part-two>

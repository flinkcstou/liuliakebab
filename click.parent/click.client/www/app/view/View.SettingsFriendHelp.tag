<view-friend-help-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">
      <div class="settings-friend-help-contact-container">
        <div class="settings-friend-help-contact-found-photo"
             style="background-image: url({suggestionOne.photo})"></div>
        <div class="settings-friend-help-contact-found-text-container">
          <div class="settings-friend-help-contact-found-text-one">GANIEV JASUR</div>
          <div class="settings-friend-help-contact-found-text-two">+90997474737</div>
        </div>
        <div class="settings-friend-help-contact-cancel-icon"></div>
      </div>

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewFriendHelpSettingsTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-friend-help-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-friend-help-settings',
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


  </script>
</view-friend-help-settings>

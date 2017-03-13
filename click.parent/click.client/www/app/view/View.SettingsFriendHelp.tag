<view-friend-help-settings>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" ontouchend="goToAddFriendView()" class="settings-friend-help-add-button"></div>
    </div>
    <div class="settings-container">
      <div each="{i in arrayOfFriends}" class="settings-friend-help-contact-container">
        <div class="settings-friend-help-contact-found-photo"
             style="background-image: url({i.photo})"></div>
        <div class="settings-friend-help-contact-found-text-container">
          <div class="settings-friend-help-contact-found-text-one">{i.name}</div>
          <div class="settings-friend-help-contact-found-text-two">+{i.number}</div>
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

    goToAddFriendView = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-add-friend>";
      riot.mount("view-add-friend");
    }
    scope.arrayOfFriends = [];

    if (localStorage.getItem('click_client_friends') === null) {
      scope.arrayOfFriends = []
    }
    else {
      scope.arrayOfFriends = JSON.parse(localStorage.getItem('click_client_friends'));
    }


  </script>
</view-friend-help-settings>

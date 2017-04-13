<view-settings>
  <div>
    <div class="settings-page-title">
      <p class="settings-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="settings-back-button"></div>
    </div>
    <div class="settings-container">
      <div class="settings-block-containter" ontouchend="goToMainSettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_general.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewMainSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="goToSecuritySettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_security.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="goToFriendHelpSettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_friendshelp.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewFriendHelpSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="goToInviteFriendSettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_invite.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewInviteFriendSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="goToAboutSettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_about.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewAboutSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="goToSupportSettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_support.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSupportSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div class="settings-block-containter" ontouchend="goToCallCenterSettings()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_callcenter.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewCallCenterSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>
    </div>

  </div>

  <view-settings-support id="settingsSupportId" style="display: none"></view-settings-support>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsTitleNameTwo;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-settings',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }
    componentMenu.check = false;
    scope.supportShow = false;

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };

    goToMainSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-general-settings>";
      riot.mount("view-general-settings");
    }

    goToSecuritySettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-security-settings>";
      riot.mount("view-security-settings");
    }

    goToFriendHelpSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount("view-friend-help-settings");
    }

    goToAboutSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-about-program>";
      riot.mount("view-about-program");
    }

    goToInviteFriendSettings = function () {
      event.preventDefault();
      event.stopPropagation();

    }

    goToSupportSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsSupportId.style.display = 'block';

      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-settings-support') {
        history.arrayOfHistory.push(
          {
            "view": 'view-settings-support',
            "params": opts,
          }
        );
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }

    }

    goToCallCenterSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      window.open('tel:+998712310880')
    }

  </script>
</view-settings>

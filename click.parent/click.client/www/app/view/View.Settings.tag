<view-settings>
  <div class="riot-tags-main-container">
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
//      scope.unmount()
    };

    goToMainSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-general-settings>";
      riot.mount("view-general-settings");

      scope.unmount()
    }

    goToSecuritySettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-security-settings>";
      riot.mount("view-security-settings");

      scope.unmount()
    }

    goToFriendHelpSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-friend-help-settings>";
      riot.mount("view-friend-help-settings");

      scope.unmount()
    }

    goToAboutSettings = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-about-program>";
      riot.mount("view-about-program");

      scope.unmount()
    }

    goToInviteFriendSettings = function () {
      event.preventDefault();
      event.stopPropagation();
      var text = "Привет! Подключайтесь к CLICK с новыми возможностями! Управляйте своими картами, Проверяйте общий баланс карт, Переводите средства с карты на карту, Оплачивайте любые услуги и погашайте кредиты!" +"Набирайте '*880#', скачивайте новое приложение CLICK Uzbekistan http://click.uz/a или пользуйтесь персональным кабинетом http://my.click.uz"
        + "(Для подключения необходимо включить услугу смс-информирования)."
      var title = "CLICK"

      window.plugins.socialsharing.share(text, title, null, null)

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

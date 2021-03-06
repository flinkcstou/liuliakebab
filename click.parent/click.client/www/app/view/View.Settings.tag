<view-settings>
  <div class="riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="settingsGoToBackStart()"
           ontouchend="settingsGoToBackEnd()"
           class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="settings-container">
      <div id="mainSettingsButtonId" class="settings-block-containter" ontouchstart="goToMainSettingsTouchStart()"
           ontouchend="goToMainSettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_general.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewMainSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="securitySettingsButtonId" class="settings-block-containter"
           ontouchstart="goToSecuritySettingsTouchStart()" ontouchend="goToSecuritySettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_security.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSecuritySettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="friendHelpSettingsButtonId" class="settings-block-containter"
           ontouchstart="goToFriendHelpSettingsTouchStart()" ontouchend="goToFriendHelpSettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_friendshelp.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewFriendHelpSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="inviteSettingsButtonId" class="settings-block-containter"
           ontouchstart="goToInviteFriendSettingsTouchStart()" ontouchend="goToInviteFriendSettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_invite.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewInviteFriendSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="goToAboutSettingsButtonId" class="settings-block-containter" ontouchstart="goToAboutSettingsTouchStart()"
           ontouchend="goToAboutSettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_about.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewAboutSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="goToSupportSettingsButtonId" class="settings-block-containter"
           ontouchstart="goToSupportSettingsTouchStart()" ontouchend="goToSupportSettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_support.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewSupportSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="callSettingsButtonId" class="settings-block-containter" ontouchstart="goToCallCenterSettingsTouchStart()"
           ontouchend="goToCallCenterSettingsTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_callcenter.png')"></div>
        <div class="settings-block-name-field">{window.languages.ViewCallCenterSettingsTitle}</div>
        <div class="settings-block-next-icon"></div>
      </div>

      <div id="clearButtonId" class="settings-block-containter" ontouchstart="localStorageClearTouchStart()"
           ontouchend="localStorageClearTouchEnd()">
        <div class="settings-block-icon"
             style="background-image: url('resources/icons/ViewSettings/settings_clear.png')"></div>
        <div class="settings-block-name-field">{window.languages.ClearLocalStorage}</div>
        <div class="settings-block-next-icon" if="{false}"></div>
      </div>
    </div>

  </div>

  <view-settings-support id="settingsSupportId" style="display: none"></view-settings-support>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsTitleNameTwo;

    window.saveHistory('view-settings', opts);

    componentMenu.check = false;
    scope.supportShow = false;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    settingsGoToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    };

    settingsGoToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {

        onBackKeyDown()
      }
//      scope.unmount()
    };

    var mainSettingsButtonStartX, mainSettingsButtonEndX, mainSettingsButtonStartY, mainSettingsButtonEndY;

    goToMainSettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

//      mainSettingsButtonId.style.webkitTransform = 'scale(0.9)'

      mainSettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      mainSettingsButtonStartX = event.changedTouches[0].pageX;
      mainSettingsButtonStartY = event.changedTouches[0].pageY;

    };

    goToMainSettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

//      mainSettingsButtonId.style.webkitTransform = 'scale(1)'

      mainSettingsButtonId.style.backgroundColor = 'transparent';

      mainSettingsButtonEndX = event.changedTouches[0].pageX;
      mainSettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(mainSettingsButtonStartX - mainSettingsButtonEndX) <= 20 && Math.abs(mainSettingsButtonStartY - mainSettingsButtonEndY) <= 20) {
        riotTags.innerHTML = "<view-general-settings>";
        riot.mount("view-general-settings");

        scope.unmount()
      }
    };

    var securitySettingsButtonStartX, securitySettingsButtonEndX, securitySettingsButtonStartY,
      securitySettingsButtonEndY;

    goToSecuritySettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      securitySettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      securitySettingsButtonStartX = event.changedTouches[0].pageX;
      securitySettingsButtonStartY = event.changedTouches[0].pageY;

    };

    goToSecuritySettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      securitySettingsButtonId.style.backgroundColor = 'transparent';

      securitySettingsButtonEndX = event.changedTouches[0].pageX;
      securitySettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(securitySettingsButtonStartX - securitySettingsButtonEndX) <= 20 && Math.abs(securitySettingsButtonStartY - securitySettingsButtonEndY) <= 20) {
        riotTags.innerHTML = "<view-security-settings>";
        riot.mount("view-security-settings");

        scope.unmount()
      }
    };

    var friendHelpSettingsButtonStartX, friendHelpSettingsButtonEndX, friendHelpSettingsButtonStartY,
      friendHelpSettingsButtonEndY;

    goToFriendHelpSettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      friendHelpSettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      friendHelpSettingsButtonStartX = event.changedTouches[0].pageX;
      friendHelpSettingsButtonStartY = event.changedTouches[0].pageY;


    };

    goToFriendHelpSettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      friendHelpSettingsButtonId.style.backgroundColor = 'transparent';

      friendHelpSettingsButtonEndX = event.changedTouches[0].pageX;
      friendHelpSettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(friendHelpSettingsButtonStartX - friendHelpSettingsButtonEndX) <= 20 && Math.abs(friendHelpSettingsButtonStartY - friendHelpSettingsButtonEndY) <= 20) {
        riotTags.innerHTML = "<view-friend-help-settings>";
        riot.mount("view-friend-help-settings");

        scope.unmount()
      }
    };


    var goToAboutSettingsButtonStartX, goToAboutSettingsButtonEndX, goToAboutSettingsButtonStartY,
      goToAboutSettingsButtonEndY;

    goToAboutSettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      goToAboutSettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      goToAboutSettingsButtonStartX = event.changedTouches[0].pageX;
      goToAboutSettingsButtonStartY = event.changedTouches[0].pageY;
    };

    goToAboutSettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      goToAboutSettingsButtonId.style.backgroundColor = 'transparent';

      goToAboutSettingsButtonEndX = event.changedTouches[0].pageX;
      goToAboutSettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToAboutSettingsButtonStartX - goToAboutSettingsButtonEndX) <= 20 && Math.abs(goToAboutSettingsButtonStartY - goToAboutSettingsButtonEndY) <= 20) {
        riotTags.innerHTML = "<view-about-program>";
        riot.mount("view-about-program");

        scope.unmount()
      }
    };

    var inviteSettingsButtonStartX, inviteSettingsButtonEndX, inviteSettingsButtonStartY, inviteSettingsButtonEndY;

    goToInviteFriendSettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      inviteSettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      inviteSettingsButtonStartX = event.changedTouches[0].pageX;
      inviteSettingsButtonStartY = event.changedTouches[0].pageY;

    };

    goToInviteFriendSettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      inviteSettingsButtonId.style.backgroundColor = 'transparent';

      inviteSettingsButtonEndX = event.changedTouches[0].pageX;
      inviteSettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(inviteSettingsButtonStartX - inviteSettingsButtonEndX) <= 20 && Math.abs(inviteSettingsButtonStartY - inviteSettingsButtonEndY) <= 20) {
        window.pickContactFromNativeChecker = true;
        var text = "Привет! Подключайтесь к CLICK с новыми возможностями! Управляйте своими картами, Проверяйте общий баланс карт, Переводите средства с карты на карту, Оплачивайте любые услуги и погашайте кредиты!" + "Набирайте '*880#', скачивайте новое приложение CLICK Uzbekistan http://click.uz/a или пользуйтесь персональным кабинетом http://my.click.uz"
          + "(Для подключения необходимо включить услугу смс-информирования).";
        var title = "CLICK";

        window.plugins.socialsharing.share(text, title, null, null)
      }
    };


    var goToSupportSettingsButtonStartX, goToSupportSettingsButtonEndX, goToSupportSettingsButtonStartY,
      goToSupportSettingsButtonEndY;

    goToSupportSettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      goToSupportSettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      goToSupportSettingsButtonStartX = event.changedTouches[0].pageX;
      goToSupportSettingsButtonStartY = event.changedTouches[0].pageY;

    };

    goToSupportSettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      goToSupportSettingsButtonId.style.backgroundColor = 'transparent';

      goToSupportSettingsButtonEndX = event.changedTouches[0].pageX;
      goToSupportSettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToSupportSettingsButtonStartX - goToSupportSettingsButtonEndX) <= 20 && Math.abs(goToSupportSettingsButtonStartY - goToSupportSettingsButtonEndY) <= 20) {
        settingsSupportId.style.display = 'block';

        window.saveHistory('view-settings-support', opts);

      }

    };

    var callSettingsButtonStartX, callSettingsButtonEndX, callSettingsButtonStartY, callSettingsButtonEndY;

    goToCallCenterSettingsTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      callSettingsButtonStartX = event.changedTouches[0].pageX;
      callSettingsButtonStartY = event.changedTouches[0].pageY;

      callSettingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

    };

    goToCallCenterSettingsTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      callSettingsButtonId.style.backgroundColor = 'transparent';

      callSettingsButtonEndX = event.changedTouches[0].pageX;
      callSettingsButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(callSettingsButtonStartX - callSettingsButtonEndX) <= 20 && Math.abs(callSettingsButtonStartY - callSettingsButtonEndY) <= 20) {
        window.open('tel:+998712310880')
      }
    };

    var resetLocalStorageTouchStartX, resetLocalStorageTouchStartY, resetLocalStorageTouchEndX,
      resetLocalStorageTouchEndY;

    localStorageClearTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      clearButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)';

      resetLocalStorageTouchStartX = event.changedTouches[0].pageX;
      resetLocalStorageTouchStartY = event.changedTouches[0].pageY;
    };

    localStorageClearTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      resetLocalStorageTouchEndX = event.changedTouches[0].pageX;
      resetLocalStorageTouchEndY = event.changedTouches[0].pageY;

      clearButtonId.style.backgroundColor = 'transparent';

      if (Math.abs(resetLocalStorageTouchStartX - resetLocalStorageTouchEndX) <= 20 && Math.abs(resetLocalStorageTouchStartY - resetLocalStorageTouchEndY) <= 20) {

        var question = 'Подтвердите удаление данных';
//        confirm(question)
        scope.confirmNote = question;
        scope.confirmType = 'local';

        window.common.alert.show("componentConfirmId", {
          "confirmnote": scope.confirmNote,
          "confirmtype": scope.confirmType,
          parent: scope
        });

        scope.update();
        scope.result = function (bool) {
          if (bool) {
            localStorage.clear();
            if (device.platform != 'BrowserStand') {
              window.FirebasePlugin.unsubscribe("news");

            }
            riotTags.innerHTML = "<view-registration-device>";
            riot.mount('view-registration-device');
            scope.unmount();
          }
        };
//      if (scope.result) {
//        localStorage.clear();
//        this.riotTags.innerHTML = "<view-registration-device>";
//        riot.mount('view-registration-device');
//        return
//      }
      }
    }

  </script>
</view-settings>

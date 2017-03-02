<component-menu>
  <div id="sideMenuBackPageId" ontouchend="menuBackPageTouchEnd()" class="side-menu-back-page"></div>
  <div id="sideMenuId" class="side-menu">

    <div class="side-menu-inside-button" ontouchend="closeMenu()"></div>
    <div class="side-menu-user-info-container">
      <div class="side-menu-user-icon" style="background-image: url({photo})"></div>
      <p class="side-menu-user-second-name">{firstName}</p>
      <p class="side-menu-user-first-name">{lastName}</p>
    </div>
    <div id="changeModeContainerId" class="side-menu-change-mode">
      <div class="side-menu-change-mode-icon"></div>
      <p class="side-menu-change-mode-text">{modeOfApplication}</p>
      <label class="switch-menu">
        <input onchange="changeMode()" id="checkBoxChangeId" type="checkbox" checked="{checkModeOfApplication}">
        <div class="slider-menu round"></div>
      </label>
    </div>
    <div class="side-menu-billings-container">
      <div class="side-menu-containers-icon side-menu-containers-icon-billings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-billings">Выставленные счета</div>
    </div>

    <div class="side-menu-favorite-container">
      <div class="side-menu-containers-icon side-menu-containers-icon-favorite"></div>
      <div class="side-menu-containers-name side-menu-containers-name-favorite">Избранные</div>
    </div>

    <div class="side-menu-auto-pay-container">
      <div class="side-menu-containers-icon side-menu-containers-icon-autopayment"></div>
      <div class="side-menu-containers-name side-menu-containers-name-autopayment">Автоплатеж</div>
    </div>

    <div class="side-menu-scanner-qr-container">
      <div class="side-menu-containers-icon side-menu-containers-icon-scanner-qr"></div>
      <div class="side-menu-containers-name side-menu-containers-name-scanner-qr">Сканер QR-кода</div>
    </div>

    <div class="side-menu-settings-container">
      <div class="side-menu-containers-icon side-menu-containers-icon-settings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-settings">Настройки</div>
    </div>

    <div class="side-menu-call-container" ontouchend="callToClick()">
      <div class="side-menu-containers-icon side-menu-containers-icon-call"></div>
      <div class="side-menu-containers-name side-menu-containers-name-call">Позвонить в Click</div>
    </div>
  </div>
  <script>
    var scope = this;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;
    if (modeOfApp.onlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
      scope.checkModeOfApplication = true;
    }
    if (modeOfApp.offlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
      scope.checkModeOfApplication = false;
    }

    this.on('mount', function () {
      if (modeOfApp.onlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
        scope.checkModeOfApplication = true;
        changeModeContainerId.style.backgroundColor = '#92bf3a'
      }
      if (modeOfApp.offlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
      }
      riot.update();
    })

    closeMenu = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      componentMenu.checkOpen = false;

      sideMenuBackPageId.style.opacity = '0';
      sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      mainPageId.style.opacity = '1';
      this.mainPageId.style.zIndex = '0';

    }

    changeMode = function () {
      console.log(checkBoxChangeId.checked)
      if (checkBoxChangeId.checked) {
        modeOfApp.onlineMode = true
        modeOfApp.offlineMode = false;
        this.riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
        return
      }
      else {
        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;
      }
      if (modeOfApp.onlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
        changeModeContainerId.style.backgroundColor = '#92bf3a'
        scope.checkModeOfApplication = true;
      }
      if (modeOfApp.offlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
      }
      riot.update()
    }

    menuBackPageTouchEnd = function () {
      closeMenu()
    }
    callToClick = function () {
      event.preventDefault();
      event.stopPropagation();

      window.open('tel:+998712310880')
    }

    goToSettings = function () {
      closeMenu();
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-settings>";
      riot.mount("view-settings");

    }


  </script>
</component-menu>
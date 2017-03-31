<component-menu>
  <div id="sideMenuBackPageId" ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>
  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="sideMenuId" class="side-menu">

    <div class="side-menu-inside-button" ontouchend="closeMenu()"></div>
    <div class="side-menu-user-info-container">
      <div class="side-menu-user-icon" style="background-image: url({photo})" ontouchend="userIconTouchEnd()"></div>
      <p class="side-menu-user-second-name">{firstName}</p>
      <p class="side-menu-user-first-name">{lastName}</p>
    </div>
    <div id="changeModeContainerId" class="side-menu-change-mode">
      <div id="changeModeIconId" class="side-menu-change-mode-icon"></div>
      <p class="side-menu-change-mode-text">{modeOfApplication}</p>
      <label class="switch-menu">
        <input onchange="changeMode()" id="checkBoxChangeId" type="checkbox" checked="{checkModeOfApplication}">
        <div class="slider-menu round"></div>
      </label>
    </div>
    <div class="side-menu-billings-container" ontouchstart="goToBillingsTouchStart()"
         ontouchend="goToBillingsTouchEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-billings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-billings">Выставленные счета</div>
    </div>

    <div class="side-menu-favorite-container" ontouchstart="goToFavoritesStart()" ontouchend="goToFavoritesEnd()">
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

    <div class="side-menu-settings-container" ontouchstart="goToSettingsStart()" ontouchend="goToSettingsEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-settings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-settings">Настройки</div>
    </div>

    <div class="side-menu-call-container" ontouchend="callToClickTouchEnd()" ontouchstart="callToClickTouchStart()">
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
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
      }
      if (modeOfApp.offlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
      }
      riot.update();
    })

    userIconTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      riotTags.innerHTML = "<view-general-settings>";
      riot.mount("view-general-settings");
    }

    closeMenu = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      componentMenu.checkOpen = false;

      sideMenuId.style.webkitTransition = '0.3s';
      sideMenuBackPageId.style.opacity = '0';
      sideMenuBackPageId.style.webkitTransition = '0';
      sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      mainPageId.style.opacity = '1';
      mainPageId.style.zIndex = '0';
      riot.update();
    }

    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndXs;
    var width = window.innerWidth;

    sideMenuTouchStart = function () {
      sideMenuId.style.webkitTransition = '0s';
      mainPageId.style.webkitTransition = '0s';
      sideMenuBackPageId.style.webkitTransition = '0s';
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);

    }

    sideMenuTouchEnd = function () {
//      event.preventDefault();
//      event.stopPropagation();
      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      console.log('touchEndMove', touchEndMove)

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeMenu();
      }
      else {
        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
          closeMenu();
        }
        else
          menuOpen()
      }
    }

    sideMenuTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      touchMoveX = event.changedTouches[0].pageX;
      if (touchStartX < touchMoveX) return
      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
      var deltaForSideMenuBack = 1 - deltaForMainPage;
      if (deltaForSideMenuBack < 0.1)
        deltaForSideMenuBack = 0.1

      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
      //console.log('deltaForMainPage', deltaForMainPage)
      mainPageId.style.opacity = deltaForMainPage;

      if (touchMoveX - touchStartX <= 0) {
        sideMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)'
        touchEndMove = touchMoveX - touchStartX
      }

    }

    changeMode = function () {
      console.log('asd')
      event.preventDefault();
      event.stopPropagation();
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
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
      }
      if (modeOfApp.offlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
      }
      riot.update()
    }

    //    menuBackPageTouchEnd = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //      console.log(event.changedTouches[0].pageX)
    //      if (event.changedTouches[0].pageX > 550 * widthK)
    //        closeMenu()
    //      else return
    //    }

    var callTouchStartX, callTouchEndX
    callToClickTouchEnd = function () {
      callTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(callTouchStartX - callTouchEndX < 20)) {
        closeMenu()
        window.open('tel:+998712310880')
      }
      else sideMenuTouchEnd()

    }

    callToClickTouchStart = function () {
      callTouchStartX = event.changedTouches[0].pageX;
    }

    var settingsTouchStartX, settingsTouchEndX

    goToSettingsEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsTouchEndX = event.changedTouches[0].pageX;

      console.log('settingsTouchStartX', settingsTouchStartX)
      console.log('settingsTouchEndX', settingsTouchEndX)

      if (Math.abs(settingsTouchStartX - settingsTouchEndX) < 20) {
        closeMenu()
        riotTags.innerHTML = "<view-settings>";
        riot.mount("view-settings");
        return
      }
      else sideMenuTouchEnd()

    }

    goToSettingsStart = function () {
      settingsTouchStartX = event.changedTouches[0].pageX;
    }


    goToBillingsTouchStart = function () {

      billingsTouchStartX = event.changedTouches[0].pageX;
    };

    goToBillingsTouchEnd = function () {

      billingsTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(billingsTouchEndX - billingsTouchStartX < 20)) {

        closeMenu();

        history.arrayOfHistory.push({view: "view-invoice-list"});
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
        riotTags.innerHTML = "<view-invoice-list>";
        riot.mount("view-invoice-list");
        return
      }
    };

    var favoritesTouchStartX, favoritesTouchEndX;

    goToFavoritesEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      favoritesTouchEndX = event.changedTouches[0].pageX;

      console.log('settingsTouchStartX', favoritesTouchStartX)
      console.log('settingsTouchEndX', favoritesTouchEndX)

      if (favoritesTouchStartX - favoritesTouchEndX < 20) {
        closeMenu();
        riotTags.innerHTML = "<view-favorites>";
        riot.mount("view-favorites");
        return
      }
      else sideMenuTouchEnd()

    }

    goToFavoritesStart = function () {
      favoritesTouchStartX = event.changedTouches[0].pageX;
    }


  </script>
</component-menu>
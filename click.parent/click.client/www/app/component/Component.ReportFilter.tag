<component-report-filter>
  <div id="filterMenuBackPageId" ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>
  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="filterMenuId" class="filter-menu">

    <div class="filter-menu-inside-button" ontouchend="closeMenu()">
      <p class="view-reports-filter-text filter-inside-text">Фильтры</p>
      <div type="button" class="view-reports-filter-button filter-inside-button"></div>
    </div>
    <div class="filter-menu-title">Выбрать даты для фильтра</div>
    <div class="filter-menu-body-container">

      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-date-icon"
             style="background-image: url('resources/icons/ViewReport/date_from.png')"></div>
        <div class="filter-menu-name-field">С 17.02.2017</div>
        <div class="filter-menu-date-next-icon"></div>
      </div>
      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-date-icon"
             style="background-image: url('resources/icons/ViewReport/date_to.png')"></div>
        <div class="filter-menu-name-field">По 18.03.2017</div>
        <div class="filter-menu-date-next-icon"></div>
      </div>

      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-name-field">За сегодня</div>
      </div>
      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-name-field">За вчера</div>
      </div>
      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-name-field">За текущую неделю</div>
      </div>
      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-name-field">За прошлую неделю</div>
      </div>
      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
        <div class="filter-menu-name-field">За текущий месяц</div>
      </div>
      <div class="filter-menu-block-containter" ontouchend="goToMainSettings()" style="border: none;">
        <div class="filter-menu-name-field">За прошлый месяц</div>
      </div>


    </div>

  </div>
  <script>
    var scope = this;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;


    userIconTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-general-settings>";
      riot.mount("view-general-settings");
    }

    closeMenu = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      componentMenu.checkOpen = false;

      filterMenuId.style.webkitTransition = '0.3s';
      filterMenuBackPageId.style.opacity = '0';
      filterMenuBackPageId.style.webkitTransition = '0';
      filterMenuId.style.webkitTransform = "translate3d(0, -100%, 0)";
      filterMenuId.style.Transform = "translate3d(0, -100%, 0)";
      reportPageId.style.opacity = '1';
      reportPageId.style.zIndex = '0';
      riot.update();
    }

    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndXs;
    var width = window.innerWidth;

    sideMenuTouchStart = function () {
//      filterMenuId.style.webkitTransition = '0s';
//      reportPageId.style.webkitTransition = '0s';
//      filterMenuBackPageId.style.webkitTransition = '0s';
//      touchStartX = event.changedTouches[0].pageX;
//      timeStartX = event.timeStamp.toFixed(0);

    }

    sideMenuTouchEnd = function () {
//      event.preventDefault();
//      event.stopPropagation();
//      touchEndX = event.changedTouches[0].pageX;
//      timeEndX = event.timeStamp.toFixed(0);
//
//      console.log('touchEndMove', touchEndMove)
//
//      if ((Math.abs(touchEndMove) > 230 * widthK)) {
//        closeMenu();
//      }
//      else {
//        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
//          closeMenu();
//        }
//        else
//          menuOpen()
//      }
    }

    sideMenuTouchMove = function () {
//      event.preventDefault();
//      event.stopPropagation();
//      touchMoveX = event.changedTouches[0].pageX;
//      if (touchStartX < touchMoveX) return
//      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
//      var deltaForSideMenuBack = 1 - deltaForMainPage;
//      if (deltaForSideMenuBack < 0.1)
//        deltaForSideMenuBack = 0.1
//
//      filterMenuBackPageId.style.opacity = deltaForSideMenuBack;
//      //console.log('deltaForMainPage', deltaForMainPage)
//      reportPageId.style.opacity = deltaForMainPage;
//
//      if (touchMoveX - touchStartX <= 0) {
//        filterMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)'
//        touchEndMove = touchMoveX - touchStartX
//      }
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
</component-report-filter>
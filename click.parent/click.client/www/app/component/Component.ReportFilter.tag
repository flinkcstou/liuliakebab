<component-report-filter>
  <div id="filterMenuBackPageId" ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>

  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="filterMenuId"
       class="filter-menu {filter-minor-menu: filterDate || filterAccount, filter-main-menu: !(filterDate || filterAccount)}">

    <div class="filter-menu-inside-button" ontouchend="closeMenu()">
      <p class="view-reports-filter-text {filter-inside-text: filterDate || filterAccount, filter-inside-text-main: !(filterDate || filterAccount)}">
        {languages.ComponentReportFilterTitle}</p>
      <div type="button"
           class="view-reports-filter-button {filter-inside-button: filterDate || filterAccount, filter-inside-button-main: !(filterDate || filterAccount)}"></div>
    </div>

    <div if="{filterAccount}">
      <div class="filter-menu-title">{languages.ComponentReportFilterAccount}</div>
      <div class="filter-menu-body-container">

        <component-pincards filteraccount="true"></component-pincards>

      </div>

    </div>

    <div if="{filterDate}">
      <div class="filter-menu-title">{languages.ComponentReportFilterDate}</div>
      <div class="filter-menu-body-container">

        <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
          <div class="filter-menu-date-icon"
               style="background-image: url('resources/icons/ViewReport/date_from.png')"></div>
          <div class="filter-menu-name-field">{languages.ComponentReportFilterByDateFrom}
            {from_dd}.{from_mm}.{from_yyyy}
          </div>
          <div class="filter-menu-date-next-icon"></div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="goToMainSettings()">
          <div class="filter-menu-date-icon"
               style="background-image: url('resources/icons/ViewReport/date_to.png')"></div>
          <div class="filter-menu-name-field">{languages.ComponentReportFilterByDateTo} {to_dd}.{to_mm}.{to_yyyy}</div>
          <div class="filter-menu-date-next-icon"></div>
        </div>

        <div class="filter-menu-block-containter" ontouchend="setDate(componentReportFilter.today)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateToday}</div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="setDate(componentReportFilter.yesterday)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateYesterday}</div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="setDate(componentReportFilter.currentWeek)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateWeek}</div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="setDate(componentReportFilter.pastWeek)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDatePastWeek}</div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="setDate(componentReportFilter.currentMonth)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateCurrentMonth}</div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="setDate(componentReportFilter.pastMonth)"
             style="border: none;">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDatePastMonth}</div>
        </div>
      </div>

    </div>

    <div if="{!(filterDate || filterAccount)}" class="report-filter-filters-content-container">
      <div class="report-filter-filter-container">
        <p class="report-filter-filter-title">{languages.ComponentReportFilterByDate}</p>
        <img class="report-filter-filter-plus-icon" src="resources/icons/ViewSettingsFriendHelp/plus.png"
             ontouchend="filterDateTouchEnd()" ontouchstart="filterDateTouchStart()">
        <div class="report-filter-filter-chosen-filter-container"></div>
      </div>
      <div class="report-filter-filter-container">
        <p class="report-filter-filter-title">{languages.ComponentReportFilterByAccount}</p>
        <img class="report-filter-filter-plus-icon" src="resources/icons/ViewSettingsFriendHelp/plus.png"
             ontouchend="filterAccountTouchEnd()" ontouchstart="filterAccountTouchStart()">
        <div class="report-filter-filter-chosen-filter-container"></div>
      </div>
    </div>

    <button class="report-filter-ready-button" if="{filterDate || filterAccount}" ontouchstart="readyButtonTouchStart()"
            ontouchend="readyButtonTouchEnd()">
      {languages.ComponentReportFilterReadyButton}
    </button>

  </div>
  <script>
    var scope = this,
        filterDateTouchStartX,
        filterDateTouchEndX,
        filterAccountTouchStartX,
        filterAccountTouchEndX,
        readyButtonTouchStartX,
        readyButtonTouchEndX,
        date;

    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;

    scope.filterDate = false;
    scope.filterAccount = false;

    setDate = function (forWhatDate) {

      date = new Date();

      //Filter Date To
      switch (forWhatDate) {

        case componentReportFilter.today:
        case componentReportFilter.currentWeek:
        case componentReportFilter.currentMonth:
        {
          scope.to_dd = date.getDate();
          scope.to_mm = date.getMonth() + 1;
          scope.to_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.yesterday:
        {
          date.setDate(date.getDate() - 1);

          scope.to_dd = date.getDate();
          scope.to_mm = date.getMonth() + 1;
          scope.to_yyyy = date.getFullYear();

          scope.from_dd = date.getDate();
          scope.from_mm = date.getMonth() + 1;
          scope.from_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.pastWeek:
        {
          day = date.getDay();

          day = (day) ? (day) : (7);

          day = date.getDate() - day;

          date.setDate(day);

          scope.to_dd = date.getDate();
          scope.to_mm = date.getMonth() + 1;
          scope.to_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.pastMonth:
        {
          date.setDate(0);

          scope.to_dd = date.getDate();
          scope.to_mm = date.getMonth() + 1;
          scope.to_yyyy = date.getFullYear();

          break;
        }
      }

      //Filter Date From
      switch (forWhatDate) {

        case componentReportFilter.today:
        {
          scope.from_dd = date.getDate();
          scope.from_mm = date.getMonth() + 1;
          scope.from_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.currentWeek:
        {
          day = date.getDay();

          day = (day) ? (day) : (7);
          day--;

          day = date.getDate() - day;

          date.setDate(day);

          scope.from_dd = date.getDate();
          scope.from_mm = date.getMonth() + 1;
          scope.from_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.currentMonth:
        {
          date.setDate(1);

          scope.from_dd = date.getDate();
          scope.from_mm = date.getMonth() + 1;
          scope.from_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.pastWeek:
        {
          day = date.getDay();

          day = (day) ? (day) : (7);
          day--;

          day = date.getDate() - day;

          date.setDate(day);

          scope.from_dd = date.getDate();
          scope.from_mm = date.getMonth() + 1;
          scope.from_yyyy = date.getFullYear();

          break;
        }
        case componentReportFilter.pastMonth:
        {
          date.setDate(1);

          scope.from_dd = date.getDate();
          scope.from_mm = date.getMonth() + 1;
          scope.from_yyyy = date.getFullYear();

          break;
        }
      }

      riot.update();
    };

    readyButtonTouchStart = function () {

      readyButtonTouchStartX = event.changedTouches[0].pageX;
    };

    readyButtonTouchEnd = function () {

      readyButtonTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(readyButtonTouchEndX - readyButtonTouchStartX) < 20) {

        scope.filterDate = false;
        scope.filterAccount = false;
        riot.update();
      }
    };

    filterDateTouchStart = function () {

      filterDateTouchStartX = event.changedTouches[0].pageX;
    };

    filterDateTouchEnd = function () {

      filterDateTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(filterDateTouchEndX - filterDateTouchStartX) < 20) {

        date = new Date();

        scope.to_dd = date.getDate();
        scope.to_mm = date.getMonth() + 1;
        scope.to_yyyy = date.getFullYear();

        date.setMonth((scope.to_mm - 1) - 1);

        scope.from_dd = date.getDate();
        scope.from_mm = date.getMonth() + 1;
        scope.from_yyyy = date.getFullYear();

        scope.filterDate = true;
        scope.filterAccount = false;
        riot.update();
      }
    };

    filterAccountTouchStart = function () {

      filterAccountTouchStartX = event.changedTouches[0].pageX;
    };

    filterAccountTouchEnd = function () {

      filterAccountTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(filterAccountTouchEndX - filterAccountTouchStartX) < 20) {

        scope.filterDate = false;
        scope.filterAccount = true;
        riot.update();
      }
    };

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

      scope.filterAccount = false;
      scope.filterDate = false;

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
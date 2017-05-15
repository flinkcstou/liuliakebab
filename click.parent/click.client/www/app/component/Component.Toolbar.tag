<component-toolbar>
  <div id="toolbar" class="toolbar">
    <div class="menu-button menu-icon" ontouchstart="menuOpenTouchStart()" ontouchend="menuOpenTouchEnd()">
    </div>

    <div id="circleMenuId" class="toolbar-circle-container" ontouchend="goToViewInfoTouchEnd()"
         ontouchstart="goToViewInfoTouchStart()">
    </div>

    <div class="bell-button bell-icon" ontouchstart="bellButtonTouchStart()" ontouchend="bellButtonTouchEnd()">
      <div if="{window.News.newsCounter != 0 && !modeOfApp.offlineMode}" class="bell-button-news-counter">
        {window.News.newsCounter}
      </div>
    </div>

  </div>

  <script id="toolbarScriptId">
    var scope = this,
      goToViewInfoTouchStartX,
      goToViewInfoTouchStartY,
      goToViewInfoTouchEndX,
      goToViewInfoTouchEndY;

    var openMenuTouchStartX,
      openMenuTouchStartY,
      openMenuTouchEndX,
      openMenuTouchEndY;

    menuOpenTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      openMenuTouchStartX = event.changedTouches[0].pageX;
      openMenuTouchStartY = event.changedTouches[0].pageY;
    }

    menuOpenTouchEnd = function (open) {
      event.preventDefault();
      event.stopPropagation();

      openMenuTouchEndX = event.changedTouches[0].pageX;
      openMenuTouchEndY = event.changedTouches[0].pageY;

      if ((Math.abs(openMenuTouchStartX - openMenuTouchEndX) <= 20 && Math.abs(openMenuTouchStartY - openMenuTouchEndY) <= 20) || open) {


        componentMenu.check = true;


        componentMenu.checkOpen = true;

        this.sideMenuBackPageId.style.webkitTransition = '0.3s';
        this.mainPageId.style.webkitTransition = '0.3s';
        this.mainPageId.style.zIndex = '-1';
        this.mainPageId.style.opacity = '0.1';
        this.sideMenuId.style.webkitTransition = '0.3s';
        this.sideMenuId.style.transform = "translate(0, 0)";
        this.sideMenuId.style.webkitTransform = "translate(0, 0)";

        this.sideMenuBackPageId.style.opacity = '1';
      }
    };

    var bellButtonTouchStartX,
      bellButtonTouchStartY,
      bellButtonTouchEndX,
      bellButtonTouchEndY;

    bellButtonTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      bellButtonTouchStartX = event.changedTouches[0].pageX;
      bellButtonTouchStartY = event.changedTouches[0].pageY;
    }

    bellButtonTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      bellButtonTouchEndX = event.changedTouches[0].pageX;
      bellButtonTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(bellButtonTouchStartX - bellButtonTouchEndX) <= 20 && Math.abs(bellButtonTouchStartY - bellButtonTouchEndY) <= 20) {

        if (modeOfApp.offlineMode)return

        viewNewsId.style.display = 'block'

        window.News.newsCounter = 0;

        if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-news') {
          history.arrayOfHistory.push(
            {
              "view": 'view-news',
              "params": opts
            }
          );
          sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
        }
      }
    };

    goToViewInfoTouchStart = function () {

      goToViewInfoTouchStartX = event.changedTouches[0].pageX;
      goToViewInfoTouchStartY = event.changedTouches[0].pageY;
    };

    goToViewInfoTouchEnd = function () {

      goToViewInfoTouchEndX = event.changedTouches[0].pageX;
      goToViewInfoTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(goToViewInfoTouchEndX - goToViewInfoTouchStartX) < 20 &&
        Math.abs(goToViewInfoTouchEndY - goToViewInfoTouchStartY) < 20) {

        this.riotTags.innerHTML = '<view-info>';
        riot.mount('view-info');
//        scope.unmount()
      }
    };
  </script>
</component-toolbar>
<component-toolbar>
  <div id="toolbar" class="toolbar">
    <div class="menu-button menu-icon" ontouchend="menuOpen()">
    </div>

    <div id="circleMenuId" class="toolbar-circle-container" ontouchend="goToViewInfoTouchEnd()"
         ontouchstart="goToViewInfoTouchStart()">
    </div>

    <div class="bell-button bell-icon" ontouchend="bellButton()">
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

    menuOpen = function () {
      componentMenu.check = true;

      event.stopPropagation();

      componentMenu.checkOpen = true;

      this.sideMenuBackPageId.style.webkitTransition = '0.3s';
      this.mainPageId.style.webkitTransition = '0.3s';
      this.mainPageId.style.zIndex = '-1';
      this.mainPageId.style.opacity = '0.1';
      this.sideMenuId.style.webkitTransition = '0.3s';
      this.sideMenuId.style.transform = "translate(0, 0)";
      this.sideMenuId.style.webkitTransform = "translate(0, 0)";

      this.sideMenuBackPageId.style.opacity = '1';
    };

    bellButton = function () {
      event.preventDefault();
      event.stopPropagation();
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
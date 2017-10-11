<component-toolbar>
  <div id="toolbar" class="toolbar">
    <div id="menuButtonId" class="menu-button menu-icon" ontouchstart="menuOpenTouchStart()"
         ontouchend="menuOpenTouchEnd()" role="button"
         aria-label="{window.languages.ComponentToolbarAriaLabelOpenSideMenu}">
    </div>

    <div id="circleMenuId" class="toolbar-circle-container" ontouchend="goToViewInfoTouchEnd()"
         ontouchstart="goToViewInfoTouchStart()" role="button"
         aria-label="{window.languages.ComponentToolbarAriaLabelOpenBalanceInfo}">
    </div>

    <div class="toolbar-circle-container-title">
      {window.languages.ComponentToolbarTitle}
    </div>

    <div if="{!modeOfApp.offlineMode}" id="bellButtonId" class="bell-button bell-icon"
         ontouchstart="bellButtonTouchStart()"
         ontouchend="bellButtonTouchEnd()" role="button"
         aria-label="{window.languages.ComponentToolbarAriaLabelOpenNews}">
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

      menuButtonId.style.webkitTransform = 'scale(0.7)'

      openMenuTouchStartX = event.changedTouches[0].pageX;
      openMenuTouchStartY = event.changedTouches[0].pageY;
    }

    menuOpenTouchEnd = function (open) {
      event.preventDefault();
      event.stopPropagation();

      menuButtonId.style.webkitTransform = 'scale(1)'

      openMenuTouchEndX = event.changedTouches[0].pageX;
      openMenuTouchEndY = event.changedTouches[0].pageY;

      if ((Math.abs(openMenuTouchStartX - openMenuTouchEndX) <= 20 && Math.abs(openMenuTouchStartY - openMenuTouchEndY) <= 20) || open) {

        componentMenu.checkOpen = true;

        this.sideMenuBackPageId.style.webkitTransition = '0.3s';
        this.mainPageId.style.webkitTransition = '0.3s';
        this.mainPageId.style.zIndex = '-1';
        this.mainPageId.style.opacity = '0.1';
        this.sideMenuId.style.webkitTransition = '0.3s';
        this.sideMenuId.style.transform = "translate3d(0, 0, 0)";
        this.sideMenuId.style.webkitTransform = "translate3d(0, 0, 0)";

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

      bellButtonId.style.webkitTransform = 'scale(0.7)'

      bellButtonTouchStartX = event.changedTouches[0].pageX;
      bellButtonTouchStartY = event.changedTouches[0].pageY;
    }

    bellButtonTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      bellButtonId.style.webkitTransform = 'scale(1)'

      bellButtonTouchEndX = event.changedTouches[0].pageX;
      bellButtonTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(bellButtonTouchStartX - bellButtonTouchEndX) <= 20 && Math.abs(bellButtonTouchStartY - bellButtonTouchEndY) <= 20) {

        if (modeOfApp.offlineMode)return

        containerCard.style.filter = 'blur(5px)';
        viewNewsId.style.display = 'block'

        window.News.newsCounter = 0;

        console.log('TOOLBAR SCOPE', scope.parent.tags['view-news'].showNewsFunction(1))

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

      circleMenuId.style.webkitTransform = 'scale(0.7)'
    };

    goToViewInfoTouchEnd = function () {

      goToViewInfoTouchEndX = event.changedTouches[0].pageX;
      goToViewInfoTouchEndY = event.changedTouches[0].pageY;

      circleMenuId.style.webkitTransform = 'scale(1)'

      if (Math.abs(goToViewInfoTouchEndX - goToViewInfoTouchStartX) < 20 &&
        Math.abs(goToViewInfoTouchEndY - goToViewInfoTouchStartY) < 20) {

        this.riotTags.innerHTML = '<view-info>';
        riot.mount('view-info');
//        scope.unmount()
      }
    };
  </script>
</component-toolbar>
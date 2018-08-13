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
         ontouchstart="actionTouchStart(this.id)"
         ontouchend="actionTouchEnd(this.id)" role="button"
         aria-label="{window.languages.ComponentToolbarAriaLabelOpenNews}">
      <div if="{window.News.newsCounter != 0 && !modeOfApp.offlineMode}" class="bell-button-news-counter">
        {window.News.newsCounter}
      </div>
    </div>

    <div if="{modeOfApp.offlineMode}" id="ussd" class="toolbar-ussd-container"
         ontouchstart="actionTouchStart(this.id)"
         ontouchend="actionTouchEnd(this.id)">
      <p class="toolbar-ussd-text">USSD режим</p>
      <img src="resources/icons/toolbar/ussd.png"  class="toolbar-ussd-icon">
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

        console.log('sss', scope);
        scope.update();
      }
    };

    var actionTouchStartX,
      actionTouchStartY,
      actionTouchEndX,
      actionTouchEndY;

    actionTouchStart = function (actionId) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(actionId).style.webkitTransform = 'scale(0.7)'

      actionTouchStartX = event.changedTouches[0].pageX;
      actionTouchStartY = event.changedTouches[0].pageY;
    }

    actionTouchEnd = function (actionId) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(actionId).style.webkitTransform = 'scale(1)'

      actionTouchEndX = event.changedTouches[0].pageX;
      actionTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(actionTouchStartX - actionTouchEndX) <= 20 && Math.abs(actionTouchStartY - actionTouchEndY) <= 20) {

        if (modeOfApp.offlineMode) {
          goOnline();
          return;
        }

        containerCard.style.filter = 'blur(5px)';
        viewNewsId.style.display = 'block';

        window.News.newsCounter = 0;

        console.log('TOOLBAR SCOPE', scope.parent.tags['view-news'].showNewsFunction(1))

        window.saveHistory('view-news', opts);

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

        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*00*3" + "%23",
            function (err) {
              if (err == "empty") {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: "Unknown phone number"
                });
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }


        this.riotTags.innerHTML = '<view-info>';
        riot.mount('view-info');
//        scope.unmount()
      }
    };

    getToolbarScope = function() {
      return scope;
    }
  </script>
</component-toolbar>
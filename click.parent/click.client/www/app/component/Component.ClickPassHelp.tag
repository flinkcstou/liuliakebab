<component-click-pass-help>
  <div id="clickPassHelpMenuBackPageId"
       ontouchend="clickPassHelpMenuTouchEnd(true)"
       ontouchstart="clickPassHelpMenuTouchStart()"
       ontouchmove="clickPassHelpMenuTouchMove()"
       class="side-menu-back-page"></div>
  <div ontouchend="clickPassHelpMenuTouchEnd()"
       ontouchstart="clickPassHelpMenuTouchStart()"
       ontouchmove="clickPassHelpMenuTouchMove()"
       id="clickPassHelpMenuId"
       class="click-pass-help-menu">

    <div class="page-title">
      <div id="closeClickPassHelpMenuButtonId"
           role="button"
           aria-label="{window.languages.Close}"
           class="click-pass-help-menu-close-button"
           ontouchstart="closeClickPassHelpMenuStart()"
           ontouchend="closeClickPassHelpMenu()"></div>
    </div>
  </div>


  <script>
    var scope = this;

    closeClickPassHelpMenuStart = function () {
      closeClickPassHelpMenuButtonId.style.webkitTransform = 'scale(0.8)';
    };

    closeClickPassHelpMenu = function () {

      closeClickPassHelpMenuButtonId.style.webkitTransform = 'scale(1)';

      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      componentClickPassHelp.checkOpen = false;

      clickPassHelpMenuId.style.webkitTransition = '0.3s';
      clickPassHelpMenuBackPageId.style.opacity = '0';
      clickPassHelpMenuBackPageId.style.webkitTransition = '0';
      clickPassHelpMenuId.style.webkitTransform = "translate3d(" + window.innerWidth + "px, 0, 0)";
      clickPassHelpMenuId.style.Transform = "translate3d(" + window.innerWidth + "px, 0, 0)";
      clickPassPageId.style.opacity = '1';
      clickPassPageId.style.zIndex = '0';
      scope.update();
    };

    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndX;
    var width = window.innerWidth;

    clickPassHelpMenuTouchStart = function () {
      clickPassHelpMenuId.style.webkitTransition = '0s';
      clickPassPageId.style.webkitTransition = '0s';
      clickPassHelpMenuBackPageId.style.webkitTransition = '0s';
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);
      console.log('START', touchStartX);
    };

    clickPassHelpMenuTouchEnd = function (bool) {
      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeClickPassHelpMenu();
      }
      else {
        console.log('END', touchEndX);
        if (Math.abs(touchStartX - touchEndX) < 20 && bool) {
          closeClickPassHelpMenu();
          return;
        }
        if (timeEndX - timeStartX < 500 && touchEndX - touchStartX > 20) {
          closeClickPassHelpMenu();
        } else {
          clickPassHelpMenuOpenTouchEnd(true);
        }
      }
    };

    clickPassHelpMenuTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      touchMoveX = event.changedTouches[0].pageX;
      console.log('MOVE', touchMoveX);
      if (touchMoveX < touchStartX)
        return;
      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
      var deltaForSideMenuBack = 1 - deltaForMainPage;
      if (deltaForSideMenuBack < 0.1)
        deltaForSideMenuBack = 0.1;

      clickPassHelpMenuBackPageId.style.opacity = deltaForSideMenuBack;
      clickPassPageId.style.opacity = deltaForMainPage;

      if (touchStartX - touchMoveX <= 0) {
        clickPassHelpMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)';
        touchEndMove = touchMoveX - touchStartX;
        componentClickPassHelp.checkOpen = true;
      }
    };

  </script>
</component-click-pass-help>
<component-dropdown>
  <div id="sideMenuBackPageId" ontouchend="sideMenuTouchEnd(true)" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>
  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="sideMenuId" class="side-menu">

    <div id="closeMenuButtonId" role="button" aria-label="{window.languages.Close}" class="side-menu-inside-button"
         ontouchstart="closeMenuStart()"
         ontouchend="closeMenu()"></div>

  </div>

  <script>
    var scope = this;
    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndXs;
    var width = window.innerWidth;


    this.on('mount', function () {

    });

    closeMenuStart = function () {
      closeMenuButtonId.style.webkitTransform = 'scale(0.8)'
    };

    closeMenu = function () {

      closeMenuButtonId.style.webkitTransform = 'scale(1)';

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
      servicePageId.style.opacity = '1';
      servicePageId.style.zIndex = '0';
      scope.update();
    };

    sideMenuTouchStart = function () {
      sideMenuId.style.webkitTransition = '0s';
      servicePageId.style.webkitTransition = '0s';
      sideMenuBackPageId.style.webkitTransition = '0s';
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);

    };

    sideMenuTouchEnd = function (bool) {

      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeMenu();
      }
      else {
        console.log('START END', touchStartX, touchEndX);
        if (Math.abs(touchStartX - touchEndX) < 20 && bool) {
          closeMenu();
          return
        }
        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
          closeMenu();
        }
        else
          menuOpenTouchEnd(true)
      }
    };

    sideMenuTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      touchMoveX = event.changedTouches[0].pageX;
      if (touchStartX < touchMoveX) return;
      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
      var deltaForSideMenuBack = 1 - deltaForMainPage;
      if (deltaForSideMenuBack < 0.1)
        deltaForSideMenuBack = 0.1;

      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
      servicePageId.style.opacity = deltaForMainPage;

      if (touchMoveX - touchStartX <= 0) {
        sideMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)';
        touchEndMove = touchMoveX - touchStartX;
        componentMenu.checkOpen = true;
      }

    };


  </script>
</component-dropdown>
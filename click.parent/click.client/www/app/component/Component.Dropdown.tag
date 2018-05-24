<component-dropdown>
  <div id="dropdownBackPageId" class="dropdown-back-page"></div>

  <div id="dropdownId" class="dropdown-menu">

    <div id="closeMenuButtonId" role="button" aria-label="{window.languages.Close}" class="dropdown-close-button "
         ontouchstart="closeDropdownStart()"
         ontouchend="closeDropdown()"></div>

    <div class="dropdown-title">ВЫБЕРИТЕ ПАКЕТ</div>
    <div class="dropdown-elements-container">
      <div class="dropdown-element" each="{i in dropdownList}" id="{i[idParam]}" name="{i[titleParam]}"
           ontouchstart="onTouchStartDropdownElement()"
           ontouchend="onTouchEndDropdownElement(this.id, this.getAttribute('name'))">{i[titleParam]}
      </div>
    </div>

  </div>

  <script>
    var scope = this;
    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndXs;
    var dropdownTouchStartX, dropdownTouchStartY, dropdownTouchEndX, dropdownTouchEndY;
    scope.dropdownList = [];
    scope.idParam = "";
    scope.titleParam = "";
    scope.chosenId = "";
    scope.oldId = "";


    this.on('mount', function () {

    });

    closeDropdownStart = function () {
      closeMenuButtonId.style.webkitTransform = 'scale(0.8)'
    };

    closeDropdown = function () {

      closeMenuButtonId.style.webkitTransform = 'scale(1)';

      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
//      componentMenu.checkOpen = false;

      dropdownId.style.webkitTransition = '0.3s';
      dropdownBackPageId.style.opacity = '0';
      dropdownBackPageId.style.webkitTransition = '0';
      dropdownId.style.webkitTransform = "translate3d(100%, 0, 0)";
      dropdownId.style.Transform = "translate3d(100%, 0, 0)";
      servicePageId.style.opacity = '1';
      servicePageId.style.zIndex = '1';
      scope.update();
    };

    //    sideMenuTouchStart = function () {
    //      sideMenuId.style.webkitTransition = '0s';
    //      servicePageId.style.webkitTransition = '0s';
    //      sideMenuBackPageId.style.webkitTransition = '0s';
    //      touchStartX = event.changedTouches[0].pageX;
    //      timeStartX = event.timeStamp.toFixed(0);
    //
    //    };
    //
    //    sideMenuTouchEnd = function (bool) {
    //
    //      touchEndX = event.changedTouches[0].pageX;
    //      timeEndX = event.timeStamp.toFixed(0);
    //
    //      if ((Math.abs(touchEndMove) > 230 * widthK)) {
    //        closeMenu();
    //      }
    //      else {
    //        console.log('START END', touchStartX, touchEndX);
    //        if (Math.abs(touchStartX - touchEndX) < 20 && bool) {
    //          closeMenu();
    //          return
    //        }
    //        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
    //          closeMenu();
    //        }
    //        else
    //          menuOpenTouchEnd(true)
    //      }
    //    };

    //    sideMenuTouchMove = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //      touchMoveX = event.changedTouches[0].pageX;
    //      if (touchStartX < touchMoveX) return;
    //      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
    //      var deltaForSideMenuBack = 1 - deltaForMainPage;
    //      if (deltaForSideMenuBack < 0.1)
    //        deltaForSideMenuBack = 0.1;
    //
    //      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
    //      servicePageId.style.opacity = deltaForMainPage;
    //
    //      if (touchMoveX - touchStartX <= 0) {
    //        sideMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)';
    //        touchEndMove = touchMoveX - touchStartX;
    //        componentMenu.checkOpen = true;
    //      }
    //
    //    };


    updateDropdownList = function (array, idParam, chosenId, titleParam) {
      scope.dropdownList = array;
      scope.idParam = idParam;
      scope.chosenId = chosenId;
      scope.titleParam = titleParam;
      console.log("list= ", scope.dropdownList, idParam, chosenId, titleParam);
      scope.update();
      if (document.getElementById(scope.chosenId)) {
        document.getElementById(scope.chosenId).style.color = '#00a8f1';
      }
    };

    scope.onTouchStartDropdownElement = onTouchStartDropdownElement = function () {
      event.stopPropagation();
      dropdownTouchStartY = event.changedTouches[0].pageY;
      dropdownTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndDropdownElement = onTouchEndDropdownElement = function (id, title) {
      event.stopPropagation();

      dropdownTouchEndY = event.changedTouches[0].pageY;
      dropdownTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(dropdownTouchStartY - dropdownTouchEndY) <= 20 && Math.abs(dropdownTouchStartX - dropdownTouchEndX) <= 20) {
        console.log("dropdown touch ", id, title);
        scope.oldId = scope.chosenId;
        scope.chosenId = id;
        if (scope.oldId) {
          document.getElementById(scope.oldId).style.color = '#595759';
        }
        if (scope.chosenId) {
          document.getElementById(scope.chosenId).style.color = '#00a8f1';
        }
        scope.parent.processDropdown(scope.chosenId, title);
        closeDropdown();
      }
    }


  </script>
</component-dropdown>
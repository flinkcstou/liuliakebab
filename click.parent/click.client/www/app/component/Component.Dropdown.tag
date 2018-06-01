<component-dropdown>
  <div id="dropdownBackPageId" ontouchend="dropdownMenuTouchEnd(true)" ontouchstart="dropdownMenuTouchStart()"
       ontouchmove="dropdownMenuTouchMove()" class="dropdown-back-page"></div>

  <div id="dropdownId" class="dropdown-menu">

    <div id="closeDropdownButtonId" role="button" aria-label="{window.languages.Close}" class="dropdown-close-button "
         ontouchstart="closeDropdownStart()"
         ontouchend="closeDropdown()"></div>

    <div class="dropdown-title">ВЫБРАТЬ</div>
    <div class="dropdown-elements-container" ontouchstart="touchStart()">
      <div class="dropdown-element" each="{i in dropdownList}" id="{idParam? i[idParam]: i}"
           name="{titleParam ? i[titleParam]: i}"
           ontouchstart="onTouchStartDropdownElement()"
           ontouchend="onTouchEndDropdownElement(this.id, this.getAttribute('name'))">{titleParam ? i[titleParam]: i}
      </div>
    </div>

  </div>

  <script>
    var scope = this;
    var touchStartX, touchStartY, touchEndX, touchMoveX, touchMoveY, touchEndMove, timeStartX, timeEndXs;
    var dropdownTouchStartX, dropdownTouchStartY, dropdownTouchEndX, dropdownTouchEndY;
    var width = window.innerWidth;
    scope.dropdownList = [];
    scope.idParam = "";
    scope.titleParam = "";
    scope.chosenId = "";
    scope.oldId = "";


    this.on('mount', function () {

    });

    closeDropdownStart = function () {
      closeDropdownButtonId.style.webkitTransform = 'scale(0.8)'
    };

    closeDropdown = function () {

      closeDropdownButtonId.style.webkitTransform = 'scale(1)';

      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }

      dropdownId.style.webkitTransition = '0.3s';
      dropdownBackPageId.style.opacity = '0';
      dropdownBackPageId.style.webkitTransition = '0.3s';
      dropdownId.style.webkitTransform = "translate3d(100%, 0, 0)";
      dropdownId.style.Transform = "translate3d(100%, 0, 0)";
      document.getElementById(scope.pageId).style.opacity = '1';
      document.getElementById(scope.pageId).style.zIndex = '1';
      document.getElementById(scope.pageId).style.webkitTransition = '0.3s';
      scope.update();
    };

    dropdownMenuTouchStart = function () {
      dropdownId.style.webkitTransition = '0s';
      document.getElementById(scope.pageId).style.webkitTransition = '0s';
      dropdownBackPageId.style.webkitTransition = '0s';
      touchStartX = event.changedTouches[0].pageX;
      touchStartY = event.changedTouches[0].pageY;
      timeStartX = event.timeStamp.toFixed(0);

    };

    dropdownMenuTouchEnd = function (bool) {

      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeDropdown();
      }
      else {
        console.log('START END', touchStartX, touchEndX);
        if (Math.abs(touchStartX - touchEndX) < 20 && bool) {
          closeDropdown();
          return
        }
        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
          closeDropdown();
        } else {
          console.log("else else")
          scope.parent.openDropdownComponent();
        }

      }
    };

    touchStart = function () {
      event.preventDefault();
      event.stopPropagation();
//      console.log("touch start dropdown elements container");
    };

    dropdownMenuTouchMove = function () {
//      event.preventDefault();
//      event.stopPropagation();
      touchMoveX = event.changedTouches[0].pageX;
      touchMoveY = event.changedTouches[0].pageY;
      if (touchStartX > touchMoveX) return;

      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
      var deltaForSideMenuBack = 1 - deltaForMainPage;
      if (deltaForSideMenuBack < 0.1)
        deltaForSideMenuBack = 0.1;

      dropdownBackPageId.style.opacity = deltaForSideMenuBack;
      document.getElementById(scope.pageId).style.opacity = deltaForMainPage;

      console.log("diff =", touchStartX - touchMoveX, Math.abs(touchStartY - touchMoveY));
      if (touchStartX - touchMoveX <= 0 && Math.abs(touchStartX - touchMoveX) > 40) {
        dropdownId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)';
        touchEndMove = touchMoveX - touchStartX;
      }

    };


    updateDropdownList = function (array, idParam, chosenId, titleParam, pageId) {
      if (document.getElementById(scope.chosenId)) {
        document.getElementById(scope.chosenId).style.color = '#595759';
      }
      scope.dropdownList = array;
      scope.idParam = idParam;
      scope.chosenId = chosenId;
      scope.titleParam = titleParam;
      scope.pageId = pageId;
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
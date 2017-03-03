<component-toolbar>
  <div id="toolbar" class="toolbar">
    <div class="menu-button menu-icon" ontouchend="menuOpen()">
    </div>

    <div id="circleMenuId" class="toolbar-circle-container" ontouchend="goToViewInfo()">
    </div>

    <div class="bell-button bell-icon" ontouchend="bellButton()">
    </div>

  </div>

  <script>
    var scope = this;

    menuOpen = function () {

      event.preventDefault();
      event.stopPropagation();

      componentMenu.checkOpen = true;

//      this.mainPageId.style.transition = '0.3s';
      this.mainPageId.style.webkitTransition = '0.3s';
      this.mainPageId.style.zIndex = '-1';
      this.mainPageId.style.opacity = '0.1';

      this.sideMenuId.style.transform = "translate3d(0, 0, 0)";
      this.sideMenuId.style.webkitTransform = "translate3d(0, 0, 0)";
      sideMenuId.style.zIndex = "1";


      this.sideMenuBackPageId.style.opacity = '1';
    }

    bellButton = function () {
      event.preventDefault();
      event.stopPropagation();
    }

    goToViewInfo = function () {
      this.riotTags.innerHTML = '<view-info>';
      riot.mount('view-info');
    }
  </script>
</component-toolbar>
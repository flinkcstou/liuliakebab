<component-toolbar>
  <div class="toolbar">
    <div class="menu-button menu-icon" ontouchend="menuOpen()">
    </div>

    <div class="toolbar-circle-container">
    </div>

    <div class="bell-button bell-icon" ontouchend="bellButton()">
    </div>

  </div>

  <script>
    var scope = this;
    menuOpen = function () {

      event.preventDefault();
      event.stopPropagation();

      this.mainPageId.style.transition = '0.5s';
      this.mainPageId.style.webkitTransition = '0.5s';
      this.mainPageId.style.opacity = '0.1';

      this.sideMenuId.style.transform = "translate3d(0, 0, 0)";
      this.sideMenuId.style.webkitTransform = "translate3d(0, 0, 0)";

      this.sideMenuBackPageId.style.opacity = '1';
    }

    bellButton = function () {
      event.preventDefault();
      event.stopPropagation();
    }
  </script>
</component-toolbar>
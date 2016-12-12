<component-toolbar>
  <div class="toolbar">
    <div class="menu-button menu-icon" ontouchend="menuOpen()">
    </div>

    <div class="bell-button bell-icon" ontouchend="bellButton()">
    </div>

  </div>

  <script>
    var scope = this;
    menuOpen = function () {
      event.preventDefault();
      event.stopPropagation();
      riot.mount('component-menu');
      this.sideMenuId.style.transform = "translate3d(0, 0, 0)";
      this.sideMenuId.style.webkitTransform = "translate3d(0, 0, 0)";
      //this.mainPageId.style.opacity = "0.5";
    }

    bellButton = function () {

    }
  </script>
</component-toolbar>
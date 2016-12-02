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

      this.sideMenuId.style.transform = "translate3d(0, 0, 0)";
      this.sideMenuId.style.webkitTransform = "translate3d(0, 0, 0)";
      this.mainPageId.style.opacity = "0.5";
    }

    bellButton = function () {
      event.preventDefault();
      event.stopPropagation();

      if (localStorage.getItem('click_client_phoneNumber') == null || localStorage.getItem('click_client_deviceID') == null || localStorage.getItem('click_client_token') == null) {
        this.riotTags.innerHTML = "<view-registration-device>";
        scope.unmount();
        riot.mount('view-registration-device');
      }
      else {
        this.riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
        scope.unmount();
      }
    }
  </script>
</component-toolbar>
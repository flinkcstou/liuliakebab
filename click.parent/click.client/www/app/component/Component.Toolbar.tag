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
      console.log(this.sideMenuId);
      this.sideMenuId.style.width = '250px';
      this.mainPageId.style.opacity = "0.5";
      console.log(event.target)
    }

    bellButton = function () {
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
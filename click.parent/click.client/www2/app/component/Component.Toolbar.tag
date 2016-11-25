<component-toolbar>
  <div class="toolbar">
    <div class="menu-button menu-icon" ontouchend="menuOpen()">
    </div>

    <div class="bell-button bell-icon" ontouchend="bellButton()">
    </div>

    <component-menu></component-menu>
  </div>

  <script>
    var scope = this;
    menuOpen = function () {
      console.log(this.sideMenuId);
      this.sideMenuId.style.width = '250px';
      this.sideMenuId.style.backgroundCol;
      console.log(event.target)
    }

    bellButton = function () {
      if (localStorage.getItem('phoneNumber') == null || localStorage.getItem('deviceID') == null || localStorage.getItem('token') == null) {
        document.getElementById('riotTags').innerHTML = "<view-registration-device></view-registration-device>";
        scope.unmount();
        riot.mount('view-registration-device');
      }
      else {
        document.getElementById('riotTags').innerHTML = "<view-authorization></view-authorization>";
        riot.mount('view-authorization');
        scope.unmount();
      }
    }
  </script>
</component-toolbar>
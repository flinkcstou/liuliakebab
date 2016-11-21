<component-toolbar>
  <div class="toolbar">
    <div class="menu-button menu-icon" onclick="{menuOpen}">
    </div>

    <div class="bell-button bell-icon" onclick="{bellButton}">
    </div>

  </div>

  <script>
    menuOpen(e)
    {
      alert('Menu is pressed');

    }

    bellButton()
    {
      if(localStorage.getItem('phoneNumber') == null || localStorage.getItem('deviceID') == null || localStorage.getItem('token') == null) {
        document.getElementById('riotTags').innerHTML = "<view-registration-device></view-registration-device>";
        this.unmount();
        riot.mount('view-registration-device');
      }
      else{
        document.getElementById('riotTags').innerHTML = "<view-authorization></view-authorization>";
        riot.mount('view-authorization');
        this.unmount();
      }
    }
  </script>
</component-toolbar>
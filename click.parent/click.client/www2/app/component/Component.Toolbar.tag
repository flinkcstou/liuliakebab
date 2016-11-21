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
      document.getElementById('riotTags').innerHTML = "<view-registration-device></view-registration-device>";
      this.unmount();
      riot.mount('view-registration-device');
    }
  </script>
</component-toolbar>
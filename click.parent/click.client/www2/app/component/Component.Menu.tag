<component-menu  id="sideMenuId" class="side-menu" ontouchend="closeMenu()">

  <script>

    closeMenu = function(){
      this.sideMenuId.style.width = '0px';
    }
  </script>
</component-menu>
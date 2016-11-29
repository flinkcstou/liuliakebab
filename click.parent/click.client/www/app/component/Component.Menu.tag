<component-menu  id="sideMenuId" class="side-menu" ontouchend="closeMenu()">
<p>asdasdas</p>
  <script>
    closeMenu = function(){
      this.mainPageId.style.opacity = "1";
      this.sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      this.sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
    }
  </script>
</component-menu>
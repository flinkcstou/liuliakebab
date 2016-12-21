<component-menu>
  <div id="sideMenuBackPageId" class="side-menu-back-page"></div>
  <div id="sideMenuId" class="side-menu" ontouchend="closeMenu()">
    <a style=" position: absolute; top: 20px;" href="index.html" type="button" value="Production"
       ontouchend="goToProduction()">Clear local storage</a>
  </div>
  <script>
    closeMenu = function () {
      event.preventDefault();
      event.stopPropagation();
      //this.style.opacity = "1";
      this.sideMenuBackPageId.style.opacity = '0';
      this.sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      this.sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      this.mainPageId.style.opacity = '1';

    }

    goToProduction = function () {
      alert("Local storage is cleared")
      localStorage.clear();
    }
  </script>
</component-menu>
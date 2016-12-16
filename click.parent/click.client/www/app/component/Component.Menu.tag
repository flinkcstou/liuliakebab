<component-menu id="sideMenuId" class="side-menu" ontouchend="closeMenu()">
  <a style=" position: absolute; top: 20px;" href="index.html" type="button" value="Production"
     ontouchend="goToProduction()">Clear local storage</a>
  <script>
    closeMenu = function () {
      event.preventDefault();
      event.stopPropagation();
      //this.style.opacity = "1";
      this.sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      this.sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      this.mainPageId.style.opacity = '1';
      this.mainPageId.style.backgroundColor = 'rgba(0,0,0,0)';
      this.mainPageId.style.transition = '0';

    }

    goToProduction = function () {
      alert("Local storage is cleared")
      localStorage.clear();
    }
  </script>
</component-menu>
<component-menu>
  <div id="sideMenuBackPageId" class="side-menu-back-page"></div>
  <div id="sideMenuId" class="side-menu" ontouchend="closeMenu()">
    <a style=" position: absolute; top: 20px;" type="button" value="Production"
       ontouchend="goToProduction()">Clear local storage</a>
    <a ontouchend="TEST()" style=" position: absolute; top: 70px;">Close demo</a>
  </div>
  <script>
    closeMenu = function () {
      event.preventDefault();
      event.stopPropagation();
      sideMenuBackPageId.style.opacity = '0';
      sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      mainPageId.style.opacity = '1';
      this.mainPageId.style.zIndex = '0';

    }

    TEST = function () {
      localStorage.setItem('demo_version', false);
      localStorage.clear();
      window.location.href = "index.html";
    }

    goToProduction = function () {
      event.preventDefault();
      event.stopPropagation();

      alert("Local storage is cleared")
      localStorage.clear();
    }
  </script>
</component-menu>
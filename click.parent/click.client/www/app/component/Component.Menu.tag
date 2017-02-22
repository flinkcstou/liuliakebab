<component-menu>
  <div id="sideMenuBackPageId" class="side-menu-back-page"></div>
  <div id="sideMenuId" class="side-menu" ontouchend="closeMenu()">
    <a style=" position: absolute; top: 20px;" type="button" value="Production"
       ontouchend="goToProduction()">Clear local storage</a>
    <a href="index-stand.html" style=" position: absolute; top: 70px;">Close demo</a>
    <button style="position: absolute; top: 300px;" ontouchend="TESTASD()">ASD</button>
  </div>
  <script>
    closeMenu = function () {
      event.preventDefault();
      event.stopPropagation();
      sideMenuBackPageId.style.opacity = '0';
      sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      mainPageId.style.opacity = '1';

    }

    goToProduction = function () {
      event.preventDefault();
      event.stopPropagation();

      alert("Local storage is cleared")
      localStorage.clear();
    }
  </script>
</component-menu>
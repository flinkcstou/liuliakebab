<component-menu>
  <div id="sideMenuBackPageId" class="side-menu-back-page"></div>
  <div id="sideMenuId" class="side-menu">
    <label class="switch">
      <input onchange="changeMode()" id="checkBoxChangeId" type="checkbox" checked="true">
      <div class="slider round"></div>
    </label>
    <div class="side-menu-user-info-container">
      <div class="side-menu-user-icon"></div>
    </div>
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

    changeMode = function () {
      console.log(checkBoxChangeId.checked)
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
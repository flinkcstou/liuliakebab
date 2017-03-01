<component-menu>
  <div id="sideMenuBackPageId" class="side-menu-back-page"></div>
  <div id="sideMenuId" class="side-menu">

    <div class="side-menu-inside-button" ontouchend="closeMenu()"></div>
    <div class="side-menu-user-info-container">
      <div class="side-menu-user-icon"></div>
      <p class="side-menu-user-second-name">Chingis</p>
      <p class="side-menu-user-first-name">Amirkazhiev</p>
    </div>
    <div class="side-menu-change-mode">
      <div class="side-menu-change-mode-icon"></div>
      <p class="side-menu-change-mode-text">Активен он-лфйн режим</p>
      <label class="switch">
        <input onchange="changeMode()" id="checkBoxChangeId" type="checkbox" checked="true">
        <div class="slider round"></div>
      </label>
    </div>
    <div class="side-menu-billings-container">
      <div class="side-menu-containers-icon"></div>
    </div>
    <div class="side-menu-auto-pay-container">
      <div class="side-menu-containers-icon"></div>
    </div>
    <div class="side-menu-scanner-qr-container">
      <div class="side-menu-containers-icon"></div>
    </div>

    <div class="side-menu-settings-container">
      <div class="side-menu-containers-icon"></div>
    </div>

    <div class="side-menu-call-container">
      <div class="side-menu-containers-icon"></div>
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
<component-menu  id="sideMenuId" class="side-menu" ontouchend="closeMenu()">
<p>asdasdas</p>
  <a href="index.html" type="button" value="Production" ontouchend="goToProduction()">asdsd</a>
  <script>
    closeMenu = function(){
      event.preventDefault();
      event.stopPropagation();

      //this.style.opacity = "1";
      this.sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      this.sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
    }

    goToProduction = function(){
      alert("going to production")
      localStorage.clear();
    }
  </script>
</component-menu>
<component-footer>
  <div class="footer" ontouchend="openFooter()">
    <h3 align="center">КОНТАКТЫ</h3>
  </div>
  <div id="contacts" class="footer-contacts" ontouchend="closeFooter()">

    <div style="position: absolute; width: 50px; height: 50px;
                border-radius: 20px; border: 2px solid yellow;
                top: 20px; left: 10px;">

    </div>

    <div style="position: absolute; width: 50px; height: 50px;
                border-radius: 20px; border: 2px solid yellow;
                top: 20px; left: 70px">

    </div>

  </div>
  <script>

    openFooter = function () {
      this.contacts.style.webkitTransform = "translate3d(0, 0, 0)";
      this.contacts.style.Transform = "translate3d(0, 0, 0)";
      return;
    }

    closeFooter = function () {
      this.contacts.style.webkitTransform = "translate3d(0, 100%, 0)";
      this.contacts.style.Transform = "translate3d(0, 100%, 0)";
      return;
    }

  </script>
</component-footer>
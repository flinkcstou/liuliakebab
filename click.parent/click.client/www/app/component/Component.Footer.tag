<component-footer>
  <div class="footer" ontouchend="touchEndFooter()">
    <h3 align="center">КОНТАКТЫ</h3>
  </div>
  <div id="contacts" class="footer-contacts">

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
    var check = true;

    touchEndFooter = function () {
      console.log(check);
      if (check) {
        this.contacts.style.webkitTransform = "translate3d(0, -50px, 0)";
        this.contacts.style.Transform = "translate3d(0, -50px, 0)";
        check = false;
        return;
      }
      if (!check) {
        this.contacts.style.webkitTransform = "translate3d(0, 100%, 0)";
        this.contacts.style.Transform = "translate3d(0, 100%, 0)";
        check = true;
        return;
      }
    }
  </script>
</component-footer>
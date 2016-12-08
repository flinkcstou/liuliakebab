<component-footer>
  <div id="contactsContainer" class="footer-contacts-container">
  <div id="contactsId" class="footer" ontouchend="openFooter()">
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
  </div>
  <script>

    var check = false;

    openFooter = function () {
      if(!check) {
        this.contactsContainer.style.webkitTransform = "translate3d(0, 0, 0)";
        this.contactsContainer.style.Transform = "translate3d(0, 0, 0)";
        check = true;
        return;
      }
      if(check){
        this.contactsContainer.style.webkitTransform = "translate3d(0, 100px, 0)";
        this.contactsContainer.style.Transform = "translate3d(0, 100px, 0)";
        check = false;
        return;
      }
    }

  </script>
</component-footer>
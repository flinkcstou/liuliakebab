<component-footer>
  <div id="contactsContainer" class="footer-contacts-container">
  <div id="contactsId" class="footer" ontouchend="openFooter()">
    <h3 align="center">КОНТАКТЫ</h3>
  </div>
  <div id="contacts" class="footer-contacts">

    <div class="footer-favourite-contacts-container">

    <div id="photoOne" class="footer-favourite-contacts-circles footer-contact-one">
    </div>
      <p class="footer-favourite-contacts-label footer-favourite-contacts-label-one">{window.first_name}<br>{window.second_name}</p>

    <div id="photoTwo" class="footer-favourite-contacts-circles footer-contact-two">
    </div>
      <p class="footer-favourite-contacts-label footer-favourite-contacts-label-two">Petr <br> Petrov</p>

    <div id="photoThree" class="footer-favourite-contacts-circles footer-contact-three">
    </div>
      <p class="footer-favourite-contacts-label footer-favourite-contacts-label-three">Vasiliy <br> Vasiliev</p>

    <div id="photoFour" class="footer-favourite-contacts-circles footer-contact-four">
    </div>
      <p class="footer-favourite-contacts-label footer-favourite-contacts-label-four">Aleksandr <br> Aleksandrov</p>

    <div id="photoFive" class="footer-favourite-contacts-circles footer-contact-five">
    </div>
      <p class="footer-favourite-contacts-label footer-favourite-contacts-label-five">Zhvanec <br> Zhvaneckiy</p>

    </div>

  </div>
  </div>
  <script>

    var check = false;

    openFooter = function () {
      event.preventDefault();
      event.stopPropagation();
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



//    findContacts = function () {
//      var options = new ContactFindOptions();
//      options.filter = "";
//      options.multiple = true;
//      window.photo = '';
//      window.first_name = '';
//      window.second_name = '';
//      var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
//      navigator.contacts.find(fields, success, error, options);
//
//      function success(contacts) {
//        console.log(navigator.contacts);
//        alert(JSON.stringify(contacts))
//        for (var i = 0; i < contacts.length; i++) {
//          console.log("FIRST NAME ", contacts[i].name.familyName)
//          console.log("FIRST NAME ", contacts[i].name.givenName)
//          if(contacts[i].photos[0].value != null) {
//            window.first_name = contacts[i].name.familyName;
//            window.second_name = contacts[i].name.givenName;
//            window.photo = contacts[i].photos[0].value;
//            this.photoOne.style.webkitBackgroundImage = "url("+window.photo+")"
//            this.photoOne.style.backgroundImage = "url("+window.photo+")"
//            riot.update();
//          }
//        }
//      }
//      function error(message) {
//        alert('Failed because: ' + message);
//      }
//    }
//
//    findContacts();

  </script>
</component-footer>
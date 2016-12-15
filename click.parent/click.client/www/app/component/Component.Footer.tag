<component-footer>
  <div id="contactsContainer" class="footer-contacts-container">
    <div id="contactsId" class="footer" ontouchend="openFooter()">
      <p class="footer-contacts-label" align="center">КОНТАКТЫ</p>
      <div class="footer-icon-tick"></div>
    </div>
    <div id="contacts" class="footer-contacts">

      <div class="footer-favourite-contacts-container">

        <div id="photoOne" class="footer-favourite-contacts-circles footer-contact-one">
        </div>
        <p class="footer-favourite-contacts-label footer-favourite-contacts-label-one">{firstContactFname}<br>{firstContactLname}</p>

        <div id="photoTwo" class="footer-favourite-contacts-circles footer-contact-two">
        </div>
        <p class="footer-favourite-contacts-label footer-favourite-contacts-label-two">{secondContactFname} <br> {secondContactLname}</p>

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
    var scope = this;

    scope.firstContactPhoto = '';
    scope.firstContactNumber = '';
    scope.firstContactFname = '';
    scope.firstContactLname = '';

    scope.secondContactPhoto = '';
    scope.secondContactNumber = '';
    scope.secondContactFname = '';
    scope.secondContactLname = '';

    scope.thirdContactPhoto = '';
    scope.thirdContactNumber = '';
    scope.thirdContactFname = '';
    scope.thirdContactLname = '';

    scope.fourContactPhoto = '';
    scope.fourContactNumber = '';
    scope.fourContactFname = '';
    scope.fourContactLname = '';

    scope.fiveContactPhoto = '';
    scope.fiveContactNumber = '';
    scope.fiveContactFname = '';
    scope.fiveContactLname = '';

    openFooter = function () {
      event.preventDefault();
      event.stopPropagation();
      if (!check) {
        this.contactsContainer.style.webkitTransform = "translate3d(0, -15px, 0)";
        this.contactsContainer.style.Transform = "translate3d(0, -15px, 0)";
        check = true;
        return;
      }

      if (check) {
        this.contactsContainer.style.webkitTransform = "translate3d(0, 100px, 0)";
        this.contactsContainer.style.Transform = "translate3d(0, 100px, 0)";
        check = false;
        return;
      }
    }

//    var arrayOfPhotosContacts = [];
//    var arrayWithoutPhotosContacts = [];
//
//    findContacts = function () {
//      var options = new ContactFindOptions();
//      options.filter = "";
//      options.multiple = true;
//      var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
//      navigator.contacts.find(fields, success, error, options);
//
//      function success(contacts) {
//        console.log(navigator.contacts);
//        alert(JSON.stringify(contacts))
//        for (var i = 0; i < contacts.length; i++) {
//
//          if (contacts[i].photos[0].value != null) {
//            arrayOfPhotosContacts[i].push(contacts[i]);
//
//            if (arrayOfPhotosContacts.length >= 5) return;
//            riot.update();
//          }
//          else if (arrayWithoutPhotosContacts.length < 5)
//            arrayWithoutPhotosContacts.push(contacts[i])
//        }
//        writeContacts();
//      }
//
//      function error(message) {
//        alert('Failed because: ' + message);
//      }
//    }
//    findContacts();
//
//    writeContacts = function () {
//      scope.first_name = contacts[i].name.familyName;
//      scope.second_name = contacts[i].name.givenName;
//      scope.photo = contacts[i].photos[0].value;
//      this.photoOne.style.webkitBackgroundImage = "url(" + scope.photo + ")"
//      this.photoOne.style.backgroundImage = "url(" + scope.photo + ")"
//
//      if(arrayOfPhotosContacts.length > 0)
//      for (var i = 0; i < arrayOfPhotosContacts.length; i++) {
//        if( i == 0) {
//          scope.firstContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
//          this.photoOne.style.webkitBackgroundImage = "url(" + scope.firstContactPhoto + ")";
//          this.photoOne.style.backgroundImage = "url(" + scope.firstContactPhoto + ")";
//          scope.firstContactFname = arrayOfPhotosContacts[i].name.familyName;
//          scope.firstContactLname = arrayOfPhotosContacts[i].name.givenName;
//          if(i == 1){
//            scope.secondContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
//            this.photoTwo.style.webkitBackgroundImage = "url(" + scope.secondContactPhoto + ")";
//            this.photoTwo.style.backgroundImage = "url(" + scope.secondContactPhoto + ")";
//            scope.secondContactFname = arrayOfPhotosContacts[i].name.familyName;
//            scope.secondContactLname = arrayOfPhotosContacts[i].name.givenName;
//          }
//        }
//      }
//    }

  </script>
</component-footer>
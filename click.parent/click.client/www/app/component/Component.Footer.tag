<component-footer>
  <div id="contactsContainer" class="footer-contacts-container">
    <div id="contactsId" class="footer" ontouchend="openFooter()">
      <div class="footer-contacts-label-icon-container">
        <p class="footer-contacts-label" align="center">{window.languages.ComponentFooterContactsLabel}</p>
        <div id="iconTickId" class="footer-icon-tick"></div>
      </div>
    </div>
    <div id="contacts" class="footer-contacts">

      <div class="footer-favourite-contacts-container">

        <div class="footer-contacts-blocks footer-contacts-block-one">
          <div id="photoOne" class="footer-favourite-contacts-circles footer-contact-one"
               style="background-image: url({firstContactObject.contactPhoto})" ontouchend="contactOneTouchEnd()">
            {firstContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-one">
            {firstContactObject.contactFname}<br>{firstContactObject.contactLname}
          </p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-two">
          <div id="photoTwo" class="footer-favourite-contacts-circles footer-contact-two"
               style="background-image: url({secondContactObject.contactPhoto})" ontouchend="contactTwoTouchEnd()">
            {secondContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-two">
            {secondContactObject.contactFname} <br>
            {secondContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-three">
          <div id="photoThree" class="footer-favourite-contacts-circles footer-contact-three"
               style="background-image: url({thirdContactObject.contactPhoto})" ontouchend="contactThreeTouchEnd()">
            {thirdContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-three">
            {thirdContactObject.contactFname} <br>
            {thirdContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-four">
          <div id="photoFour" class="footer-favourite-contacts-circles footer-contact-four"
               style="background-image: url({fourContactObject.contactPhoto})" ontouchend="contactFourTouchEnd()">
            {fourContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-four">
            {fourContactObject.contactFname} <br>
            {fourContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-five">
          <div id="photoFive" class="footer-favourite-contacts-circles footer-contact-five"
               style="background-image: url({fiveContactObject.contactPhoto})" ontouchend="contactFiveTouchEnd()">
            {fiveContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-five">
            {fiveContactObject.contactFname} <br>
            {fiveContactObject.contactLname}</p>
        </div>

      </div>

    </div>
  </div>
  <script>

    var check = false;
    var scope = this;

    scope.firstContactObject = {};
    scope.firstContactObject.contactFname = '';
    scope.firstContactObject.contactLname = '';
    scope.firstContactObject.contactPhoto = '';
    scope.firstContactObject.firstLetter = '';

    scope.secondContactObject = {};
    scope.secondContactObject.contactFname = '';
    scope.secondContactObject.contactLname = '';
    scope.secondContactObject.contactPhoto = '';
    scope.secondContactObject.firstLetter = '';

    scope.thirdContactObject = {};
    scope.thirdContactObject.contactFname = '';
    scope.thirdContactObject.contactLname = '';
    scope.thirdContactObject.contactPhoto = '';
    scope.thirdContactObject.firstLetter = '';

    scope.fourContactObject = {};
    scope.fourContactObject.contactFname = '';
    scope.fourContactObject.contactLname = '';
    scope.fourContactObject.contactPhoto = '';
    scope.fourContactObject.firstLetter = '';


    scope.fiveContactObject = {};
    scope.fiveContactObject.contactFname = '';
    scope.fiveContactObject.contactLname = '';
    scope.fiveContactObject.contactPhoto = '';
    scope.fiveContactObject.firstLetter = '';

    scope.arrayOfPhotos = [];
    scope.arrayOfPhotos.push(scope.firstContactObject);
    scope.arrayOfPhotos.push(scope.secondContactObject);
    scope.arrayOfPhotos.push(scope.thirdContactObject);
    scope.arrayOfPhotos.push(scope.fourContactObject);
    scope.arrayOfPhotos.push(scope.fiveContactObject);

    contactOneTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-contact>";
      riot.mount('view-contact',
        {
          "object": scope.firstContactObject,
        }
      );
    }

    contactTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-contact>";
      riot.mount('view-contact',
        {
          "object": scope.secondContactObject,
        }
      );
    }

    contactThreeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-contact>";
      riot.mount('view-contact',
        {
          "object": scope.thirdContactObject,
        }
      );
    }

    contactFourTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-contact>";
      riot.mount('view-contact',
        {
          "object": scope.fourContactObject,
        }
      );
    }

    contactFiveTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      riotTags.innerHTML = "<view-contact>";
      riot.mount('view-contact',
        {
          "object": scope.fiveContactObject,
        }
      );
    }


    openFooter = function () {
      event.preventDefault();
      event.stopPropagation();
      if (!check) {
        this.iconTickId.style.transform = "rotate3d(1, 0, 0, 180deg)";
        this.iconTickId.style.webkitTransform = "rotate3d(1, 0, 0, 180deg)";
        this.contactsContainer.style.webkitTransform = "translate3d(0," + -30 * widthK + "px, 0)";
        this.contactsContainer.style.Transform = "translate3d(0, -30px, 0)";
        check = true;
        riot.update(scope.firstContactObject);
        riot.update(scope.secondContactObject);
        riot.update(scope.thirdContactObject);
        riot.update(scope.fourContactObject);
        riot.update(scope.fiveContactObject);
        return;
      }

      if (check) {
        this.iconTickId.style.transform = "rotate3d(0, 0, 0, 0deg)";
        this.iconTickId.style.webkitTransform = "rotate3d(0, 0, 0, 0deg)";
        this.contactsContainer.style.webkitTransform = "translate3d(0," + 200 * widthK + "px, 0)";
        this.contactsContainer.style.Transform = "translate3d(0," + 200 * widthK + "px, 0)";
        check = false;
        return;
      }
    }


    var arrayOfPhotosContacts = [];
    var arrayWithoutPhotosContacts = [];
    var arrayOfConnectedContacts = [];


    findContacts = function () {
      if (!localStorage.getItem('transferContacts')) {
        var options = new ContactFindOptions();
        options.filter = "";
        options.multiple = true;
        var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
        navigator.contacts.find(fields, success, error, options);

        function success(contacts) {
          //alert(JSON.stringify(contacts));
          for (var i = 0; i < contacts.length; i++) {
            if (contacts[i].photos != null) {
              if (contacts[i].photos[0].value != null && contacts[i].name != null && contacts[i].phoneNumbers != null) {
                arrayOfPhotosContacts.push(contacts[i]);

                if (arrayOfPhotosContacts.length >= 5) break;
              }
            }
            else if (contacts[i].name != null && contacts[i].phoneNumbers != null && arrayWithoutPhotosContacts.length <= 5)
              arrayWithoutPhotosContacts.push(contacts[i])
          }

          arrayOfConnectedContacts = arrayOfPhotosContacts.concat(arrayWithoutPhotosContacts);

          writeContacts(arrayOfConnectedContacts);
        }

        function error(message) {
          alert('Failed because: ' + message);
        }
      }
      else {
        var arrayOfContacts = JSON.parse(localStorage.getItem('transferContacts'));
        writeContacts(arrayOfContacts);
      }
    }
    if (device.platform != 'BrowserStand')
      findContacts();

    function writeContacts(arrayOfConnectedContacts) {
      var j = 0;
      if (arrayOfConnectedContacts.length >= 5) {
        j = 5;
        arrayOfConnectedContacts = arrayOfConnectedContacts.splice(0, 5);
      }
      else {
        j = arrayOfConnectedContacts.length;
        arrayOfConnectedContacts = arrayOfConnectedContacts.splice(0, j);
      }

      for (var i = 0; i < j; i++) {
        if (arrayOfConnectedContacts[i].photos != null) {
          scope.arrayOfPhotos[i].contactPhoto = arrayOfConnectedContacts[i].photos[0].value;
          scope.arrayOfPhotos[i].firstLetter = '';
        }
        else {
          scope.arrayOfPhotos[i].contactPhoto = '';
          if (arrayOfConnectedContacts[i].name.familyName) {
            scope.arrayOfPhotos[i].firstLetter = arrayOfConnectedContacts[i].name.familyName[0].toUpperCase();
          }
          else {
            if (arrayOfConnectedContacts[i].name.givenName) {
              scope.arrayOfPhotos[i].firstLetter = arrayOfConnectedContacts[i].name.givenName[0].toUpperCase();
            }
          }
        }

        if (arrayOfConnectedContacts[i].name.familyName != null)
          scope.arrayOfPhotos[i].contactFname = arrayOfConnectedContacts[i].name.familyName;
        else
          scope.arrayOfPhotos[i].contactFname = arrayOfConnectedContacts[i].name.givenName;

        if (arrayOfConnectedContacts[i].name.givenName != null && arrayOfConnectedContacts[i].name.familyName != null) {
          scope.arrayOfPhotos[i].contactLname = arrayOfConnectedContacts[i].name.givenName;
        }
      }
      riot.update(scope.firstContactObject);
      riot.update(scope.secondContactObject);
      riot.update(scope.thirdContactObject);
      riot.update(scope.fourContactObject);
      riot.update(scope.fiveContactObject);

      localStorage.setItem('transferContacts', JSON.stringify(arrayOfConnectedContacts))
    }

  </script>
</component-footer>
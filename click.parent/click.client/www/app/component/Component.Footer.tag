<component-footer>
  <div id="contactsContainer" class="footer-contacts-container">
    <div id="contactsId" class="footer" ontouchstart="openFooterTouchStart()" ontouchend="openFooterTouchEnd()">
      <div class="footer-contacts-label-icon-container">
        <p class="footer-contacts-label" align="center">{window.languages.ComponentFooterContactsLabel}</p>
        <div id="iconTickId" class="footer-icon-tick"></div>
      </div>
    </div>
    <div id="contacts" class="footer-contacts">

      <div class="footer-favourite-contacts-container">

        <div class="footer-contacts-blocks footer-contacts-block-one">
          <div id="photoOne" class="footer-favourite-contacts-circles footer-contact-one"
               style="background-image: url({firstContactObject.contactPhoto})" ontouchstart="contactOneTouchStart()"
               ontouchend="contactOneTouchEnd()">
            {firstContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-one">
            {firstContactObject.contactFname}<br>{firstContactObject.contactLname}
          </p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-two">
          <div id="photoTwo" class="footer-favourite-contacts-circles footer-contact-two"
               style="background-image: url({secondContactObject.contactPhoto})" ontouchstart="contactTwoTouchStart()"
               ontouchend="contactTwoTouchEnd()">
            {secondContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-two">
            {secondContactObject.contactFname} <br>
            {secondContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-three">
          <div id="photoThree" class="footer-favourite-contacts-circles footer-contact-three"
               style="background-image: url({thirdContactObject.contactPhoto})" ontouchstart="contactThreeTouchStart()"
               ontouchend="contactThreeTouchEnd()">
            {thirdContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-three">
            {thirdContactObject.contactFname} <br>
            {thirdContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-four">
          <div id="photoFour" class="footer-favourite-contacts-circles footer-contact-four"
               style="background-image: url({fourContactObject.contactPhoto})" ontouchstart="contactFourTouchStart()"
               ontouchend="contactFourTouchEnd()">
            {fourContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-four">
            {fourContactObject.contactFname} <br>
            {fourContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-five">
          <div id="photoFive" class="footer-favourite-contacts-circles footer-contact-five"
               style="background-image: url({fiveContactObject.contactPhoto})" ontouchstart="contactFiveTouchStart()"
               ontouchend="contactFiveTouchEnd()">
            {fiveContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-five">
            {fiveContactObject.contactFname} <br>
            {fiveContactObject.contactLname}</p>
        </div>

      </div>

    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var check = false;
    var scope = this;

    scope.showError = false;

    scope.firstContactObject = {};
    scope.firstContactObject.contactFname = '';
    scope.firstContactObject.contactLname = '';
    scope.firstContactObject.contactPhoto = '';
    scope.firstContactObject.firstLetter = '';
    scope.firstContactObject.phoneNumbers = [];

    scope.secondContactObject = {};
    scope.secondContactObject.contactFname = '';
    scope.secondContactObject.contactLname = '';
    scope.secondContactObject.contactPhoto = '';
    scope.secondContactObject.firstLetter = '';
    scope.secondContactObject.phoneNumbers = [];

    scope.thirdContactObject = {};
    scope.thirdContactObject.contactFname = '';
    scope.thirdContactObject.contactLname = '';
    scope.thirdContactObject.contactPhoto = '';
    scope.thirdContactObject.firstLetter = '';
    scope.thirdContactObject.phoneNumbers = [];

    scope.fourContactObject = {};
    scope.fourContactObject.contactFname = '';
    scope.fourContactObject.contactLname = '';
    scope.fourContactObject.contactPhoto = '';
    scope.fourContactObject.firstLetter = '';
    scope.fourContactObject.phoneNumbers = [];


    scope.fiveContactObject = {};
    scope.fiveContactObject.contactFname = '';
    scope.fiveContactObject.contactLname = '';
    scope.fiveContactObject.contactPhoto = '';
    scope.fiveContactObject.firstLetter = '';
    scope.fiveContactObject.phoneNumbers = [];

    scope.arrayOfPhotos = [];
    scope.arrayOfPhotos.push(scope.firstContactObject);
    scope.arrayOfPhotos.push(scope.secondContactObject);
    scope.arrayOfPhotos.push(scope.thirdContactObject);
    scope.arrayOfPhotos.push(scope.fourContactObject);
    scope.arrayOfPhotos.push(scope.fiveContactObject);

    var contactOneTouchStartX,
      contactOneTouchStartY,
      contactOneTouchEndX,
      contactOneTouchEndY;

    contactOneTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      contactOneTouchStartX = event.changedTouches[0].pageX;
      contactOneTouchStartY = event.changedTouches[0].pageY;

    }

    contactOneTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      contactOneTouchEndX = event.changedTouches[0].pageX;
      contactOneTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactOneTouchStartX - contactOneTouchEndX) <= 20 && Math.abs(contactOneTouchStartY - contactOneTouchEndY) <= 20) {

        riotTags.innerHTML = "<view-contact>";
        riot.mount('view-contact',
          {
            "object": scope.firstContactObject,
          }
        );
      }
//      scope.unmount()
    }

    var contactTwoTouchStartX,
      contactTwoTouchStartY,
      contactTwoTouchEndX,
      contactTwoTouchEndY;

    contactTwoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      contactTwoTouchStartX = event.changedTouches[0].pageX;
      contactTwoTouchStartY = event.changedTouches[0].pageY;
    }

    contactTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      contactTwoTouchEndX = event.changedTouches[0].pageX;
      contactTwoTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactTwoTouchStartX - contactTwoTouchEndX) <= 20 && Math.abs(contactTwoTouchStartY - contactTwoTouchEndY) <= 20) {

        riotTags.innerHTML = "<view-contact>";
        riot.mount('view-contact',
          {
            "object": scope.secondContactObject,
          }
        );
      }
//      scope.unmount()
    }

    var contactThreeTouchStartX,
      contactThreeTouchStartY,
      contactThreeTouchEndX,
      contactThreeTouchEndY;

    contactThreeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      contactThreeTouchStartX = event.changedTouches[0].pageX;
      contactThreeTouchStartY = event.changedTouches[0].pageY;

    }

    contactThreeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      contactThreeTouchEndX = event.changedTouches[0].pageX;
      contactThreeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactThreeTouchStartX - contactThreeTouchEndX) <= 20 && Math.abs(contactThreeTouchStartY - contactThreeTouchEndY) <= 20) {


        riotTags.innerHTML = "<view-contact>";
        riot.mount('view-contact',
          {
            "object": scope.thirdContactObject,
          }
        );
      }
//      scope.unmount()
    }

    var contactFourTouchStartX,
      contactFourTouchStartY,
      contactFourTouchEndX,
      contactFourTouchEndY;

    contactFourTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      contactFourTouchStartX = event.changedTouches[0].pageX;
      contactFourTouchStartY = event.changedTouches[0].pageY;

    }

    contactFourTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      contactFourTouchEndX = event.changedTouches[0].pageX;
      contactFourTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactFourTouchStartX - contactFourTouchEndX) <= 20 && Math.abs(contactFourTouchStartY - contactFourTouchEndY) <= 20) {

        riotTags.innerHTML = "<view-contact>";
        riot.mount('view-contact',
          {
            "object": scope.fourContactObject,
          }
        );
      }
//      scope.unmount()
    }

    var contactFiveTouchStartX,
      contactFiveTouchStartY,
      contactFiveTouchEndX,
      contactFiveTouchEndY;

    contactFiveTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      contactFiveTouchStartX = event.changedTouches[0].pageX;
      contactFiveTouchStartY = event.changedTouches[0].pageY;
    }

    contactFiveTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      contactFiveTouchEndX = event.changedTouches[0].pageX;
      contactFiveTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactFiveTouchStartX - contactFiveTouchEndX) <= 20 && Math.abs(contactFiveTouchStartY - contactFiveTouchEndY) <= 20) {

        riotTags.innerHTML = "<view-contact>";
        riot.mount('view-contact',
          {
            "object": scope.fiveContactObject,
          }
        );
      }
//      scope.unmount()
    }

    var footerOpenTouchStartX,
      footerOpenTouchStartY,
      footerOpenTouchEndX,
      footerOpenTouchEndY;

    openFooterTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      footerOpenTouchStartX = event.changedTouches[0].pageX;
      footerOpenTouchStartY = event.changedTouches[0].pageY;
    }

    openFooterTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      footerOpenTouchEndX = event.changedTouches[0].pageX;
      footerOpenTouchEndY = event.changedTouches[0].pageY;



      if (Math.abs(footerOpenTouchStartX - footerOpenTouchEndX) <= 20 && Math.abs(footerOpenTouchStartY - footerOpenTouchEndY) <= 20) {
        scope.update()
        if (!check) {
          this.iconTickId.style.transform = "rotate3d(1, 0, 0, 180deg)";
          this.iconTickId.style.webkitTransform = "rotate3d(1, 0, 0, 180deg)";
          this.contactsContainer.style.webkitTransform = "translate(0," + -30 * widthK + "px)";
          this.contactsContainer.style.Transform = "translate(0, -30px)";
          check = true;
          return;
        }

        if (check) {
          this.iconTickId.style.transform = "rotate3d(0, 0, 0, 0deg)";
          this.iconTickId.style.webkitTransform = "rotate3d(0, 0, 0, 0deg)";
          this.contactsContainer.style.webkitTransform = "translate(0," + 200 * widthK + "px)";
          this.contactsContainer.style.Transform = "translate(0," + 200 * widthK + "px)";
          check = false;
          return;
        }
      }
    }


    var arrayOfPhotosContacts = [];
    var arrayWithoutPhotosContacts = [];
    var arrayOfConnectedContacts = [];


    findContacts = function () {
      console.log("FOOTER FIND CONTACTS")
      if (!localStorage.getItem('transferContacts')) {
        console.log("WRITING CONTACTS...")
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
          scope.clickPinError = false;
          scope.errorNote = 'Failed because: ' + message;
          scope.showError = true;
          scope.update();
        }
      }
      else {
        var arrayOfContacts = JSON.parse(localStorage.getItem('transferContacts'));
        writeContacts(arrayOfContacts);
      }
    }

    console.log(device.platform)
    if (device.platform != 'BrowserStand') {
      findContacts();
      console.log('FINDCONTACTS() RUN')
    }

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
          scope.arrayOfPhotos[i].phoneNumbers.push(arrayOfConnectedContacts[i].phoneNumbers);
        }
        else {
          scope.arrayOfPhotos[i].phoneNumbers.push(arrayOfConnectedContacts[i].phoneNumbers);
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
      scope.update();

      localStorage.setItem('transferContacts', JSON.stringify(arrayOfConnectedContacts))
    }

    console.log("FOOTER SCRIPT")

  </script>
</component-footer>
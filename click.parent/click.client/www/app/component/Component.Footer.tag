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
                         style="background-image: url({firstContactObject.contactPhoto})">
                    </div>
                    <p class="footer-favourite-contacts-label footer-favourite-contacts-label-one">
                        {firstContactObject.contactFname}<br>{firstContactObject.contactLname}
                    </p>
                </div>

                <div class="footer-contacts-blocks footer-contacts-block-two">
                    <div id="photoTwo" class="footer-favourite-contacts-circles footer-contact-two"
                         style="background-image: url({secondContactObject.contactPhoto})">
                    </div>
                    <p class="footer-favourite-contacts-label footer-favourite-contacts-label-two">
                        {secondContactObject.contactFname} <br>
                        {secondContactObject.contactLname}</p>
                </div>

                <div class="footer-contacts-blocks footer-contacts-block-three">
                    <div id="photoThree" class="footer-favourite-contacts-circles footer-contact-three"
                         style="background-image: url({thirdContactObject.contactPhoto})">
                    </div>
                    <p class="footer-favourite-contacts-label footer-favourite-contacts-label-three">
                        {thirdContactObject.contactFname} <br>
                        {thirdContactObject.contactLname}</p>
                </div>

                <div class="footer-contacts-blocks footer-contacts-block-four">
                    <div id="photoFour" class="footer-favourite-contacts-circles footer-contact-four"
                         style="background-image: url({fourContactObject.contactPhoto})">
                    </div>
                    <p class="footer-favourite-contacts-label footer-favourite-contacts-label-four">
                        {fourContactObject.contactFname} <br>
                        {fourContactObject.contactLname}</p>
                </div>

                <div class="footer-contacts-blocks footer-contacts-block-five">
                    <div id="photoFive" class="footer-favourite-contacts-circles footer-contact-five"
                         style="background-image: url({fiveContactObject.contactPhoto})">
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

        scope.secondContactObject = {};

        scope.thirdContactObject = {};

        scope.fourContactObject = {};

        scope.fiveContactObject = {};

        scope.arrayOfPhotos = [];
        scope.arrayOfPhotos.push(scope.firstContactObject);
        scope.arrayOfPhotos.push(scope.secondContactObject);
        scope.arrayOfPhotos.push(scope.thirdContactObject);
        scope.arrayOfPhotos.push(scope.fourContactObject);
        scope.arrayOfPhotos.push(scope.fiveContactObject);


        openFooter = function () {
            event.preventDefault();
            event.stopPropagation();
            if (!check) {
                this.iconTickId.style.transform = "rotate3d(1, 0, 0, 180deg)";
                this.contactsContainer.style.webkitTransform = "translate3d(0," + -30 * widthK + "px, 0)";
                this.contactsContainer.style.Transform = "translate3d(0, -30px, 0)";
                check = true;
                riot.update();
                return;
            }

            if (check) {
                this.iconTickId.style.transform = "rotate3d(0, 0, 0, 0deg)";
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
            var options = new ContactFindOptions();
            options.filter = "";
            options.multiple = true;
            var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
            navigator.contacts.find(fields, success, error, options);

            function success(contacts) {
                //alert(JSON.stringify(contacts));
                for (var i = 0; i < contacts.length; i++) {
                    if (contacts[i].photos != null) {
                        if (contacts[i].photos[0].value != null && contacts[i].name != null) {
                            arrayOfPhotosContacts.push(contacts[i]);

                            if (arrayOfPhotosContacts.length >= 5) break;
                        }
                    }
                    if (contacts[i].photos == null && contacts[i].name != null && arrayWithoutPhotosContacts.length <= 5)
                        arrayWithoutPhotosContacts.push(contacts[i])
                }

                arrayOfConnectedContacts = arrayOfPhotosContacts.concat(arrayWithoutPhotosContacts);

                writeContacts(arrayOfConnectedContacts);
            }

            function error(message) {
                alert('Failed because: ' + message);
            }
        }
        if (device.platform != 'BrowserStand')
            findContacts();

        writeContacts = function (arrayOfConnectedContacts) {
            var j = 0;
            if (arrayOfConnectedContacts.length >= 5)
                j = 5;
            else j = arrayOfConnectedContacts.length;
            for (var i = 0; i < j; i++) {
                if (arrayOfConnectedContacts[i].photos != null)
                    scope.arrayOfPhotos[i].contactPhoto = arrayOfConnectedContacts[i].photos[0].value;
                else
                    scope.arrayOfPhotos[i].contactPhoto = '';

                if (arrayOfConnectedContacts[i].name.familyName != null)
                    scope.arrayOfPhotos[i].contactFname = arrayOfConnectedContacts[i].name.familyName;
                else
                    scope.arrayOfPhotos[i].contactFname = arrayOfConnectedContacts[i].name.givenName;

                if (arrayOfConnectedContacts[i].name.givenName != null && arrayOfConnectedContacts[i].name.familyName != null) {
                    scope.arrayOfPhotos[i].contactLname = arrayOfConnectedContacts[i].name.givenName;
                }
            }
            riot.update();
        }

        //
        //    writeContacts = function () {
        //      console.log("CONTACTS WITH PHOTOS ", arrayOfPhotosContacts)
        //      console.log("CONTACTS WITHout PHOTOS ", arrayWithoutPhotosContacts)
        //
        //
        //      if (arrayOfPhotosContacts.length > 0)
        //        for (var i = 0; i < arrayOfPhotosContacts.length; i++) {
        //          if (i == 0) {
        //            scope.firstContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
        //
        //            this.photoOne.style.webkitBackgroundImage = "url(" + scope.firstContactPhoto + ")";
        //            this.photoOne.style.backgroundImage = "url(" + scope.firstContactPhoto + ")";
        //
        //            if (arrayOfPhotosContacts[i].name != null) {
        //
        //              if (arrayOfPhotosContacts[i].name.familyName != null)
        //                scope.firstContactFname = arrayOfPhotosContacts[i].name.familyName;
        //              else
        //                scope.firstContactFname = arrayOfPhotosContacts[i].name.givenName;
        //
        //              if (arrayOfPhotosContacts[i].name.familyName != null && arrayOfPhotosContacts[i].name.givenName != null)
        //                scope.firstContactLname = arrayOfPhotosContacts[i].name.givenName;
        //            }
        //            if (i == 1) {
        //              scope.secondContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
        //              this.photoTwo.style.webkitBackgroundImage = "url(" + scope.secondContactPhoto + ")";
        //              this.photoTwo.style.backgroundImage = "url(" + scope.secondContactPhoto + ")";
        //
        //              if (arrayOfPhotosContacts[i].name != null) {
        //
        //                if (arrayOfPhotosContacts[i].name.familyName != null)
        //                  scope.secondContactFname = arrayOfPhotosContacts[i].name.familyName;
        //                else
        //                  scope.secondContactFname = arrayOfPhotosContacts[i].name.givenName;
        //
        //                if (arrayOfPhotosContacts[i].name.familyName != null && arrayOfPhotosContacts[i].name.givenName != null)
        //                  scope.secondContactLname = arrayOfPhotosContacts[i].name.givenName;
        //              }
        //            }
        //
        //            if (i == 2) {
        //              scope.thirdContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
        //              this.photoThree.style.webkitBackgroundImage = "url(" + scope.thirdContactPhoto + ")";
        //              this.photoThree.style.backgroundImage = "url(" + scope.thirdContactPhoto + ")";
        //
        //              if (arrayOfPhotosContacts[i].name != null) {
        //
        //                if (arrayOfPhotosContacts[i].name.familyName != null)
        //                  scope.thirdContactFname = arrayOfPhotosContacts[i].name.familyName;
        //                else
        //                  scope.thirdContactFname = arrayOfPhotosContacts[i].name.givenName;
        //
        //                if (arrayOfPhotosContacts[i].name != null && arrayOfPhotosContacts[i].name.givenName != null)
        //                  scope.thirdContactLname = arrayOfPhotosContacts[i].name.givenName;
        //              }
        //            }
        //
        //            if (i == 3) {
        //              scope.fourContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
        //              this.photoFour.style.webkitBackgroundImage = "url(" + scope.fourContactPhoto + ")";
        //              this.photoFour.style.backgroundImage = "url(" + scope.fourContactPhoto + ")";
        //
        //              if (arrayOfPhotosContacts[i].name != null) {
        //
        //                if (arrayOfPhotosContacts[i].name.familyName != null)
        //                  scope.fourContactFname = arrayOfPhotosContacts[i].name.familyName;
        //                else
        //                  scope.fourContactFname = arrayOfPhotosContacts[i].name.givenName;
        //
        //                if (arrayOfPhotosContacts[i].name.familyName != null && arrayOfPhotosContacts[i].name.givenName != null)
        //                  scope.fourContactLname = arrayOfPhotosContacts[i].name.givenName;
        //              }
        //            }
        //
        //            if (i == 4) {
        //              scope.fiveContactPhoto = arrayOfPhotosContacts[i].photos[0].value;
        //              this.photoFive.style.webkitBackgroundImage = "url(" + scope.fiveContactPhoto + ")";
        //              this.photoFive.style.backgroundImage = "url(" + scope.fiveContactPhoto + ")";
        //
        //              if (arrayOfPhotosContacts[i].name != null) {
        //
        //                if (arrayOfPhotosContacts[i].name.familyName != null)
        //                  scope.fiveContactFname = arrayOfPhotosContacts[i].name.familyName;
        //                else
        //                  scope.fiveContactFname = arrayOfPhotosContacts[i].name.givenName;
        //
        //                if (arrayOfPhotosContacts[i].name != null && arrayOfPhotosContacts[i].name.givenName != null)
        //                  scope.fiveContactLname = arrayOfPhotosContacts[i].name.givenName;
        //              }
        //            }
        //          }
        //        }
        //
        ////      CONTACTS WITHOUT PHOTOS
        //
        //      if (j == 0) {
        //
        //        if (arrayWithoutPhotosContacts[0].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[0].name.familyName != null)
        //            scope.firstContactFname = arrayWithoutPhotosContacts[0].name.familyName;
        //          else
        //            scope.firstContactFname = arrayWithoutPhotosContacts[0].name.givenName;
        //
        //          if (arrayWithoutPhotosContacts[0].name.familyName != null && arrayWithoutPhotosContacts[0].name.givenName != null)
        //            scope.firstContactLname = arrayWithoutPhotosContacts[0].name.givenName;
        //        }
        //
        //        if (arrayWithoutPhotosContacts[1].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[1].name.familyName != null)
        //            scope.secondContactFname = arrayWithoutPhotosContacts[1].name.familyName;
        //          else
        //            scope.secondContactFname = arrayWithoutPhotosContacts[1].name.givenName;
        //
        //          if (arrayWithoutPhotosContacts[1].name.familyName != null && arrayWithoutPhotosContacts[1].name.givenName != null)
        //            scope.secondContactLname = arrayWithoutPhotosContacts[1].name.givenName;
        //        }
        //
        //
        //        if (arrayWithoutPhotosContacts[2].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[2].name.familyName != null)
        //            scope.thirdContactFname = arrayWithoutPhotosContacts[2].name.familyName;
        //          else
        //            scope.thirdContactFname = arrayWithoutPhotosContacts[2].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[2].name.familyName != null && arrayWithoutPhotosContacts[2].name.givenName != null)
        //            scope.thirdContactLname = arrayWithoutPhotosContacts[2].name.givenName;
        //        }
        //
        //
        //        if (arrayWithoutPhotosContacts[3].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null)
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.familyName;
        //          else
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.givenName
        //
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null && arrayWithoutPhotosContacts[3].name.givenName != null)
        //            scope.fourContactLname = arrayWithoutPhotosContacts[3].name.givenName;
        //        }
        //
        //        if (arrayWithoutPhotosContacts[4].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null)
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.familyName;
        //          else
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null && arrayWithoutPhotosContacts[4].name.givenName != null)
        //            scope.fiveContactLname = arrayWithoutPhotosContacts[4].name.givenName;
        //        }
        //      }
        //
        //      if (j == 1) {
        //
        //        if (arrayWithoutPhotosContacts[1].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[1].name.familyName != null)
        //            scope.secondContactFname = arrayWithoutPhotosContacts[1].name.familyName;
        //          else
        //            scope.secondContactFname = arrayWithoutPhotosContacts[1].name.givenName;
        //
        //          if (arrayWithoutPhotosContacts[1].name.familyName != null && arrayWithoutPhotosContacts[1].name.givenName != null)
        //            scope.secondContactLname = arrayWithoutPhotosContacts[1].name.givenName;
        //        }
        //
        //
        //        if (arrayWithoutPhotosContacts[2].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[2].name.familyName != null)
        //            scope.thirdContactFname = arrayWithoutPhotosContacts[2].name.familyName;
        //          else
        //            scope.thirdContactFname = arrayWithoutPhotosContacts[2].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[2].name.familyName != null && arrayWithoutPhotosContacts[2].name.givenName != null)
        //            scope.thirdContactLname = arrayWithoutPhotosContacts[2].name.givenName;
        //        }
        //
        //
        //        if (arrayWithoutPhotosContacts[3].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null)
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.familyName;
        //          else
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.givenName
        //
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null && arrayWithoutPhotosContacts[3].name.givenName != null)
        //            scope.fourContactLname = arrayWithoutPhotosContacts[3].name.givenName;
        //        }
        //
        //        if (arrayWithoutPhotosContacts[4].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null)
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.familyName;
        //          else
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null && arrayWithoutPhotosContacts[4].name.givenName != null)
        //            scope.fiveContactLname = arrayWithoutPhotosContacts[4].name.givenName;
        //        }
        //      }
        //
        //      if (j == 2) {
        //
        //        if (arrayWithoutPhotosContacts[2].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[2].name.familyName != null)
        //            scope.thirdContactFname = arrayWithoutPhotosContacts[2].name.familyName;
        //          else
        //            scope.thirdContactFname = arrayWithoutPhotosContacts[2].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[2].name.familyName != null && arrayWithoutPhotosContacts[2].name.givenName != null)
        //            scope.thirdContactLname = arrayWithoutPhotosContacts[2].name.givenName;
        //        }
        //
        //
        //        if (arrayWithoutPhotosContacts[3].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null)
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.familyName;
        //          else
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.givenName
        //
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null && arrayWithoutPhotosContacts[3].name.givenName != null)
        //            scope.fourContactLname = arrayWithoutPhotosContacts[3].name.givenName;
        //        }
        //
        //        if (arrayWithoutPhotosContacts[4].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null)
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.familyName;
        //          else
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null && arrayWithoutPhotosContacts[4].name.givenName != null)
        //            scope.fiveContactLname = arrayWithoutPhotosContacts[4].name.givenName;
        //        }
        //      }
        //
        //      if (j == 3) {
        //
        //        if (arrayWithoutPhotosContacts[3].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null)
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.familyName;
        //          else
        //            scope.fourContactFname = arrayWithoutPhotosContacts[3].name.givenName
        //
        //
        //          if (arrayWithoutPhotosContacts[3].name.familyName != null && arrayWithoutPhotosContacts[3].name.givenName != null)
        //            scope.fourContactLname = arrayWithoutPhotosContacts[3].name.givenName;
        //        }
        //
        //        if (arrayWithoutPhotosContacts[4].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null)
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.familyName;
        //          else
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null && arrayWithoutPhotosContacts[4].name.givenName != null)
        //            scope.fiveContactLname = arrayWithoutPhotosContacts[4].name.givenName;
        //        }
        //      }
        //
        //      if (j == 4) {
        //
        //        if (arrayWithoutPhotosContacts[4].name != null) {
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null)
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.familyName;
        //          else
        //            scope.fiveContactFname = arrayWithoutPhotosContacts[4].name.givenName;
        //
        //
        //          if (arrayWithoutPhotosContacts[4].name.familyName != null && arrayWithoutPhotosContacts[4].name.givenName != null)
        //            scope.fiveContactLname = arrayWithoutPhotosContacts[4].name.givenName;
        //        }
        //      }
        //    }

    </script>
</component-footer>
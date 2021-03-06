<component-footer>
  <div id="contactsContainer" class="footer-contacts-container">
    <div id="contactsId" role="button" aria-label="{window.languages.ComponentFooterContactsLabel}" class="footer"
         ontouchstart="openFooterTouchStart()" ontouchend="openFooterTouchEnd()">
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
               ontouchend="contactOneTouchEnd()" role="button"
               aria-label="{firstContactObject.contactFname} {firstContactObject.contactLname}">
            {firstContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-one">
            {firstContactObject.contactFname}<br>{firstContactObject.contactLname}
          </p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-two" if="{firstContactObject.exist}">
          <div id="photoTwo" class="footer-favourite-contacts-circles footer-contact-two"
               style="background-image: url({secondContactObject.contactPhoto})" ontouchstart="contactTwoTouchStart()"
               ontouchend="contactTwoTouchEnd()">
            {secondContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-two">
            {secondContactObject.contactFname} <br>
            {secondContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-three" if="{secondContactObject.exist}">
          <div id="photoThree" class="footer-favourite-contacts-circles footer-contact-three"
               style="background-image: url({thirdContactObject.contactPhoto})" ontouchstart="contactThreeTouchStart()"
               ontouchend="contactThreeTouchEnd()">
            {thirdContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-three">
            {thirdContactObject.contactFname} <br>
            {thirdContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-four" if="{thirdContactObject.exist}">
          <div id="photoFour" class="footer-favourite-contacts-circles footer-contact-four"
               style="background-image: url({fourContactObject.contactPhoto})" ontouchstart="contactFourTouchStart()"
               ontouchend="contactFourTouchEnd()">
            {fourContactObject.firstLetter}
          </div>
          <p class="footer-favourite-contacts-label footer-favourite-contacts-label-four">
            {fourContactObject.contactFname} <br>
            {fourContactObject.contactLname}</p>
        </div>

        <div class="footer-contacts-blocks footer-contacts-block-five" if="{fourContactObject.exist}">
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

  <script>

    var check = false;
    var scope = this;

    scope.on('mount', function () {
      if (device.platform === 'iOS') {
        if (contactsId) {
          contactsId.style.paddingBottom = 'calc(env(safe-area-inset-bottom) / 2)';
        }
      }
    });

    scope.firstContactObject = {};
    scope.firstContactObject.contactFname = 'Добавить';
    scope.firstContactObject.contactLname = '';
    scope.firstContactObject.id = '';
    scope.firstContactObject.contactPhoto = "resources/icons/ViewContact/contact_plus.png";
    scope.firstContactObject.firstLetter = '';
    scope.firstContactObject.phoneNumbers = [];
    scope.firstContactObject.exist = false;
    scope.firstContactObject.addContact = false;

    scope.secondContactObject = {};
    scope.secondContactObject.contactFname = 'Добавить';
    scope.secondContactObject.contactLname = '';
    scope.secondContactObject.id = '';
    scope.secondContactObject.contactPhoto = "resources/icons/ViewContact/contact_plus.png";
    scope.secondContactObject.firstLetter = '';
    scope.secondContactObject.phoneNumbers = [];
    scope.secondContactObject.exist = false;
    scope.secondContactObject.addContact = false;

    scope.thirdContactObject = {};
    scope.thirdContactObject.contactFname = 'Добавить';
    scope.thirdContactObject.contactLname = '';
    scope.thirdContactObject.id = '';
    scope.thirdContactObject.contactPhoto = "resources/icons/ViewContact/contact_plus.png";
    scope.thirdContactObject.firstLetter = '';
    scope.thirdContactObject.phoneNumbers = [];
    scope.thirdContactObject.exist = false;
    scope.thirdContactObject.addContact = false;

    scope.fourContactObject = {};
    scope.fourContactObject.contactFname = 'Добавить';
    scope.fourContactObject.contactLname = '';
    scope.fourContactObject.id = '';
    scope.fourContactObject.contactPhoto = "resources/icons/ViewContact/contact_plus.png";
    scope.fourContactObject.firstLetter = '';
    scope.fourContactObject.phoneNumbers = [];
    scope.fourContactObject.exist = false;
    scope.fourContactObject.addContact = false;


    scope.fiveContactObject = {};
    scope.fiveContactObject.contactFname = 'Добавить';
    scope.fiveContactObject.contactLname = '';
    scope.fiveContactObject.id = '';
    scope.fiveContactObject.contactPhoto = "resources/icons/ViewContact/contact_plus.png";
    scope.fiveContactObject.firstLetter = '';
    scope.fiveContactObject.phoneNumbers = [];
    scope.fiveContactObject.exist = false;
    scope.fiveContactObject.addContact = false;

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

    var arrayToSend = []
    if (localStorage.getItem('contactList')) {
      arrayToSend = JSON.parse(localStorage.getItem('contactList'))
    }

    contactOneTouchStart = function () {
//      event.preventDefault();
//      event.stopPropagation();

      photoOne.style.webkitTransform = 'scale(0.7)'

      contactOneTouchStartX = event.changedTouches[0].pageX;
      contactOneTouchStartY = event.changedTouches[0].pageY;

    }

    contactOneTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      photoOne.style.webkitTransform = 'scale(1)'

      contactOneTouchEndX = event.changedTouches[0].pageX;
      contactOneTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactOneTouchStartX - contactOneTouchEndX) <= 20 && Math.abs(contactOneTouchStartY - contactOneTouchEndY) <= 20) {

        if (scope.firstContactObject.exist) {
          riotTags.innerHTML = "<view-contact>";
          riot.mount('view-contact',
            {
              "object": scope.firstContactObject,
            }
          );
        }
        else {
          window.pickContactFromNativeChecker = true;

          navigator.contacts.pickContact(function (contact) {
            console.log('CONTACT PICK', contact)

            window.common.alert.hide("componentAlertId");

            if (!contact.phoneNumbers) {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                errornote: 'Отсутствует номер контакта'
              });
              scope.update();
              return;
            }

            if (!contact.name) {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                errornote: 'Отсутствует имя контакта'
              });
              scope.update();
              return;
            }

            if (!contact.name.givenName) {
              if (!contact.name.familyName) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует имя контакта'
                });
                scope.update();
                return;
              }
            }

            for (var i in arrayToSend) {
              if (arrayToSend[i].id == contact.id) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Этот контакт уже добавлен'
                });
                scope.update();
                return;
              }
            }

            arrayToSend.push(contact)
            writeContactsFooter(arrayToSend)
          }, function (err) {
            console.log('Error: ' + err);
          });
        }
      }
    }

    var contactTwoTouchStartX,
      contactTwoTouchStartY,
      contactTwoTouchEndX,
      contactTwoTouchEndY;

    contactTwoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      photoTwo.style.webkitTransform = 'scale(0.7)'

      contactTwoTouchStartX = event.changedTouches[0].pageX;
      contactTwoTouchStartY = event.changedTouches[0].pageY;
    }

    contactTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      photoTwo.style.webkitTransform = 'scale(1)'

      contactTwoTouchEndX = event.changedTouches[0].pageX;
      contactTwoTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactTwoTouchStartX - contactTwoTouchEndX) <= 20 && Math.abs(contactTwoTouchStartY - contactTwoTouchEndY) <= 20) {

        if (scope.secondContactObject.exist) {
          riotTags.innerHTML = "<view-contact>";
          riot.mount('view-contact',
            {
              "object": scope.secondContactObject,
            }
          );
        }
        else {
          arrayToSend = JSON.parse(localStorage.getItem('contactList'))
          window.pickContactFromNativeChecker = true;

          try {
            navigator.contacts.pickContact(function (contact) {

              window.common.alert.hide("componentAlertId");

              if (!contact.phoneNumbers) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует номер контакта'
                });
                scope.update();
                return;
              }

              if (!contact.name) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует имя контакта'
                });
                scope.update();
                return;
              }

              if (!contact.name.givenName) {
                if (!contact.name.familyName) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Отсутствует имя контакта'
                  });
                  scope.update()
                  return
                }
              }

              for (var i in arrayToSend) {
                console.log(arrayToSend[i].id, contact.id)
                if (arrayToSend[i].id == contact.id) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Этот контакт уже добавлен'
                  });
                  scope.update();
                  return;
                }
              }

              console.log("ARRAY TO SEND", arrayToSend)
              arrayToSend.push(contact)
              writeContactsFooter(arrayToSend)
            }, function (err) {
              console.log('Error: ' + err);
            });
          }
          catch (e) {
            console.log(e)
          }
        }
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

      photoThree.style.webkitTransform = 'scale(0.7)'

      contactThreeTouchStartX = event.changedTouches[0].pageX;
      contactThreeTouchStartY = event.changedTouches[0].pageY;

    }

    contactThreeTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      photoThree.style.webkitTransform = 'scale(0.7)'

      contactThreeTouchEndX = event.changedTouches[0].pageX;
      contactThreeTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactThreeTouchStartX - contactThreeTouchEndX) <= 20 && Math.abs(contactThreeTouchStartY - contactThreeTouchEndY) <= 20) {

        if (scope.thirdContactObject.exist) {
          riotTags.innerHTML = "<view-contact>";
          riot.mount('view-contact',
            {
              "object": scope.thirdContactObject,
            }
          );
        }
        else {
          arrayToSend = JSON.parse(localStorage.getItem('contactList'))

          try {
            window.pickContactFromNativeChecker = true;

            navigator.contacts.pickContact(function (contact) {

              window.common.alert.hide("componentAlertId");

              if (!contact.phoneNumbers) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует номер контакта'
                });
                scope.update()
                return
              }

              if (!contact.name) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует имя контакта'
                });
                scope.update()
                return
              }

              if (!contact.name.givenName) {
                if (!contact.name.familyName) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Отсутствует имя контакта'
                  });
                  scope.update()
                  return
                }
              }

              for (var i in arrayToSend) {
                console.log(arrayToSend[i].id, contact.id)
                if (arrayToSend[i].id == contact.id) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Этот контакт уже добавлен'
                  });
                  scope.update();
                  return;
                }
              }


              arrayToSend.push(contact)
              writeContactsFooter(arrayToSend)
            }, function (err) {
              console.log('Error: ' + err);
            });
          }
          catch (e) {
            console.log(e)
          }
        }
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

      photoFour.style.webkitTransform = 'scale(0.7)'

      contactFourTouchStartX = event.changedTouches[0].pageX;
      contactFourTouchStartY = event.changedTouches[0].pageY;

    }

    contactFourTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      photoFour.style.webkitTransform = 'scale(1)'

      contactFourTouchEndX = event.changedTouches[0].pageX;
      contactFourTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactFourTouchStartX - contactFourTouchEndX) <= 20 && Math.abs(contactFourTouchStartY - contactFourTouchEndY) <= 20) {

        if (scope.fourContactObject.exist) {
          riotTags.innerHTML = "<view-contact>";
          riot.mount('view-contact',
            {
              "object": scope.fourContactObject,
            }
          );
        }
        else {
          arrayToSend = JSON.parse(localStorage.getItem('contactList'))

          window.pickContactFromNativeChecker = true;

          try {
            navigator.contacts.pickContact(function (contact) {

              window.common.alert.hide("componentAlertId");

              if (!contact.phoneNumbers) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует номер контакта'
                });
                scope.update();
                return;
              }

              if (!contact.name) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует имя контакта'
                });
                scope.update();
                return;
              }

              if (!contact.name.givenName) {
                if (!contact.name.familyName) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Отсутствует имя контакта'
                  });
                  scope.update();
                  return;
                }
              }

              for (var i in arrayToSend) {
                console.log(arrayToSend[i].id, contact.id)
                if (arrayToSend[i].id == contact.id) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Этот контакт уже добавлен'
                  });
                  scope.update();
                  return;
                }
              }


              arrayToSend.push(contact)
              writeContactsFooter(arrayToSend)
            }, function (err) {
              console.log('Error: ' + err);
            });
          }
          catch (e) {
            console.log(e)
          }
        }
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

      photoFive.style.webkitTransform = 'scale(0.7)'

      contactFiveTouchStartX = event.changedTouches[0].pageX;
      contactFiveTouchStartY = event.changedTouches[0].pageY;
    }

    contactFiveTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      photoFive.style.webkitTransform = 'scale(1)'

      contactFiveTouchEndX = event.changedTouches[0].pageX;
      contactFiveTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(contactFiveTouchStartX - contactFiveTouchEndX) <= 20 && Math.abs(contactFiveTouchStartY - contactFiveTouchEndY) <= 20) {

        if (scope.fiveContactObject.exist) {
          riotTags.innerHTML = "<view-contact>";
          riot.mount('view-contact',
            {
              "object": scope.fiveContactObject,
            }
          );
        }
        else {
          arrayToSend = JSON.parse(localStorage.getItem('contactList'))

          try {
            window.pickContactFromNativeChecker = true;

            navigator.contacts.pickContact(function (contact) {
              window.common.alert.hide("componentAlertId");

              if (!contact.phoneNumbers) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует номер контакта'
                });
                scope.update()
                return
              }

              if (!contact.name) {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  errornote: 'Отсутствует имя контакта'
                });
                scope.update()
                return
              }

              for (var i in arrayToSend) {
                console.log(arrayToSend[i].id, contact.id)
                if (arrayToSend[i].id == contact.id) {
                  window.common.alert.show("componentAlertId", {
                    parent: scope,
                    errornote: 'Этот контакт уже добавлен'
                  });
                  scope.update()
                  return
                }
              }


              arrayToSend.push(contact)
              writeContactsFooter(arrayToSend)
            }, function (err) {
              console.log('Error: ' + err);
            });
          }
          catch (e) {
            console.log(e)
          }
        }
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
          this.contactsContainer.style.webkitTransform = "translate3d(0," + -30 * widthK + "px,0)";
          this.contactsContainer.style.Transform = "translate3d(0, -30px,0)";
          check = true;
          return;
        }

        if (check) {
          this.iconTickId.style.transform = "rotate3d(0, 0, 0, 0deg)";
          this.iconTickId.style.webkitTransform = "rotate3d(0, 0, 0, 0deg)";
          this.contactsContainer.style.webkitTransform = "translate3d(0," + 200 * widthK + "px,0)";
          this.contactsContainer.style.Transform = "translate3d(0," + 200 * widthK + "px,0)";
          check = false;
          return;
        }
      }
    }


    var arrayOfPhotosContacts = [];
    var arrayWithoutPhotosContacts = [];
    var arrayOfConnectedContacts = [];

    //
    //    findContactsFooter = function () {
    //      console.log("FOOTER FIND CONTACTS")
    //      if (!localStorage.getItem('contactList')) {
    //        console.log("WRITING CONTACTS...")
    //        var options = new ContactFindOptions();
    //        options.filter = "";
    //        options.multiple = true;
    //        var fields = [navigator.contacts.fieldType.displayName, navigator.contacts.fieldType.name, navigator.contacts.fieldType.photos];
    //        navigator.contacts.find(fields, success, error, options);
    //
    //        function success(contacts) {
    //          //alert(JSON.stringify(contacts));
    //          for (var i = 0; i < contacts.length; i++) {
    //            if (contacts[i].photos != null) {
    //              if (contacts[i].photos[0].value != null && contacts[i].name != null && contacts[i].phoneNumbers != null) {
    //                arrayOfPhotosContacts.push(contacts[i]);
    //
    //                if (arrayOfPhotosContacts.length >= 5) break;
    //              }
    //            }
    //            else if (contacts[i].name != null && contacts[i].phoneNumbers != null && arrayWithoutPhotosContacts.length <= 5)
    //              arrayWithoutPhotosContacts.push(contacts[i])
    //          }
    //
    //          arrayOfConnectedContacts = arrayOfPhotosContacts.concat(arrayWithoutPhotosContacts);
    //
    //          writeContactsFooter(arrayOfConnectedContacts);
    //        }
    //
    //        function error(message) {
    //          scope.clickPinError = false;
    //          scope.errorNote = 'Failed because: ' + message;
    //          scope.showError = true;
    //          scope.update();
    //        }
    //      }
    //      else {
    //        var arrayOfContacts = JSON.parse(localStorage.getItem('contactList'));
    //        writeContactsFooter(arrayOfContacts);
    //      }
    //    }
    //

    findContactsFooter = function () {
      if (!localStorage.getItem('contactList')) {
        scope.firstContactObject.addContact = true;
        scope.update()
      }
      else {
        var arrayOfContacts = JSON.parse(localStorage.getItem('contactList'));
        writeContactsFooter(arrayOfContacts);
      }
    }

    //    findContactsFooter()
    if (device.platform != 'BrowserStand') {
      findContactsFooter();
      console.log('FINDCONTACTS() RUN')
    }

    function writeContactsFooter(arrayOfConnectedContacts) {
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
        scope.arrayOfPhotos[i].exist = true;
        scope.arrayOfPhotos[i].addContact = false;
        scope.arrayOfPhotos[i].id = arrayOfConnectedContacts[i].id;
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

      localStorage.setItem('contactList', JSON.stringify(arrayOfConnectedContacts))
    }

  </script>
</component-footer>
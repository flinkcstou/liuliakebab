<view-friend-help-settings>
  <div class="riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()" class="pay-back-button"></div>
      <div id="rightButton" ontouchstart="goToAddFriendViewStart()" ontouchend="goToAddFriendViewEnd()"
           class="settings-friend-help-add-button"></div>
    </div>
    <div id="mainContainerId" class="settings-container">
      <div each="{i in arrayOfFriends}" id="{'id'+i.number}" class="settings-friend-help-contact-container">
        <div class="settings-friend-help-contact-found-photo"
             style="background-image: url({i.photo})">{i.firstLetterOfName}
        </div>
        <div class="settings-friend-help-contact-found-text-container"
             ontouchstart="chooseFriendForHelpStart('id'+{i.number})"
             ontouchend="chooseFriendForHelpEnd({i.number}, 'id'+{i.number})">
          <div class="settings-friend-help-contact-found-text-one">{i.name}</div>
          <div class="settings-friend-help-contact-found-text-two">+{i.number}</div>
        </div>
        <div id="{'del' + i.number}" class="settings-friend-help-contact-cancel-icon"
             ontouchstart="deleteFriendTouchStart(this.id)"
             ontouchend="deleteFriendTouchEnd({'id'+i.number}, {i.number}, this.id)"></div>
      </div>

    </div>

  </div>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>
    var scope = this;
    console.log('OPTS in FriendHelp', opts);

    scope.arrayOfPhoneNumbers = [];

    this.titleName = window.languages.ViewSecuritySettingsFriendHelpTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-friend-help-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-friend-help-settings',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.arrayOfFriends = [];

    if (localStorage.getItem('click_client_friends') === null) {
      scope.arrayOfFriends = []
    }
    else {
      scope.arrayOfFriends = JSON.parse(localStorage.getItem('click_client_friends'));
      console.log('scope.arrayOfFriends', scope.arrayOfFriends)

//      for(var i in scope.arrayOfFriends){
//        if(scope.arrayOfFriends[i].photo === null){
//
//        }
//      }
    }

    function onSuccess(contacts) {
      //      alert('Found ' + contacts.length + ' contacts.');
      console.log('contacts', contacts)

      for (var i in contacts) {
        var personObj = {};
        if (contacts[i].phoneNumbers) {
          personObj.phone = [];
          for (var k in contacts[i].phoneNumbers) {
            personObj.phone.push(window.inputVerification.spaceDeleter(contacts[i].phoneNumbers[k].value))
          }
        }
        else {
          continue
        }
        if (contacts[i].name && contacts[i].name.familyName)
          personObj.lastname = contacts[i].name.familyName

        if (contacts[i].name && contacts[i].name.givenName)
          personObj.firstname = contacts[i].name.givenName

        scope.arrayOfPhoneNumbers.push(personObj)
      }

      console.log('CONTACTS ARRAY', scope.arrayOfPhoneNumbers)

      if (!scope.arrayOfPhoneNumbers) return

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = info.session_key;

      window.api.call({
        method: 'check.contact.list',
        input: {
          phone_num: phoneNumber,
          phone_list: scope.arrayOfPhoneNumbers,
          session_key: sessionKey,

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log("contact list checker method", result);
            var object = {};

            if (result[1][0])
              for (var i in result[1][0].phone_list) {
                object = {}
                console.log('result[1][0]', result[1][0])
                if (!result[1][0].phone_list[i].phone) {
                  continue
                }
                if (result[1][0].phone_list[i].firstname && result[1][0].phone_list[i].lastname)
                  object.name = result[1][0].phone_list[i].firstname + " " + result[1][0].phone_list[i].lastname;
                else {
                  if (result[1][0].phone_list[i].firstname)
                    object.name = result[1][0].phone_list[i].firstname;
                  else {
                    if (result[1][0].phone_list[i].lastname) {
                      object.name = result[1][0].phone_list[i].lastname
                    }
                    else {
                      object.name = 'Неизвестно'
                    }
                  }
                }
                object.number = result[1][0].phone_list[i].phone;
                if (object.name)
                  object.firstLetterOfName = object.name[0].toUpperCase();
                object.photo = null;

                scope.arrayOfFriends.push(object);
              }

//            localStorage.setItem('click_client_friends',JSON.stringify(scope.arrayOfFriends))
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.viewPage = ''
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    function onError(contactError) {
      //      alert('onError!');
      console.log('error', contactError)
    }


    // find all contacts with 'Bob' in any name field

    if (device.platform != 'BrowserStand') {
      var options = new ContactFindOptions();
      options.multiple = true;
      options.hasPhoneNumber = true;
      navigator.contacts.find(["phoneNumbers"], onSuccess, onError, options);
    }


    //    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    //    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    //    var sessionKey = info.session_key;
    //
    //    window.api.call({
    //      method: 'card.add',
    //      input: {
    //        phone_num: phoneNumber,
    //        card_number: cardNumber,
    //        card_data: dateOrPin,
    //        session_key: sessionKey,
    //
    //      },
    //
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        if (result[0][0].error == 0) {
    //          console.log("CARD ADD", result);
    //
    //          scope.clickPinError = false;
    //          scope.errorNote = result[0][0].error_note;
    //          scope.showError = true;
    //          scope.viewPage = 'view-main-page'
    //          scope.update();
    //        }
    //        else {
    //          scope.clickPinError = false;
    //          scope.errorNote = result[0][0].error_note;
    //          scope.showError = true;
    //          scope.viewPage = ''
    //          scope.update();
    //        }
    //      },
    //
    //      onFail: function (api_status, api_status_message, data) {
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        if (opts.from && opts.from == "view-qr") {
          onBackParams.opts = null;
          onBackKeyDown()
        }
        else {
          onBackParams.opts = JSON.parse(JSON.stringify(opts));
          onBackKeyDown();
        }
        scope.unmount()
      }
    };

    var addButtonStartX, addButtonEndX, addButtonStartY, addButtonEndY;

    goToAddFriendViewStart = function () {
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(0.7)'

      addButtonStartX = event.changedTouches[0].pageX;
      addButtonStartY = event.changedTouches[0].pageY;
    }

    goToAddFriendViewEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      rightButton.style.webkitTransform = 'scale(1)'

      addButtonEndX = event.changedTouches[0].pageX;
      addButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(addButtonStartX - addButtonEndX) <= 20 && Math.abs(addButtonStartY - addButtonEndY) <= 20) {
        riotTags.innerHTML = "<view-add-friend>";
        riot.mount("view-add-friend");

        scope.unmount()
      }
    }


    var chooseButtonStartX, chooseButtonEndX, chooseButtonStartY, chooseButtonEndY;

    chooseFriendForHelpStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      console.log("ID", id)

      document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)'

      chooseButtonStartX = event.changedTouches[0].pageX;
      chooseButtonStartY = event.changedTouches[0].pageY;
    }

    chooseFriendForHelpEnd = function (number, id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.backgroundColor = 'transparent'

      chooseButtonEndX = event.changedTouches[0].pageX;
      chooseButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(chooseButtonStartX - chooseButtonEndX) <= 20 && Math.abs(chooseButtonStartY - chooseButtonEndY) <= 20) {
        if (viewServicePinCards.friendHelpPaymentMode) {
          console.log("in choose friend for help");
          console.log("OPTS", opts)
          for (var i in scope.arrayOfFriends) {
            if (scope.arrayOfFriends[i].number == number) {
              viewServicePinCards.chosenFriendForHelp = scope.arrayOfFriends[i];
              opts.chosenFriendForHelp = scope.arrayOfFriends[i];
              console.log(viewServicePinCards.chosenFriendForHelp);
              if (opts.from && opts.from == "view-qr") {
                onBackParams.opts = null;
                onBackKeyDown()
              }
              else {
                onBackParams.opts = JSON.parse(JSON.stringify(opts));
                onBackKeyDown();
              }
            }
          }

        }
      }

    }

    var delButtonStartX, delButtonEndX, delButtonStartY, delButtonEndY;

    deleteFriendTouchStart = function (id) {
      event.preventDefault();
      event.stopPropagation();

      delButtonStartX = event.changedTouches[0].pageX;
      delButtonStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.7)'
    }

    deleteFriendTouchEnd = function (id, idWithoutPrefix, delId) {

      event.preventDefault();
      event.stopPropagation();

      delButtonEndX = event.changedTouches[0].pageX;
      delButtonEndY = event.changedTouches[0].pageY;

      document.getElementById(delId).style.webkitTransform = 'scale(1)'


      if (Math.abs(delButtonStartX - delButtonEndX) <= 20 && Math.abs(delButtonStartY - delButtonEndY) <= 20) {

        var question = "Подтвердите удаление из списка";


        scope.confirmShowBool = true;
        scope.confirmNote = question;
        scope.confirmType = 'local';
        scope.result = function (bool) {
          if (bool) {
            var idOfBlock = 'id' + idWithoutPrefix;
            idOfBlock = idOfBlock.substring(2, idOfBlock.length);
            console.log('idWithoutPrefix', idWithoutPrefix)

            var arrayOfFriends = JSON.parse(localStorage.getItem('click_client_friends'));
            arrayOfFriends.filter(function (wordOfFunction, indexOfFind) {
              console.log("ASD TSET", indexOfFind);
              var index = wordOfFunction.number.indexOf(idWithoutPrefix);
              console.log(index)
              if (index != -1) {
                console.log('index', indexOfFind)
                arrayOfFriends.splice(indexOfFind, 1);
                console.log(arrayOfFriends)
                localStorage.setItem('click_client_friends', JSON.stringify(arrayOfFriends))
                id.parentNode.removeChild(id);
                return;
              }
            })
          }
        };
        scope.update();
      }
    }


  </script>
</view-friend-help-settings>

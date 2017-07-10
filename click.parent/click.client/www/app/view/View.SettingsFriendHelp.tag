<view-friend-help-settings>
  <div class="riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" ontouchend="goToAddFriendView()" class="settings-friend-help-add-button"></div>
    </div>
    <div id="mainContainerId" class="settings-container">
      <div each="{i in arrayOfFriends}" id="{'id'+i.number}" class="settings-friend-help-contact-container">
        <div class="settings-friend-help-contact-found-photo"
             style="background-image: url({i.photo})">{i.firstLetterOfName}
        </div>
        <div id="" class="settings-friend-help-contact-found-text-container"
             ontouchend="chooseFriendForHelp({i.number})">
          <div class="settings-friend-help-contact-found-text-one">{i.name}</div>
          <div class="settings-friend-help-contact-found-text-two">+{i.number}</div>
        </div>
        <div class="settings-friend-help-contact-cancel-icon"
             ontouchend="deleteFriendTouchEnd({'id'+i.number}, {i.number})"></div>
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

//    function onSuccess(contacts) {
////      alert('Found ' + contacts.length + ' contacts.');
//      console.log('contacts', contacts)
//
//      for(var i in contacts){
//        for(var j in contacts[i].phoneNumbers){
//          scope.arrayOfPhoneNumbers.push(contacts[i].phoneNumbers[j].value)
//        }
//      }
//
//      console.log('CONTACTS ARRAY', scope.arrayOfPhoneNumbers)
//
//      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
//      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
//      var sessionKey = info.session_key;
//
//      window.api.call({
//        method: 'check.contact.list',
//        input: {
//          phone_num: phoneNumber,
//          phone_list : scope.arrayOfPhoneNumbers,
//          session_key: sessionKey,
//
//        },
//
//        scope: this,
//
//        onSuccess: function (result) {
//          if (result[0][0].error == 0) {
//            console.log("contact list checker method", result);
//            scope.update();
//          }
//          else {
//            scope.clickPinError = false;
//            scope.errorNote = result[0][0].error_note;
//            scope.showError = true;
//            scope.viewPage = ''
//            scope.update();
//          }
//        },
//
//        onFail: function (api_status, api_status_message, data) {
//          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//          console.error(data);
//        }
//      });
//    }
//
//
//    function onError(contactError) {
////      alert('onError!');
//      console.log('error', contactError)
//    }
//
//
//    // find all contacts with 'Bob' in any name field
//    var options = new ContactFindOptions();
//    options.multiple = true;
//    options.hasPhoneNumber = true;
//    navigator.contacts.find(["phoneNumbers"], onSuccess, onError, options);


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

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    goToAddFriendView = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-add-friend>";
      riot.mount("view-add-friend");

      scope.unmount()
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

    chooseFriendForHelp = function (number) {
      if (viewServicePinCards.friendHelpPaymentMode) {
        console.log("in choose friend for help");
        console.log("OPTS", opts)
        for (var i in scope.arrayOfFriends) {
          if (scope.arrayOfFriends[i].number == number) {
            viewServicePinCards.chosenFriendForHelp = scope.arrayOfFriends[i];
            opts.chosenFriendForHelp = scope.arrayOfFriends[i];
            console.log(viewServicePinCards.chosenFriendForHelp);

            if (opts.from && opts.from == "view-qr")
              onBackKeyDown()
            else {
              onBackKeyDownWithParams(opts, 1);
            }
          }
        }

      }

    }

    deleteFriendTouchEnd = function (id, idWithoutPrefix) {

      event.preventDefault();
      event.stopPropagation();
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


  </script>
</view-friend-help-settings>

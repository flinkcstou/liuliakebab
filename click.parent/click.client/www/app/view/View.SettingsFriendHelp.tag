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
             ontouchend="deleteFriendTouchEnd({id+i.number}, {i.number})"></div>
      </div>

    </div>

  </div>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>
    var scope = this;
    console.log('OPTS in FriendHelp', opts);

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

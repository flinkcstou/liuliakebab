<view-general-settings>
  <div class="riot-tags-main-container">
    <div class="settings-general-user-info-container">

      <div class="page-title settings-general-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()" class="settings-general-back-button"></div>
        <div id="rightButton" type="button" class="settings-general-check-button"
             ontouchend="saveEditedNameTouchEnd()"></div>
      </div>

      <img src="resources/icons/ViewSettingsGeneral/general_avatar.png" id="imageUserAvatarId"
           class="settings-general-user-icon"/>
      <div class="settings-general-user-name-container">
        <input id="settingsUserNameId" readonly="true" class="settings-general-user-first-name"/>
        <div id="editUserInfoIconId" class="settings-general-user-name-save" ontouchend="editUserInfoTouchEnd()"></div>
      </div>
      <div class="settings-general-download-delete-container">
        <div id="uploadUserAvatarId" class="settings-general-user-upload-avatar"></div>
        <div id="imageSelectButtinId" class="settings-general-download-container" ontouchstart="imageSelectedChangeStart()" ontouchend="imageSelectedChangeEnd()">
          <div class="settings-general-download-icon"></div>
          <p class="settings-general-download-title">{window.languages.ViewSettingsGeneralDownloadPhotoTitle}</p>
        </div>
        <div id="delButtonId" class="settings-general-delete-container" ontouchstart="photoDeleteTouchStart()" ontouchend="photoDeleteTouchEnd()">
          <div class="settings-general-delete-icon"></div>
          <p class="settings-general-delete-title">{window.languages.ViewSettingsGeneralDeletePhotoTitle}</p>
        </div>
      </div>
    </div>
    <div class="settings-container settings-general-container">
      <div class="settings-general-gender-container">
        <div class="settings-general-male-container" ontouchend="maleTouchEnd()">
          <div id="maleIconId" class="settings-general-male-icon"></div>
          <p id="maleTitleId" class="settings-general-gender-text">
            {window.languages.ViewSettingsGeneralGenderMaleTitle}</p>
        </div>
        <div class="settings-general-line-between"></div>
        <div class="settings-general-female-container" ontouchend="femaleTouchEnd()">
          <div id="femaleIconId" class="settings-general-female-icon"></div>
          <p id="femaleTitleId" class="settings-general-gender-text">
            {window.languages.ViewSettingsGeneralGenderFemaleTitle}</p>
        </div>
      </div>
      <div class="settings-general-languages-container" if="{langChangeBool}">
        <div class="settings-general-lang-container" ontouchend="MakeMainCheck()">
          <p class="settings-general-lang-text">Русский</p>
          <div id="langCheckId" class="settings-general-lang-check"></div>
        </div>
      </div>


    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = window.languages.ViewMainSettingsTitleTwo;
    scope.langChangeBool = false;
    var checkOfEdit = false;

    console.log(JSON.parse(localStorage.getItem('click_client_loginInfo')))
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;
    scope.gender = loginInfo.gender;

    this.on('mount', function () {
      if (scope.photo) {
        imageUserAvatarId.src = scope.photo;
      }

      settingsUserNameId.value = scope.firstName + ' ' + scope.lastName;
      if (scope.gender == 'M') {
        maleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_male_active.png)'
        maleTitleId.style.color = 'black'

        femaleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_female_inactive.png)'
        femaleTitleId.style.color = 'lightgrey'
      }
      else {
        maleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_male_inactive.png)'
        maleTitleId.style.color = 'lightgrey'

        femaleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_female_active.png)'
        femaleTitleId.style.color = 'black'
      }

      scope.update();

    })

    var delButtonStartX, delButtonEndX, delButtonStartY, delButtonEndY;

    photoDeleteTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      delButtonId.style.webkitTransform = 'scale(0.8)'

      delButtonStartX = event.changedTouches[0].pageX;
      delButtonStartY = event.changedTouches[0].pageY;
    }

    photoDeleteTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      delButtonId.style.webkitTransform = 'scale(1)'

      delButtonEndX = event.changedTouches[0].pageX;
      delButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(delButtonStartX - delButtonEndX) <= 20 && Math.abs(delButtonStartY - delButtonEndY) <= 20) {

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      var result;

      scope.confirmShowBool = true;
      scope.confirmType = 'local';
      scope.confirmNote = 'Подтвердите удаление фото';
      scope.update();
      scope.result = function (bool) {
        if (bool) {
          result = true;
        }
        else result = false;
      };

      if (result)
        window.api.call({
          method: 'settings.photo.remove',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
          },
          scope: this,
          onSuccess: function (result) {
            console.log(result)
            if (result[0][0].error == 0) {

            }
            else {
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;
              scope.showError = true;
              scope.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });

    }
    }

    saveEditedNameTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
      console.log('settingsUserNameId.value', settingsUserNameId.value)

      window.api.call({
        method: 'settings.change.profile.data',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          name: settingsUserNameId.value,
          gender: scope.gender,
        },
        //TODO: DO CARDS
        scope: this,
        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log(result[1])
            loginInfo.firstname = result[1][0].firstname
            loginInfo.lastname = result[1][0].lastname
            loginInfo.gender = result[1][0].gender
            localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo))
            scope.clickPinError = false;
            scope.errorNote = 'Изменения сохранены';
            scope.showError = true;
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    scope.base64Data = '';

    var imageButtonStartX, imageButtonEndX, imageButtonStartY, imageButtonEndY;

    imageSelectedChangeStart = function (){
      event.preventDefault();
      event.stopPropagation();

      imageSelectButtinId.style.webkitTransform = 'scale(0.8)'

      imageButtonStartX = event.changedTouches[0].pageX;
      imageButtonStartY = event.changedTouches[0].pageY;
    }

    imageSelectedChangeEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      scope.base64Data = '';

      imageSelectButtinId.style.webkitTransform = 'scale(1)'

      imageButtonEndX = event.changedTouches[0].pageX;
      imageButtonEndY = event.changedTouches[0].pageY;


      if (Math.abs(imageButtonStartX - imageButtonEndX) <= 20 && Math.abs(imageButtonStartY - imageButtonEndY) <= 20) {
        console.log("QWE")

        var options = {
          quality: 50,
          destinationType: Camera.DestinationType.DATA_URL,
          sourceType: Camera.PictureSourceType.PHOTOLIBRARY,
          allowEdit: true,
          encodingType: Camera.EncodingType.JPEG,
          targetWidth: 100,
          targetHeight: 100,
          popoverOptions: CameraPopoverOptions,
          saveToPhotoAlbum: false,
          correctOrientation: true
        };

        navigator.camera.getPicture(onSuccess, onFail, options);

        function onSuccess(imageData) {
          imageUserAvatarId.src = "data:image/jpeg;base64," + imageData;
          var canvas = document.createElement("canvas");
          canvas.width = imageUserAvatarId.width;
          canvas.height = imageUserAvatarId.height;
          var ctx = canvas.getContext("2d");
          ctx.drawImage(imageUserAvatarId, 0, 0);
          scope.base64Data = canvas.toDataURL("image/png");
          var index = scope.base64Data.indexOf(',');
          scope.base64Cut = scope.base64Data.substring(index + 1, scope.base64Data.length)


          console.log('scope.base64Data', scope.base64Data)
          console.log('scope.base64Cut', scope.base64Cut)

          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var sessionKey = loginInfo.session_key;
          if (scope.base64Data)
            window.api.call({
              method: 'settings.photo.upload',
              input: {
                session_key: sessionKey,
                phone_num: phoneNumber,
                data: scope.base64Cut,
              },
              scope: this,
              onSuccess: function (result) {
                console.log("RESULT PHOTO", result)
                if (result[0][0].error == 0) {
                  if (result[1][0]) {
                    imageUserAvatarId.src = "data:image/jpeg;base64," + imageData;
                    loginInfo.profile_image_url = result[1][0].profile_image_url;
                    localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo))
                    localStorage.setItem('click_client_avatar', scope.base64Data)
                  }
                }
                else {
                  scope.clickPinError = false;
                  scope.errorNote = result[0][0].error_note;
                  scope.showError = true;
                  scope.update();
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });

          riot.update();
        }

        function onFail(message) {
          console.log('Failed because: ' + message);
        }


//      var reader = new FileReader();
//      if (event.target.files && event.target.files[0]) {
//        console.log('event PHOTO UPLOAD', event)
//        console.log('event.target', event.target)
//        console.log('event.target.files', event.target.files)
//        reader.readAsDataURL(uploadUserAvatarId.files[0]);
//
//        console.log('uploadUserAvatarId.files[0]', uploadUserAvatarId.files[0])
//
//        reader.onload = function (event) {
//          console.log('uploadUserAvatarId.files[0]', uploadUserAvatarId.files[0])
//          ImageTools.resize(uploadUserAvatarId.files[0], {
//              width: 240,
//              height: 320,
//            },
//            function (blob, didItResize) {
//              console.log('blob', blob)
//              console.log('didItResize', didItResize)
//              // didItResize will be true if it managed to resize it, otherwise false (and will return the original file as 'blob')
////              imageUserAvatarId.src = window.URL.createObjectURL(blob);
//              var convertReader = new FileReader();
//              convertReader.readAsDataURL(blob);
//              convertReader.onload = function () {
//                scope.base64Data = convertReader.result;
//                var exif =
//
//                console.log('EXIF',exif)
//
//                var index = scope.base64Data.indexOf(',');
//                var base64Cut = scope.base64Data.substring(index + 1, scope.base64Data.length)
//
//                var phoneNumber = localStorage.getItem("click_client_phoneNumber");
//                var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
//                var sessionKey = loginInfo.session_key;
//


//      var reader = new FileReader();
//      if (event.target.files && event.target.files[0]) {
//        console.log('event PHOTO UPLOAD', event)
//        console.log('event.target', event.target)
//        console.log('event.target.files', event.target.files)
//        reader.readAsDataURL(uploadUserAvatarId.files[0]);
//
//        console.log('uploadUserAvatarId.files[0]', uploadUserAvatarId.files[0])
//
//        reader.onload = function (event) {
//          console.log('uploadUserAvatarId.files[0]', uploadUserAvatarId.files[0])
//          ImageTools.resize(uploadUserAvatarId.files[0], {
//              width: 240,
//              height: 320,
//            },
//            function (blob, didItResize) {
//              console.log('blob', blob)
//              console.log('didItResize', didItResize)
//              // didItResize will be true if it managed to resize it, otherwise false (and will return the original file as 'blob')
////              imageUserAvatarId.src = window.URL.createObjectURL(blob);
//              var convertReader = new FileReader();
//              convertReader.readAsDataURL(blob);
//
//              convertReader.onload = function () {
//                scope.base64Data = convertReader.result;
//                var index = scope.base64Data.indexOf(',');
//                var base64Cut = scope.base64Data.substring(index + 1, scope.base64Data.length)
//
//                var phoneNumber = localStorage.getItem("click_client_phoneNumber");
//                var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
//                var sessionKey = loginInfo.session_key;
//
//                if (scope.base64Data)
//                  window.api.call({
//                    method: 'settings.photo.upload',
//                    input: {
//                      session_key: sessionKey,
//                      phone_num: phoneNumber,
//                      data: base64Cut,
//                    },
//                    scope: this,
//                    onSuccess: function (result) {
//                      console.log("RESULT PHOTO", result)
//                      if (result[0][0].error == 0) {
//                        if (result[1][0]) {
//                          imageUserAvatarId.src = scope.base64Data
//                          loginInfo.profile_image_url = result[1][0].profile_image_url;
//                          localStorage.setItem("click_client_loginInfo", JSON.stringify(loginInfo))
//                        }
//                      }
//                      else {
//                        scope.clickPinError = false;
//                        scope.errorNote = result[0][0].error_note;
//                        scope.showError = true;
//                        scope.update();
//                      }
//                    },
//
//                    onFail: function (api_status, api_status_message, data) {
//                      console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//                      console.error(data);
//                    }
//                  });
//              }
//              localStorage.setItem('click_client_avatar', imageUserAvatarId.src)
//              // you can also now upload this blob using an XHR.
//            });
//        }
//      }
      }
    }

    maleTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      maleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_male_active.png)'
      maleTitleId.style.color = 'black'

      femaleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_female_inactive.png)'
      femaleTitleId.style.color = 'lightgrey'

      scope.gender = 'M'
    }

    femaleTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      maleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_male_inactive.png)'
      maleTitleId.style.color = 'lightgrey'

      femaleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_female_active.png)'
      femaleTitleId.style.color = 'black'

      scope.gender = 'F'
    }


    editUserInfoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      if (!checkOfEdit) {
        editUserInfoIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_save.png)';
        checkOfEdit = true;
        settingsUserNameId.readOnly = false;
        settingsUserNameId.focus();
        return;
      }
      else {
        editUserInfoIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_edit.png)';
        checkOfEdit = false;
        settingsUserNameId.readOnly = true;
      }
    }


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-general-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-general-settings',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

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
        onBackKeyDown()
        scope.unmount()
      }
    };


  </script>
</view-general-settings>

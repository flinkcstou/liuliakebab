<view-general-settings>
  <div>
    <div class="settings-general-user-info-container">

      <div class="page-title settings-general-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
        <div id="rightButton" type="button" class="settings-general-check-button"
             ontouchend="saveEditedNameToucEnd()"></div>
      </div>

      <img src="resources/icons/ViewSettingsGeneral/general_avatar.png" id="imageUserAvatarId"
           class="settings-general-user-icon"/>
      <div class="settings-general-user-name-container">
        <input id="settingsUserNameId" readonly="true" class="settings-general-user-first-name"/>
        <div id="editUserInfoIconId" class="settings-general-user-name-save" ontouchend="editUserInfoTouchEnd()"></div>
      </div>
      <div class="settings-general-download-delete-container">
        <input id="uploadUserAvatarId" class="settings-general-user-upload-avatar" type="file" accept="image/*"
               onchange="imageSelectedChange()"/>
        <div class="settings-general-download-container">
          <div class="settings-general-download-icon"></div>
          <p class="settings-general-download-title">{window.languages.ViewSettingsGeneralDownloadPhotoTitle}</p>
        </div>
        <div class="settings-general-delete-container">
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

  <script>
    var scope = this;
    this.titleName = window.languages.ViewMainSettingsTitleTwo;
    scope.langChangeBool = false;
    var checkOfEdit = false;

    console.log(JSON.parse(localStorage.getItem('click_client_loginInfo')))
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    this.on('mount', function () {

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
      riot.update();

    })

    imageSelectedChange = function () {
      event.preventDefault();
      event.stopPropagation();


      var reader = new FileReader();
      if (event.target.files && event.target.files[0]) {
        console.log(reader)
        reader.readAsDataURL(uploadUserAvatarId.files[0]);

        reader.onload = function (event) {
          console.log('uploadUserAvatarId.files[0]', uploadUserAvatarId.files[0])
          ImageTools.resize(uploadUserAvatarId.files[0], {
              width: 32,
              height: 24,
            },
            function (blob, didItResize) {
              // didItResize will be true if it managed to resize it, otherwise false (and will return the original file as 'blob')
              imageUserAvatarId.src = window.URL.createObjectURL(blob);
              console.log('event', event)
              // you can also now upload this blob using an XHR.
            });
        }
      }
    }

    maleTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      maleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_male_active.png)'
      maleTitleId.style.color = 'black'

      femaleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_female_inactive.png)'
      femaleTitleId.style.color = 'lightgrey'
    }

    femaleTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      maleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_male_inactive.png)'
      maleTitleId.style.color = 'lightgrey'

      femaleIconId.style.backgroundImage = 'url(resources/icons/ViewSettingsGeneral/general_female_active.png)'
      femaleTitleId.style.color = 'black'
    }

    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;
    scope.gender = loginInfo.gender;
    console.log('LOGIN', loginInfo)

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
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


  </script>
</view-general-settings>

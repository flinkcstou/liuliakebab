<view-general-settings>
  <div>
    <div class="page-title settings-general-page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      <div id="rightButton" type="button" class="check-button" ontouchend="saveEdit()"></div>
    </div>
    <div class="settings-general-user-info-container">
      <div class="settings-general-user-icon" style="background-image: url({photo})"></div>
      <div class="settings-general-user-name-container">
        <p class="settings-general-user-first-name">{lastName}</p>
        <p class="settings-general-user-second-name">{firstName}</p>
      </div>
      <div class="settings-general-edit-icon"></div>
    </div>
    <div class="settings-container settings-general-container">
      <div class="settings-general-gender-container">
        <div class="settings-general-male-container">
          <div class="settings-general-male-icon"></div>
          <p class="settings-general-gender-text" style="color: #353340;">Муж</p>
        </div>
        <div class="settings-general-female-container">
          <div class="settings-general-female-icon"></div>
          <p class="settings-general-gender-text">Жен</p>
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

    console.log(JSON.parse(localStorage.getItem('click_client_loginInfo')))
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;


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

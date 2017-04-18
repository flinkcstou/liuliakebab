<view-autopay-method>
  <div>
    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title autopay-method-page-title">{titleName}</p>
      <div ontouchend="goToBack()"
           class="servicepage-button-back autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">
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

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = "АВТОПЛАТЕЖ";
    //window.languages.ViewMainSettingsTitleTwo;
    scope.langChangeBool = false;
    var checkOfEdit = false;

    console.log(JSON.parse(localStorage.getItem('click_client_loginInfo')))
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

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

      riot.update();

    })


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


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-general-settings') {
      history.arrayOfHistory.push(
        {
          "view": 'view-general-settings',
          "params": opts
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
</view-autopay-method>

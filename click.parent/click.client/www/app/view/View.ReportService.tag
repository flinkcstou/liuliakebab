<view-report-service>
  <div>

    <div class="report-service-upper-container">

      <div class="page-title settings-general-page-title">
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
      </div>

      <img src="resources/icons/ViewSettingsGeneral/general_avatar.png" id="imageUserAvatarId"
           class="report-service-icon"/>

      <div class="report-service-upper-info-container">
        <div class="report-service-title">Ucell</div>
        <div class="report-service-payment-info-text">Номер платежа: 333 897 649</div>
        <div class="report-service-payment-info-text">Дата: 2017-03-01 11:43:20</div>
      </div>

    </div>

    <div class="report-service-body-container">

    </div>

  </div>

  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
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

    })


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-report-service') {
      history.arrayOfHistory.push(
        {
          "view": 'view-report-service',
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
</view-report-service>

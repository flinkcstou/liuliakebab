<view-about-program class="riot-tags-main-container">
  <div class="settings-about-program-blue-container">
    <div class="settings-about-program-page-title">
      <p class="settings-about-program-name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>
    <div class="settings-about-program-click-icon"></div>
    <p class="settings-about-program-version-title-part-one">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartOne} <br>{window.languages.ViewSettingsAboutProgramVersionTitleNamePartOneClick}
    </p>
    <p class="settings-about-program-version-title-part-two">
      {window.languages.ViewSettingsAboutProgramVersionTitleNamePartTwo}</p>
  </div>
  <div class="settings-container settings-about-program-container">
    <div id="agreementButtonId" class="settings-about-program-user-agreement-container"
         ontouchstart="userAgreementTouchStart()" ontouchend="userAgreementTouchEnd()">
      <p class="settings-about-program-user-agreement-title">
        {window.languages.ViewSettingsAboutProgramUserAgreementTitleName}</p>
      <div class="settings-about-program-user-agreement-icon"></div>
    </div>
    <div id="rankButtonId" class="settings-about-program-rank-container" ontouchstart="rankAppTouchStart()"
         ontouchend="rankAppTouchEnd()">
      <p id="rankText" class="settings-about-program-rank-title">{(device.platform == "iOS")?
        (window.languages.ViewSettingsAboutProgramIOSRankTitleName):(window.languages.ViewSettingsAboutProgramRankTitleName)}</p>
      <div class="settings-about-program-rank-icon"></div>
    </div>
  </div>


  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsAboutProgramTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-about-program') {
      history.arrayOfHistory.push(
        {
          "view": 'view-about-program',
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

    var agreementButtonStartX, agreementButtonEndX, agreementButtonStartY, agreementButtonEndY;

    userAgreementTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      agreementButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      agreementButtonStartX = event.changedTouches[0].pageX;
      agreementButtonStartY = event.changedTouches[0].pageY;
    }

    userAgreementTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      agreementButtonId.style.backgroundColor = 'transparent'

      agreementButtonEndX = event.changedTouches[0].pageX;
      agreementButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(agreementButtonStartX - agreementButtonEndX) <= 20 && Math.abs(agreementButtonStartY - agreementButtonEndY) <= 20) {

        riotTags.innerHTML = "<view-settings-user-agreement>";
        riot.mount("view-settings-user-agreement");

        scope.unmount()
      }
    }

    var rankButtonStartX, rankButtonEndX, rankButtonStartY, rankButtonEndY;

    rankAppTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      rankButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      rankButtonStartX = event.changedTouches[0].pageX;
      rankButtonStartY = event.changedTouches[0].pageY;
    }

    rankAppTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      rankButtonId.style.backgroundColor = 'transparent'

      rankButtonEndX = event.changedTouches[0].pageX;
      rankButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(rankButtonStartX - rankButtonEndX) <= 20 && Math.abs(rankButtonStartY - rankButtonEndY) <= 20) {

        if (device.platform === "iOS") {

          window.open('https://itunes.apple.com/us/app/click-uzbekistan/id768132591?mt=8');
        } else {

          window.open('https://play.google.com/store/apps/details?id=air.com.ssdsoftwaresolutions.clickuz');
        }
      }
    }


  </script>
</view-about-program>

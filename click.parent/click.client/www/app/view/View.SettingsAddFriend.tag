<view-add-friend>
  <div>
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    </div>
    <div class="settings-container">

    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewSettingsAboutProgramTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-about-program') {
      history.arrayOfHistory.push(
        {
          "view": 'view-about-program',
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
</view-add-friend>

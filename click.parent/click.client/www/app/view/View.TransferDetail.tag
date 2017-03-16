<view-transfer-detail>
  <div>
    <div class="settings-general-user-info-container">

      <div class="page-title settings-general-page-title">
        <p class="name-title">{titleName}</p>
        <div id="backButton" ontouchend="goToBack()" class="settings-general-back-button"></div>
        <div id="rightButton" type="button" class="settings-general-check-button"
             ontouchend="saveEditedNameTouchEnd()"></div>
      </div>
    </div>

    <div class="settings-container settings-general-container">
    </div>

  </div>

  <script>
    var scope = this;
    this.titleName = window.languages.ViewTransferDetailTitle;

    this.on('mount', function () {

    })


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


  </script>
</view-transfer-detail>

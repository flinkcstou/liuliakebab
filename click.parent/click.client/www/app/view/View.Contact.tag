<view-contact>

  <div class="view-contact-page-title">
    <p class="view-contact-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="view-contact-back-button"></div>
  </div>

  <div class="view-contact">
    <div class="view-contact-info-title">
      <div class="view-contact-info-icon"></div>
      <p class="view-contact-info-text">ALEKSANDR ALEKSANDROV</p>
    </div>
    <div class="view-contact-pay-transfer-container">
      <div class="view-contact-pay-icon"></div>
      <div class="view-contact-open-icon"></div>
    </div>
    <div class="view-contact-pay-transfer-container">
      <div class="view-contact-transfer-icon"></div>
      <div class="view-contact-open-icon"></div>
    </div>
  </div>

  <script>
    var scope = this;

    this.on('mount', function () {

    })

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-contact') {
      history.arrayOfHistory.push(
        {
          "view": 'view-contact',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.titleName = window.languages.ViewContactTitle;

    goToBack = function () {
      event.preventDefault()
      event.stopPropagation()
      onBackKeyDown()
    }


  </script>
</view-contact>
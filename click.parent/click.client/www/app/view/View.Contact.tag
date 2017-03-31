<view-contact>

  <div class="contact-page-title">
    <p class="contact-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="contact-back-button"></div>
  </div>

  <div class="view-contact">
    <div class="contact-info-title">
      <div class="contact-info-icon"></div>
      <p class="contact-info-text">ALEKSANDR ALEKSANDROV</p>
    </div>
    <div></div>
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
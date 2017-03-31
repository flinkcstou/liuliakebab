<view-contact>

  <div class="contact-page-title">
    <p class="contact-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="contact-back-button"></div>
  </div>

  <div class="view-contact">

  </div>

  <script>
    var scope = this;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-contact') {
      history.arrayOfHistory.push(
        {
          "view": 'view-contact',
          "params": ''
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


    this.on('mount', function () {

    })


  </script>
</view-contact>
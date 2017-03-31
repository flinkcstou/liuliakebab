<view-contact>

  <div class="view-contact-page-title">
    <p class="view-contact-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="view-contact-back-button"></div>
  </div>

  <div class="view-contact">
    <div class="view-contact-info-title">
      <div class="view-contact-info-icon" style="background-image: url({contactPhoto})">{firstLetter}</div>
      <p class="view-contact-info-text">{firstName} {secondName}</p>
    </div>
    <div class="view-contact-pay-transfer-container">
      <div class="view-contact-pay-icon"></div>
      <p class="view-contact-pay-title">Оплатить за мобильный</p>
      <div class="view-contact-open-icon"></div>
    </div>
    <div class="view-contact-pay-transfer-container">
      <div class="view-contact-transfer-icon"></div>
      <p class="view-contact-transfer-title">Перевод по номеру телефона</p>
      <div class="view-contact-open-icon"></div>
    </div>
  </div>

  <script>
    var scope = this;

    this.on('mount', function () {

    })
    console.log(opts.object)
    scope.firstName = opts.object.contactFname;
    scope.secondName = opts.object.contactLname;
    scope.contactPhoto = opts.object.contactPhoto;
    scope.firstLetter = opts.object.firstLetter;

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
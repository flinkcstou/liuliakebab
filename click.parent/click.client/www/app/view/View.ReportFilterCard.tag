<view-report-filter-card>
  <div class="view-report-filter-page">

    <div class="page-title page-title-shadow" style="border: none;">
      <p class="name-title">{window.languages.ViewReportFilterCardPageTitle}</p>
      <div id="backButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div class="title-bottom-border"></div>
    </div>

    <div class="view-report-filter-card-choose-card-text">
      {window.languages.ViewReportFilterCardChooseCardText}
    </div>

    <div id="cardsContainerId"
         class="view-report-filter-card-cards-container">
      <div class="view-report-filter-card-card" each="{i in accounts}"
           id="{i.card_id}" if="{i.access == 2}">
        <div class="view-report-filter-card-card-logo-container"
             style="background-image: url({i.image_url})"></div>
        <div class="view-report-filter-card-card-info-container">
          <p class="view-report-filter-card-card-info-text-one">{i.description}</p>
          <p class="view-report-filter-card-card-info-text-three">{i.accno}</p>
        </div>
        <div class="view-report-filter-card-card-check-icon"></div>
        <div class="title-bottom-border">
        </div>
      </div>
    </div>

    <div id="firstEnterButtonId" class="bottom-button-container"
         ontouchend="firstPinEnterTouchEnd()"
         ontouchstart="firstPinEnterTouchStart()">
      <div class="button-enter-label">{window.languages.ViewReportFilterSaveButton}</div>
    </div>
  </div>

  <script>

    var scope = this;

    console.log('opts in report filter by card before saving', opts);

    window.saveHistory('view-report-filter-card', opts);

    scope.accounts = localStorage.getItem('click_client_accountInfo') ? JSON.parse(localStorage.getItem('click_client_accountInfo')) : [];

    //Go back from filter
    {
      var goToBackStartX, goToBackStartY,
        goToBackEndX, goToBackEndY;

      goToBackStart = function () {
        event.preventDefault();
        event.stopPropagation();

        backButtonId.style.webkitTransform = 'scale(0.8)';

        goToBackStartX = event.changedTouches[0].pageX;
        goToBackStartY = event.changedTouches[0].pageY;
      };

      goToBackEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        backButtonId.style.webkitTransform = 'scale(1)';

        goToBackEndX = event.changedTouches[0].pageX;
        goToBackEndY = event.changedTouches[0].pageY;

        if (Math.abs(goToBackStartX - goToBackEndX) <= 20
          && Math.abs(goToBackStartY - goToBackEndY) <= 20) {
          onBackKeyDown();
          scope.unmount();
        }
      }
    }

  </script>
</view-report-filter-card>
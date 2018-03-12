<view-report-filter>
  <div id="filterPageId" class="view-reports-page">

    <div class="page-title" style="border: none;">
      <p class="name-title">{window.languages.ViewReportFilterTitle}</p>
      <div id="backButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div class="title-bottom-border"></div>
    </div>

    <div id="filtersContainerId"
         class="view-report-filters-container">

      <div id="filterByDateId"
           class="view-report-filter-bydate-container"
           ontouchstart="byDateStart()"
           ontouchend="byDateEnd()">
        <div class="view-report-filter-bydate-icon"></div>
        <div class="view-report-filter-bydate-title">
          {window.languages.ViewReportFilterByDateTitle}
        </div>
        <div class="view-report-filter-bydate-text">
          02.01.2018 - 02.02.2018
        </div>
        <div class="view-report-filter-arrow-icon"></div>
        <div class="title-bottom-border">
        </div>
      </div>

      <div id="filterByCardId"
           class="view-report-filter-bycard-container"
           ontouchstart="byCardStart()"
           ontouchend="byCardEnd()">
        <div class="view-report-filter-bycard-icon"></div>
        <div class="view-report-filter-bycard-title">
          {window.languages.ViewReportFilterByCardTitle}
        </div>
        <div class="view-report-filter-bycard-text">
          Все карты
        </div>
        <div class="view-report-filter-arrow-icon"></div>
        <div class="title-bottom-border"></div>
      </div>

    </div>

    <div id="firstEnterButtonId" class="bottom-button-container"
         ontouchend="firstPinEnterTouchEnd()"
         ontouchstart="firstPinEnterTouchStart()">
      <div class="button-enter-label">{window.languages.ViewReportFilterApplyButton}</div>
    </div>

  </div>

  <script>

    var scope = this;

    console.log('opts in report filter before saving', opts);

    window.saveHistory('view-report-filter', opts);

    //Go to filter by date or by card
    {
      var byDateStartX, byDateStartY,
        byDateEndX, byDateEndY;

      byDateStart = function () {
        event.preventDefault();
        event.stopPropagation();

        filterByDateId.style.backgroundColor = 'rgba(231,231,231,0.8)';

        byDateStartX = event.changedTouches[0].pageX;
        byDateStartY = event.changedTouches[0].pageY;
      };

      byDateEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        filterByDateId.style.backgroundColor = 'transparent';

        byDateEndX = event.changedTouches[0].pageX;
        byDateEndY = event.changedTouches[0].pageY;

        if (Math.abs(byDateStartX - byDateEndX) <= 20
          && Math.abs(byDateStartY - byDateEndY) <= 20) {
          riotTags.innerHTML = "<view-report-filter-date>";
          riot.mount('view-report-filter-date', opts);
          scope.unmount();
        }
      };

      var byCardStartX, byCardStartY,
        byCardEndX, byCardEndY;

      byCardStart = function () {
        event.preventDefault();
        event.stopPropagation();

        filterByCardId.style.backgroundColor = 'rgba(231,231,231,0.8)';

        byCardStartX = event.changedTouches[0].pageX;
        byCardStartY = event.changedTouches[0].pageY;
      };

      byCardEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        filterByCardId.style.backgroundColor = 'transparent';

        byCardEndX = event.changedTouches[0].pageX;
        byCardEndY = event.changedTouches[0].pageY;

        if (Math.abs(byCardStartX - byCardEndX) <= 20
          && Math.abs(byCardStartY - byCardEndY) <= 20) {
          riotTags.innerHTML = "<view-report-filter-card>";
          riot.mount('view-report-filter-card', opts);
          scope.unmount();
        }
      };
    }

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
</view-report-filter>
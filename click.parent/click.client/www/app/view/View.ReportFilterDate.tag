<view-report-filter-date>
  <div class="view-report-filter-page">

    <div class="page-title page-title-shadow" style="border: none;">
      <p class="name-title">{window.languages.ViewReportFilterDatePageTitle}</p>
      <div id="backButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div class="title-bottom-border"></div>
    </div>

    <div id="customPeriodContainerId"
         class="view-report-filter-date-custom-container">
      <div class="view-report-filter-date-custom-text">
        {window.languages.ViewReportFilterDateCustomText}
      </div>
      <div id="customPeriodFromDateId" class="view-report-filter-date-custom-from">
        <div class="title-top-border"></div>

        <div class="view-report-filter-date-custom-from-title">{window.languages.ViewReportFilterDateCustomFrom}</div>
        <div class="view-report-filter-date-custom-arrow"></div>

        <div class="title-bottom-border"></div>
      </div>
      <div id="customPeriodToDateId" class="view-report-filter-date-custom-to">
        <div class="view-report-filter-date-custom-to-title">{window.languages.ViewReportFilterDateCustomTo}</div>
        <div class="view-report-filter-date-custom-arrow"></div>
        <div class="title-bottom-border"></div>
      </div>
    </div>

    <div id="rangeTypeContainerId"
         class="view-report-filter-date-range-type-container">
      <div class="view-report-filter-date-range-type">
        <div class="title-top-border"></div>
        <div class="view-report-filter-date-range-type-title">
          {window.languages.ViewReportFilterDateRangeToday}
        </div>
        <div id="todayId" class="view-report-filter-date-range-type-check-icon"></div>
        <div class="title-bottom-border"></div>
      </div>
      <div class="view-report-filter-date-range-type">
        <div class="view-report-filter-date-range-type-title">
          {window.languages.ViewReportFilterDateRangeYesterday}
        </div>
        <div id="yesterdayId" class="view-report-filter-date-range-type-check-icon"></div>
        <div class="title-bottom-border"></div>
      </div>
      <div class="view-report-filter-date-range-type">
        <div class="view-report-filter-date-range-type-title">
          {window.languages.ViewReportFilterDateRangeCurrentWeek}
        </div>
        <div id="currentWeekId" class="view-report-filter-date-range-type-check-icon"></div>
        <div class="title-bottom-border"></div>
      </div>
      <div class="view-report-filter-date-range-type">
        <div class="view-report-filter-date-range-type-title">
          {window.languages.ViewReportFilterDateRangeLastWeek}
        </div>
        <div id="lastWeekId" class="view-report-filter-date-range-type-check-icon"></div>
        <div class="title-bottom-border"></div>
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

    console.log('opts in report filter by date before saving', opts);

    window.saveHistory('view-report-filter-date', opts);

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
</view-report-filter-date>
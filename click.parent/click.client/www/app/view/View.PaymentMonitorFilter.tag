<view-payment-report-filter>
  <div class="page-title" style="border: none;">
    <p class="name-title">{ViewMonitoringReportFilterTitle}</p>
    <div id="backButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackTouchStart()"
         ontouchend="goToBackTouchEnd()"
         class="back-button">
    </div>
    <div class="title-bottom-border">
    </div>
  </div>

  <div id="filtersContainerId">
    <div id="filterByDate"></div>
    <div id="filterByCard"></div>
  </div>
</view-payment-report-filter>
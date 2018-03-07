<view-monitoring-report class="riot-tags-main-container">
  <div id="reportPageId" class="view-reports-page">
    <div class="page-title" style="border: none;">
      <p class="name-title">{titleText}</p>
      <div id="backButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackReportTouchStart()"
           ontouchend="goToBackReportTouchEnd()"
           class="back-button">
      </div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div id="typeAndTurnOnContainerId"
         class="view-monitoring-report-type-and-turn-on-container">
      <div id="typeContainerId"
           class="view-monitoring-report-type-container">
      </div>
      <div id="turnOnContainerId"
           if="noToken"
           class="view-monitoring-report-turnon-container">
        <p class="view-monitoring-report-turnon-text-one">{window.languages.ViewMonitoringReportTurnOnTextOne}</p>
        <p class="view-monitoring-report-turnon-text-two">{window.languages.ViewMonitoringReportTurnOnTextTwo}</p>
      </div>
    </div>
  </div>

  <script>

    window.saveHistory('view-monitoring-report', opts);

    var scope = this;
    scope.noTokens = true;
    scope.noTokenTitle = window.languages.ViewMonitoringReportNoTokenTitle;
    scope.titleText = '';
    scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
    scope.filter = {
      start: '',
      end: '',
      card: ''
    };
    scope.noToken = true;

    scope.on('mount', function () {
      scope.titleText = generateTitleText();
      console.log(generateTitleText());
      scope.noToken = checkForTokens();
      scope.update();
    });

    //Go back from monitoring report
    {
      var goToBackReportTouchStartX, goToBackReportTouchStartY,
        goToBackReportTouchEndX, goToBackReportTouchEndY;

      goToBackReportTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        backButtonId.style.webkitTransform = 'scale(0.8)';

        goToBackReportTouchStartX = event.changedTouches[0].pageX;
        goToBackReportTouchStartY = event.changedTouches[0].pageY;
      };

      goToBackReportTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        backButtonId.style.webkitTransform = 'scale(1)';

        goToBackReportTouchEndX = event.changedTouches[0].pageX;
        goToBackReportTouchEndY = event.changedTouches[0].pageY;

        if (Math.abs(goToBackReportTouchStartX - goToBackReportTouchEndX) <= 20
          && Math.abs(goToBackReportTouchStartY - goToBackReportTouchEndY) <= 20) {
          onBackKeyDown();
          scope.unmount();
        }
      }
    }

    checkForTokens = function () {
      var result = false;
      for (var i in scope.cardsarray){
        if (scope.cardsarray[i].monitoring_token !== ""){
          result = true;
        }
      }
      console.log('found token !', result);
      return result;
    };

    generateTitleText = function () {
      var resultTitle = '';
      if (checkForTokens()){
        resultTitle = window.languages.ViewMonitoringReportYesTokenTitle;
        var currentMonth = new Date().getMonth() + 1;
        for (var i in window.languages.ViewReportMonthsArray){
          if (window.languages.ViewReportMonthsArray[i].count === currentMonth){
            resultTitle = resultTitle + window.languages.ViewReportMonthsArray[i].name.toUpperCase();
          }
        }
      } else {
        resultTitle = window.languages.ViewMonitoringReportNoTokenTitle;
      }
      if (scope.filter.start !== '' || scope.filter.end !== ''){
        resultTitle = scope.filter.start.toString() + '-' + scope.filter.end.toString();
      }
      return resultTitle;
    };
  </script>

</view-monitoring-report>
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
           if="{!noToken}"
           class="view-monitoring-report-type-container">

        <div id="incomeTypeId"
             class="view-monitoring-report-type"
             ontouchstart="typeTouchStart(this.id)"
             ontouchend="typeTouchEnd(this.id)">
          <div id="incomeTypeTitleId"
               class="view-monitoring-report-type-title">
            {window.languages.ViewMonitoringReportIncomeTypeTitle}
          </div>
        </div>

        <div id="outgoTypeId"
             class="view-monitoring-report-type"
             ontouchstart="typeTouchStart(this.id)"
             ontouchend="typeTouchEnd(this.id)">
          <div id="outgoTypeTitleId"
               class="view-monitoring-report-type-title">
            {window.languages.ViewMonitoringReportOutgoTypeTitle}
          </div>
        </div>

      </div>

      <div id="turnOnContainerId"
           if="{noToken}"
           class="view-monitoring-report-turnon-container">
        <p class="view-monitoring-report-turnon-text-one">
          {window.languages.ViewMonitoringReportTurnOnTextOne}
        </p>
        <p class="view-monitoring-report-turnon-text-two">
          {window.languages.ViewMonitoringReportTurnOnTextTwo}
        </p>
        <div id="turnOnButtonId"
             class="view-monitoring-report-turnon-turnon"
             ontouchstart="goToTurnOnTouchStart()"
             ontouchend="goToTurnOnTouchEnd()">
          {window.languages.ViewMonitoringReportTurnOnTurnOn}
          <div class="view-monitoring-report-turnon-arrow">
          </div>
        </div>
      </div>
    </div>

  </div>

  <script>

    window.saveHistory('view-monitoring-report', opts);

    var scope = this;
    scope.noTokenTitle = window.languages.ViewMonitoringReportNoTokenTitle;
    scope.titleText = '';
    scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
    scope.filter = {
      start: '',
      end: '',
      card: ''
    };
    scope.noToken = true;

    scope.reportsList = [];
    scope.outgoList = [];
    scope.incomeList = [];

    scope.on('mount', function () {
      scope.titleText = generateTitleText();
      scope.noToken = !checkForTokens();
      if (!scope.noToken){
        loadOutgo();
      }
      scope.update();
    });

    //Go to turning on payment monitor
    {
      var goToTurnOnTouchStartX, goToTurnOnTouchStartY,
        goToTurnOnTouchEndX, goToTurnOnTouchEndY;

      goToTurnOnTouchStart = function () {
        event.preventDefault();
        event.stopPropagation();

        turnOnButtonId.style.webkitTransform = 'scale(0.8)';

        goToTurnOnTouchStartX = event.changedTouches[0].pageX;
        goToTurnOnTouchStartY = event.changedTouches[0].pageY;
      };

      goToTurnOnTouchEnd = function () {
        event.preventDefault();
        event.stopPropagation();

        turnOnButtonId.style.webkitTransform = 'scale(1)';

        goToTurnOnTouchEndX = event.changedTouches[0].pageX;
        goToTurnOnTouchEndY = event.changedTouches[0].pageY;

        if (Math.abs(goToTurnOnTouchStartX - goToTurnOnTouchEndX) <= 20
          && Math.abs(goToTurnOnTouchStartY - goToTurnOnTouchEndY) <= 20) {
          riotTags.innerHTML = "<view-payment-monitor>";
          riot.mount('view-payment-monitor');
          scope.unmount();
        }
      }
    }

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

    //Change type html+css
    {
      var typeTouchStartX, typeTouchStartY,
        typeTouchEndX, typeTouchEndY;

      typeTouchStart = function (id) {
        event.preventDefault();
        event.stopPropagation();

        console.log(id);

        document.getElementById(id).style.webkitTransform = 'scale(0.8)';

        typeTouchStartX = event.changedTouches[0].pageX;
        typeTouchStartY = event.changedTouches[0].pageY;
      };

      typeTouchEnd = function (id) {
        event.preventDefault();
        event.stopPropagation();

        incomeTypeId.style.webkitTransform = 'scale(1)';
        outgoTypeId.style.webkitTransform = 'scale(1)';

        typeTouchEndX = event.changedTouches[0].pageX;
        typeTouchEndY = event.changedTouches[0].pageY;

        if (Math.abs(typeTouchStartX - typeTouchEndX) <= 20
          && Math.abs(typeTouchStartY - typeTouchEndY) <= 20) {
          changeType(id);
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

    changeType = function (id) {
      console.log('chosenType', id);
      incomeTypeId.style.borderBottom = "";
      outgoTypeId.style.borderBottom = "";
      incomeTypeId.style.fontFamily = "";
      outgoTypeId.style.fontFamily = "";
      incomeTypeId.style.color = "";
      outgoTypeId.style.color = "";
      document.getElementById(id).style.borderBottom = "" + 3 * widthK + "px solid red";
      document.getElementById(id).style.fontFamily = "SFUIDisplay-Semibold";
      document.getElementById(id).style.color = "red";
    };

    loadOutgo = function (id) {
      if (scope.outgoList.length === 0){

      }
    };

    scope.paymentListUpdate = paymentListUpdate = function (from) {

      if (from == 'fromGraph' || from == 'fromFilter') {
        scope.pageNumberOptional = 1;
        scope.paymentsMap = {};
        scope.paymentDates = [];
        scope.paymentsList = []
      }
      if (scope.monthNotStartedYet) {
        scope.paymentsMap = {};
        scope.paymentDates = [];
        scope.paymentsList = [];
        scope.update();
        return;
      }
      else {
        if (monthChanged) {
          scope.pageNumberOptional = 1;
          scope.paymentsMap = {};
          scope.paymentDates = [];
          scope.paymentsList = [];
          monthChanged = false;
        }
      }

      scope.update();
      var firstDay = scope.tags["component-report-filter"].filterDateFrom,
        lastDay = scope.tags["component-report-filter"].filterDateTo,
        accountId = scope.tags["component-report-filter"].filterByAccount;

      if (!accountId) {

        accountId = null;
      }

      if (!(firstDay && lastDay)) {

        var date = new Date();
        firstDay = new Date(scope.mArray[scope.mNumber].year, scope.mArray[scope.mNumber].month, 1);
        lastDay = new Date(scope.mArray[scope.mNumber].year, scope.mArray[scope.mNumber].month + 1, 0);

        firstDay = convertDate(firstDay);
        lastDay = convertDate(lastDay);
      }

      scope.update();

      window.startSpinner();
      window.clearTimeout(timeOutTimerPayment);

      if (window.fakedSocket)
        if (window.fakedSocket.readyState == 1) {
          scope.pageNumberOptional = 1;
          scope.paymentsMap = {};
          scope.paymentDates = [];
          scope.paymentsList = []
        }

      window.api.call({
        method: 'get.payment.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          page_number: parseInt(scope.pageNumberOptional),
          date_start: firstDay,
          date_end: lastDay,
          account_id: accountId
        },
        scope: this,

        onSuccess: function (result) {

          console.log('Clearing timer onSuccess', timeOutTimerPayment);
          window.clearTimeout(timeOutTimerPayment);

          if (result[0][0].error == 0) {

            for (var i in result[1]) {

              if (result[1][i].created)
                if (result[1][i].created.split(" ")[1])
                  if (result[1][i].created.split(" ")[1].substr(0, 5))
                    result[1][i].paymentTime = result[1][i].created.split(" ")[1].substr(0, 5);

              var date = new Date(result[1][i].created_timestamp * 1000);

              var dateStr = date.getUTCDate() + ' ' + window.languages.ViewReportMonthsArrayTwo[date.getUTCMonth()] + ' ' + date.getUTCFullYear();

              if (date.getUTCDate() == new Date().getUTCDate() && date.getUTCMonth() == new Date().getUTCMonth() && date.getUTCFullYear() == new Date().getUTCFullYear())
                dateStr = 'сегодня';

              if (date.getUTCDate() == new Date().getUTCDate() - 1 && date.getUTCMonth() == new Date().getUTCMonth() && date.getUTCFullYear() == new Date().getUTCFullYear())
                dateStr = 'вчера';

              if (result[1][i].state == -1) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_error.png"
              }

              if (result[1][i].state == 2) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_ok.png"
              }

              if (result[1][i].state == 1) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_processing.png"
              }

              if (!scope.paymentsMap[dateStr]) {
                scope.paymentsMap[dateStr] = [];
                scope.paymentDates.push(dateStr);
                scope.paymentsMap[dateStr].push(result[1][i]);
              }
              else {
                scope.paymentsMap[dateStr].push(result[1][i]);
              }
              scope.paymentsList.push(result[1][i]);
            }
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
              step_amount: scope.stepAmount
            });
            scope.update();

          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimerPayment);
          window.clearTimeout(timeOutTimerPayment);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimerPayment = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method:'get.payment.list',
            });
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 0;
            scope.update();
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
              step_amount: scope.stepAmount
            });
            window.stopSpinner();
          }, 30000);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimerPayment);
          window.clearTimeout(timeOutTimerPayment);
        }
      }, 30000);
    };

  </script>

</view-monitoring-report>
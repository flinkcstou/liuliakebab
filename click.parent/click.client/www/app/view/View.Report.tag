<view-report class="riot-tags-main-container">
  <component-report-filter></component-report-filter>
  <div id="reportPageId" class="view-reports-page">
    <div class="page-title" style="border: none;">
      <p class="name-title">{titleName}</p>
      <div id="backButtonId" ontouchstart="touchStartTitleStart()" ontouchend="touchStartTitleEnd()"
           class="back-button">
      </div>
      <div class="view-reports-filter-container" ontouchend="openFilter()">
        <p class="view-reports-filter-text">{languages.ComponentReportFilterTitle}</p>
        <div type="button" class="view-reports-filter-button"></div>
      </div>
      <div id="graphButtonId" type="button" class="view-reports-graph-button" ontouchend="graphView()"></div>
    </div>


    <div id="monthContainerId" class="view-reports-months-container" ontouchstart="monthContainerTouchStart()"
         ontouchend="monthContainerTouchEnd()"
         ontouchmove="monthContainerTouchMove()"
         hidden="{(tags['component-report-filter'].filterDateFrom && tags['component-report-filter'].filterDateTo)}">
      <div class="view-reports-month-info-container" each="{i in monthsArray}"
           style="left:{50*i.count}%;">
        <p class="view-reports-month-info-name">{i.name}</p>
      </div>
    </div>

    <p class="view-reports-date-filter-text"
       if="{(tags['component-report-filter'].filterDateFrom && tags['component-report-filter'].filterDateTo)}">
      {tags['component-report-filter'].createdDateFilter}
    </p>

    <p class="view-reports-month-not-started-yet-label" if="{monthNotStartedYet}">
      {languages.ViewReportMonthsArray[mNumber].name}
      {languages.ViewReportsFilterMonthNotStartedYet}</p>

    <div ontouchstart="reportsBodyContainerTouchStart()" ontouchend="reportsBodyContainerTouchEnd()"
         class="view-reports-body-container" id="reportBodyContainerId" if="{firstReportView}"
         onscroll="reportsBodyContainerTouchMove()">
      <div class="view-reports-payments-container" each="{i in paymentDates}">
        <div class="view-reports-payment-date-containter" id="{'id'+i}">
          <div class="view-reports-payment-date-field">{i}</div>
        </div>
        <div class="view-reports-payment-block-containter" each="{j in paymentsMap[i]}" id="{j.payment_id}"
             ontouchstart="paymentTouchStart(this.id)" onclick="paymentTouchEnd(this.id)">
          <div class="view-reports-payment-icon"
               style="background-image: url({j.image})"></div>
          <div class="view-reports-payment-info-container">
            <p class="view-reports-payment-info-name">{j.service_name}</p>
            <div class="view-reports-payment-info-balance">{window.amountTransform(j.amount.toString())}
            </div>
            <div class="view-reports-payment-info-currency-field">сум</div>
            <p class="view-reports-payment-info-number">{j.cntrg_info_param2}</p>
          </div>
          <p class="view-reports-payment-info-time">{j.paymentTime}</p>
          <div class="view-reports-payment-info-state-image" style="background-image: url({j.state_image})"></div>
        </div>
      </div>
    </div>

    <div class="view-reports-graph-body-container" if="{!firstReportView}">
      <div class="view-reports-graph-bigamount-container">
        <p class="view-reports-graph-bigamount-text">{paymentsSum} сум</p>
        <p class="view-reports-account-filter-text">
          {(tags["component-report-filter"].createdAccountFilter)?(tags["component-report-filter"].createdAccountFilter):(languages.ViewReportsFilterAllAccountsText)}</p>
      </div>
      <div class="view-reports-graph-image-container" ontouchstart="monthContainerTouchStart()"
           ontouchend="monthContainerTouchEnd()"
           ontouchmove="monthContainerTouchMove()">
        <div class="view-reports-graph-frame">
          <canvas class="view-reports-graph-frame" id="myChart">
          </canvas>

          <div class="view-reports-graph-percent-image-container" each="{i in arrayOfCoordinates}"
               id="chartImageBlockId{i.order}" if="{i.percent > 15}"
               style="top: {i.y * heightK}px; left: {i.x  * heightK}px; transform: translate3d(-55%, -{i.position}% ,0);">
            <p if="{i.percent > 10}" class="view-reports-graph-percent">{i.percent}%</p>
            <div class="view-reports-graph-image"
                 style="background-image: url({i.image})"></div>
          </div>
        </div>
      </div>
      <div class="view-reports-graph-content-container">
        <div class="view-reports-graph-block-containter" each="{j in graphList}">
          <div class="view-reports-graph-block-icon"
               style="background-image: url({j.image})"></div>
          <div class="view-reports-graph-block-name-field">{j.category_name}</div>
          <div class="view-reports-graph-block-amount-field" style="color: {j.color_hex}">{j.amount}</div>
          <div class="view-reports-graph-block-currency-field" style="color: {j.color_hex}">сум</div>
          <div hidden class="view-reports-graph-block-next-icon"></div>
        </div>
      </div>
    </div>
  </div>

  <view-report-service-new hidden="{!showComponent}"></view-report-service-new>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>

    var scope = this;

    this.titleName = 'ОТЧЕТЫ';

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-report') {
      history.arrayOfHistory.push(
        {
          "view": 'view-report',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");

      if (!modeOfApp.offlineMode) {
        writeBalance();
      }

      if (opts.account_id) {

        scope.tags["component-report-filter"].filterByAccount = opts.account_id;
        scope.update();
      }

      if (opts.card_name) {

        scope.tags["component-report-filter"].createdAccountFilter = opts.card_name;
        scope.update();
      }
    });

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    touchStartTitleStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButtonId.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    };

    touchStartTitleEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButtonId.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    scope.leftOfOperations = 320 * widthK;
    scope.firstReportView = true;
    scope.showError = false;

    scope.count = 12;
    //    localStorage.setItem('click_client_countCard', count);

    scope.firstReportView = !opts.show_graph;


    if (!scope.mNumber) {
      scope.mNumber = new Date().getMonth();
      console.log('MONTH NUMBER', scope.mNumber)

      scope.monthNotStartedYet = false;

      this.on('mount', function () {
        changePositionReportInit();
      });
    }

    scope.filterOpen = false;

    openFilter = function () {
      event.stopPropagation();

      scope.filterOpen = true;

//      componentMenu.checkOpen = false;

      this.filterMenuBackPageId.style.webkitTransition = '0.3s';
      this.reportPageId.style.webkitTransition = '0.3s';
      this.reportPageId.style.zIndex = '-1';
      this.reportPageId.style.opacity = '0.1';
      this.filterMenuId.style.webkitTransition = '0.3s';
      this.filterMenuId.style.transform = "translate3d(0, 0, 0)";
      this.filterMenuId.style.webkitTransform = "translate3d(0, 0, 0)";
      this.filterMenuBackPageId.style.opacity = '1';
    };


    graphView = function () {

      scope.firstReportView = !scope.firstReportView;
      scope.update();

      var date = new Date();
      var firstDay = new Date(date.getFullYear(), scope.mNumber, 1);
      var lastDay = new Date(date.getFullYear(), scope.mNumber + 1, 0);
      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);

      if (scope.firstReportView) {
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_off.png)";
        paymentListUpdate('fromGraph');
      }
      else {
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_on.png)";
        graphListUpdate();
      }
    };

    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    console.log("monthsArray", scope.monthsArray);
    scope.update(scope.monthsArray);


    var monthChanged = false;
    var mCarouselTouchStartX, mCarouselTouchStartY, mCarouselTouchEndX, mCarouselTouchEndY
    var left;
    var delta;
    var percentageTouche;

    monthContainerTouchStart = function () {

      if ((scope.tags['component-report-filter'].filterDateFrom && scope.tags['component-report-filter'].filterDateTo)) {

        return;
      }

      console.log("in start touch=", scope.mNumber);
      mCarouselTouchStartX = event.changedTouches[0].pageX;
      mCarouselTouchStartY = event.changedTouches[0].pageY;

      percentageTouche = (mCarouselTouchStartX * 100.0) / window.innerHeight;

      console.log("touche started at %", percentageTouche);

      left = -(50 * scope.mNumber) - percentageTouche;
      delta = left;
    };


    monthContainerTouchEnd = function () {


      event.preventDefault();
      event.stopPropagation();

      if ((scope.tags['component-report-filter'].filterDateFrom && scope.tags['component-report-filter'].filterDateTo)) {
        return;
      }

      mCarouselTouchEndX = event.changedTouches[0].pageX;
      mCarouselTouchEndY = event.changedTouches[0].pageY;
      console.log(Math.abs(mCarouselTouchStartX - mCarouselTouchEndX))
      console.log(Math.abs(mCarouselTouchStartY - mCarouselTouchEndY))
      if (Math.abs(mCarouselTouchStartX - mCarouselTouchEndX) > 20) {
        console.log('Touch end of carousel')
        changePositionReport();
      }
      else {
        monthChanged = false;
      }
    };


    var toucheInPercentage;
    monthContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();

      if ((scope.tags['component-report-filter'].filterDateFrom && scope.tags['component-report-filter'].filterDateTo)) {

        return;
      }

      toucheInPercentage = (event.changedTouches[0].pageX * 100.0) / window.innerHeight;

      this.monthContainerId.style.transition = '0s';
      this.monthContainerId.style.webkitTransition = '0s';
      this.monthContainerId.style.transform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";
      this.monthContainerId.style.webkitTransform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";

    };


    changePositionReport = function () {
      console.log("One")
      console.log("scope.count", scope.count)

      monthChanged = true;
      if (mCarouselTouchEndX < mCarouselTouchStartX && scope.mNumber < scope.count - 1) {
        ++scope.mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (mCarouselTouchEndX > mCarouselTouchStartX && scope.mNumber == 0) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (mCarouselTouchEndX < mCarouselTouchStartX && scope.mNumber == scope.count - 1) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (mCarouselTouchEndX > mCarouselTouchStartX && scope.mNumber > 0) {
        --scope.mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      var dateForComparison = new Date();

      if (dateForComparison.getMonth() < scope.mNumber) {

        scope.monthNotStartedYet = true;
        scope.update();

      } else {

        scope.monthNotStartedYet = false;
        scope.update();
      }

      if (scope.firstReportView) {
        paymentListUpdate();
      } else {
        graphListUpdate();
      }

      localStorage.setItem('mNumber', scope.mNumber);
    };

    changePositionReportInit = function () {
      console.log("TWO")

      if (scope.mNumber < scope.count - 1) {
        ++scope.mNumber;
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (scope.mNumber == 0) {
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (scope.mNumber == scope.count - 1) {
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (scope.mNumber > 0) {
        --scope.mNumber;
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      var dateForComparison = new Date();

      if (dateForComparison.getMonth() < scope.mNumber) {

        scope.monthNotStartedYet = true;
        scope.update();

      } else {

        scope.monthNotStartedYet = false;
        scope.update();
      }

      if (scope.firstReportView) {
        paymentListUpdate();
      } else {
        graphListUpdate();
      }

    };

    function convertDate(date) {
      var yyyy = date.getFullYear().toString();
      var mm = (date.getMonth() + 1).toString();
      var dd = date.getDate().toString();

      var mmChars = mm.split('');
      var ddChars = dd.split('');

      return yyyy + '-' + (mmChars[1] ? mm : "0" + mmChars[0]) + '-' + (ddChars[1] ? dd : "0" + ddChars[0]);
    }

    scope.paymentsMap = {};
    scope.paymentDates = [];
    scope.paymentsList = [];
    scope.pageNumberOptional = 1;

    reportsBodyContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();

//      for(var i in scope.paymentDates){
//
//        console.log('element',document.getElementById('id' + scope.paymentDates[i]).offsetTop)
//        console.log('main div',reportBodyContainerId.scrollTop)
//        if(document.getElementById('id' + scope.paymentDates[i]).offsetTop - reportBodyContainerId.scrollTop == 0 ){
//          document.getElementById('id' + scope.paymentDates[i]).style.position = 'fixed'
//        }
////        else{
////          document.getElementById('id' + scope.paymentDates[i]).style.position = 'relative'
////        }
//      }


      if ((reportBodyContainerId.scrollHeight - reportBodyContainerId.scrollTop) == reportBodyContainerId.offsetHeight) {
        // you're at the bottom of the page
        scope.pageNumberOptional++;
        paymentListUpdate();
      }
//      var position = reportBodyContainerId.scrollTop;
//      console.log('POSITION', position)
//      console.log('HEight', reportBodyContainerId.style.height)
    }

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
          scope.paymentsList = []
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

        firstDay = new Date(date.getFullYear(), scope.mNumber, 1);
        lastDay = new Date(date.getFullYear(), scope.mNumber + 1, 0);

        firstDay = convertDate(firstDay);
        lastDay = convertDate(lastDay);
      }

      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);


      scope.update();

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: false};

        SpinnerPlugin.activityStart("", options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      if (window.fakedSocket)
        if (window.fakedSocket.readyState == 1) {
          scope.pageNumberOptional = 1;
          scope.paymentsMap = {};
          scope.paymentDates = [];
          scope.paymentsList = []
        }

      var gotAnswer = false;

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

          gotAnswer = true;

          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            console.log('PAYMENTLIST=', result[1]);
            for (var i in result[1]) {

//              console.log("C", result[1][i].payment_id);

//              console.log("created=", result[1][i].created.split(" ")[1].substr(0, 5));

//              result[1][i].paymentTime = result[1][i].created.split(" ")[1].substr(0, 5);

              if (result[1][i].created)
                if (result[1][i].created.split(" ")[1])
                  if (result[1][i].created.split(" ")[1].substr(0, 5))
                    result[1][i].paymentTime = result[1][i].created.split(" ")[1].substr(0, 5);

              var date = new Date(result[1][i].created_timestamp * 1000);

              var dateStr = date.getUTCDate() + ' ' + window.languages.ViewReportMonthsArrayTwo[date.getUTCMonth()] + ' ' + date.getUTCFullYear();

              if (date.getUTCDate() == new Date().getUTCDate() && date.getUTCMonth() == new Date().getUTCMonth() && date.getUTCFullYear() == new Date().getUTCFullYear())
                dateStr = 'сегодня'

              if (date.getUTCDate() == new Date().getUTCDate() - 1 && date.getUTCMonth() == new Date().getUTCMonth() && date.getUTCFullYear() == new Date().getUTCFullYear())
                dateStr = 'вчера'

              if (result[1][i].state == -1) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_error.png"
              }

              if (result[1][i].state == 2) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_ok.png"
              }

              if (result[1][i].state == 1) {
                result[1][i].state_image = "resources/icons/ViewReport/report_status_processing.png"
              }


//              console.log("DATE DATE", dateStr)
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

            console.log('scope.paymentDates', scope.paymentDates)
            console.log('scope.paymentsMap', scope.paymentsMap)
            scope.update();
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();

          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });


      if (!gotAnswer && window.isConnected)
        setTimeout(function () {
          if (!gotAnswer) {
            scope.showError = true;
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 0;
            scope.update();
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            window.isConnected = false;
            return
          }
        }, 10000);


    };


    scope.graphListUpdate = graphListUpdate = function () {

//      scope.paymentsMap = {};
//      scope.paymentDates = [];
//      scope.paymentsList = []

      if (scope.monthNotStartedYet) {

        scope.graphList = [];
        scope.paymentsSum = 0;

        createGraph([]);

        scope.update();

        return;
      }

      var firstDay = scope.tags["component-report-filter"].filterDateFrom,
        lastDay = scope.tags["component-report-filter"].filterDateTo,
        accountId = scope.tags["component-report-filter"].filterByAccount;

      if (!accountId) {

        accountId = null;
      }

      if (!(firstDay && lastDay)) {

        var date = new Date();

        firstDay = new Date(date.getFullYear(), scope.mNumber, 1);
        lastDay = new Date(date.getFullYear(), scope.mNumber + 1, 0);

        firstDay = convertDate(firstDay);
        lastDay = convertDate(lastDay);
      }

      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);

      if (device.platform != 'BrowserStand') {
        var options = {dimBackground: true};

        SpinnerPlugin.activityStart(languages.Downloading, options, function () {
          console.log("Started");
        }, function () {
          console.log("closed");
        });
      }

      scope.graphList = [];
      scope.paymentsSum = 0;
      var gotAnswer = false;
      scope.update();
      window.api.call({
        method: 'history.chart.data',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          date_start: firstDay,
          date_end: lastDay,
          account_id: accountId
        },
        scope: this,

        onSuccess: function (result) {

          scope.graphList = [];
          scope.paymentsSum = 0;
          gotAnswer = true;

          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            for (var i in result[1]) {

              scope.paymentsSum += parseInt(result[1][i].amount.replace(/\s/g, ''));

              scope.graphList.push(result[1][i]);
            }

            scope.paymentsSum = scope.paymentsSum.toString();

            if (scope.paymentsSum)
              scope.paymentsSum = window.amountTransform(scope.paymentsSum);

            scope.update();

            console.log('history chart data', scope.graphList);

            createGraph(scope.graphList);
          }
          else {
            scope.graphList = []
            createGraph(scope.graphList);
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

      if (!gotAnswer && window.isConnected)
        setTimeout(function () {
          if (!gotAnswer) {
            scope.showError = true;
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 0;
            scope.update();
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            window.isConnected = false;
            return
          }
        }, 10000);

    };

    createGraph = function (arrayForGraph) {
      scope.countForGraph = 0;

      var data = {
        datasets: [
          {
            borderWidth: 0,
            data: [],
            backgroundColor: []
          }]
      };

      var sumOfAngle = 0;
      scope.arrayOfCoordinates = [];
      var j = 0;
      for (var i in arrayForGraph) {
        data.datasets[0].data.push(arrayForGraph[i].percent);
        data.datasets[0].backgroundColor.push(arrayForGraph[i].color_hex);
        var centerOfBlock = parseInt(sumOfAngle) + parseInt(arrayForGraph[i].percent) / 2;

        console.log('CENTER', centerOfBlock)
        var alpha = 3.6 * parseInt(centerOfBlock);
        console.log('ALPHA', alpha)
        sumOfAngle += parseInt(arrayForGraph[i].percent);

        var x = 240 + (170 * Math.sin(alpha / (180 / Math.PI)));
        var y = 240 - (170 * Math.cos(alpha / (180 / Math.PI)));

        var position = 50;
        if (alpha >= 90 && alpha < 270) {
          position = 50;
        }
        else {
          position = 55;
        }
        var width = 160;
        if ((alpha >= 30 && alpha < 125) || (alpha >= 205 && alpha < 335)) {
          width = 100;
        }

        console.log('DATA', data)
        var percent = arrayForGraph[i].percent;
        var coordinates = {
          x: x,
          y: y,
          percent: parseInt(percent),
          image: arrayForGraph[i].image_inner,
          order: j,
          alpha: alpha,
          position: position,
//          width: width
        }
        scope.arrayOfCoordinates.push(coordinates);
        j++;

        scope.countForGraph = j;
      }
      scope.update()
      console.log("ARRAY OF COORDINATES", scope.arrayOfCoordinates)
      console.log('DATA', data)
      if (document.getElementById('myChart'))
        var ctx = document.getElementById('myChart').getContext('2d');
      else {
        return
      }
      var myChart = new Chart(ctx, {
          type: 'doughnut',
          data: data,
          options: {
            cutoutPercentage: 55,
            animateScale: false,
            tooltips: {
              enabled: false
            },
            events: [],

          }
        })
      ;

      for (var i in scope.arrayOfCoordinates) {
        if (document.getElementById('chartImageBlockId' + scope.arrayOfCoordinates[i].order)) {
          document.getElementById('chartImageBlockId' + scope.arrayOfCoordinates[i].order).style.opacity = 1;
          console.log('scope.arrayOfCoordinates[i]', scope.arrayOfCoordinates)
        }
      }
    }

    //    paymentListUpdate();


    scope.showComponent = false;


    var paymentTouchStartY, paymentTouchStartX, paymentTouchEndY, paymentTouchEndX;
    var paymentTimeStart, paymentTimeEnd;

    paymentOnClick = function () {
      console.log("ONCLICK")
    }

    paymentTouchEnd = function (paymentId) {


      console.log("TOUCHEND", event)

      document.getElementById(paymentId).style.backgroundColor = 'rgba(231,231,231,0.8)'

      setTimeout(function () {
        document.getElementById(paymentId).style.backgroundColor = 'transparent'
      }, 300)


//      paymentTouchEndY = event.changedTouches[0].pageY;
//      paymentTouchEndX = event.changedTouches[0].pageX;
//      paymentTimeEnd = event.timeStamp.toFixed(0);

      paymentTouchEndY = event.pageY;
      paymentTouchEndX = event.pageX;
      paymentTimeEnd = event.timeStamp.toFixed(0);

      console.log('settingsTouchStartY', paymentTouchStartY)
      console.log('settingsTouchEndY', paymentTouchEndY)

      setTimeout(function () {


        if (Math.abs(paymentTouchStartY - paymentTouchEndY) <= 20 && (Math.abs(paymentTouchStartX - paymentTouchEndX) <= 20)) {

          if (modeOfApp.demoVersion) {
            var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
            scope.showError = true;
            scope.errorNote = question;
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
            scope.update();

            return
          }

          for (var i = 0; i < scope.paymentsList.length; i++) {
            if (scope.paymentsList[i].payment_id == paymentId) {
//            console.log("FROM VIEW REPORT service report for=", scope.paymentsList[i]);

              console.log(scope.paymentsList[i])
              console.log("scope.tags['view-report-service-new']", scope.tags)
              console.log("scope.tags['view-report-service-new']", scope)

              var servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
              var servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);

              if (servicesMap[scope.paymentsList[i].service_id])
                scope.paymentsList[i].canAddToFavorite = true;
              else
                scope.paymentsList[i].canAddToFavorite = false;

              scope.showComponent = true;
              scope.tags['view-report-service-new'].opts = scope.paymentsList[i]

              console.log("scope.tags['view-report-service-new']", scope.tags['view-report-service-new']);

              window.checkShowingComponent = scope.tags['view-report-service-new'];


              riot.update()
              break;
            }
          }
        }
        else {
          if (Math.abs(paymentTouchStartY - paymentTouchEndY) <= 100 && (Math.abs(paymentTouchStartX - paymentTouchEndX) > 20) && paymentTimeEnd - paymentTimeStart < 500) {
            mCarouselTouchEndX = paymentTouchEndX
            mCarouselTouchStartX = paymentTouchStartX
            monthChanged = true
            changePositionReport()
          }
        }
      }, 100)

    }

    paymentTouchStart = function (paymentId) {
      paymentTouchStartY = event.changedTouches[0].pageY;
      paymentTouchStartX = event.changedTouches[0].pageX;
      paymentTimeStart = event.timeStamp.toFixed(0);
    }

    paymentTouchMove = function (paymentId) {

      console.log("paymentId=", paymentId);
      console.log("paymentId asdd=", document.getElementById(paymentId).childNodes[0]);

      console.log("paymentId scrollTop =", paymentId.clientTop)
    }

    var reportBodyContainerStartX, reportBodyContainerStartY, reportBodyContainerEndX, reportBodyContainerEndY;
    var reportBodyTimeStart, reportBodyTimeEnd;
    reportsBodyContainerTouchStart = function () {
      reportBodyContainerStartY = event.changedTouches[0].pageY;
      reportBodyContainerStartX = event.changedTouches[0].pageX;
      reportBodyTimeStart = event.timeStamp.toFixed(0);
    }

    reportsBodyContainerTouchEnd = function () {

      if (scope.filterOpen) return;

      reportBodyContainerEndY = event.changedTouches[0].pageY;
      reportBodyContainerEndX = event.changedTouches[0].pageX;
      reportBodyTimeEnd = event.timeStamp.toFixed(0);

      if (Math.abs(reportBodyContainerStartY - reportBodyContainerEndY) <= 100 && (Math.abs(reportBodyContainerStartX - reportBodyContainerEndX) > 20) && reportBodyTimeEnd - reportBodyTimeStart < 500) {
        mCarouselTouchEndX = reportBodyContainerEndX
        mCarouselTouchStartX = reportBodyContainerStartX
        monthChanged = true
        changePositionReport()
      }

    }

  </script>
</view-report>

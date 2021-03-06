<view-report class="riot-tags-main-container">
  <component-report-filter></component-report-filter>
  <div id="reportPageId" class="view-reports-page">
    <div class="page-title" style="border: none;">
      <p class="name-title">{titleName}</p>
      <div id="backButtonId" role="button" aria-label="{window.languages.Back}" ontouchstart="touchStartTitleStart()"
           ontouchend="touchStartTitleEnd()"
           class="back-button">
      </div>
      <div class="view-reports-filter-container" role="button" aria-label="{languages.ComponentReportFilterTitle}"
           ontouchend="openFilter()">
        <p class="view-reports-filter-text">{languages.ComponentReportFilterTitle}</p>
        <div type="button" class="view-reports-filter-button"></div>
      </div>
      <div id="graphButtonId" role="button" aria-label="{window.languages.ViewReportAriaLabelToggleGraphic}"
           type="button" class="view-reports-graph-button" ontouchend="graphView()"></div>
      <div class="title-bottom-border">
      </div>
    </div>


    <div id="monthContainerId" class="view-reports-months-container" ontouchstart="monthContainerTouchStart()"
         ontouchend="monthContainerTouchEnd()"
         ontouchmove="monthContainerTouchMove()"
         hidden="{(tags['component-report-filter'].filterDateFrom && tags['component-report-filter'].filterDateTo)}">
      <div class="view-reports-month-info-container" each="{i in mArray}"
           style="left:{50*i.count}%;">
        <p class="view-reports-month-info-name"
           ontouchend="changePositionReportVoiceOver({i.count})">
          {i.name}</p>
      </div>
    </div>

    <p class="view-reports-date-filter-text"
       if="{(tags['component-report-filter'].filterDateFrom && tags['component-report-filter'].filterDateTo)}">
      {tags['component-report-filter'].createdDateFilter}
    </p>

    <p class="view-reports-month-not-started-yet-label" if="{monthNotStartedYet}">
      {mArray[mNumber].name}
      {languages.ViewReportsFilterMonthNotStartedYet}</p>

    <div ontouchstart="reportsBodyContainerTouchStart()" ontouchend="reportsBodyContainerTouchEnd()"
         class="view-reports-body-container" id="reportBodyContainerId" if="{firstReportView}"
         onscroll="reportsBodyContainerScroll()">
      <div class="view-reports-payments-container" each="{i in paymentDates}">
        <div class="date-container" id="{'id'+i}">
          <div class="view-reports-payment-date-field">{i}</div>
        </div>
        <div class="info-container" each="{j in paymentsMap[i]}" id="{j.payment_id}"
             ontouchstart="paymentTouchStart(this.id)" onclick="paymentTouchEnd(this.id)" role="button"
             aria-label="{j.service_name}">
          <div class="centering-background-image view-info-left-item"
               style="background-image: url({j.image}); background-size: 80%;">
          </div>

          <div class="info-center-container">
            <div class="horizontal-centering">
              <p class="title-text text-margin">
                {j.service_name}
              </p>
              <p class="main-text text-margin">
                - {window.amountTransform(j.amount.toString())}
                <small class="main-text text-margin" style="font-size: {22*widthK}px;">
                  {window.languages.Currency}
                </small>
              </p>
              <p if="{j.comission_amount > 0 && (j.nds == null || j.nds == 0)}"
                 class="text-margin title-text">
                {window.languages.Commission}{j.comission_amount}
                {window.languages.Currency}
              </p>
              <p if="{(j.comission_amount == 0 || j.comission_amount == null) && j.nds > 0}"
                 class="text-margin title-text">
                {window.languages.Nds}{window.calculateNds(window.toInt(j.amount), j.nds)} {window.languages.Currency}
              </p>
              <p if="{j.comission_amount > 0 && j.nds > 0}"
                 class="text-margin title-text">
                {window.languages.CommissionAndNds}
                {j.comission_amount}
                {window.languages.Currency}
              </p>

              <p class="title-text text-margin">{j.cntrg_info_param2}</p>
            </div>
          </div>

          <div class="centering-background-image view-info-right-item vertical-centering-content">
            <div class="horizontal-centering">
              <p if={j.paymentTime} class="title-text text-margin" style="margin-bottom: 20%">{j.paymentTime}</p>
              <div class="centering-background-image state-image-container"
                   style="background-image: url({j.state_image});">
              </div>
            </div>
          </div>

          <div class="border-bottom"></div>
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
               style="top: {i.y * heightK}px; left: {i.x  * heightK}px; -webkit-transform: translate3d(-55%, -{i.position}% ,0);">
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
          <div class="view-reports-graph-block-name-field">
            {j.category_name}
          </div>
          <div class="view-reports-graph-block-amount-field" style=" color: {j.color_hex}">
            {j.amount}
          </div>
          <div class="view-reports-graph-block-currency-field" style="color: {j.color_hex}">сум</div>
          <div hidden class="view-reports-graph-block-next-icon"></div>
        </div>
      </div>
    </div>
  </div>

  <view-report-service-new hidden="{!showComponent}"></view-report-service-new>

  <script>

    var scope = this;

    this.titleName = 'ОТЧЕТЫ';
    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;
    var timeOutTimerData = 0;
    var timeOutTimerPayment = 0;

    window.saveHistory('view-report', opts);

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#ffffff");

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

    var monthChanged = false;
    var mCarouselTouchStartX, mCarouselTouchStartY, mCarouselTouchEndX, mCarouselTouchEndY;
    var paymentTouchStartY, paymentTouchStartX, paymentTouchEndY, paymentTouchEndX;
    var paymentTimeStart, paymentTimeEnd;
    var reportBodyContainerStartX, reportBodyContainerStartY, reportBodyContainerEndX, reportBodyContainerEndY;
    var reportBodyTimeStart, reportBodyTimeEnd;
    var left;
    var delta;
    var percentageTouche;
    var toucheInPercentage;
    scope.paymentsMap = {};
    scope.paymentDates = [];
    scope.paymentsList = [];
    scope.pageNumberOptional = 1;
    scope.showComponent = false;
    window.checkShowingComponent = null;

    scope.leftOfOperations = 320 * widthK;
    scope.firstReportView = true;
    scope.count = 12;
    scope.firstReportView = !opts.show_graph;
    scope.filterOpen = false;
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    scope.mArray = [];
    var j = 12, t;
    var curMonth = new Date().getMonth();
    var i = curMonth;
    var y = new Date().getFullYear();
    var yearChanged = false;

    var clickOnScrollHandler = ClickOnScrollHandler();
    clickOnScrollHandler.addClickEvent('payment');

    if (!scope.mNumber) {
      scope.mNumber = 12;

      scope.monthNotStartedYet = false;

      this.on('mount', function () {
        changePositionReportInit();
      });
    }


    while (j > 0) {

      if (i < 0) {

        t = 12 + i;

        if (!yearChanged) {
          yearChanged = true;
          y--;
        }

      } else {
        t = i;
      }
      scope.mArray[j - 1] = {"count": j--, "name": scope.monthsArray[t].name, "month": t, "year": y};
      i--;
    }

    scope.update(scope.mArray);


    touchStartTitleStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButtonId.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    };

    touchStartTitleEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButtonId.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    openFilter = function () {
      event.stopPropagation();

      scope.filterOpen = true;

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
      firstDay = new Date(scope.mArray[scope.mNumber].year, scope.mArray[scope.mNumber].month, 1);
      lastDay = new Date(scope.mArray[scope.mNumber].year, scope.mArray[scope.mNumber].month + 1, 0);

      if (scope.firstReportView) {
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_off.png)";
        paymentListUpdate('fromGraph');
      }
      else {
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_on.png)";
        graphListUpdate();
      }
    };

    monthContainerTouchStart = function () {

      if ((scope.tags['component-report-filter'].filterDateFrom && scope.tags['component-report-filter'].filterDateTo)) {
        return;
      }

      mCarouselTouchStartX = event.changedTouches[0].pageX;
      mCarouselTouchStartY = event.changedTouches[0].pageY;

      percentageTouche = (mCarouselTouchStartX * 100.0) / window.innerHeight;

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

      if (Math.abs(mCarouselTouchStartX - mCarouselTouchEndX) > 20) {
        changePositionReport();
      }
      else {
        monthChanged = false;
      }
      scope.monthContainerMoved = false;
    };

    monthContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();

      if ((scope.tags['component-report-filter'].filterDateFrom && scope.tags['component-report-filter'].filterDateTo)) {

        return;
      }

      scope.monthContainerMoved = true;

      toucheInPercentage = (event.changedTouches[0].pageX * 100.0) / window.innerHeight;

      this.monthContainerId.style.transition = '0s';
      this.monthContainerId.style.webkitTransition = '0s';
      this.monthContainerId.style.transform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";
      this.monthContainerId.style.webkitTransform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";

    };

    changePositionReportVoiceOver = function (count) {

      if (scope.monthContainerMoved) return;
      if (scope.mNumber == count - 1) return;

      monthChanged = true;

      if (scope.mNumber < count - 1) {
        ++scope.mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (scope.mNumber > count - 1) {
        --scope.mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      var dateForComparison = new Date();

      scope.monthNotStartedYet = false;
      scope.update();

      if (scope.firstReportView) {
        paymentListUpdate();
      } else {
        graphListUpdate();
      }

      localStorage.setItem('mNumber', scope.mNumber);
    };

    changePositionReport = function () {


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

      scope.monthNotStartedYet = false;
      scope.update();


      if (scope.firstReportView) {
        paymentListUpdate();
      } else {
        graphListUpdate();
      }

      localStorage.setItem('mNumber', scope.mNumber);
    };

    changePositionReportInit = function () {

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

      scope.monthNotStartedYet = false;
      scope.update();


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

    reportsBodyContainerScroll = function () {
      clickOnScrollHandler.resetScrollTime();

      if ((reportBodyContainerId.scrollHeight - reportBodyContainerId.scrollTop) == reportBodyContainerId.offsetHeight && reportBodyContainerId.scrollTop != 0) {

        console.log("Payment list length = ", scope.paymentsList.length);
        if (scope.paymentsList.length % 15 == 0) {
          console.log("paging");
          scope.pageNumberOptional++;
          paymentListUpdate();
        }

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
              method: 'get.payment.list',
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

    scope.graphListUpdate = graphListUpdate = function () {

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
        firstDay = new Date(scope.mArray[scope.mNumber].year, scope.mArray[scope.mNumber].month, 1);
        lastDay = new Date(scope.mArray[scope.mNumber].year, scope.mArray[scope.mNumber].month + 1, 0);

        firstDay = convertDate(firstDay);
        lastDay = convertDate(lastDay);
      }

      window.startSpinner();
      window.clearTimeout(timeOutTimerData);

      scope.graphList = [];
      scope.paymentsSum = 0;
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
          console.log('Clearing timer onSuccess', timeOutTimerData);
          window.clearTimeout(timeOutTimerData);
          if (result[0][0].error == 0) {
            for (var i in result[1]) {
              scope.paymentsSum += parseInt(result[1][i].amount.replace(/\s/g, ''));
              scope.graphList.push(result[1][i]);
            }
            scope.paymentsSum = scope.paymentsSum.toString();
            if (scope.paymentsSum)
              scope.paymentsSum = window.amountTransform(scope.paymentsSum);
            scope.update();
            createGraph(scope.graphList);
          }
          else {
            scope.graphList = [];
            createGraph(scope.graphList);
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
          console.log('Clearing timer onFail', timeOutTimerData);
          window.clearTimeout(timeOutTimerData);
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimerData = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'history.char.data',
            });
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 0;
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
              step_amount: scope.stepAmount
            });
            window.stopSpinner();
            scope.update();
          }, 30000);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimerData);
          window.clearTimeout(timeOutTimerData);
        }
      }, 30000);

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
        var alpha = 3.6 * parseInt(centerOfBlock);
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

        var percent = arrayForGraph[i].percent;
        var coordinates = {
          x: x,
          y: y,
          percent: parseInt(percent),
          image: arrayForGraph[i].image_inner,
          order: j,
          alpha: alpha,
          position: position
//          width: width
        }
        scope.arrayOfCoordinates.push(coordinates);
        j++;

        scope.countForGraph = j;
      }
      scope.update();
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
    };

    paymentTouchEnd = function (paymentId) {
      if(!clickOnScrollHandler.getClickEvent('payment')) return;

      document.getElementById(paymentId).style.backgroundColor = 'rgba(231,231,231,0.8)';

      setTimeout(function () {
        document.getElementById(paymentId).style.backgroundColor = 'transparent'
      }, 300);


      paymentTouchEndY = event.pageY;
      paymentTouchEndX = event.pageX;
      paymentTimeEnd = event.timeStamp.toFixed(0);

      setTimeout(function () {


        if (Math.abs(paymentTouchStartY - paymentTouchEndY) <= 20 && (Math.abs(paymentTouchStartX - paymentTouchEndX) <= 20)) {

          if (modeOfApp.demoVersion) {
            var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
            scope.errorNote = question;
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: scope.clickPinError,
              errornote: scope.errorNote,
              step_amount: scope.stepAmount
            });
            scope.update();

            return
          }

          for (var i = 0; i < scope.paymentsList.length; i++) {
            if (scope.paymentsList[i].payment_id == paymentId) {


              var servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
              var servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
              var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));

              if (favoritePaymentsList) {
                for (var j in favoritePaymentsList) {
                  console.log("fav payment j ", favoritePaymentsList[j].params)
                  if (favoritePaymentsList[j].params.paymentId && favoritePaymentsList[j].params.paymentId == paymentId) {
                    console.log("found , saved to opts ", favoritePaymentsList[j].params.paymentId)
                    scope.tags['view-report-service-new'].isInFavorites = true;
                    scope.favoriteId = favoritePaymentsList[j].id;
                    break;
                  }
                  scope.tags['view-report-service-new'].isInFavorites = false;
                }

              } else {
                scope.tags['view-report-service-new'].isInFavorites = false;
              }

              if (servicesMap) {
                if (servicesMap[scope.paymentsList[i].service_id])
                  scope.paymentsList[i].canAddToFavorite = true;
                else
                  scope.paymentsList[i].canAddToFavorite = false;
              } else {
                scope.paymentsList[i].canAddToFavorite = false;
              }

              scope.paymentsList[i].favoriteId = scope.favoriteId;
              scope.showComponent = true;
              console.log("report service component is being shown up");
              scope.tags['view-report-service-new'].opts = scope.paymentsList[i];
              window.checkShowingComponent = scope.tags['view-report-service-new'];

              scope.update();
              break;
            }
          }
        }
        else {
          if (Math.abs(paymentTouchStartY - paymentTouchEndY) <= 100 && (Math.abs(paymentTouchStartX - paymentTouchEndX) > 20) && paymentTimeEnd - paymentTimeStart < 500) {
            mCarouselTouchEndX = paymentTouchEndX;
            mCarouselTouchStartX = paymentTouchStartX;
            monthChanged = true;
            changePositionReport()
          }
        }
      }, 100)
    };

    paymentTouchStart = function (paymentId) {
      if (clickOnScrollHandler.stoppedScroll()) {
        clickOnScrollHandler.setClickEvent('payment', false);
        return;
      }
      clickOnScrollHandler.setClickEvent('payment', true);
      paymentTouchStartY = event.changedTouches[0].pageY;
      paymentTouchStartX = event.changedTouches[0].pageX;
      paymentTimeStart = event.timeStamp.toFixed(0);
    };

    reportsBodyContainerTouchStart = function () {
      reportBodyContainerStartY = event.changedTouches[0].pageY;
      reportBodyContainerStartX = event.changedTouches[0].pageX;
      reportBodyTimeStart = event.timeStamp.toFixed(0);
    };

    reportsBodyContainerTouchEnd = function () {

      if (scope.filterOpen) return;

      reportBodyContainerEndY = event.changedTouches[0].pageY;
      reportBodyContainerEndX = event.changedTouches[0].pageX;
      reportBodyTimeEnd = event.timeStamp.toFixed(0);
      console.log("touch end out", reportBodyContainerEndY, reportBodyContainerStartY, 250 * widthK, reportBodyContainerId.scrollTop);

      if (Math.abs(reportBodyContainerStartY - reportBodyContainerEndY) <= 100 && (Math.abs(reportBodyContainerStartX - reportBodyContainerEndX) > 20) && (reportBodyTimeEnd - reportBodyTimeStart) < 500) {
        mCarouselTouchEndX = reportBodyContainerEndX;
        mCarouselTouchStartX = reportBodyContainerStartX;
        console.log("touch end inner", reportBodyContainerEndY);
        monthChanged = true
        changePositionReport()
      } else if (reportBodyContainerEndY > reportBodyContainerStartY && (reportBodyContainerEndY - reportBodyContainerStartY) >= (250 * widthK) && reportBodyContainerId.scrollTop == 0) {
        console.log("update page")
        console.log("scrollTop=", reportBodyContainerId.scrollTop)
        scope.pageNumberOptional = 1;
        scope.paymentsMap = {};
        scope.paymentDates = [];
        scope.paymentsList = [];
        monthChanged = false;
        paymentListUpdate();

      }

    }

  </script>
</view-report>
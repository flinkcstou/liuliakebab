<view-autopay-schedule-method>
  <div>
    <div class="pay-page-title" style="border-style: none;">
      <p class="autopay-method-page-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodSchedulerText}</p>
      <div ontouchend="goToBack()"
           class="autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">
      <div class="autopay-method-choose-text autopay-schedule-howoften-text">
        {window.languages.ViewAutoPayMethodScheduleHowOftenText}
      </div>

      <div class="autopay-schedule-block-containter" ontouchend="everyMonthLastDay()">
        <div class="autopay-schedule-block-text">{window.languages.ViewAutoPayMethodScheduleEveryMonth}</div>
        <div class="autopay-schedule-block-detail-text">
          {window.languages.ViewAutoPayMethodScheduleLastDay}
        </div>
        <div class="autopay-schedule-block-next-icon"></div>
      </div>
      <div class="autopay-schedule-block-containter" ontouchend="everyMonthChosenDay()">
        <div class="autopay-schedule-block-text">{window.languages.ViewAutoPayMethodScheduleEveryMonth}</div>
        <div class="autopay-schedule-block-detail-text">
          {window.languages.ViewAutoPayMethodScheduleChosenDay}
        </div>
        <div class="autopay-schedule-block-next-icon"></div>
      </div>
      <div class="autopay-schedule-block-containter" ontouchend="everyWeek()">
        <div class="autopay-schedule-block-text">{window.languages.ViewAutoPayMethodScheduleEveryWeek}</div>
        <div class="autopay-schedule-block-next-icon"></div>
      </div>

    </div>
  </div>

  <div id="dateChooseBlockId" class="schedule-date-block">
    <div class="schedule-date-block-title-container">
      <hr class="schedule-date-block-title-line"/>
      <div class="schedule-date-block-title">{dateBlockTitle}</div>
    </div>

    <div
      class="{schedule-date-block-days-outer-container: !timeMode && !weekMode && dayMode,schedule-date-block-week-outer-container: !timeMode && weekMode && !dayMode, schedule-date-block-time-outer-container: timeMode && !weekMode && !dayMode}">
      <div id="dateContainerId"
           class="{schedule-date-block-days-container: !timeMode && (weekMode || dayMode), schedule-date-block-hours-container:timeMode && !weekMode && !dayMode}"
           ontouchstart="dateContainerTouchStart()"
           ontouchend="dateContainerTouchEnd()"
           ontouchmove="dateContainerTouchMove()">
        <div class="schedule-date-block-day" each="{i in dateBlockArray}"
             style="top:{topOfOperations*i.k}px;">
          <p id="day{i.k-1}"
             class="{schedule-date-block-day-text: !timeMode && !weekMode && dayMode, schedule-date-block-week-text: !timeMode && weekMode && !dayMode, schedule-date-block-time-text: timeMode && !weekMode && !dayMode}">
            {i.v}</p>
        </div>
      </div>
      <div class="schedule-date-block-hmcolon-container" if="{timeMode && !weekMode && !dayMode}">
        <p class="schedule-date-block-time-colon-text">{window.languages.ViewAutoPayMethodScheduleHMColonText}</p>
      </div>
      <div id="minutesContainerId" if="{timeMode && !weekMode && !dayMode}"
           class="schedule-date-block-minutes-container"
           ontouchstart="minContainerTouchStart()"
           ontouchend="minContainerTouchEnd()"
           ontouchmove="minContainerTouchMove()">
        <div class="schedule-date-block-day" each="{i in minutesArray}"
             style="top:{topOfOperations*i.k}px;">
          <p id="min{i.k-1}"
             class="{schedule-date-block-day-text: !timeMode && !weekMode && dayMode, schedule-date-block-week-text: !timeMode && weekMode && !dayMode, schedule-date-block-time-text: timeMode && !weekMode && !dayMode}">
            {i.v}</p>
        </div>
      </div>
    </div>

    <div class="schedule-date-block-hm-bottom" if="{timeMode && !weekMode && !dayMode}">
      <hr class="schedule-date-block-hm-bottom-line"/>
      <div class="schedule-date-block-hm-bottom-hour-text">{window.languages.ViewAutoPayMethodScheduleHourText}</div>
      <div class="schedule-date-block-hm-bottom-min-text">{window.languages.ViewAutoPayMethodScheduleMinutesText}
      </div>
    </div>

    <button class="schedule-date-block-button-choose" ontouchend="chooseDate()">
      {window.languages.ViewAutoPayMethodScheduleChoseButtonLabel}
    </button>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = window.languages.ViewAutoPayTitleName;
    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    //    console.log("ID of service=", opts.id);
    this.serviceName = scope.servicesMap[scope.autoPayData.service_id][0].name;
    this.serviceIcon = scope.servicesMap[scope.autoPayData.service_id][0].image;

    scope.daysArray = window.languages.ViewAutoPayMethodScheduleDaysArray;
    scope.weekDaysArray = window.languages.ViewAutoPayMethodScheduleWeekDaysArray;
    scope.hoursArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
    scope.minutesArray = window.languages.ViewAutoPayMethodScheduleMinutesArray;

    scope.weekMode = false;
    scope.timeMode = false;
    scope.dayMode = false;

    scope.shift = 200;

    //    scope.topOfWeekOperations = 100 * widthK;
    var dateNumber, count, minuteNumber = 0, minutesCount = 60;
    localStorage.setItem('click_client_countCard', count);


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-schedule-method') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-schedule-method',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    everyMonthLastDay = function () {
      scope.autoPayData.type = 4;
      dateNumber = 0;
      minuteNumber = 0;
      scope.topOfOperations = 150 * widthK;
      scope.weekMode = false;
      scope.timeMode = true;
      scope.dayMode = false;
      scope.shift = 150;
      count = 24;
      scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseTime;
      scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
      scope.dateBlockArrayTwo = window.languages.ViewAutoPayMethodScheduleMinutesArray;
      dateChooseBlockId.style.display = 'block';
//      console.log("LAST DAY, dateBlockArray", scope.dateBlockArray);
      riot.update(scope.dateBlockTitle);
      riot.update(scope.dateBlockArray);
      changePositionInit();
      changeMinutesPositionInit();
    }

    everyMonthChosenDay = function () {
      scope.autoPayData.type = 3;
      dateNumber = 0;
      scope.topOfOperations = 200 * widthK;
      scope.weekMode = false;
      scope.timeMode = false;
      scope.dayMode = true;
      scope.shift = 200;
      count = 31;
      scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseDate;
      scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleDaysArray;
      dateChooseBlockId.style.display = 'block';
//      console.log("CHOSEN DAY, dateBlockArray", scope.dateBlockArray);
      riot.update(scope.dateBlockTitle);
      riot.update(scope.dateBlockArray);
      changePositionInit();
    }

    everyWeek = function () {
      scope.autoPayData.type = 2;
      dateNumber = 0;
      scope.topOfOperations = 100 * widthK;
      scope.shift = 100;
      scope.weekMode = true;
      scope.timeMode = false;
      scope.dayMode = false;
      count = 7;
      scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseWeekDay;
      scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleWeekDaysArray;
      dateChooseBlockId.style.display = 'block';
//      console.log("EVERY WEEK, dateBlockArray", scope.dateBlockArray);
      riot.update(scope.dateBlockTitle);
      riot.update(scope.dateBlockArray);
      riot.update(scope.weekMode);
      changePositionInit();
    }

    chooseDate = function () {
//      dateChooseBlockId.style.display = 'none';
      if (scope.timeMode) {
        console.log("HOUR=", dateNumber);
        console.log("MIN=", minuteNumber);
        scope.autoPayData.paytime = window.languages.ViewAutoPayMethodScheduleHoursArray[dateNumber + 1].v + ':' + window.languages.ViewAutoPayMethodScheduleMinutesArray[minuteNumber + 1].v;
        console.log("autoPayData=", scope.autoPayData);

        if (scope.autoPayData.type == 2) {
          scope.autoPayData.condition_text = window.languages.ViewAutoPayMethodScheduleWeekDaysArray[scope.autoPayData.week_day].v + ", " +
            scope.autoPayData.paytime;
        } else if (scope.autoPayData.type == 3) {
          scope.autoPayData.condition_text = scope.autoPayData.month_day + ", " +
            scope.autoPayData.paytime;
        } else if (scope.autoPayData.type == 4) {
          scope.autoPayData.condition_text = window.languages.ViewAutoPayEveryMonthLastDayTextTwo + ", " +
            scope.autoPayData.paytime;
        }

        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
        event.stopPropagation();
        riotTags.innerHTML = "<view-service-page>";
        riot.mount("view-service-page", opts);

        scope.unmount()
      } else {
        if (scope.dayMode) {
          console.log("dayMode, Number=", dateNumber);
          scope.autoPayData.month_day = dateNumber + 1;
        }
        else if (scope.weekMode) {
          console.log("weekMode, Number=", dateNumber);
          scope.autoPayData.week_day = dateNumber + 1;
        }
        dateNumber = 0;
        minuteNumber = 0;
        scope.topOfOperations = 150 * widthK;
        scope.weekMode = false;
        scope.timeMode = true;
        scope.dayMode = false;
        scope.shift = 150;
        count = 24;
        scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseTime;
        scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
        scope.dateBlockArrayTwo = window.languages.ViewAutoPayMethodScheduleMinutesArray;
        dateChooseBlockId.style.display = 'block';
//        console.log("LAST DAY, dateBlockArray", scope.dateBlockArray);
        riot.update(scope.dateBlockTitle);
        riot.update(scope.dateBlockArray);
        changePositionInit();
        changeMinutesPositionInit();
      }

    }


    if (!dateNumber) {
      dateNumber = 0;

      this.on('mount', function () {
        changePositionInit();
      });

    }


    dateContainerTouchStart = function () {
      console.log("in start touch=", dateNumber);
      carouselTouchStartY = event.changedTouches[0].pageY;
      console.log("startY=", carouselTouchStartY);
      touchStartTime = new Date().getTime();
      left = -((scope.shift * dateNumber) * widthK) - carouselTouchStartY;
      delta = left;
    }

    dateContainerTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndY = event.changedTouches[0].pageY;
//      touchEndTime = new Date().getTime();
//      var speed = Math.abs((carouselTouchEndY - carouselTouchStartY) / (touchEndTime - touchStartTime));
//      console.log("SPEED=", speed);

//      console.log("endY=", carouselTouchEndY);
//      console.log("N to Move=", Math.abs(carouselTouchStartY - carouselTouchEndY) / scope.shift);
//      console.log("N fixed=", (Math.abs(carouselTouchStartY - carouselTouchEndY) / scope.shift).toFixed(0));
      nShift = Math.round(Math.abs(carouselTouchEndY - carouselTouchStartY) / scope.shift);
//      console.log("potential move=", Math.ceil(speed) * nShift);

      if (Math.abs(carouselTouchStartY - carouselTouchEndY) > 20) {
        changePosition(nShift);
      }
    }


    dateContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.dateContainerId.style.transition = '0s';
      this.dateContainerId.style.webkitTransition = '0s';
      this.dateContainerId.style.transform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
      this.dateContainerId.style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
//      console.log("x=", event.changedTouches[0].pageY);
//      console.log("xx=", event.changedTouches[0].pageY + delta);

    }

    function changePosition(nShift) {
//      console.log("NSHIFT", nShift);

      if (carouselTouchEndY < carouselTouchStartY) {
//        console.log("111", dateNumber + Number(nShift));
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        if ((dateNumber + Number(nShift)) > (count - 1)) {
          dateNumber = dateNumber + Number(nShift) - count;
          this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        } else {
          dateNumber = dateNumber + Number(nShift);
//          this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
//          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        }
//        dateNumber = (dateNumber + Number(nShift)) > (count - 1) ? (dateNumber + Number(nShift) - count) : (dateNumber + Number(nShift));

        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
//        console.log("2=", dateNumber);


      } else if (carouselTouchEndY > carouselTouchStartY) {
//        console.log("222", dateNumber - Number(nShift));
//        console.log("222 =", (count + (dateNumber - Number(nShift))));
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        if ((dateNumber - Number(nShift)) < 0) {
          dateNumber = count + (dateNumber - Number(nShift));
          this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        } else {
          dateNumber = dateNumber - Number(nShift);
//          this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
//          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        }
//        dateNumber = (dateNumber - Number(nShift)) < 0 ? (count + (dateNumber - Number(nShift))) : (dateNumber - Number(nShift));

        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
        //console.log("5=", dateNumber);
      }

      localStorage.setItem('dateNumber', dateNumber);
    }

    function changePositionInit() {

      if (dateNumber < count - 1) {
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        ++dateNumber;
        this.dateContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
      }

      if (dateNumber == 0) {
        this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (dateNumber == count - 1) {
        this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (dateNumber > 0) {
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        --dateNumber;
        this.dateContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
      }

    }

    //    for minutes

    minContainerTouchStart = function () {
      console.log("in start touch=", minuteNumber);
      minutesTouchStartY = event.changedTouches[0].pageY;
//      mtouchStartTime = new Date().getTime();
      mleft = -((scope.shift * minuteNumber) * widthK) - minutesTouchStartY;
      mdelta = mleft;
    }

    minContainerTouchEnd = function () {
      event.preventDefault();

      event.stopPropagation();
      minutesTouchEndY = event.changedTouches[0].pageY;
//      mtouchEndTime = new Date().getTime();
//      var mspeed = Math.abs((minutesTouchEndY - minutesTouchStartY) / (mtouchEndTime - mtouchStartTime));
//      console.log("SPEED=", mspeed);
//      console.log("N fixed=", (Math.abs(minutesTouchStartY - minutesTouchEndY) / scope.shift).toFixed(0));
      mShift = Math.round(Math.abs(minutesTouchStartY - minutesTouchEndY) / scope.shift);
//      console.log("potential move=", Math.ceil(mspeed) * mShift);

      if (Math.abs(minutesTouchStartY - minutesTouchEndY) > 20) {
        changeMinutesPosition(mShift);
      }
    }


    minContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.minutesContainerId.style.transition = '0s';
      this.minutesContainerId.style.webkitTransition = '0s';
      this.minutesContainerId.style.transform = "translate3d(0," + (event.changedTouches[0].pageY + mdelta ) + 'px' + ", 0)";
      this.minutesContainerId.style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + mdelta ) + 'px' + ", 0)";
    }

    function changeMinutesPosition(mShift) {

      if (minutesTouchEndY < minutesTouchStartY) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        if ((minuteNumber + Number(mShift)) > (minutesCount - 1)) {
          minuteNumber = minuteNumber + Number(mShift) - minutesCount;
          this.minutesContainerId.style.transition = '0.0001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.webkitTransition = '0.0001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        } else {
          minuteNumber = minuteNumber + Number(mShift);
//          this.minutesContainerId.style.transition = '0.1s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.minutesContainerId.style.webkitTransition = '0.1s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        }
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';

      } else if (minutesTouchEndY > minutesTouchStartY) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        if ((minuteNumber - Number(mShift)) < 0) {
          minuteNumber = minutesCount + (minuteNumber - Number(mShift));
          this.minutesContainerId.style.transition = '0.0001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.webkitTransition = '0.0001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        } else {
          minuteNumber = minuteNumber - Number(mShift);
//          this.minutesContainerId.style.transition = '0.1s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.minutesContainerId.style.webkitTransition = '0.1s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        }
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
      }


//      if (minutesTouchEndY < minutesTouchStartY && minuteNumber < minutesCount - 1) {
//        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
//        minuteNumber = minuteNumber + Number(mShift);
//        this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
//
//      } else if (minutesTouchEndY > minutesTouchStartY && minuteNumber < 0) {
//        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
//        minuteNumber = minutesCount - 1;
//        this.minutesContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
//
//      } else if (minutesTouchEndY < minutesTouchStartY && minuteNumber > minutesCount - 1) {
//        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
//        minuteNumber = 0;
//        this.minutesContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
//
//      } else if (minutesTouchEndY > minutesTouchStartY && minuteNumber > 0) {
//        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
//        minuteNumber = minuteNumber - Number(mShift);
//        this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
//        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
//        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
//      }

      localStorage.setItem('minuteNumber', minuteNumber);
    }

    function changeMinutesPositionInit() {

      if (minuteNumber < minutesCount - 1) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        ++minuteNumber;
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
      }

      if (minuteNumber == 0) {
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (minuteNumber == minutesCount - 1) {
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (minuteNumber > 0) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        --minuteNumber;
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
      }

    }


  </script>
</view-autopay-schedule-method>

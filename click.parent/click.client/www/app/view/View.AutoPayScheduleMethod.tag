<view-autopay-schedule-method>
  <div>
    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title autopay-method-page-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodSchedulerText}</p>
      <div ontouchend="goToBack()"
           class="servicepage-button-back autopay-method-back-button">
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

    <button class="schedule-date-block-button-choose" ontouchend="chooseDate()">
      {window.languages.ViewAutoPayMethodScheduleChoseButtonLabel}
    </button>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = "АВТОПЛАТЕЖ";
    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    console.log("ID of service=", opts);
    this.serviceName = scope.servicesMap[opts[0]][0].name;
    this.serviceIcon = scope.servicesMap[opts[0]][0].image;

    scope.daysArray = window.languages.ViewAutoPayMethodScheduleDaysArray;
    scope.weekDaysArray = window.languages.ViewAutoPayMethodScheduleWeekDaysArray;
    scope.hoursArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
    scope.minutesArray = window.languages.ViewAutoPayMethodScheduleMinutesArray;

    scope.weekMode = false;
    scope.timeMode = false;
    scope.dayMode = false;

    scope.shift = 200;

    //    scope.topOfWeekOperations = 100 * widthK;
    var dateNumber, count, minuteNumber = 0;
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
    };

    everyMonthLastDay = function () {
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
      console.log("LAST DAY, dateBlockArray", scope.dateBlockArray);
      riot.update(scope.dateBlockTitle);
      riot.update(scope.dateBlockArray);
      changePositionTwo();
    }

    everyMonthChosenDay = function () {
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
      console.log("CHOSEN DAY, dateBlockArray", scope.dateBlockArray);
      riot.update(scope.dateBlockTitle);
      riot.update(scope.dateBlockArray);
      changePositionTwo();
    }

    everyWeek = function () {
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
      console.log("EVERY WEEK, dateBlockArray", scope.dateBlockArray);
      riot.update(scope.dateBlockTitle);
      riot.update(scope.dateBlockArray);
      riot.update(scope.weekMode);
      changePositionTwo();
    }

    chooseDate = function () {
      dateChooseBlockId.style.display = 'none';
    }


    if (!dateNumber) {
      dateNumber = 0;

      this.on('mount', function () {
        changePositionTwo();
      });

    }


    dateContainerTouchStart = function () {
      console.log("in start touch=", dateNumber);
      carouselTouchStartY = event.changedTouches[0].pageY;
      left = -((scope.shift * dateNumber) * widthK) - carouselTouchStartY;
      delta = left;
    }

    dateContainerTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndY = event.changedTouches[0].pageY;
      if (Math.abs(carouselTouchStartY - carouselTouchEndY) > 20) {
        changePosition();
      }
    }


    dateContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.dateContainerId.style.transition = '0s';
      this.dateContainerId.style.webkitTransition = '0s';
      this.dateContainerId.style.transform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
      this.dateContainerId.style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
    }

    function changePosition() {

      if (carouselTouchEndY < carouselTouchStartY && dateNumber < count - 1) {
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        ++dateNumber;
        this.dateContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
      }

      if (carouselTouchEndY > carouselTouchStartY && dateNumber == 0) {
        this.dateContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (carouselTouchEndY < carouselTouchStartY && dateNumber == count - 1) {
        this.dateContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (carouselTouchEndY > carouselTouchStartY && dateNumber > 0) {
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        --dateNumber;
        this.dateContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
      }

      localStorage.setItem('dateNumber', dateNumber);
    }

    function changePositionTwo() {

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
        this.dateContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (dateNumber == count - 1) {
        this.dateContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.dateContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
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
      carouselTouchStartY = event.changedTouches[0].pageY;
      left = -((scope.shift * minuteNumber) * widthK) - carouselTouchStartY;
      delta = left;
    }

    minContainerTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndY = event.changedTouches[0].pageY;
      if (Math.abs(carouselTouchStartY - carouselTouchEndY) > 20) {
        changePosition();
      }
    }


    minContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.minutesContainerId.style.transition = '0s';
      this.minutesContainerId.style.webkitTransition = '0s';
      this.minutesContainerId.style.transform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
      this.minutesContainerId.style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
    }

    function changePosition() {

      if (carouselTouchEndY < carouselTouchStartY && minuteNumber < count - 1) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        ++dateNumber;
        this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("min" + dateNumber).style.color = '#01B8FE';
      }

      if (carouselTouchEndY > carouselTouchStartY && dateNumber == 0) {
        this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (carouselTouchEndY < carouselTouchStartY && dateNumber == count - 1) {
        this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (carouselTouchEndY > carouselTouchStartY && dateNumber > 0) {
        document.getElementById("min" + dateNumber).style.color = '#c1c1c1';
        --dateNumber;
        this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("min" + dateNumber).style.color = '#01B8FE';
      }

      localStorage.setItem('dateNumber', dateNumber);
    }

    function changePositionTwo() {

      if (dateNumber < count - 1) {
        document.getElementById("min" + dateNumber).style.color = '#c1c1c1';
        ++dateNumber;
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("min" + dateNumber).style.color = '#01B8FE';
      }

      if (dateNumber == 0) {
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (dateNumber == count - 1) {
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
      }

      if (dateNumber > 0) {
        document.getElementById("min" + dateNumber).style.color = '#c1c1c1';
        --dateNumber;
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        document.getElementById("min" + dateNumber).style.color = '#01B8FE';
      }

    }


  </script>
</view-autopay-schedule-method>

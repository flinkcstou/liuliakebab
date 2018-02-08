<view-autopay-schedule-method-new>
  <div class="riot-tags-main-container">
    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{window.languages.ViewAutoPayMethodSchedulerText}</p>
      <div ontouchend="goToBack()" ontouchstart="onTouchStartOfBack()"
           class="servicepage-button-back">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
      <div class="title-bottom-border">
      </div>
    </div>


    <div class="autopay-method-body-container">
      <div class="autopay-method-choose-text autopay-schedule-howoften-text">
        {window.languages.ViewAutoPayMethodScheduleHowOftenText}
      </div>

      <div id="everyMonthButtonId" class="autopay-schedule-block-containter" ontouchstart="everyMonthLastDayStart()"
           ontouchend="everyMonthLastDayEnd()">
        <div class="autopay-schedule-block-text">{window.languages.ViewAutoPayMethodScheduleEveryMonth}</div>
        <div class="autopay-schedule-block-detail-text">
          {window.languages.ViewAutoPayMethodScheduleLastDay}
        </div>
        <div class="autopay-schedule-block-next-icon"></div>
      </div>
      <div id="everyMonthChosenDayButtonId" class="autopay-schedule-block-containter"
           ontouchstart="everyMonthChosenDayStart()" ontouchend="everyMonthChosenDayEnd()">
        <div class="autopay-schedule-block-text">{window.languages.ViewAutoPayMethodScheduleEveryMonth}</div>
        <div class="autopay-schedule-block-detail-text">
          {window.languages.ViewAutoPayMethodScheduleChosenDay}
        </div>
        <div class="autopay-schedule-block-next-icon"></div>
      </div>
      <div id="everyWeekButtonId" class="autopay-schedule-block-containter" ontouchstart="everyWeekStart()"
           ontouchend="everyWeekEnd()">
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
        <div
            class="{schedule-date-block-day:!timeMode && !weekMode && dayMode,schedule-date-block-week:!timeMode && weekMode && !dayMode,schedule-date-block-time:timeMode && !weekMode && !dayMode}"
            each="{i in dateBlockArray}"
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

    <button id="chooseAutoPayButtonId" class="schedule-date-block-button-choose"
            ontouchstart="onTouchStartOfChooseDate()"
            ontouchend="chooseDate()">
      {window.languages.ViewAutoPayMethodScheduleChoseButtonLabel}
    </button>
  </div>

  <script>

    console.log("OPTS AutoPayMethod SCHEDULE NEW=", opts);
    var scope = this;

    window.saveHistory('view-autopay-schedule-method-new', opts);

    var backStartY, backStartX, backEndY, backEndX;

    scope.onTouchStartOfBack = onTouchStartOfBack = function () {
      event.stopPropagation();
      backStartY = event.changedTouches[0].pageY;
      backStartX = event.changedTouches[0].pageX;
    };

    goToBack = function () {
      event.stopPropagation();

      backEndY = event.changedTouches[0].pageY;
      backEndX = event.changedTouches[0].pageX;

      if (Math.abs(backStartY - backEndY) <= 20 && Math.abs(backStartX - backEndX) <= 20) {
        event.preventDefault();
        event.stopPropagation();
        if (scope.autoPayData.fromView == 'PAYCONFIRM') {
          opts.mode = 'USUAL';
          onBackParams.opts = JSON.parse(JSON.stringify(opts));
        }
        onBackKeyDown(opts);
        scope.unmount()
      }
    };

    this.titleName = window.languages.ViewAutoPayTitleName;
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    onBackParams.opts = JSON.parse(JSON.stringify(opts));
    if (scope.autoPayData.fromView == 'PAYCONFIRM') {
      onBackParams.opts.mode = 'USUAL';
      opts.mode = 'ADDAUTOPAY';
    }
    console.log("Window.opts=", onBackParams.opts)
    //    console.log("ID of service=", opts.id);
    if (viewPay.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
      scope.serviceName = 'Мой номер';
      scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
    } else {
      this.serviceName = scope.servicesMap[scope.autoPayData.service_id][0].name;
      this.serviceIcon = scope.servicesMap[scope.autoPayData.service_id][0].image;
    }

    scope.daysArray = window.languages.ViewAutoPayMethodScheduleDaysArray;
    scope.weekDaysArray = window.languages.ViewAutoPayMethodScheduleWeekDaysArray;
    scope.hoursArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
    scope.minutesArray = window.languages.ViewAutoPayMethodScheduleMinutesArray;

    scope.weekMode = false;
    scope.timeMode = false;
    scope.dayMode = false;

    //    scope.shift = 170;

    //    scope.topOfWeekOperations = 100 * widthK;
    var dateNumber, count, minuteNumber = 0, minutesCount = 60;


    var everyMonthButtonStartX, everyMonthButtonEndX, everyMonthButtonStartY, everyMonthButtonEndY;

    everyMonthLastDayStart = function () {

      everyMonthButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      everyMonthButtonStartX = event.changedTouches[0].pageX;
      everyMonthButtonStartY = event.changedTouches[0].pageY;

    }

    everyMonthLastDayEnd = function () {

      everyMonthButtonId.style.backgroundColor = 'transparent'

      everyMonthButtonEndX = event.changedTouches[0].pageX;
      everyMonthButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(everyMonthButtonStartX - everyMonthButtonEndX) <= 20 && Math.abs(everyMonthButtonStartY - everyMonthButtonEndY) <= 20) {

        scope.autoPayData.type = 4;
        dateNumber = -2;
        minuteNumber = -2;
        scope.topOfOperations = 143 * widthK;
        scope.weekMode = false;
        scope.timeMode = true;
        scope.dayMode = false;
        scope.shift = 143;
        count = 24;
        scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseTime;
        scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
        scope.dateBlockArrayTwo = window.languages.ViewAutoPayMethodScheduleMinutesArray;
        dateChooseBlockId.style.display = 'block';
//      console.log("LAST DAY, dateBlockArray", scope.dateBlockArray);
        scope.update();
        changePositionInitAutoPay();
        changeMinutesPositionInit();
      }
    }

    var everyMonthChosenDayButtonStartX, everyMontChosenDayButtonEndX, everyMontChosenDayButtonStartY,
      everyMontChosenDayButtonEndY;

    everyMonthChosenDayStart = function () {

      everyMonthChosenDayButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      everyMonthChosenDayButtonStartX = event.changedTouches[0].pageX;
      everyMontChosenDayButtonStartY = event.changedTouches[0].pageY;

    }


    everyMonthChosenDayEnd = function () {

      everyMonthChosenDayButtonId.style.backgroundColor = 'transparent'

      everyMontChosenDayButtonEndX = event.changedTouches[0].pageX;
      everyMontChosenDayButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(everyMonthChosenDayButtonStartX - everyMontChosenDayButtonEndX) <= 20 && Math.abs(everyMontChosenDayButtonStartY - everyMontChosenDayButtonEndY) <= 20) {

        scope.autoPayData.type = 3;
        dateNumber = 0;
        scope.topOfOperations = 185 * widthK;
        scope.weekMode = false;
        scope.timeMode = false;
        scope.dayMode = true;
        scope.shift = 185;
        count = 31;
        scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseDate;
        scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleDaysArray;
        dateChooseBlockId.style.display = 'block';
//      console.log("CHOSEN DAY, dateBlockArray", scope.dateBlockArray);
        scope.update();
        changePositionInitAutoPay();
      }
    }


    var everyWeekButtonStartX, everyWeekButtonEndX, everyWeekButtonStartY, everyWeekButtonEndY;

    everyWeekStart = function () {

      everyWeekButtonId.style.backgroundColor = 'rgba(231,231,231,0.5)'

      everyWeekButtonStartX = event.changedTouches[0].pageX;
      everyWeekButtonStartY = event.changedTouches[0].pageY;

    }

    everyWeekEnd = function () {

      everyWeekButtonId.style.backgroundColor = 'transparent'

      everyWeekButtonEndX = event.changedTouches[0].pageX;
      everyWeekButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(everyWeekButtonStartX - everyWeekButtonEndX) <= 20 && Math.abs(everyWeekButtonStartY - everyWeekButtonEndY) <= 20) {

        scope.autoPayData.type = 2;
        dateNumber = 0;
        scope.topOfOperations = 84 * widthK;
        scope.shift = 84;
        scope.weekMode = true;
        scope.timeMode = false;
        scope.dayMode = false;
        count = 7;
        scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseWeekDay;
        scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleWeekDaysArray;
        dateChooseBlockId.style.display = 'block';
        console.log("EVERY WEEK, count=", count);
        scope.update();
        changePositionInitAutoPay();
      }
    }

    var chooseDateStartY, chooseDateStartX, chooseDateEndY, chooseDateEndX;

    scope.onTouchStartOfChooseDate = onTouchStartOfChooseDate = function () {
      event.stopPropagation();

      chooseAutoPayButtonId.style.webkitTransform = 'scale(0.8)'

      chooseDateStartY = event.changedTouches[0].pageY;
      chooseDateStartX = event.changedTouches[0].pageX;
    };

    chooseDate = function () {
      event.stopPropagation();

      chooseAutoPayButtonId.style.webkitTransform = 'scale(1)'

      chooseDateEndY = event.changedTouches[0].pageY;
      chooseDateEndX = event.changedTouches[0].pageX;

      if (Math.abs(chooseDateStartY - chooseDateEndY) <= 20 && Math.abs(chooseDateStartX - chooseDateEndX) <= 20) {
//      dateChooseBlockId.style.display = 'none';
        if (scope.timeMode) {
          //console.log("HOUR=", dateNumber);
          //console.log("MIN=", minuteNumber);
          scope.autoPayData.paytime = window.languages.ViewAutoPayMethodScheduleHoursArray[dateNumber + 6].v + ':' + window.languages.ViewAutoPayMethodScheduleMinutesArray[minuteNumber + 6].v;
          console.log("autoPayData=", scope.autoPayData);

          if (scope.autoPayData.type == 2) {
            scope.autoPayData.condition_text = window.languages.ViewAutoPayMethodScheduleWeekDaysArray[scope.autoPayData.week_day - 1].v + ", " +
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
          onBackParams.opts = JSON.parse(JSON.stringify(opts));
          riotTags.innerHTML = "<view-service-page-new>";
          riot.mount("view-service-page-new", opts);

          scope.unmount()
        } else {
          if (scope.dayMode) {
            console.log("dayMode, Number=", dateNumber + 1);
            scope.autoPayData.month_day = dateNumber + 1;
          }
          else if (scope.weekMode) {
            console.log("weekMode, Number=", dateNumber + 1);
            scope.autoPayData.week_day = dateNumber + 1;
          }
          dateNumber = -2;
          minuteNumber = -2;
          scope.topOfOperations = 143 * widthK;
          scope.weekMode = false;
          scope.timeMode = true;
          scope.dayMode = false;
          scope.shift = 143;
          count = 24;
          scope.dateBlockTitle = window.languages.ViewAutoPayMethodScheduleChoseTime;
          scope.dateBlockArray = window.languages.ViewAutoPayMethodScheduleHoursArray;
          scope.dateBlockArrayTwo = window.languages.ViewAutoPayMethodScheduleMinutesArray;
          dateChooseBlockId.style.display = 'block';
//        console.log("LAST DAY, dateBlockArray", scope.dateBlockArray);
          scope.update();
          changePositionInitAutoPay();
          changeMinutesPositionInit();
        }

      }

    };


    if (!dateNumber) {
      dateNumber = 0;

      this.on('mount', function () {
        changePositionInitAutoPay();
      });

    }

    var left, delta, mleft, mdelta;
    var tempEndY, oldShift, tempShift, nOld = 0, nNew = 0, tempStartY, counter = 0;


    dateContainerTouchStart = function () {
      console.log("in start touch=", dateNumber);
      dateCarouselTouchStartY = event.changedTouches[0].pageY;
//      dateCarouselTouchStartX = event.changedTouches[0].pageX;
//      console.log("startY=", dateCarouselTouchStartY);
      tempStartY = dateCarouselTouchStartY;
      nNew = dateNumber;
//      touchStartTime = new Date().getTime();
      left = -((scope.shift * dateNumber) * widthK) - dateCarouselTouchStartY;
      delta = left;
//      console.log("nNew=", nNew);
      oldShift = Math.round(Math.abs(event.changedTouches[0].pageY + delta) / (scope.shift * widthK));
    };

    dateContainerTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      dateCarouselTouchEndY = event.changedTouches[0].pageY;
//      dateCarouselTouchEndX = event.changedTouches[0].pageX;

      nShift = Math.round(Math.abs(dateCarouselTouchEndY - dateCarouselTouchStartY) / (scope.shift * widthK));

      if (Math.abs(dateCarouselTouchStartY - dateCarouselTouchEndY) > 20) {
        changePositionAutoPay(nShift);
      }
    };


    dateContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.dateContainerId.style.transition = '0s';
      this.dateContainerId.style.webkitTransition = '0s';
      this.dateContainerId.style.transform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
      this.dateContainerId.style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
//      console.log("x=", event.changedTouches[0].pageY);
//      console.log("xx=", event.changedTouches[0].pageY + delta);
//      changePosition(event.changedTouches[0].pageY + delta);
      tempShift = Math.round(Math.abs(event.changedTouches[0].pageY + delta) / (scope.shift * widthK));
      tempEndY = event.changedTouches[0].pageY;
//      console.log("s=", tempShift);
      if (tempShift != oldShift) {
        if (counter == 0) {
          document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        }
        changeColor(tempEndY);
        oldShift = tempShift;
        counter++;
      }
    };

    function changeColor(tempEndY) {
//      nNew = Math.abs(nNew - dateNumber) == 0 ? dateNumber : nNew;

      document.getElementById("day" + nOld).style.color = '#c1c1c1';
//      console.log("nNew in move=", nNew);

      if (tempEndY < tempStartY) {
        ++nNew;
      } else if (tempEndY > tempStartY) {
        --nNew;
      }
      document.getElementById("day" + nNew).style.color = '#01B8FE';
      nOld = nNew;
      tempStartY = tempEndY;

    }

    function changePositionAutoPay(nShift) {
//      console.log("NSHIFT", Number(nShift));
      document.getElementById("day" + nOld).style.color = '#c1c1c1';
      document.getElementById("day" + nNew).style.color = '#c1c1c1';

      if (dateCarouselTouchEndY < dateCarouselTouchStartY) {
        //        console.log("111", dateNumber + Number(nShift));
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        if ((dateNumber + Number(nShift)) > (count - 1)) {
          dateNumber = (dateNumber + (Number(nShift) % count)) >= count ? ((dateNumber + (Number(nShift) % count)) - count) : (dateNumber + (Number(nShift) % count));
          this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        } else {
          dateNumber = dateNumber + Number(nShift);
          this.dateContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        }
        //        dateNumber = (dateNumber + Number(nShift)) > (count - 1) ? (dateNumber + Number(nShift) - count) : (dateNumber + Number(nShift));

        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
        //        console.log("2=", dateNumber);
      } else if (dateCarouselTouchEndY > dateCarouselTouchStartY) {
        //        console.log("222", dateNumber - Number(nShift));
        //        console.log("222 =", (count + (dateNumber - Number(nShift))));
        document.getElementById("day" + dateNumber).style.color = '#c1c1c1';
        if ((dateNumber - Number(nShift)) < 0) {
          dateNumber = (dateNumber - (Number(nShift) % count)) < 0 ? ((dateNumber - (Number(nShift) % count)) + count) : (dateNumber - (Number(nShift) % count));
          this.dateContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        } else {
          dateNumber = dateNumber - Number(nShift);
          this.dateContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.dateContainerId.style.transform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
          this.dateContainerId.style.webkitTransform = "translate3d(0," + (-dateNumber * scope.shift) * widthK + 'px' + ", 0)";
        }
        //        dateNumber = (dateNumber - Number(nShift)) < 0 ? (count + (dateNumber - Number(nShift))) : (dateNumber - Number(nShift));
        document.getElementById("day" + dateNumber).style.color = '#01B8FE';
        //console.log("5=", dateNumber);
      }

      console.log("dateNumber after", dateNumber);
      console.log();

      counter = 0;
    }

    function changePositionInitAutoPay() {

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
    var minutesTouchStartY, minutesTouchEndY;
    var mtempEndY, moldShift, mtempShift, mnOld = 0, mnNew = 0, mtempStartY, mcounter = 0, minShift = 143;
    var widthKCopy = widthK;

    minContainerTouchStart = function () {
//      console.log("in start touch=", minuteNumber);
      minutesTouchStartY = event.changedTouches[0].pageY;

      mtempStartY = minutesTouchStartY;
      mnNew = minuteNumber;
      mleft = -((minShift * minuteNumber) * widthKCopy) - minutesTouchStartY;
      mdelta = mleft;
      moldShift = Math.round(Math.abs(event.changedTouches[0].pageY + mdelta) / (minShift * widthKCopy));
    }

    minContainerTouchEnd = function () {
      event.preventDefault();

      event.stopPropagation();
      minutesTouchEndY = event.changedTouches[0].pageY;

      mShift = Math.round(Math.abs(minutesTouchStartY - minutesTouchEndY) / (minShift * widthKCopy));


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

      mtempShift = Math.round(Math.abs(event.changedTouches[0].pageY + mdelta) / (minShift * widthKCopy));
      mtempEndY = event.changedTouches[0].pageY;
//      console.log("s=", tempShift);
      if (mtempShift != moldShift) {
        if (mcounter == 0) {
          document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        }
        changeMinutesColor(mtempEndY);
        moldShift = mtempShift;
        mcounter++;
      }
    }

    function changeMinutesColor(mtempEndY) {
//      nNew = Math.abs(nNew - dateNumber) == 0 ? dateNumber : nNew;

      document.getElementById("min" + mnOld).style.color = '#c1c1c1';
//      console.log("nNew in move=", mnNew);

      if (mtempEndY < mtempStartY) {
        ++mnNew;
      } else if (mtempEndY > mtempStartY) {
        --mnNew;
      }
      document.getElementById("min" + mnNew).style.color = '#01B8FE';
      mnOld = mnNew;
      mtempStartY = mtempEndY;

    }

    function changeMinutesPosition(mShift) {

      document.getElementById("min" + mnOld).style.color = '#c1c1c1';
      document.getElementById("min" + mnNew).style.color = '#c1c1c1';

      if (minutesTouchEndY < minutesTouchStartY) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        if ((minuteNumber + Number(mShift)) > (minutesCount - 1)) {
          minuteNumber = (minuteNumber + (Number(mShift) % minutesCount)) >= minutesCount ? ((minuteNumber + (Number(mShift) % minutesCount)) - minutesCount) : (minuteNumber + (Number(mShift) % minutesCount));
          this.minutesContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        } else {
          minuteNumber = minuteNumber + Number(mShift);
          this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        }
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';

      } else if (minutesTouchEndY > minutesTouchStartY) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        if ((minuteNumber - Number(mShift)) < 0) {
          minuteNumber = (minuteNumber - (Number(mShift) % minutesCount)) < 0 ? ((minuteNumber - (Number(mShift) % minutesCount)) + minutesCount) : (minuteNumber - (Number(mShift) % minutesCount));
          this.minutesContainerId.style.transition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.webkitTransition = '0s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        } else {
          minuteNumber = minuteNumber - Number(mShift);
          this.minutesContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
          this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
          this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        }
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
      }
      mcounter = 0;

    }

    function changeMinutesPositionInit() {

      if (minuteNumber < minutesCount - 1) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        ++minuteNumber;
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
      }

      if (minuteNumber == 0) {
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
      }

      if (minuteNumber == minutesCount - 1) {
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
      }

      if (minuteNumber > 0) {
        document.getElementById("min" + minuteNumber).style.color = '#c1c1c1';
        --minuteNumber;
        this.minutesContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.minutesContainerId.style.transform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        this.minutesContainerId.style.webkitTransform = "translate3d(0," + (-minuteNumber * minShift) * widthKCopy + 'px' + ", 0)";
        document.getElementById("min" + minuteNumber).style.color = '#01B8FE';
      }

    }


  </script>
</view-autopay-schedule-method-new>

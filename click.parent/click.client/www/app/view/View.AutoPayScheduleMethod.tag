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
      <div class="autopay-schedule-block-containter" ontouchend="goToCallCenterSettings()">
        <div class="autopay-schedule-block-text">{window.languages.ViewAutoPayMethodScheduleEveryWeek}</div>
        <div class="autopay-schedule-block-next-icon"></div>
      </div>

    </div>

  </div>

  <div id="dayChooseBlockId" class="schedule-date-block">
    <div class="schedule-date-block-title-container">
      <hr class="schedule-date-block-title-line"/>
      <div class="schedule-date-block-title">{window.languages.ViewAutoPayMethodScheduleChoseDate}</div>
    </div>

    <div class="schedule-date-block-days-outer-container">

      <div id="monthContainerId" class="schedule-date-block-days-container" ontouchstart="monthContainerTouchStart()"
           ontouchend="monthContainerTouchEnd()"
           ontouchmove="monthContainerTouchMove()">
        <div class="schedule-date-block-day" each="{i in daysArray}"
             style="top:{topOfOperations*i}px;">
          <p id="day{i-1}" class="schedule-date-block-day-text">{i}</p>
        </div>
      </div>
    </div>

    <button class="schedule-date-block-button-choose" ontouchend="chooseDate()">
      {window.languages.ViewAutoPayMethodScheduleChoseButtonLabel}
    </button>
  </div>

  <div id="dateChooseBlockId" class="schedule-date-block">
    <div class="schedule-date-block-title-container">
      <hr class="schedule-date-block-title-line"/>
      <div class="schedule-date-block-title">{window.languages.ViewAutoPayMethodScheduleChoseDate}</div>
    </div>

    <div class="schedule-date-block-days-outer-container">

      <div id="monthContainerId" class="schedule-date-block-days-container" ontouchstart="monthContainerTouchStart()"
           ontouchend="monthContainerTouchEnd()"
           ontouchmove="monthContainerTouchMove()">
        <div class="schedule-date-block-day" each="{i in daysArray}"
             style="top:{topOfOperations*i}px;">
          <p id="day{i-1}" class="schedule-date-block-day-text">{i}</p>
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

    everyMonthChosenDay = function () {
      dateChooseBlockId.style.display = 'block';
    }

    everyMonthLastDay = function () {
      dateChooseBlockId.style.display = 'block';
    }

    chooseDate = function () {
      dateChooseBlockId.style.display = 'none';
    }

    scope.daysArray = window.languages.ViewAutoPayMethodScheduleDaysArray;
    console.log("daysArray", scope.daysArray);
    riot.update(scope.daysArray);

    scope.topOfOperations = 200 * widthK;
    var mNumber;
    var count = 31;
    localStorage.setItem('click_client_countCard', count);


    if (!mNumber) {
      mNumber = 0;

      this.on('mount', function () {
        changePositionTwo();
      });

    }


    monthContainerTouchStart = function () {
      console.log("in start touch=", mNumber);
      carouselTouchStartY = event.changedTouches[0].pageY;
      left = -((200 * mNumber) * widthK) - carouselTouchStartY;
      delta = left;
    }

    monthContainerTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndY = event.changedTouches[0].pageY;
      if (Math.abs(carouselTouchStartY - carouselTouchEndY) > 20) {
        changePosition();
      }
    }


    monthContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.monthContainerId.style.transition = '0s';
      this.monthContainerId.style.webkitTransition = '0s';
      this.monthContainerId.style.transform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
      this.monthContainerId.style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + delta ) + 'px' + ", 0)";
    }

    function changePosition() {

      if (carouselTouchEndY < carouselTouchStartY && mNumber < count - 1) {
        document.getElementById("day" + mNumber).style.color = '#c1c1c1';
        ++mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        document.getElementById("day" + mNumber).style.color = '#01B8FE';
      }

      if (carouselTouchEndY > carouselTouchStartY && mNumber == 0) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
      }

      if (carouselTouchEndY < carouselTouchStartY && mNumber == count - 1) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
      }

      if (carouselTouchEndY > carouselTouchStartY && mNumber > 0) {
        document.getElementById("day" + mNumber).style.color = '#c1c1c1';
        --mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        document.getElementById("day" + mNumber).style.color = '#01B8FE';
      }


      localStorage.setItem('mNumber', mNumber);
    }

    function changePositionTwo() {

      if (mNumber < count - 1) {
        document.getElementById("day" + mNumber).style.color = '#c1c1c1';
        ++mNumber;
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        document.getElementById("day" + mNumber).style.color = '#01B8FE';
      }

      if (mNumber == 0) {
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
      }

      if (mNumber == count - 1) {
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
      }

      if (mNumber > 0) {
        document.getElementById("day" + mNumber).style.color = '#c1c1c1';
        --mNumber;
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(0," + (-mNumber * 200) * widthK + 'px' + ", 0)";
        document.getElementById("day" + mNumber).style.color = '#01B8FE';
      }

    }

  </script>
</view-autopay-schedule-method>

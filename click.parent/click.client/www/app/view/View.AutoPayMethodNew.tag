<view-autopay-method-new>
  <div class="riot-tags-main-container">
    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title">{titleName} {serviceName}</p>
      <div ontouchend="goToBack()" ontouchstart="onTouchStartOfBack()"
           class="servicepage-button-back">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
      <div class="title-bottom-border">
      </div>
    </div>


    <div class="autopay-method-body-container">
      <div class="autopay-method-choose-text">{window.languages.ViewAutoPayMethodChooseText}</div>
      <div class="autopay-method-container">
        <div class="autopay-method-event-container" ontouchstart="onTouchStartOfEvent()" ontouchend="eventTouchEnd()">
          <div id="maleIconId" class="autopay-method-event-icon"></div>
          <p id="maleTitleId" class="autopay-method-text">
            {window.languages.ViewAutoPayMethodEventText}</p>
        </div>
        <div class="autopay-method-line-between"></div>
        <div class="autopay-method-schedule-container" ontouchstart="onTouchStartOfSchedule()"
             ontouchend="scheduleTouchEnd()">
          <div id="femaleIconId" class="autopay-method-schedule-icon"></div>
          <p id="femaleTitleId" class="autopay-method-text">
            {window.languages.ViewAutoPayMethodSchedulerText}</p>
        </div>
      </div>


    </div>

  </div>

  <component-tour view="autopaymethod"></component-tour>

  <script>
    var scope = this;

    window.saveHistory('view-autopay-method-new', opts);

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
    console.log("OPTS AutoPayMethod NEW=", opts);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    onBackParams.opts = JSON.parse(JSON.stringify(opts));
    if (scope.autoPayData.fromView == 'PAYCONFIRM') {
      onBackParams.opts.mode = 'USUAL';
      opts.mode = 'ADDAUTOPAY';
    }
    console.log("Window.opts=", onBackParams.opts)

    //    console.log("chosenServiceId=", viewPay.chosenServiceId);

    if (viewPay.chosenServiceId == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
      scope.serviceName = 'Мой номер';
      scope.serviceIcon = 'resources/icons/ViewPay/myphone.png';
    } else {
      this.serviceName = scope.servicesMap[scope.autoPayData.service_id][0].name;
      this.serviceIcon = scope.servicesMap[scope.autoPayData.service_id][0].image;
    }

    this.on('mount', function () {

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).autopaymethod) {
        componentTourId.style.display = "block";
        StatusBar.backgroundColorByHexString("#ffffff");
      }
    });

    var eventStartY, eventStartX, eventEndY, eventEndX;

    scope.onTouchStartOfEvent = onTouchStartOfEvent = function () {
      event.stopPropagation();
      eventStartY = event.changedTouches[0].pageY;
      eventStartX = event.changedTouches[0].pageX;
    };


    eventTouchEnd = function () {
      event.stopPropagation();

      eventEndY = event.changedTouches[0].pageY;
      eventEndX = event.changedTouches[0].pageX;

      if (Math.abs(eventStartY - eventEndY) <= 20 && Math.abs(eventStartX - eventEndX) <= 20) {
        scope.autoPayData.title = window.languages.ViewAutoPayMethodEventText;
        scope.autoPayData.autopay_type = 2;
        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
        event.preventDefault();
        event.stopPropagation();
//      localStorage.setItem('autoPayType', window.languages.ViewAutoPayMethodEventText);
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        riotTags.innerHTML = "<view-autopay-event-method-new>";
        riot.mount("view-autopay-event-method-new", opts);
        scope.unmount()
      }
    }

    var scheduleStartY, scheduleStartX, scheduleEndY, scheduleEndX;

    scope.onTouchStartOfSchedule = onTouchStartOfSchedule = function () {
      event.stopPropagation();
      scheduleStartY = event.changedTouches[0].pageY;
      scheduleStartX = event.changedTouches[0].pageX;
    };

    scheduleTouchEnd = function () {
      event.stopPropagation();

      scheduleEndY = event.changedTouches[0].pageY;
      scheduleEndX = event.changedTouches[0].pageX;

      if (Math.abs(scheduleStartY - scheduleEndY) <= 20 && Math.abs(scheduleStartX - scheduleEndX) <= 20) {
        scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
        scope.autoPayData.autopay_type = 1;
        localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
        event.preventDefault();
        event.stopPropagation();
//      localStorage.setItem('autoPayType', window.languages.ViewAutoPayMethodSchedulerText);
        onBackParams.opts = JSON.parse(JSON.stringify(opts));
        riotTags.innerHTML = "<view-autopay-schedule-method-new>";
        riot.mount("view-autopay-schedule-method-new", opts);
        scope.unmount()
      }
    }


  </script>
</view-autopay-method-new>

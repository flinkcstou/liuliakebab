<view-autopay-method-new>
  <div class="riot-tags-main-container">
    <div class="pay-page-title" style="border-style: none;">
      <p class="autopay-method-page-title">{titleName} {serviceName}</p>
      <div ontouchend="goToBack()"
           class="autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">
      <div class="autopay-method-choose-text">{window.languages.ViewAutoPayMethodChooseText}</div>
      <div class="autopay-method-container">
        <div class="autopay-method-event-container" ontouchend="eventTouchEnd()">
          <div id="maleIconId" class="autopay-method-event-icon"></div>
          <p id="maleTitleId" class="autopay-method-text">
            {window.languages.ViewAutoPayMethodEventText}</p>
        </div>
        <div class="autopay-method-line-between"></div>
        <div class="autopay-method-schedule-container" ontouchend="scheduleTouchEnd()">
          <div id="femaleIconId" class="autopay-method-schedule-icon"></div>
          <p id="femaleTitleId" class="autopay-method-text">
            {window.languages.ViewAutoPayMethodSchedulerText}</p>
        </div>
      </div>


    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-tour view="autopaymethod"></component-tour>

  <script>
    var scope = this;
    scope.showError = false;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-method-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-method-new',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      console.log("JSON.parse(localStorage.getItem('autoPayData'))", JSON.parse(localStorage.getItem('autoPayData')));
      if (JSON.parse(localStorage.getItem('autoPayData')).fromView == 'PAYCONFIRM') {
        opts.mode = 'USUAL';
      }
      onBackKeyDownWithParams(opts, 1);
      scope.unmount()
    };


    this.titleName = window.languages.ViewAutoPayTitleName;
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    console.log("OPTS AutoPayMethod NEW=", opts);
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));

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
        StatusBar.backgroundColorByHexString("#004663");
      }
    });


    eventTouchEnd = function () {
      scope.autoPayData.title = window.languages.ViewAutoPayMethodEventText;
      scope.autoPayData.autopay_type = 2;
      localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
      event.preventDefault();
      event.stopPropagation();
//      localStorage.setItem('autoPayType', window.languages.ViewAutoPayMethodEventText);
      riotTags.innerHTML = "<view-autopay-event-method-new>";
      riot.mount("view-autopay-event-method-new", opts);
      scope.unmount()
    }

    scheduleTouchEnd = function () {
      scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
      scope.autoPayData.autopay_type = 1;
      localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
      event.preventDefault();
      event.stopPropagation();
//      localStorage.setItem('autoPayType', window.languages.ViewAutoPayMethodSchedulerText);
      riotTags.innerHTML = "<view-autopay-schedule-method-new>";
      riot.mount("view-autopay-schedule-method-new", opts);
      scope.unmount()
    }


  </script>
</view-autopay-method-new>
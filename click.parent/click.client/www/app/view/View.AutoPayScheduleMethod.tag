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
      <div class="autopay-schedule-block-containter" ontouchend="goToCallCenterSettings()">
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

  <div id="dateChooseBlockId" class="schedule-date-block">
    <hr class="schedule-date-block-title-line"/>
    <p class="schedule-date-block-title">{window.languages.ViewAutoPayMethodScheduleChoseDate}</p>


    <button class="schedule-date-block-button-choose" ontouchend="chooseDate()">
      {window.languages.ComponentAlertOk}
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


    //    this.on('mount', function () {
    //
    //
    //      riot.update();
    //
    //    })


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
      dateChooseBlockId.style.display = 'block';
    }

    chooseDate = function () {
      dateChooseBlockId.style.display = 'none';
    }


  </script>
</view-autopay-schedule-method>

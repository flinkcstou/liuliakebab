<view-autopay-method>
  <div>
    <div class="pay-page-title" style="border-style: none;">
      <p class="servicepage-title autopay-method-page-title">{titleName} {serviceName}</p>
      <div ontouchend="goToBack()"
           class="servicepage-button-back autopay-method-back-button">
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

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = "АВТОПЛАТЕЖ";
    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    console.log("ID of srevice=", opts.id);
    this.serviceName = scope.servicesMap[opts.id][0].name;
    this.serviceIcon = scope.servicesMap[opts.id][0].image;


    //    this.on('mount', function () {
    //
    //
    //      riot.update();
    //
    //    })


    eventTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-autopay-event-method>";
      riot.mount("view-autopay-event-method", opts);

    }

    scheduleTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      riotTags.innerHTML = "<view-autopay-schedule-method>";
      riot.mount("view-autopay-schedule-method", opts);
    }


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-method') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-method',
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


  </script>
</view-autopay-method>

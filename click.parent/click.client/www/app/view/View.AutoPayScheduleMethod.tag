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
      <div class="autopay-method-choose-text">{window.languages.ViewAutoPayMethodChooseText}</div>


    </div>

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


  </script>
</view-autopay-schedule-method>

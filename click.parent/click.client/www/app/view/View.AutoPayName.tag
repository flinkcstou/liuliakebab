<view-autopay-name>
  <div>
    <div class="pay-page-title" style="border-style: none;">
      <p class="autopay-method-page-title">{titleName} {serviceName}</p>
      <p class="servicepage-category-field">{autoPayTypeText}</p>
      <div ontouchend="goToBack()"
           class="autopay-method-back-button">
      </div>
      <div type="button" class="servicepage-service-icon autopay-method-service-icon"
           style="background-image: url({serviceIcon})"></div>
    </div>


    <div class="autopay-method-body-container">

      <div class="servicepage-first-field autopay-event-number-field">
        <p class="servicepage-text-field">{window.languages.ViewAutoPayNameFieldText}</p>

        <input class="servicepage-number-input-part autopay-name-input-part" type="text" id="autoPayNameInput"
               autofocus="true"/>
      </div>

      <button class="autopay-event-button-enter"
              ontouchend="goToPayConfirmPage()">{window.languages.ViewServicePageEnterLabel}
      </button>

    </div>

  </div>


  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;
    this.titleName = window.languages.ViewAutoPayTitleName;
    scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
    this.autoPayTypeText = scope.autoPayData.title;

    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);

    this.serviceName = scope.servicesMap[viewPay.chosenServiceId][0].name;
    this.serviceIcon = scope.servicesMap[viewPay.chosenServiceId][0].image;


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-autopay-name') {
      history.arrayOfHistory.push(
        {
          "view": 'view-autopay-name',
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


    goToPayConfirmPage = function () {
      if (autoPayNameInput.value.length < 1) {
        scope.clickPinError = false;
        scope.errorNote = "Введите название автоплатежа";
        scope.showError = true;
        scope.update();
        return;
      }
      scope.autoPayData.name = autoPayNameInput.value;
      scope.autoPayData.isNew = true;
      localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

      this.riotTags.innerHTML = "<view-pay-confirm>";
      riot.mount('view-pay-confirm', [opts[0], opts[1], opts[2], 'ADDAUTOPAY']);
      scope.unmount()
    }


  </script>
</view-autopay-name>

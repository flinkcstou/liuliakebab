<view-service-info class="view-service-pincards">

  <div class="pay-page-title" style="border-style: none;">
    <p class="{servicepage-title :opts[8]!='ADDAUTOPAY', autopay-method-page-title:opts[8]=='ADDAUTOPAY'}">
      {(opts[8]=='ADDAUTOPAY')?(window.languages.ViewAutoPayTitleName):("")}
      {titleName}</p>
    <p class="servicepage-category-field">{(opts[8]=='ADDAUTOPAY')?
      (autoPayTypeText):(categoryName)}</p>
    <div ontouchend="touchStartTitle()"
         class="{servicepage-button-back:opts[8]!='ADDAUTOPAY', autopay-method-back-button:opts[8]=='ADDAUTOPAY'}">
    </div>
    <div type="button" class="servicepage-service-icon" if="{opts[8]=='ADDAUTOPAY'}"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="pincard-body-container">
    <div class="serviceinfo-options" if="{type==3}">
      <div class="serviceinfo-option-text-container">
        <p class="serviceinfo-option-text">{window.languages.ViewServicePinCardPayFromField}</p></div>

      <div class="serviceinfo-option-containter" ontouchend="chooseOption(this.id)" each="{i in optionsArray}"
           id="{i.option_value}">
        <div class="serviceinfo-option-title-text">{i.option_object[0].title}:</div>
        <div class="serviceinfo-option-value-text">
          {i.option_object[0].value}
        </div>
        <div class="serviceinfo-option-title-text">{i.option_object[1].title}:</div>
        <div class="serviceinfo-option-value-text">
          {i.option_object[1].value}
        </div>
        <div id="check{i.option_value}" class="serviceinfo-option-check-icon"></div>
      </div>
    </div>

    <div class="serviceinfo-options" if="{type==1}">
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Номер счета:</p>
        <p class="serviceinfo-inform-field-value">0579 0795 7987</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">ФИО:</p>
        <p class="serviceinfo-inform-field-value">Ганиев Жасур</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Адрес:</p>
        <p class="serviceinfo-inform-field-value">ул. Дустлик, 95</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Период:</p>
        <p class="serviceinfo-inform-field-value">Март, 2017 г.</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Начислено:</p>
        <p class="serviceinfo-inform-field-value">78 900 сум</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Поступления:</p>
        <p class="serviceinfo-inform-field-value">0 сум</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Электронные поступления:</p>
        <p class="serviceinfo-inform-field-value">0 сум</p>
      </div>
      <div class="serviceinfo-inform-field">
        <p class="serviceinfo-inform-field-title">Баланс:</p>
        <p class="serviceinfo-inform-field-value">-568 000 сум</p>
      </div>

    </div>

    <button class="serviceinfo-button-next"
            ontouchend="goToNextPage()">
      {window.languages.ViewServiceInfoButtonNextText}
    </button>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>


    console.log('OPTS', opts);
    var arrayForPay = [];
    arrayForPay.push(opts[0]);
    arrayForPay.push(opts[1]);
    arrayForPay.push(opts[2]);
    arrayForPay.push(opts[3]);
    arrayForPay.push(opts[4]);
    arrayForPay.push(opts[5]);
    arrayForPay.push(opts[6]);
    arrayForPay.push(opts[7]);
    //    8 - mode for titlename
    arrayForPay.push(opts[8]);
    console.log(arrayForPay);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-info') {
      history.arrayOfHistory.push(
        {
          "view": 'view-service-info',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var scope = this;
    scope.showError = false;
    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    scope.servicesMap = JSON.parse(localStorage.getItem("click_client_servicesMap"));
    console.log("servicesMap=", scope.servicesMap);
    scope.service = scope.servicesMap[viewPay.chosenServiceId][0];
    scope.categoryNamesMap = JSON.parse(localStorage.getItem("click_client_categoryNamesMap"));
    scope.type = 0;

    if (opts[8] == 'ADDAUTOPAY') {
      scope.autoPayData = JSON.parse(localStorage.getItem('autoPayData'));
      this.autoPayTypeText = scope.autoPayData.title;
      console.log("autoPayType=", this.autoPayTypeText);
    }

    this.titleName = scope.service.name;
    this.serviceIcon = scope.service.image;
    this.categoryName = scope.categoryNamesMap[scope.service.category_id].name;

    console.log("PAYMENT_DATA=", opts[8].payment_data)

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    scope.serviceData;

    window.api.call({
      method: 'get.additional.information',
      input: {
        phone_num: phoneNumber,
        service_id: viewPay.chosenServiceId,
        payment_data: opts[8].payment_data
      },

      scope: this,

      onSuccess: function (result) {
        if (result[0][0].error == 0) {
          console.log("result of GET ADDITIONAL INFO 0", result);
          if (result[1]) {
            scope.serviceData = result[1];
            if (result[1][0].information_type == 1) {
              scope.optionsArray = result[1][0].options;
              scope.type = 3;
              scope.update();
            } else if (result[1][0].information_type == 3) {
              console.log("ADFDSFDS");
              scope.type = 1;
              scope.update();
            }

          }
        }
        else {
          console.log("result of GET ADDITIONAL INFO 2", result);
          //          componentUnsuccessId.style.display = 'block';
        }
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });


    scope.index = -1;
    chooseOption = function (id) {
      if (scope.index != -1 && scope.index != id)
        document.getElementById("check" + scope.index).style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
      document.getElementById("check" + id).style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
      scope.index = id;
    }


    goToNextPage = function () {
      console.log("dfkl");

      this.riotTags.innerHTML = "<view-service-pincards>";
      riot.mount('view-service-pincards', opts);
      scope.unmount()
    };


  </script>
</view-service-info>

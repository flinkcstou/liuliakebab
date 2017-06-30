<view-service-info-new class="view-service-pincards">

  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">{titleName}</p>
    <p class="servicepage-category-field">{categoryName}</p>
    <div ontouchend="goToBack()"
         class="servicepage-button-back">
    </div>
    <div type="button" class="servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
  </div>

  <div class="pincard-body-container">
    <div class="serviceinfo-options" if="{type==3}">
      <div class="serviceinfo-option-text-container">
        <p class="serviceinfo-option-text">{optionsHeader}</p></div>

      <div class="serviceinfo-option-containter" ontouchstart="optionOnTouchStart()"
           ontouchend="optionOnTouchEnd(this.id)"
           each="{i in optionsArray}"
           id="{i.option_value}">
        <ul class="serviceinfo-option-info-container" style="list-style:none">
          <li class="serviceinfo-option-detail" each="{j in i.option_object}">
            <div class="serviceinfo-option-title-text">{j.title}:</div>
            <div class="serviceinfo-option-value-text">
              {j.value}
            </div>
          </li>
        </ul>
        <div id="check{i.option_value}" class="serviceinfo-option-check-icon" if="{checkIconShow}"></div>
      </div>
    </div>

    <div class="serviceinfo-options" if="{type==1}">
      <div class="serviceinfo-inform-field" each="{i in infoArray}">
        <p class="serviceinfo-inform-field-title">{i.title}:</p>
        <p class="serviceinfo-inform-field-value">{i.value}</p>
      </div>

    </div>

    <button class="serviceinfo-button-next"
            ontouchend="goToNextPage()">
      {window.languages.ViewServiceInfoButtonNextText}
    </button>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}" step_amount="{stepAmount}"
                   errornote="{errorNote}"></component-alert>

  <script>


    console.log('OPTS in ServiceInfo NEW', opts);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-service-info-new') {
      history.arrayOfHistory.push(
        {
          "view": 'view-service-info-new',
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

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    console.log("servicesMap=", scope.servicesMap);
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    this.titleName = scope.service.name;
    this.serviceIcon = scope.service.image;
    this.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var payment_data, optionAttribute;
    scope.type = 0;


    if (opts.formtype == 1) {
      payment_data = {
        "param": opts.firstFieldId,
        "value": opts.firstFieldText,
        "transaction_id": parseInt(Date.now() / 1000)
      };

    }
    else if (opts.formtype == 2) {
      payment_data = {
        "pin_param": opts.cardTypeId,
        "transaction_id": parseInt(Date.now() / 1000)
      };

    }
    else if (opts.formtype == 3) {
      payment_data = {
        "param": opts.firstFieldId,
        "value": opts.firstFieldText,
        "communal_param": opts.communalParam,
        "transaction_id": parseInt(Date.now() / 1000)
      };


    }
    else if (opts.formtype == 4) {
      payment_data = {
        "param": opts.firstFieldId,
        "value": opts.firstFieldText,
        "internet_package_param": opts.internetPackageParam,
        "transaction_id": parseInt(Date.now() / 1000)
      };

    }

    if (device.platform != 'BrowserStand') {
      var options = {dimBackground: true};

      SpinnerPlugin.activityStart(languages.Downloading, options, function () {
        console.log("Started");
      }, function () {
        console.log("closed");
      });
    }

    getInformation();


    function getInformation() {
      var checkAnswer = false;
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

      window.api.call({
        method: 'get.additional.information',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          service_id: opts.chosenServiceId,
          payment_data: payment_data
        },

        scope: this,

        onSuccess: function (result) {
          checkAnswer = true;
          if (result[0][0].error == 0) {
            console.log("result of GET ADDITIONAL INFO 0", result);
            if (result[1]) {
              scope.serviceData = result[1][0];
              if (result[1][0].information_type == 3) {
                scope.optionsArray = result[1][0].options;
                scope.optionsHeader = result[1][0].options_header;
                scope.checkIconShow = result[1][0].options.length > 1;
                optionAttribute = result[1][0].options[0].option_payment_attribute;
                opts.optionAttribute = optionAttribute;
                opts.optionValue = scope.checkIconShow ? null : result[1][0].options[0].option_value;
                scope.type = 3;
                scope.update();
              } else if (result[1][0].information_type == 1 || result[1][0].information_type == 4) {
                scope.infoArray = result[1][0].information_object;
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

      if (!checkAnswer && window.isConnected)
        setTimeout(function () {
          if (!checkAnswer) {
            scope.showError = true;
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 0;
            scope.update();
            if (device.platform != 'BrowserStand') {
              SpinnerPlugin.activityStop();
            }
            window.isConnected = false;
            return
          }
        }, 10000);


    }

    var optionOnTouchStartY, optionOnTouchStartX, optionOnTouchEndY, optionOnTouchEndX;

    optionOnTouchStart = function () {
      event.stopPropagation();
      optionOnTouchStartY = event.changedTouches[0].pageY;
      optionOnTouchStartX = event.changedTouches[0].pageX;
    };


    scope.index = -1;
    optionOnTouchEnd = function (id) {
      event.stopPropagation();

      optionOnTouchEndY = event.changedTouches[0].pageY;
      optionOnTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(optionOnTouchStartY - optionOnTouchEndY) <= 20 && Math.abs(optionOnTouchStartX - optionOnTouchEndX) <= 20) {

        if (scope.index != -1 && scope.index != id)
          document.getElementById("check" + scope.index).style.backgroundImage = "url(resources/icons/ViewService/unchecked.png)";
        document.getElementById("check" + id).style.backgroundImage = "url(resources/icons/ViewSettingsGeneral/general_save.png)";
        scope.index = id;
        opts.optionValue = id;
      }
    };


    goToNextPage = function () {

      if (scope.index == -1 && scope.serviceData.information_type == 3 && scope.checkIconShow) {

        scope.clickPinError = false;
        scope.errorNote = "Выберите из вариантов";
        scope.showError = true;
        scope.update();
      } else {
        this.riotTags.innerHTML = "<view-service-pincards-new>";
        riot.mount('view-service-pincards-new', opts);
        scope.unmount()
      }

    };


  </script>
</view-service-info-new>

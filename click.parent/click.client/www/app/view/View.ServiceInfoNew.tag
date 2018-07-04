<view-service-info-new class="view-service-pincards">

  <div class="pay-page-title" style="border-style: none;">
    <p class="servicepage-title">{titleName}</p>
    <p class="servicepage-category-field">{categoryName}</p>
    <div id="goBackServiceInfoButtonId" ontouchstart="goToBackServiceInfoStart()" ontouchend="goToBackServiceInfoEnd()"
         class="servicepage-button-back">
    </div>
    <div type="button" class="servicepage-service-icon"
         style="background-image: url({serviceIcon})"></div>
    <div class="title-bottom-border">
    </div>
  </div>

  <div class="serviceinfo-body-container">
    <div class="serviceinfo-options" if="{type==3}">
      <div class="serviceinfo-option-text-container">
        <div class="serviceinfo-option-text">{optionsHeader}<p if="{!checkIconShow}" style="display:inline">:
          {opts.firstFieldText}</p></div>
      </div>

      <div class="serviceinfo-option-containter" ontouchstart="optionOnTouchStart()"
           ontouchend="optionOnTouchEnd(this.id)"
           each="{i in optionsArray}"
           id="{i.id}">
        <ul class="serviceinfo-option-info-container" style="list-style:none">
          <li class="serviceinfo-option-detail" each="{j in i.option_object}" if="{j.title}">
            <div
              class="{serviceinfo-option-title-text-option:checkIconShow,serviceinfo-option-title-text:!checkIconShow}">
              {j.title}:
            </div>
            <div
              class="{serviceinfo-option-value-text-option:checkIconShow,serviceinfo-option-value-text:!checkIconShow}">
              {j.value}
            </div>
          </li>
        </ul>
        <div id="check{i.id}" class="serviceinfo-option-check-icon" if="{checkIconShow}"></div>
      </div>
    </div>

    <div class="serviceinfo-option-containter">
      <ul class="serviceinfo-option-info-container" if="{type==1}">
        <li class="serviceinfo-option-detail" each="{i in infoArray}">
          <div class="serviceinfo-option-title-text">{i.title}:</div>
          <div class="serviceinfo-option-value-text">{i.value}</div>
        </li>
      </ul>
    </div>

    <button id="serviceinfoButtonNextId"
            class="serviceinfo-button-next"
            ontouchstart="goToNextPageStart()"
            ontouchend="goToNextPageEnd()">
      {window.languages.ViewServiceInfoButtonNextText}
    </button>
  </div>

  <script>

    console.log('OPTS in ServiceInfo NEW', opts);

    window.saveHistory('view-service-info-new', opts);

    var scope = this;

    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    console.log("servicesMap=", scope.servicesMap);
    scope.service = scope.servicesMap[opts.chosenServiceId][0];
    scope.titleName = scope.service.name;
    scope.serviceIcon = scope.service.image;
    scope.categoryName = scope.categoryNamesMap[scope.service.category_id].name;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var payment_data, optionAttribute;
    var timeOutTimer = 0;
    var goBackStartY, goBackStartX, goBackEndY, goBackEndX;
    var optionOnTouchStartY, optionOnTouchStartX, optionOnTouchEndY, optionOnTouchEndX;
    scope.type = 0;
    scope.index = -1;
    if (!opts.transactionId) {
      opts.transactionId = parseInt(Date.now() / 1000);
      console.log('TRANSACTION_ID FROM OPTS', JSON.stringify(opts))
    }

    if (opts.formtype == 1) {
      payment_data = {
        "param": opts.firstFieldId,
        "value": opts.firstFieldText,
        "transaction_id": opts.transactionId
      };
    }
    else if (opts.formtype == 2) {
      payment_data = {
        "pin_param": opts.cardTypeId,
        "transaction_id": opts.transactionId
      };
    }
    else if (opts.formtype == 3 || opts.formtype == 5 || opts.formtype == 6) {
      payment_data = {
        "param": opts.firstFieldId,
        "value": opts.firstFieldText,
        "communal_param": opts.communalParam,
        "transaction_id": opts.transactionId
      };
      if (opts.formtype == 6) {
        payment_data = {
          "param": opts.chosenPrefixId,
          "value": opts.chosenPrefixName + opts.firstFieldText,
          "transaction_id": opts.transactionId
        }
      }
      console.log("payment data ", payment_data);
    }
    else if (opts.formtype == 4) {
      payment_data = {
        "param": opts.firstFieldId,
        "value": opts.firstFieldText,
        "internet_package_param": opts.internetPackageParam,
        "transaction_id": opts.transactionId
      };
    }

    window.startSpinner();

    console.log("enable_information_cache", localStorage.getItem('click_client_infoCacheEnabled'))

    if (localStorage.getItem('click_client_infoCacheEnabled') && !JSON.parse(localStorage.getItem('click_client_infoCacheEnabled'))) {
      console.log("get information")
      getInformation();
    }
    else {
      scope.serviceData = JSON.parse(localStorage.getItem("click_client_infoCached"));

      window.stopSpinner();

      console.log("Displaying cached info")
      if (scope.serviceData.information_type == 3) {
        for(var j=0;j<scope.serviceData.options.length;j++)
        {
          scope.serviceData.options[j].id=j;
        }
        scope.optionsArray = scope.serviceData.options;
        scope.optionsHeader = scope.serviceData.options_header;
        scope.checkIconShow = scope.serviceData.options.length > 1;
        optionAttribute = scope.serviceData.options[0].option_payment_attribute;
        opts.paymentDataAttributes = scope.serviceData.options[0].payment_data_attributes;
        //find array in cached data
        for (var i in scope.serviceData.options[0].option_object) {
          if (scope.serviceData.options[0].option_object[i].constructor === Array) {
            console.log(scope.serviceData.options[0].option_object[i]);
            opts.code = scope.serviceData.options[0].option_object[i][0];
          }
        }
        opts.optionAttribute = optionAttribute;
        opts.optionValue = scope.checkIconShow ? null : scope.serviceData.options[0].option_value;
        scope.type = 3;
        scope.update();
      } else if (scope.serviceData.information_type == 1 || scope.serviceData.information_type == 4) {
        scope.infoArray = scope.serviceData.information_object;
        scope.type = 1;
        scope.update();
      }

    }

    function getInformation() {
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
          console.log('Clearing timer onSuccess', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          if (result[0][0].error == 0) {
            if (result[1]) {
              localStorage.setItem('click_client_infoCacheEnabled', result[1][0].enable_information_cache);
              if (result[1][0].enable_information_cache)
                localStorage.setItem("click_client_infoCached", JSON.stringify(result[1][0]));
              scope.serviceData = result[1][0];
              if (result[1][0].information_type == 3) {
                for(var j=0;j<scope.serviceData.options.length;j++)
                {
                  scope.serviceData.options[j].id=j;
                }
                scope.optionsArray = result[1][0].options;
                scope.optionsHeader = result[1][0].options_header;
                scope.checkIconShow = result[1][0].options.length > 1;
                optionAttribute = result[1][0].options[0].option_payment_attribute;
                opts.paymentDataAttributes = result[1][0].options[0].payment_data_attributes;
                //find array in result
                for (var i in result[1][0].options[0].option_object) {
                  if (result[1][0].options[0].option_object[i].constructor === Array) {
                    console.log(result[1][0].options[0].option_object[i]);
                    opts.code = result[1][0].options[0].option_object[i][0];
                  } else if (result[1][0].options[0].option_object[i].code == 'AMOUNT' && opts.formtype == 6) {
                    console.log("formType 6 amount field = ", result[1][0].options[0].option_object[i].value);
                    opts.amountText = result[1][0].options[0].option_object[i].value;

                  }

                }
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
            scope.errorMessage = result[0][0].error_note;
            scope.stepAmount = 1;
            window.common.alert.show("componentUnsuccessId", {
              parent: scope,
              step_amount: scope.stepAmount,
              operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
              operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
              operationmessagepartthree: scope.errorMessage
            });
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          scope.stepAmount = 1;
          window.common.alert.show("componentUnsuccessId", {
            parent: scope,
            step_amount: scope.stepAmount,
            operationmessagepartone: window.languages.ComponentUnsuccessMessagePart1,
            operationmessageparttwo: window.languages.ComponentUnsuccessMessagePart2,
            operationmessagepartthree: api_status_message
          });
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'get.additional.information'
            });
            scope.errorNote = "Сервис временно недоступен";
            scope.stepAmount = 1;
            scope.update();

            window.common.alert.show("componentAlertId", {
              parent: scope,
              step_amount: scope.stepAmount,
              viewmount: true,
              errornote: scope.errorNote,
            });
            window.stopSpinner();
          }, 15000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      }, 15000);
    }


    goToBackServiceInfoStart = function () {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById("goBackServiceInfoButtonId").style.webkitTransform = 'scale(0.7)';

      goBackStartY = event.changedTouches[0].pageY;
      goBackStartX = event.changedTouches[0].pageX;

    };

    goToBackServiceInfoEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById("goBackServiceInfoButtonId").style.webkitTransform = 'scale(1)';

      goBackEndY = event.changedTouches[0].pageY;
      goBackEndX = event.changedTouches[0].pageX;

      if (Math.abs(goBackStartY - goBackEndY) <= 20 && Math.abs(goBackStartX - goBackEndX) <= 20) {

        onBackKeyDown();
        scope.unmount()
      }
    };

    optionOnTouchStart = function () {
      event.stopPropagation();
      optionOnTouchStartY = event.changedTouches[0].pageY;
      optionOnTouchStartX = event.changedTouches[0].pageX;
    };

    optionOnTouchEnd = function (id) {
      event.stopPropagation();

      optionOnTouchEndY = event.changedTouches[0].pageY;
      optionOnTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(optionOnTouchStartY - optionOnTouchEndY) <= 20 && Math.abs(optionOnTouchStartX - optionOnTouchEndX) <= 20) {

        if (scope.index != -1 && scope.index != id)
          document.getElementById("check" + scope.index).style.backgroundImage = "url(resources/icons/ViewService/radio_unselected.png)";
        document.getElementById("check" + id).style.backgroundImage = "url(resources/icons/ViewService/radio_selected.png)";
        var option_id=scope.serviceData.options[parseInt(id)].option_value;
        scope.index = option_id;
        opts.optionValue = option_id;
        opts.payment_data_attributes =scope.serviceData.options[parseInt(id)].payment_data_attributes;
      }
    };

    goToNextPageStart = function () {
      serviceinfoButtonNextId.style.webkitTransform = 'scale(0.8)';
    };

    goToNextPageEnd = function () {
      serviceinfoButtonNextId.style.webkitTransform = 'scale(1)';

      if (scope.index == -1 && scope.serviceData.information_type == 3 && scope.checkIconShow) {

        scope.clickPinError = false;
        scope.errorNote = "Выберите из вариантов";

        window.common.alert.show("componentAlertId", {
          parent: scope,
          clickpinerror: scope.clickPinError,
          step_amount: scope.stepAmount,
          viewpage: scope.viewPage,
          viewmount: true,
          errornote: scope.errorNote
        });

        scope.update();
      } else {
        if (opts.formtype == 5) {
          console.log("opts to send ", opts)
          this.riotTags.innerHTML = "<view-service-additional-info>";
          riot.mount('view-service-additional-info', opts);
          scope.unmount()
        } else {
          this.riotTags.innerHTML = "<view-service-pincards-new>";
          riot.mount('view-service-pincards-new', opts);
          scope.unmount()
        }
      }

    };


  </script>
</view-service-info-new>

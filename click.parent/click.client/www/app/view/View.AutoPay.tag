<view-auto-pay class="riot-tags-main-container">
  <div class="pay-page-title">
    <p class="pay-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    <div id="rightButton" ontouchend="addAutoPay()" class="settings-friend-help-add-button"></div>
  </div>

  <div class="view-autopay-container" if="{false}">
    <div class="view-autopay-block-containter" each="{j in autopayList}">
      <div id="{j.id}" class="view-autopay-block-inner-containter" ontouchstart="onTouchStartOfAutoPayment()"
           ontouchend="onTouchEndOfAutoPayment(this.id)">
        <div class="view-autopay-icon" style="background-image: url({j.service_icon});"></div>
        <div class="view-autopay-info-container">
          <p class="view-autopay-info-name">{j.service_title}</p>
          <div class="view-autopay-info-balance">{j.amount}</div>
          <div class="view-autopay-info-currency-field">сум</div>
          <p class="view-autopay-info-condition">{j.condition_text}</p>
          <p class="view-autopay-info-number">{j.cntrg_param2}</p>
        </div>
      </div>
      <div class="view-autopay-next-icon"></div>
    </div>
  </div>
  <div class="view-autopay-container" if="{true}">
    <div class="component-card-upper-container">
      <div class="component-card-upper-icon-in"
           style="background-image: url('resources/icons/ViewAutoPay/autopayment_empty.png');background-size: 50%;background-position-y: 50%;"></div>
    </div>
    <div class="component-card-lower-container">
      <p class="component-card-lower-title-text">Title</p>
      <p class="component-card-lower-body-text">Text text</p>
    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    this.titleName = window.languages.ViewAutoPayTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-auto-pay') {
      history.arrayOfHistory.push(
        {
          "view": 'view-auto-pay',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    alert("VGFTYVFYUI");


    goToBack = function () {
      viewServicePage.phoneText = null;
      viewServicePage.amountText = null;
      localStorage.setItem('autoPayData', null);
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };

    addAutoPay = function () {
      event.preventDefault();
      event.stopPropagation();
      opts.mode = 'ADDAUTOPAY';
      riotTags.innerHTML = "<view-pay>";
      riot.mount("view-pay", opts);
      scope.unmount()
    }

    componentMenu.check = false;
    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;


    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    scope.servicesMap = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    localStorage.setItem('autoPayData', null);
    if (info)
      var sessionKey = info.session_key;


    scope.autopayList = [];
    window.api.call({
      method: 'autopay.list',
      input: {
        phone_num: phoneNumber,
        session_key: sessionKey,
      },

      scope: this,

      onSuccess: function (result) {
        if (result[0][0].error == 0) {

          for (var i in result[1]) {

            result[1][i].service_title = scope.servicesMap[result[1][i].service_id][0].name;
            result[1][i].service_icon = scope.servicesMap[result[1][i].service_id][0].image;
            result[1][i].form_type = scope.servicesMap[result[1][i].service_id][0].form_type;

            if (result[1][i].type && result[1][i].autopay_type == 1) {
              if (result[1][i].type == 2) {
                result[1][i].condition_text = window.languages.ViewAutoPayMethodScheduleWeekDaysArray[(result[1][i].week_day) - 1].v + ", " +
                  result[1][i].paytime;
              } else if (result[1][i].type == 3) {
                result[1][i].condition_text = result[1][i].month_day + ", " +
                  result[1][i].paytime;
              } else if (result[1][i].type == 4) {
                result[1][i].condition_text = window.languages.ViewAutoPayEveryMonthLastDayTextTwo + ", " +
                  result[1][i].paytime;
              }
            } else if (result[1][i].autopay_type == 2) {
//                console.log("autopay type 2");
              for (var j in scope.servicesMap[result[1][i].service_id][0].autopay_available_steps)
                if (scope.servicesMap[result[1][i].service_id][0].autopay_available_steps[j].step_value == result[1][i].step) {
                  result[1][i].condition_text = window.languages.ViewAutoPayAfterMinimumBalansText + scope.servicesMap[result[1][i].service_id][0].autopay_available_steps[j].step_title;
//                    console.log("STep title=", scope.servicesMap[result[1][i].service_id][0].autopay_available_steps[j].step_title);
                  break;
                }
            }
//              console.log("ss", result[1][i].service_title, ", dd", result[1][i].service_icon);
            scope.autopayList.push(result[1][i]);
          }
//            console.log("L=", result[1]);
//            scope.autopayList = result[1];
          console.log("Autopay list", scope.autopayList);
          scope.update(scope.autopayList);
          localStorage.setItem('click_client_autopayList', JSON.stringify(scope.autopayList));
        }
        else
          alert(result[0][0].error_note);
      },

      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

    onTouchStartOfAutoPayment = function () {
      event.stopPropagation();
      autoPayOnTouchStartY = event.changedTouches[0].pageY;
      autoPayOnTouchStartX = event.changedTouches[0].pageX;
    }


    onTouchEndOfAutoPayment = function (id) {
      event.stopPropagation();

      autoPayOnTouchEndY = event.changedTouches[0].pageY;
      autoPayOnTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if (Math.abs(autoPayOnTouchStartY - autoPayOnTouchEndY) <= 20 && Math.abs(autoPayOnTouchStartX - autoPayOnTouchEndX) <= 20) {
        console.log("autoPayment ID to open=", id);
        for (var i in scope.autopayList) {
          if (scope.autopayList[i].id == id) {
            scope.autoPayData = {};
            scope.autoPayData.id = id;
            viewPay.chosenServiceId = scope.autopayList[i].service_id;
            scope.autoPayData.service_id = scope.autopayList[i].service_id;
            scope.autoPayData.name = scope.autopayList[i].name;// autoPayNameInput.value;
            scope.autoPayData.autopay_type = scope.autopayList[i].autopay_type; //1;
            scope.autoPayData.amount = scope.autopayList[i].amount; //scope.chosenAmount;
            scope.autoPayData.isNew = false;
            scope.autoPayData.cntrg_phone_num = scope.autopayList[i].cntrg_param2; //firstFieldInput.value;
            scope.autoPayData.condition_text = scope.autopayList[i].condition_text;
            var amountText = {"amountText": scope.autopayList[i].amount};


            if (scope.autopayList[i].autopay_type == 2) {
              scope.autoPayData.step = scope.autopayList[i].step;//chosenStep;

              scope.autoPayData.title = window.languages.ViewAutoPayMethodEventText;
              localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

              var formtype = {"formtype": 1};
              var firstFieldId = {"firstFieldId": 1};
              var firstFieldText = {"firstFieldText": scope.autopayList[i].cntrg_param2};
              var cardTypeId = {"cardTypeId": null};
              var communalParam = {"communalParam": null};
              var internetPackageParam = {"internetPackageParam": null};


              viewServicePage.firstFieldTitle = "Номер абонента";
              viewServicePage.phoneText = scope.autopayList[i].cntrg_param2;
              var isInFavorites = {"isInFavorites": false};

            } else if (scope.autopayList[i].autopay_type == 1) {
              scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
              localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

              if (scope.autopayList[i].form_type == 3) {
                var internetPackageParam = {"internetPackageParam": null};
                var communalParam = {"communalParam": scope.autopayList[i].cntrg_param5};
              } else if (scope.autopayList[i].form_type == 1) {
                var communalParam = {"communalParam": null};
                var internetPackageParam = {"internetPackageParam": null};
              } else if (scope.autopayList[i].form_type == 4) {
                var communalParam = {"communalParam": null};
                var internetPackageParam = {"internetPackageParam": scope.autopayList[i].cntrg_param5};
              }

              var formtype = {"formtype": scope.autopayList[i].form_type};
              var firstFieldId = {"firstFieldId": 2};
              var firstFieldText = {"firstFieldText": scope.autopayList[i].cntrg_param2};
              var cardTypeId = {"cardTypeId": scope.autopayList[i].cntrg_param5};

              viewServicePage.firstFieldTitle = "Номер абонента";
              viewServicePage.phoneText = scope.autopayList[i].cntrg_param2;
              var isInFavorites = {"isInFavorites": false};

            }

            var paramsArray = [formtype, firstFieldId, firstFieldText, cardTypeId, communalParam, amountText, internetPackageParam, isInFavorites];

            this.riotTags.innerHTML = "<view-pay-confirm>";
            riot.mount('view-pay-confirm', [paramsArray, true, scope.autopayList[i].account_id, 'ADDAUTOPAY']);
            scope.unmount()

          }
        }
      }
    };

    //    window.api.call({
    //      method: 'get.terms',
    //      input: {
    //        session_key: sessionKey,
    //        phone_num: phoneNumber,
    //
    //      },
    //
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        console.log('get.terms', result)
    //        if (result[0][0].error == 0) {
    //          console.log("get.terms", result);
    //        }
    //        else
    //          alert(result[0][0].error_note);
    //      },
    //
    //      onFail: function (api_status, api_status_message, data) {
    //        console.log('get.terms')
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });
    //
    //    window.api.call({
    //      method: 'settings.change.visibility',
    //      input: {
    //        session_key: sessionKey,
    //        phone_num: phoneNumber,
    //        visibility: 0,
    //
    //      },
    //
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        console.log('settings.change.visibility', result)
    //        if (result[0][0].error == 0) {
    //          console.log("settings.change.visibility", result);
    //        }
    //        else
    //          alert(result[0][0].error_note);
    //      },
    //
    //      onFail: function (api_status, api_status_message, data) {
    //        console.log('settings.change.visibility')
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });
    //
    //    window.api.call({
    //      method: 'settings.change.profile.data',
    //      input: {
    //        session_key: sessionKey,
    //        phone_num: phoneNumber,
    //        firstname: 'BKB',
    //        lastname: lName,
    //        gender: gender,
    //
    //      },
    //
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        console.log('settings.change.profile.data', result)
    //        if (result[0][0].error == 0) {
    //          console.log("settings.change.profile.data", result);
    //        }
    //        else
    //          alert(result[0][0].error_note);
    //      },
    //
    //      onFail: function (api_status, api_status_message, data) {
    //        console.log('settings.change.profile.data')
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });
    //
    //
    //    window.api.call({
    //      method: 'history.chart.data',
    //      input: {
    //        session_key: sessionKey,
    //        phone_num: phoneNumber,
    //
    //      },
    //
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        console.log('history.chart.data', result)
    //        if (result[0][0].error == 0) {
    //          console.log("result of history.chart.data' ", result);
    //        }
    //        else
    //          alert(result[0][0].error_note);
    //      },
    //
    //      onFail: function (api_status, api_status_message, data) {
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });
    //
    //    var timeStamp = parseInt(Date.now() / 1000);
    //    var sign_string = hex_md5(phoneNumber.substring(0, 5) + timeStamp + phoneNumber.substring(phoneNumber.length - 4, phoneNumber.length));
    //    window.api.call({
    //      method: 'pin.reset',
    //      input: {
    //        timestamp: timeStamp,
    //        phone_num: phoneNumber,
    //        sign_string: sign_string
    //
    //      },
    //
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        console.log('pin.reset', result)
    //        if (result[0][0].error == 0) {
    //          console.log("result of PIN RESET ", result);
    //        }
    //        else
    //          alert(result[0][0].error_note);
    //      },
    //
    //      onFail: function (api_status, api_status_message, data) {
    //        console.log('pin.reset')
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });


  </script>
</view-auto-pay>

<view-auto-pay>
  <div class="pay-page-title">
    <p class="pay-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    <div id="rightButton" ontouchend="addAutoPay()" class="settings-friend-help-add-button"></div>
  </div>

  <div class="view-autopay-container">
    <div class="view-autopay-block-containter" each="{j in autopayList}">
      <div id="{j.id}" class="view-autopay-block-inner-containter"
           ontouchend="openAutoPayment(this.id)">
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

    this.on('mount', function () {
    })

    goToBack = function () {
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
    if (info)
      var sessionKey = info.session_key;

    scope.autopayList = JSON.parse(localStorage.getItem('click_client_autopayList'));

    //    if (scope.favoritePaymentsList) {
    ////      console.log("favorite list", scope.favoritePaymentsList);
    //      scope.favPaymentsList = [];
    //      for (var i in scope.favoritePaymentsList) {
    //        if (scope.favPaymentsList.length < 4) {
    //          if (scope.favoritePaymentsList[i].opts[1].firstFieldId == '1') {
    //            var firstField = scope.favoritePaymentsList[i].opts[2].firstFieldText.toString();
    //            console.log(scope.favoritePaymentsList[i].opts[5])
    //            if (scope.favoritePaymentsList[i].opts[5] && scope.favoritePaymentsList[i].opts[5].amountText)
    //              scope.favoritePaymentsList[i].opts[5].amountText = window.amountTransform(scope.favoritePaymentsList[i].opts[5].amountText)
    //            if (firstField.length == 9) {
    //              firstField = '+' + window.languages.CodeOfCountry + ' ' + firstField.substr(0, 2) + ' ' + firstField.substr(2, 3) + ' ' + firstField.substr(5, 2) + ' ' +
    //                firstField.substr(7, 2);
    //            }
    //            scope.favoritePaymentsList[i].opts[2].firstFieldText = firstField;
    //          }
    //          scope.favPaymentsList.push(scope.favoritePaymentsList[i]);
    //        }
    //
    //        else break;
    //      }
    ////      console.log("favorites=", scope.favPaymentsList);
    //      riot.update(scope.favPaymentsList);
    //    }

    if (scope.autopayList) {
      console.log("Autopay list", scope.autopayList);
      scope.update(scope.autopayList);
    }
    else {
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
    }

    openAutoPayment = function (id) {
      console.log("autoPayment ID to open=", id);
      for (var i in scope.autopayList) {
        if (scope.autopayList[i].id == id) {
          scope.autoPayData = {};
          scope.autoPayData.id = id;
          viewPay.chosenServiceId = scope.autopayList[i].service_id;
          scope.autoPayData.service_id = scope.autopayList[i].service_id;
          scope.autoPayData.name = scope.autopayList[i].name;// autoPayNameInput.value;
          scope.autoPayData.autopay_type = scope.autopayList[i].autopay_type; //1;
          scope.autoPayData.isNew = false;

          if (scope.autopayList[i].autopay_type == 2) {
            console.log("WWW");
            scope.autoPayData.step = scope.autopayList[i].step;//chosenStep;
            scope.autoPayData.cntrg_phone_num = scope.autopayList[i].cntrg_param2; //firstFieldInput.value;
            scope.autoPayData.amount = scope.autopayList[i].amount; //scope.chosenAmount;
            scope.autoPayData.condition_text = scope.autopayList[i].condition_text;
            scope.autoPayData.title = window.languages.ViewAutoPayMethodEventText;
            localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));

            var formtype = {"formtype": 1};
            var firstFieldId = {"firstFieldId": 1};
            var firstFieldText = {"firstFieldText": scope.autopayList[i].cntrg_param2};
            var cardTypeId = {"cardTypeId": null};
            var communalParam = {"communalParam": null};
            var internetPackageParam = {"internetPackageParam": null};
            var amountText = {"amountText": scope.autopayList[i].amount};

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

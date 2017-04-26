<view-auto-pay>
  <div class="pay-page-title">
    <p class="pay-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    <div id="rightButton" ontouchend="addAutoPay()" class="settings-friend-help-add-button"></div>
  </div>

  <div class="view-autopay-container">
    <div class="view-autopay-block-containter" each="{j in autopayList}">
      <div id="p{j.id}" class="view-autopay-block-inner-containter"
           ontouchend="openFavoritePayment(this.id)">
        <div class="view-autopay-icon" style="background-image: url({j.service_icon});"></div>
        <div class="view-autopay-info-container">
          <p class="view-autopay-info-name">{j.service_title}</p>
          <div class="view-autopay-info-balance">{j.amount}</div>
          <div class="view-autopay-info-currency-field">сум</div>
          <p class="view-autopay-info-condition">{j.service_title}</p>
          <p class="view-autopay-info-number">{j.cntrg_param2}</p>
        </div>
      </div>
      <div id="{j.id}" class="view-autopay-next-icon" ontouchend="removeFromFavorites(this.id)"></div>
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
    };

    addAutoPay = function () {
      event.preventDefault();
      event.stopPropagation();
      opts.mode = 'ADDAUTOPAY';
      riotTags.innerHTML = "<view-pay>";
      riot.mount("view-pay", opts);
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
      riot.update(scope.autopayList);
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

              console.log("ss", result[1][i].service_title, ", dd", result[1][i].service_icon);

              scope.autopayList.push(result[1][i]);

            }
            console.log("L=", result[1]);
//            scope.autopayList = result[1];
            console.log("Autopay list", scope.autopayList);
            riot.update(scope.autopayList);
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

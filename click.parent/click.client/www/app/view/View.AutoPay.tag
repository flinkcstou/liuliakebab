<view-auto-pay>
  <div class="pay-page-title">
    <p class="pay-name-title">{titleName}</p>
    <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
    <div id="rightButton" ontouchend="addFavorite()" class="settings-friend-help-add-button"></div>
  </div>

  <div class="view-favorites-container">
    <div class="view-favorites-block-containter" each="{j in autopayList}">
      <div id="p{j.service.id}" class="view-favorites-block-inner-containter"
           ontouchend="openFavoritePayment(this.id)">
        <div class="view-favorites-icon"
        ></div>
        <div class="view-favorites-info-container">
          <p class="view-favorites-info-name">{j.service_name}</p>
          <div class="view-favorites-info-balance">{j.amountText}</div>
          <div class="view-favorites-info-currency-field">сум</div>
          <p class="view-favorites-info-number">{j.firstFieldText}</p>
        </div>
      </div>
      <div id="{j.service.id}" class="view-favorites-delete-icon" ontouchend="removeFromFavorites(this.id)"></div>
    </div>
  </div>

  <script>

    this.titleName = window.languages.ComponentBankOperationsAutoPay;

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

    componentMenu.check = false;
    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;


    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
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

    if (!scope.autopayList)
      window.api.call({
        method: 'autopay.list',
        input: {
          phone_num: phoneNumber,
          session_key: sessionKey,

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log("Autopay list", result[1]);
            localStorage.setItem('click_client_autopayList', JSON.stringify(result[1]));

          }
          else
            alert(result[0][0].error_note);
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

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

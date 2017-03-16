<view-report>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}"
                        style="border: none;">
  </component-page-title>

  <div class="view-reports-months-container">
    <div class="view-reports-month-info-container" each="{i in monthsArray}"
         style="left:{leftOfOperations*i.count + 50}px;">
      <p class="view-reports-month-info-name">{i.name}</p>
    </div>
  </div>

  <div class="view-reports-body-container">

    <div class="view-reports-payment-date-containter">
      <div class="view-reports-payment-date-field">18 февраля 2017</div>
    </div>

    <div class="view-reports-payment-block-containter" each="{i in paymentsList}">
      <div class="view-reports-payment-icon"
           style="background-image: url({i.image})"></div>

      <div class="view-reports-payment-info-container">
        <p class="view-reports-payment-info-name">{i.service_name}</p>
        <p class="view-reports-payment-info-balance">{i.amount}</p>
        <p class="view-reports-payment-info-balance">{}</p>
        <p class="view-reports-payment-info-number">{i.cntrg_info_param2}</p>
      </div>

      <div class="settings-block-next-icon"></div>
    </div>


  </div>

  <script>
    this.titleName = 'ОТЧЕТЫ';

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-report') {
      history.arrayOfHistory.push(
        {
          "view": 'view-report',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.leftOfOperations = 350 * widthK;

    sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    console.log("monthsArray", scope.monthsArray);
    riot.update(scope.monthsArray);

    scope.paymentsList = [];

    window.api.call({
      method: 'get.payment.list',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,
      },
      scope: this,

      onSuccess: function (result) {
        console.log(result)
        console.log(result[0][0])
        if (result[0][0].error == 0) {
          for (var i in result[1]) {
            scope.paymentsList.push(result[1][i])
          }
          riot.update(scope.paymentsList)
          console.log('scope.paymentsList', scope.paymentsList);
        }
        else {
          alert(result[0][0].error_note);
        }

      },
      onFail: function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    });

  </script>
</view-report>

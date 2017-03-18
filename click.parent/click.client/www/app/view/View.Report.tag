<view-report>

  <div class="page-title" style="border: none;">
    <p class="name-title">{titleName}</p>
    <div id="backButton" ontouchend="touchStartTitle()"
         class="back-button">
    </div>
    <div class="view-reports-filter-container">
      <p class="view-reports-filter-text">Фильтры</p>
      <div type="button" class="view-reports-filter-button" ontouchend="filter()"></div>
    </div>
    <div id="graphButtonId" type="button" class="view-reports-graph-button" ontouchend="graphView()"></div>
  </div>


  <div id="monthContainerId" class="view-reports-months-container" ontouchstart="monthContainerTouchStart()"
       ontouchend="monthContainerTouchEnd()"
       ontouchmove="monthContainerTouchMove()">
    <div class="view-reports-month-info-container" each="{i in monthsArray}"
         style="left:{leftOfOperations*i.count}px;">
      <p class="view-reports-month-info-name">{i.name}</p>
    </div>
  </div>


  <div class="view-reports-body-container" if="{firstReportView}">
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
      <p class="view-reports-payment-info-time">18:31</p>
    </div>
  </div>


  <div class="view-reports-body-container" if="{!firstReportView}">


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

    touchStartTitle = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
    };


    scope = this;
    scope.leftOfOperations = 320 * widthK;
    scope.firstReportView = true;
    var mNumber;
    var count = 12;
    localStorage.setItem('click_client_countCard', count);


    if (!mNumber) {
      mNumber = 0;
    }

    graphView = function () {
      scope.firstReportView = !scope.firstReportView;
      riot.update(scope.firstReportView);

      if (scope.firstReportView)
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_off.png)";
      else
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_on.png)";
    }

    sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    console.log("monthsArray", scope.monthsArray);
    riot.update(scope.monthsArray);

    scope.paymentsList = [];

    var date = new Date();
    var firstDay = new Date(date.getFullYear(), mNumber, 1);
    var lastDay = new Date(date.getFullYear(), mNumber + 1, 0);
    console.log("firstDay=", firstDay);
    console.log("lastDay=", lastDay);

    window.api.call({
      method: 'get.payment.list',
      input: {
        session_key: sessionKey,
        phone_num: phoneNumber,
        date_start: convertDate(firstDay),
        date_end: convertDate(lastDay)
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
          console.log('QQQQQQQQ', scope.paymentsList);
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

    //    window.api.call({
    //      method: 'history.chart.data',
    //      input: {
    //        session_key: sessionKey,
    //        phone_num: phoneNumber,
    //
    //      },
    //      scope: this,
    //
    //      onSuccess: function (result) {
    //        console.log(result)
    //        console.log(result[0][0])
    //        if (result[0][0].error == 0) {
    //          for (var i in result[1]) {
    //            scope.paymentsList.push(result[1][i])
    //          }
    //          riot.update(scope.paymentsList)
    //          console.log('history chart data', result);
    //        }
    //        else {
    //          alert(result[0][0].error_note);
    //        }
    //
    //      },
    //      onFail: function (api_status, api_status_message, data) {
    //        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //        console.error(data);
    //      }
    //    });

    monthContainerTouchStart = function () {
      console.log("in start touch=", mNumber);
      carouselTouchStartX = event.changedTouches[0].pageX;
      left = -((320 * mNumber) * widthK) - carouselTouchStartX;
      delta = left;
    }

    monthContainerTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 20) {
        changePosition();
      }
    }


    monthContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      this.monthContainerId.style.transition = '0s';
      this.monthContainerId.style.webkitTransition = '0s';
      this.monthContainerId.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
      this.monthContainerId.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";

    }

    function changePosition() {
      console.log("number before change", mNumber);

      if (carouselTouchEndX < carouselTouchStartX && mNumber < count - 1) {
        ++mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        console.log("1=", mNumber);

      }

      if (carouselTouchEndX > carouselTouchStartX && mNumber == 0) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        console.log("2=", mNumber);
      }

      if (carouselTouchEndX < carouselTouchStartX && mNumber == count - 1) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        console.log("3=", mNumber);

      }

      if (carouselTouchEndX > carouselTouchStartX && mNumber > 0) {
        --mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        console.log("4=", mNumber);
      }


      console.log("!!!!!!!!", mNumber);

      var date = new Date();
      var firstDay = new Date(date.getFullYear(), mNumber, 1);
      var lastDay = new Date(date.getFullYear(), mNumber + 1, 0);
      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);

      scope.paymentsList = [];

      window.api.call({
        method: 'get.payment.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          date_start: convertDate(firstDay),
          date_end: convertDate(lastDay)
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            for (var i in result[1]) {
              scope.paymentsList.push(result[1][i])
            }
            console.log('ASAASASDASDFAAS', scope.paymentsList);
            riot.update(scope.paymentsList)
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


      localStorage.setItem('mNumber', mNumber);
    }


    function convertDate(date) {
      var yyyy = date.getFullYear().toString();
      var mm = (date.getMonth() + 1).toString();
      var dd = date.getDate().toString();

      var mmChars = mm.split('');
      var ddChars = dd.split('');

      return yyyy + '-' + (mmChars[1] ? mm : "0" + mmChars[0]) + '-' + (ddChars[1] ? dd : "0" + ddChars[0]);
    }


  </script>
</view-report>

<view-report>
  <component-report-filter></component-report-filter>
  <div id="reportPageId" class="view-reports-page">
    <div class="page-title" style="border: none;">
      <p class="name-title">{titleName}</p>
      <div id="backButton" ontouchend="touchStartTitle()"
           class="back-button">
      </div>
      <div class="view-reports-filter-container" ontouchend="openFilter()">
        <p class="view-reports-filter-text">Фильтры</p>
        <div type="button" class="view-reports-filter-button"></div>
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
      <div class="view-reports-payments-container" each="{i in paymentDates}">
        <div class="view-reports-payment-date-containter">
          <div class="view-reports-payment-date-field">{i}</div>
        </div>
        <div class="view-reports-payment-block-containter" each="{j in paymentsMap[i]}" id="{j.payment_id}"
             ontouchstart="paymentTouchStart()" ontouchend="paymentTouchEnd(this.id)">
          <div class="view-reports-payment-icon"
               style="background-image: url({j.image})"></div>
          <div class="view-reports-payment-info-container">
            <p class="view-reports-payment-info-name">{j.service_name}</p>
            <div class="view-reports-payment-info-balance">{j.amount}</div>
            <div class="view-reports-payment-info-currency-field">сум</div>
            <p class="view-reports-payment-info-number">{j.cntrg_info_param2}</p>
          </div>
          <p class="view-reports-payment-info-time">{j.paymentTime}</p>
        </div>
      </div>
    </div>

    <div class="view-reports-graph-body-container" if="{!firstReportView}">
      <div class="view-reports-graph-bigamount-container">
        <p class="view-reports-graph-bigamount-text">{paymentsSum} сум</p>
      </div>
      <div class="view-reports-graph-image-container" ontouchstart="monthContainerTouchStart()"
           ontouchend="monthContainerTouchEnd()"
           ontouchmove="monthContainerTouchMove()">
        <div class="view-reports-graph-frame">
          <canvas class="view-reports-graph-frame" id="myChart">
          </canvas>

          <div class="view-reports-graph-percent-image-container" each="{i in arrayOfCoordinates}"
               id="chartImageBlockId{i.order}" if="{i.percent > 10}"
               style="top: {i.y * heightK}px; left: {i.x  * heightK}px; transform: translate3d(-55%, -{i.position}% ,0);">
            <p if="{i.percent > 10}" class="view-reports-graph-percent">{i.percent}%</p>
            <div class="view-reports-graph-image"
                 style="background-image: url({i.image})"></div>
          </div>
        </div>
      </div>
      <div class="view-reports-graph-content-container">
        <div class="view-reports-graph-block-containter" each="{j in graphList}">
          <div class="view-reports-graph-block-icon"
               style="background-image: url({j.image})"></div>
          <div class="view-reports-graph-block-name-field">{j.category_name}</div>
          <div class="view-reports-graph-block-amount-field" style="color: {j.color_hex}">{j.amount}</div>
          <div class="view-reports-graph-block-currency-field" style="color: {j.color_hex}">сум</div>
          <div class="view-reports-graph-block-next-icon"></div>
        </div>
      </div>
    </div>
  </div>

  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

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

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");

      if (!modeOfApp.offlineMode) {
        writeBalance();
      }
    })


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

    scope.firstReportView = !opts.show_graph;


    if (!mNumber) {
      mNumber = new Date().getMonth();

      this.on('mount', function () {
        changePositionTwo();
      });
    }

    openFilter = function () {
      event.stopPropagation();

      componentMenu.checkOpen = true;

      this.filterMenuBackPageId.style.webkitTransition = '0.3s';
      this.reportPageId.style.webkitTransition = '0.3s';
      this.reportPageId.style.zIndex = '-1';
      this.reportPageId.style.opacity = '0.1';
      this.filterMenuId.style.webkitTransition = '0.3s';
      this.filterMenuId.style.transform = "translate3d(0, 0, 0)";
      this.filterMenuId.style.webkitTransform = "translate3d(0, 0, 0)";
      this.filterMenuBackPageId.style.opacity = '1';
    }


    graphView = function () {
      scope.firstReportView = !scope.firstReportView;
      riot.update(scope.firstReportView);

      var date = new Date();
      var firstDay = new Date(date.getFullYear(), mNumber, 1);
      var lastDay = new Date(date.getFullYear(), mNumber + 1, 0);
      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);

      if (scope.firstReportView) {
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_off.png)";
        paymentListUpdate();
      }
      else {
        graphButtonId.style.backgroundImage = "url(resources/icons/ViewReport/reports_chart_on.png)";
        graphListUpdate();
      }
    }

    sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    console.log("monthsArray", scope.monthsArray);
    riot.update(scope.monthsArray);


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

      if (carouselTouchEndX < carouselTouchStartX && mNumber < count - 1) {
        ++mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX > carouselTouchStartX && mNumber == 0) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX < carouselTouchStartX && mNumber == count - 1) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX > carouselTouchStartX && mNumber > 0) {
        --mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (scope.firstReportView) {
        paymentListUpdate();
      } else {
        graphListUpdate();
      }

      localStorage.setItem('mNumber', mNumber);
    }

    function changePositionTwo() {

      if (mNumber < count - 1) {
        ++mNumber;
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (mNumber == 0) {
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (mNumber == count - 1) {
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (mNumber > 0) {
        --mNumber;
        this.monthContainerId.style.transition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.001s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-mNumber * 320) * widthK + 'px' + ", 0, 0)";
      }

      if (scope.firstReportView) {
        paymentListUpdate();
      } else {
        graphListUpdate();
      }

    }


    function convertDate(date) {
      var yyyy = date.getFullYear().toString();
      var mm = (date.getMonth() + 1).toString();
      var dd = date.getDate().toString();

      var mmChars = mm.split('');
      var ddChars = dd.split('');

      return yyyy + '-' + (mmChars[1] ? mm : "0" + mmChars[0]) + '-' + (ddChars[1] ? dd : "0" + ddChars[0]);
    }

    paymentListUpdate = function () {
      var date = new Date();
      var firstDay = new Date(date.getFullYear(), mNumber, 1);
      var lastDay = new Date(date.getFullYear(), mNumber + 1, 0);
      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);

      scope.paymentsMap = {};
      scope.paymentDates = [];
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
            console.log('PAYMENTLIST=', result[1]);
            for (var i in result[1]) {

              console.log("C", result[1][i].payment_id);

              var date = new Date(result[1][i].created);
              var dateStr = date.getDate() + ' ' + window.languages.ViewReportMonthsArrayTwo[date.getMonth()] + ' ' + date.getFullYear();
              if (date.getMinutes() < 10 && date.getHours() < 10) {
                result[1][i].paymentTime = '0' + date.getHours() + ':' + '0' + date.getMinutes();
              } else if (date.getMinutes() < 10 && date.getHours() >= 10) {
                result[1][i].paymentTime = date.getHours() + ':' + '0' + date.getMinutes();
              } else if (date.getMinutes() >= 10 && date.getHours() < 10) {
                result[1][i].paymentTime = '0' + date.getHours() + ':' + date.getMinutes();
              } else {
                result[1][i].paymentTime = date.getHours() + ':' + date.getMinutes();
              }


              if (!scope.paymentsMap[dateStr]) {
                scope.paymentsMap[dateStr] = [];
                scope.paymentDates.push(dateStr);
                scope.paymentsMap[dateStr].push(result[1][i]);
                console.log("A", result[1][i].payment_id);
              }
              else {
                console.log("B", result[1][i].payment_id);
                scope.paymentsMap[dateStr].push(result[1][i]);
              }

              scope.paymentsList.push(result[1][i]);

            }
            console.log('ASAASASDASDFAAS', scope.paymentsMap);
            riot.update(scope.paymentDates)
            riot.update(scope.paymentsMap)
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            riot.update();
            componentAlertId.style.display = 'block';
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    graphListUpdate = function () {
      var date = new Date();
      var firstDay = new Date(date.getFullYear(), mNumber, 1);
      var lastDay = new Date(date.getFullYear(), mNumber + 1, 0);
      console.log("firstDay=", firstDay);
      console.log("lastDay=", lastDay);

      scope.graphList = [];
      scope.paymentsSum = 0;
      window.api.call({
        method: 'history.chart.data',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          date_start: convertDate(firstDay),
          date_end: convertDate(lastDay),
          account_id: opts.account_id
        },
        scope: this,

        onSuccess: function (result) {
          console.log(result)
          console.log(result[0][0])
          if (result[0][0].error == 0) {
            for (var i in result[1]) {

              scope.paymentsSum += parseInt(result[1][i].amount.replace(/\s/g, ''));

              scope.graphList.push(result[1][i]);
            }

            scope.paymentsSum = scope.paymentsSum.toString();

            if (scope.paymentsSum.length == 7) {
              scope.paymentsSum = scope.paymentsSum.substring(0, 1) + ' ' +
                  scope.paymentsSum.substring(1, 4) + ' ' + scope.paymentsSum.substring(4, scope.paymentsSum.length)

            }

            if (scope.paymentsSum.length == 6) {
              scope.paymentsSum = scope.paymentsSum.substring(0, 3) + ' ' +
                  scope.paymentsSum.substring(3, scope.paymentsSum.length)

            }

            if (scope.paymentsSum.length == 5) {
              scope.paymentsSum = scope.paymentsSum.substring(0, 2) + ' ' +
                  scope.paymentsSum.substring(2, scope.paymentsSum.length)

            }

            if (scope.paymentsSum.length == 4) {
              scope.paymentsSum = scope.paymentsSum.substring(0, 1) + ' ' +
                  scope.paymentsSum.substring(1, scope.paymentsSum.length)

            }

            riot.update(scope.graphList);
            riot.update(scope.paymentsSum);
            console.log('history chart data', scope.graphList);
            createGraph(scope.graphList);
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            riot.update();
            componentAlertId.style.display = 'block';
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });

    }

    createGraph = function (arrayForGraph) {

      var data = {
        datasets: [
          {
            borderWidth: 0,
            data: [],
            backgroundColor: []
          }]
      };

      var sumOfAngle = 0;
      scope.arrayOfCoordinates = [];
      var j = 0;
      for (var i in arrayForGraph) {
        data.datasets[0].data.push(arrayForGraph[i].percent);
        data.datasets[0].backgroundColor.push(arrayForGraph[i].color_hex);
        var centerOfBlock = parseInt(sumOfAngle) + parseInt(arrayForGraph[i].percent) / 2;
        console.log('CENTER', centerOfBlock)
        var alpha = 3.6 * parseInt(centerOfBlock);
        console.log('ALPHA', alpha)
        sumOfAngle += parseInt(arrayForGraph[i].percent);

        var x = 240 + (170 * Math.sin(alpha / (180 / Math.PI)));
        var y = 240 - (170 * Math.cos(alpha / (180 / Math.PI)));

        var position = 50;
        if (alpha >= 90 && alpha < 270) {
          position = 50;
        }
        else {
          position = 50;
        }
        var width = 160;
        if ((alpha >= 30 && alpha < 125) || (alpha >= 205 && alpha < 335)) {
          width = 100;
        }

        console.log('DATA', data)
        var percent = arrayForGraph[i].percent;
        var coordinates = {
          x: x,
          y: y,
          percent: parseInt(percent),
          image: arrayForGraph[i].image_inner,
          order: j,
          alpha: alpha,
          position: position,
//          width: width
        }
        scope.arrayOfCoordinates.push(coordinates);
        j++;
      }
      riot.update()
      console.log("ARRAY OF COORDINATES", scope.arrayOfCoordinates)
      console.log('DATA', data)
      var ctx = document.getElementById('myChart').getContext('2d');
      var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: data,
            options: {
              cutoutPercentage: 55,
              animateScale: false,
              tooltips: {
                enabled: false
              },
              events: [],

            }
          })
          ;

      for (var i in scope.arrayOfCoordinates) {
        if (document.getElementById('chartImageBlockId' + scope.arrayOfCoordinates[i].order)) {
          document.getElementById('chartImageBlockId' + scope.arrayOfCoordinates[i].order).style.opacity = 1;
          console.log('scope.arrayOfCoordinates[i]', scope.arrayOfCoordinates)
        }
      }
    }

    //    paymentListUpdate();


    var paymentTouchStartY, paymentTouchEndY;

    paymentTouchEnd = function (paymentId) {
      event.preventDefault();
      event.stopPropagation();

      paymentTouchEndY = event.changedTouches[0].pageY;

      console.log('settingsTouchStartY', paymentTouchStartY)
      console.log('settingsTouchEndY', paymentTouchEndY)

      if (Math.abs(paymentTouchStartY - paymentTouchEndY) < 20) {

        for (var i = 0; i < scope.paymentsList.length; i++) {
          if (scope.paymentsList[i].payment_id == paymentId) {
            console.log("service report for=", scope.paymentsList[i]);
            riotTags.innerHTML = "<view-report-service>";
            riot.mount("view-report-service", scope.paymentsList[i]);
            break;
          }
        }
      }

    }

    paymentTouchStart = function () {
      paymentTouchStartY = event.changedTouches[0].pageY;
    }

  </script>
</view-report>

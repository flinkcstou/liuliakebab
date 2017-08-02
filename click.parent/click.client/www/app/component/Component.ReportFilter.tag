<component-report-filter>
  <div id="filterMenuBackPageId" class="side-menu-back-page"></div>

  <div id="filterMenuId"
       class="filter-menu {filter-minor-menu: filterDate || filterAccount, filter-main-menu: !(filterDate || filterAccount)}">

    <div class="filter-menu-inside-button" ontouchend="closeFilter()">
      <p
        class="view-reports-filter-text {filter-inside-text: filterDate || filterAccount, filter-inside-text-main: !(filterDate || filterAccount)}">
        {languages.ComponentReportFilterTitle}</p>
      <div type="button"
           class="view-reports-filter-button {filter-inside-button: filterDate || filterAccount, filter-inside-button-main: !(filterDate || filterAccount)}"></div>
    </div>

    <div class="report-filter-clear-filters-container"
         ontouchend="deleteAccountFilterTouchEnd(), deleteDateFilterTouchEnd()"
         ontouchstart="deleteAccountFilterTouchStart(), deleteDateFilterTouchStart()">
      <p class="report-filter-clear-filters-label">Очистить</p>
      <div class="report-filter-clear-filters-icon"></div>
    </div>

    <div if="{filterAccount}">
      <div class="filter-menu-title">{languages.ComponentReportFilterAccount}</div>
      <div class="filter-menu-body-container">

        <component-pincards filteraccount="true"></component-pincards>

        <button id="readyButtonId" class="report-filter-ready-button" if="{filterDate || filterAccount}"
                ontouchstart="readyButtonTouchStart(this.id)"
                ontouchend="readyButtonTouchEnd(this.id)">
          {languages.ComponentReportFilterReadyButton}
        </button>

      </div>

    </div>

    <div if="{filterDate}">
      <div class="filter-menu-title">{languages.ComponentReportFilterDate}</div>
      <div class="filter-menu-body-container">

        <div class="filter-menu-block-containter" ontouchend="pickDateFrom()">
          <div class="filter-menu-date-icon"
               style="background-image: url('resources/icons/ViewReport/date_from.png')"></div>
          <div class="filter-menu-name-field">{languages.ComponentReportFilterByDateFrom}
            {from_dd}.{from_mm}.{from_yyyy}
          </div>
          <div class="filter-menu-date-next-icon"></div>
        </div>
        <div class="filter-menu-block-containter" ontouchend="pickDateTo()">
          <div class="filter-menu-date-icon"
               style="background-image: url('resources/icons/ViewReport/date_to.png')"></div>
          <div class="filter-menu-name-field">{languages.ComponentReportFilterByDateTo} {to_dd}.{to_mm}.{to_yyyy}</div>
          <div class="filter-menu-date-next-icon"></div>
        </div>

        <div id="todayButtonId" class="filter-menu-block-containter" ontouchstart="setDateStart(this.id)"
             ontouchend="setDate(componentReportFilter.today, this.id)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateToday}</div>
          <div class="{pincard-card-uncheckmark : !todayButton, pincard-card-checkmark : todayButton}"></div>
        </div>
        <div id="yesterdayButtonId" class="filter-menu-block-containter" ontouchstart="setDateStart(this.id)"
             ontouchend="setDate(componentReportFilter.yesterday, this.id)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateYesterday}</div>
          <div class="{pincard-card-uncheckmark : !yesterdayButton, pincard-card-checkmark : yesterdayButton}"></div>
        </div>
        <div id="weekButtonId" class="filter-menu-block-containter" ontouchstart="setDateStart(this.id)"
             ontouchend="setDate(componentReportFilter.currentWeek, this.id)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateWeek}</div>
          <div class="{pincard-card-uncheckmark : !weekButton, pincard-card-checkmark : weekButton}"></div>
        </div>
        <div id="pastWeekButtonId" class="filter-menu-block-containter" ontouchstart="setDateStart(this.id)"
             ontouchend="setDate(componentReportFilter.pastWeek, this.id)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDatePastWeek}</div>
          <div class="{pincard-card-uncheckmark : !pastWeekButton, pincard-card-checkmark : pastWeekButton}"></div>
        </div>
        <div id="monthButtonId" class="filter-menu-block-containter" ontouchstart="setDateStart(this.id)"
             ontouchend="setDate(componentReportFilter.currentMonth, this.id)">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDateCurrentMonth}</div>
          <div class="{pincard-card-uncheckmark : !monthButton, pincard-card-checkmark : monthButton}"></div>
        </div>
        <div id="pastMonthButtonId" class="filter-menu-block-containter" ontouchstart="setDateStart(this.id)"
             ontouchend="setDate(componentReportFilter.pastMonth, this.id)"
             style="border: none;">
          <div class="filter-menu-name-field">{languages.ComponentReportFilterDatePastMonth}</div>
          <div class="{pincard-card-uncheckmark : !pastMonthButton, pincard-card-checkmark : pastMonthButton}"></div>
        </div>

        <button id="secondReadyButtonId" class="report-filter-ready-button" if="{filterDate || filterAccount}"
                ontouchstart="readyButtonTouchStart(this.id)"
                ontouchend="readyButtonTouchEnd(this.id)">
          {languages.ComponentReportFilterReadyButton}
        </button>

      </div>

    </div>

    <div if="{!(filterDate || filterAccount)}" class="report-filter-filters-content-container">
      <div class="report-filter-filter-container">
        <p class="report-filter-filter-title">{languages.ComponentReportFilterByDate}</p>
        <img class="report-filter-filter-plus-icon" src="resources/icons/ViewSettingsFriendHelp/plus.png"
             ontouchend="filterDateTouchEnd()" ontouchstart="filterDateTouchStart()">
        <div class="report-filter-filter-chosen-filter-container">
          <div class="report-filter-filter-info-container" if="{createdDateFilter}">
            <p class="report-filter-filter-info-text">{createdDateFilter}</p>
            <img class="report-filter-filter-delete-icon" src="resources/icons/ViewReport/reports_filters_del.png"
                 ontouchend="deleteDateFilterTouchEnd()" ontouchstart="deleteDateFilterTouchStart()">
          </div>
        </div>
      </div>
      <div class="report-filter-filter-container">
        <p class="report-filter-filter-title">{languages.ComponentReportFilterByAccount}</p>
        <img class="report-filter-filter-plus-icon" src="resources/icons/ViewSettingsFriendHelp/plus.png"
             ontouchend="filterAccountTouchEnd()" ontouchstart="filterAccountTouchStart()">
        <div class="report-filter-filter-chosen-filter-container">
          <div class="report-filter-filter-info-container" if="{createdAccountFilter}">
            <p class="report-filter-filter-info-text">{createdAccountFilter}</p>
            <img class="report-filter-filter-delete-icon" src="resources/icons/ViewReport/reports_filters_del.png"
                 ontouchend="deleteAccountFilterTouchEnd()" ontouchstart="deleteAccountFilterTouchStart()">
          </div>
        </div>
      </div>

      <button id="okButtonId" class="report-filter-ok-button" ontouchstart="attachFiltersStart()"
              ontouchend="attachFiltersEnd()">ok
      </button>
    </div>


  </div>
  <script>
    var scope = this,
      filterDateTouchStartX,
      filterDateTouchEndX,
      filterAccountTouchStartX,
      filterAccountTouchEndX,
      readyButtonTouchStartX,
      readyButtonTouchEndX,
      deleteAccountFilterTouchStartX,
      deleteAccountFilterTouchEndX,
      deleteDateFilterTouchStartX,
      deleteDateFilterTouchEndX,
      date,
      dateFrom,
      dateTo;

    scope.todayButton = false;
    scope.yesterdayButton = false;
    scope.weekButton = false;
    scope.pastWeekButton = false;
    scope.monthButton = false;
    scope.pastMonthButton = false;

    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
    scope.firstName = loginInfo.firstname;
    scope.lastName = loginInfo.lastname;
    scope.photo = loginInfo.profile_image_url;

    scope.filterDate = false;
    scope.filterAccount = false;

    pickDateFrom = function () {

      var currentDate = new Date(),
        verifiedDate;

      var options = {
        date: new Date(),
        mode: 'date',
        androidTheme: 5
      };

      function onSuccess(pickedDate) {

        verifiedDate = pickedDate;

        if (verifiedDate.getTime() > currentDate.getTime()) {

          verifiedDate = currentDate;

        }

        if (dateTo) {

          if (dateTo.getTime() < verifiedDate.getTime()) {

            verifiedDate = dateTo;
          }
        }

        dateFrom = verifiedDate;

        scope.from_dd = dateFrom.getDate();
        scope.from_mm = dateFrom.getMonth() + 1;
        scope.from_yyyy = dateFrom.getFullYear();

        scope.update();
      }

      datePicker.show(options, onSuccess);
    };

    pickDateTo = function () {

      var currentDate = new Date(),
        verifiedDate;

      var options = {
        date: new Date(),
        mode: 'date',
        androidTheme: 5
      };

      function onSuccess(pickedDate) {

        verifiedDate = pickedDate;

        if (verifiedDate.getTime() > currentDate.getTime()) {

          verifiedDate = currentDate;
        }

        if (dateFrom) {

          if (dateFrom.getTime() > verifiedDate.getTime()) {

            verifiedDate = dateFrom;
          }
        }

        dateTo = verifiedDate;

        scope.to_dd = dateTo.getDate();
        scope.to_mm = dateTo.getMonth() + 1;
        scope.to_yyyy = dateTo.getFullYear();

        scope.update();
      };

      datePicker.show(options, onSuccess);
    };

    deleteAccountFilterTouchStart = function () {

      deleteAccountFilterTouchStartX = event.changedTouches[0].pageX;
    };

    deleteAccountFilterTouchEnd = function () {

      deleteAccountFilterTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(deleteAccountFilterTouchEndX - deleteAccountFilterTouchStartX) < 20) {

        scope.createdAccountFilter = "";
        scope.filterByAccount = "";

        scope.update();
      }
    };

    deleteDateFilterTouchStart = function () {

      deleteDateFilterTouchStartX = event.changedTouches[0].pageX;
    };

    deleteDateFilterTouchEnd = function () {

      deleteDateFilterTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(deleteDateFilterTouchEndX - deleteDateFilterTouchStartX) < 20) {

        scope.createdDateFilter = "";
        scope.filterDateFrom = "";
        scope.filterDateTo = "";

        scope.update();
      }
    };

    var dateButtonStartX, dateButtonEndX, dateButtonStartY, dateButtonEndY;

    setDateStart = function (id) {

      document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.8)'

      dateButtonStartX = event.changedTouches[0].pageX;
      dateButtonStartY = event.changedTouches[0].pageY;
    }

    setDate = function (forWhatDate, id) {

      document.getElementById(id).style.backgroundColor = 'transparent'

      dateButtonEndX = event.changedTouches[0].pageX;
      dateButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(dateButtonStartX - dateButtonEndX) <= 20 && Math.abs(dateButtonStartY - dateButtonEndY) <= 20) {

        date = new Date();

        scope.todayButton = false;
        scope.yesterdayButton = false;
        scope.weekButton = false;
        scope.pastWeekButton = false;
        scope.monthButton = false;
        scope.pastMonthButton = false;

        //Filter Date To
        switch (forWhatDate) {

          case componentReportFilter.today:{

            scope.to_dd = date.getDate();
            scope.to_mm = date.getMonth() + 1;
            scope.to_yyyy = date.getFullYear();

            scope.from_dd = date.getDate();
            scope.from_mm = date.getMonth() + 1;
            scope.from_yyyy = date.getFullYear();

            scope.todayButton = true;
            scope.update()
            break;

          }
          case componentReportFilter.currentWeek:{
            var day = date.getDay();

            day = (day) ? (day) : (7);
            day--;

            day = date.getDate() - day;

            date.setDate(day);

            scope.from_dd = date.getDate();
            scope.from_mm = date.getMonth() + 1;
            scope.from_yyyy = date.getFullYear();

            scope.weekButton = true;
            scope.update()

            break;

          }
          case componentReportFilter.currentMonth: {
            scope.to_dd = date.getDate();
            scope.to_mm = date.getMonth() + 1;
            scope.to_yyyy = date.getFullYear();

            scope.monthButton = true;
            scope.update()

            break;
          }
          case componentReportFilter.yesterday: {
            date.setDate(date.getDate() - 1);

            scope.to_dd = date.getDate();
            scope.to_mm = date.getMonth() + 1;
            scope.to_yyyy = date.getFullYear();

            scope.from_dd = date.getDate();
            scope.from_mm = date.getMonth() + 1;
            scope.from_yyyy = date.getFullYear();

            scope.yesterdayButton = true;
            scope.update()

            break;
          }
          case componentReportFilter.pastWeek: {
            day = date.getDay();

            day = (day) ? (day) : (7);

            day = date.getDate() - day;

            date.setDate(day);

            scope.to_dd = date.getDate();
            scope.to_mm = date.getMonth() + 1;
            scope.to_yyyy = date.getFullYear();

            scope.pastWeekButton = true;
            scope.update()

            break;
          }
          case componentReportFilter.pastMonth: {
            date.setDate(0);

            scope.to_dd = date.getDate();
            scope.to_mm = date.getMonth() + 1;
            scope.to_yyyy = date.getFullYear();

            scope.pastMonthButton = true;
            scope.update()

            break;
          }
        }

        //Filter Date From
        switch (forWhatDate) {
          case componentReportFilter.currentMonth: {
            date.setDate(1);

            scope.from_dd = date.getDate();
            scope.from_mm = date.getMonth() + 1;
            scope.from_yyyy = date.getFullYear();

            scope.monthButton = true;
            scope.update()

            break;
          }
          case componentReportFilter.pastWeek: {
            day = date.getDay();

            day = (day) ? (day) : (7);
            day--;

            day = date.getDate() - day;

            date.setDate(day);

            scope.from_dd = date.getDate();
            scope.from_mm = date.getMonth() + 1;
            scope.from_yyyy = date.getFullYear();

            scope.pastWeekButton = true;
            scope.update()

            break;
          }
          case componentReportFilter.pastMonth: {
            date.setDate(1);

            scope.from_dd = date.getDate();
            scope.from_mm = date.getMonth() + 1;
            scope.from_yyyy = date.getFullYear();

            scope.pastMonthButton = true;
            scope.update()

            break;
          }
        }

        scope.update();
      }
    };

    readyButtonTouchStart = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      readyButtonTouchStartX = event.changedTouches[0].pageX;
    };

    readyButtonTouchEnd = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      readyButtonTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(readyButtonTouchEndX - readyButtonTouchStartX) < 20) {

        if (scope.filterDate) {

          scope.filterDateFrom = representDashedDate(scope.from_yyyy, scope.from_mm, scope.from_dd);
          scope.filterDateTo = representDashedDate(scope.to_yyyy, scope.to_mm, scope.to_dd);

          if (scope.from_dd == scope.to_dd) {

            var newDate = new Date();

            if (newDate.getDate() == scope.from_dd) {

              scope.createdDateFilter = languages.ComponentReportFilterTodayText;

            } else if (newDate.getDate() - 1 == scope.from_dd) {

              scope.createdDateFilter = languages.ComponentReportFilterYesterdayText;
            }

          } else {

            scope.createdDateFilter = representDotedDate(scope.from_dd, scope.from_mm, scope.from_yyyy) + " - " + representDotedDate(scope.to_dd, scope.to_mm, scope.to_yyyy);
          }

        } else if (scope.filterAccount) {

          scope.filterByAccount = scope.tags["component-pincards"].getAccountCardId();
          scope.createdAccountFilter = scope.tags["component-pincards"].getAccountCardName();
        }

        scope.filterDate = false;
        scope.filterAccount = false;
        scope.update();
      }
    };

    filterDateTouchStart = function () {

      filterDateTouchStartX = event.changedTouches[0].pageX;
    };

    filterDateTouchEnd = function () {

      filterDateTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(filterDateTouchEndX - filterDateTouchStartX) < 20) {

        date = new Date();

        scope.to_dd = date.getDate();
        scope.to_mm = date.getMonth() + 1;
        scope.to_yyyy = date.getFullYear();

        date.setMonth((scope.to_mm - 1) - 1);

        scope.from_dd = date.getDate();
        scope.from_mm = date.getMonth() + 1;
        scope.from_yyyy = date.getFullYear();

        scope.filterDate = true;
        scope.filterAccount = false;
        scope.update();
      }
    };

    filterAccountTouchStart = function () {

      filterAccountTouchStartX = event.changedTouches[0].pageX;
    };

    filterAccountTouchEnd = function () {

      filterAccountTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(filterAccountTouchEndX - filterAccountTouchStartX) < 20) {

        scope.filterDate = false;
        scope.filterAccount = true;
        scope.update();
      }
    };


    var readyOkButtonStartX, readyOkButtonEndX, readyOkButtonStartY, readyOkButtonEndY;

    attachFiltersStart = function () {

      okButtonId.style.webkitTransform = 'scale(0.8)'

      readyOkButtonStartX = event.changedTouches[0].pageX;
      readyOkButtonStartY = event.changedTouches[0].pageY;
    }


    attachFiltersEnd = function () {

      okButtonId.style.webkitTransform = 'scale(1)'

      readyOkButtonEndX = event.changedTouches[0].pageX;
      readyOkButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(readyOkButtonStartX - readyOkButtonEndX) <= 20 && Math.abs(readyOkButtonStartY - readyOkButtonEndY) <= 20) {

        console.log('PARENT', scope.parent)

        if (event) {
          event.preventDefault();
          event.stopPropagation();
        }
//        componentMenu.checkOpen = false;

        if(!scope.createdDateFilter){
          scope.parent.filterOpen = false;
        }

        scope.filterAccount = false;
        scope.filterDate = false;

        filterMenuId.style.webkitTransition = '0.3s';
        filterMenuBackPageId.style.opacity = '0';
        filterMenuBackPageId.style.webkitTransition = '0';
        filterMenuId.style.webkitTransform = "translate3d(0, -100%, 0)";
        filterMenuId.style.Transform = "translate3d(0, -100%, 0)";
        reportPageId.style.opacity = '1';
        reportPageId.style.zIndex = '0';
        scope.update();

        console.log("ASDASDASD", scope.parent);

        if (scope.parent) {

          if (scope.parent.firstReportView) {

            if (scope.parent.paymentListUpdate) {

              scope.parent.paymentListUpdate('fromFilter');
            }
          } else {

            if (scope.parent.graphListUpdate) {

              scope.parent.graphListUpdate();
            }
          }
        }
      }
    };

    closeFilter = function () {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }

      scope.todayButton = false;
      scope.yesterdayButton = false;
      scope.weekButton = false;
      scope.pastWeekButton = false;
      scope.monthButton = false;
      scope.pastMonthButton = false;
//      componentMenu.checkOpen = false;

      scope.parent.filterOpen = false;

      scope.filterAccount = false;
      scope.filterDate = false;

      filterMenuId.style.webkitTransition = '0.3s';
      filterMenuBackPageId.style.opacity = '0';
      filterMenuBackPageId.style.webkitTransition = '0';
      filterMenuId.style.webkitTransform = "translate3d(0, -100%, 0)";
      filterMenuId.style.Transform = "translate3d(0, -100%, 0)";
      reportPageId.style.opacity = '1';
      reportPageId.style.zIndex = '0';

      scope.filterDateFrom = "";
      scope.filterDateTo = "";

      scope.createdDateFilter = "";
      scope.filterByAccount = "";
      scope.createdAccountFilter = "";

      scope.update();
    };


  </script>
</component-report-filter>
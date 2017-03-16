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

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    console.log("monthsArray", scope.monthsArray);
    riot.update(scope.monthsArray);

  </script>
</view-report>

<view-report>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>


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

  </script>
</view-report>

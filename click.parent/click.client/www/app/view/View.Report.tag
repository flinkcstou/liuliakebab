<view-report>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>


  <script>
    this.titleName = 'ОТЧЕТЫ';
    history.arrayOfHistory.push('view-device');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;

  </script>
</view-report>

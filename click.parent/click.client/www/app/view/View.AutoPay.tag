<view-auto-pay>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>

  <script>
    history.arrayOfHistory.push('view-auto-pay');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
  </script>
</view-auto-pay>

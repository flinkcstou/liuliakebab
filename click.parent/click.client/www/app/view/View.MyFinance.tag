<view-my-finance>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>

  <script>
    var scope = this;

    scope.titleName = 'МОИ ФИНАНСЫ';

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-my-finance') {
      history.arrayOfHistory.push(
        {
          "view": 'view-my-finance',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
  </script>
</view-my-finance>

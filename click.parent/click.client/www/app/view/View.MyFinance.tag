<view-my-finance>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>

  <script>
    var scope = this;

    scope.titleName = 'МОИ ФИНАНСЫ';

    window.saveHistory('view-my-finance', opts);

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
  </script>
</view-my-finance>

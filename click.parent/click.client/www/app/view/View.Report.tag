<view-report>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>

  <ul style="display: inline; width: 100%; height: 40px; position: absolute; top: 100px; border: 1px solid red">
    <li style="display: inline">asd</li>
    <li style="display: inline">bkb</li>
    <li style="display: inline">ult</li>
  </ul>

  <script>
    history.arrayOfHistory.push('view-device');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;

  </script>
</view-report>

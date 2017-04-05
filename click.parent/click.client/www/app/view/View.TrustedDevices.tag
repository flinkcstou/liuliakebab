<view-trusted-devices>

  <div class="trusted-devices-page-title">
    <p class="trusted-devices-title">{languages.ViewTrustedDevicesTitle}</p>
    <div id="backButton" ontouchend="goToBack()" class="trusted-devices-back-button"></div>
  </div>

  <div class="trusted-devices-content-container">
    <div each="{device in devices}" class="trusted-devices-device-info-container">
      <img class="trusted-devices-device-info-icon" src="resources/icons/ViewTrustedDevices/devices_android.png">
      <p class="trusted-devices-device-info-name">Motorola Nexus 6</p>
      <p class="trusted-devices-device-info-date">27.02.2017</p>
      <img class="trusted-devices-device-delete-icon" src="resources/icons/ViewSettingsFriendHelp/delete.png">
    </div>
  </div>

  <script>

    var scope = this;

  </script>

</view-trusted-devices>
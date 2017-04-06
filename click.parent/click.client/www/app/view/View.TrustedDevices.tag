<view-trusted-devices>

  <div class="trusted-devices-page-title">
    <p class="trusted-devices-title">{languages.ViewTrustedDevicesTitle}</p>
    <div id="backButton" ontouchend="goToBack()" class="trusted-devices-back-button"></div>
  </div>

  <div class="trusted-devices-content-container">
    <div each="{device in devices}" class="trusted-devices-device-info-container">
      <div
          class="trusted-devices-device-info-icon-container {trusted-devices-android-device-icon: device.device_type == 1,
                                                              trusted-devices-ios-device-icon: device.device_type == 2,
                                                              trusted-devices-web-device-icon: device.device_type == 3}"></div>
      <div class="trusted-devices-info-container">
        <p class="trusted-devices-device-info-name">{device.device_name}</p>
        <p class="trusted-devices-device-info-date">27.02.2017</p>
        <img class="trusted-devices-device-delete-icon" src="resources/icons/ViewSettingsFriendHelp/delete.png">
      </div>
    </div>
  </div>

  <script>

    var scope = this;



  </script>

</view-trusted-devices>
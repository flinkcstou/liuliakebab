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

    getTrustedDevicesList = function () {


      console.log("GET TRUSTED DEVICES STARTED");


      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;

      window.api.call({
        method: 'settings.get.trusted.devices',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,
        onSuccess: function (result) {

          console.log("GET TRUSTED DEVICES RESPONSE", result);

          if (result[0][0].error == 0) {
            if (result[1]) {
              if (result[1][0]) {
                console.log('TRUSTED DEVICES', result[1]);

                scope.devices = result[1];
                riot.update(scope.devices);
              }
              else {

              }
            }
          }
          else {
            alert(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    getTrustedDevicesList();

  </script>

</view-trusted-devices>
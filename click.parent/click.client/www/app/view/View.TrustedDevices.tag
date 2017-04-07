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
        <p class="trusted-devices-device-info-date">{device.date}</p>
        <img id="{device.device_id}" class="trusted-devices-device-delete-icon"
             ontouchend="deleteDeviceOnTouchEnd(this.id)" ontouchstart="deleteDeviceOnTouchStart()"
             src="resources/icons/ViewSettingsFriendHelp/delete.png">
      </div>
    </div>
  </div>

  <component-alert clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var scope = this,
        deleteTouchStartX,
        deleteTouchEndX,
        deleteTouchStartY,
        deleteTouchEndY;

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
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            riot.update();
            componentAlertId.style.display = 'block';
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    deleteDeviceOnTouchStart = function () {

      deleteTouchStartX = event.changedTouches[0].pageX;
      deleteTouchStartY = event.changedTouches[0].pageY;
    };

    deleteDeviceOnTouchEnd = function (device_id) {

      console.log("DELETE DEVICE FROM TRUSTED STARTED");

      deleteTouchEndX = event.changedTouches[0].pageX;
      deleteTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(deleteTouchEndX - deleteTouchStartX) < 20 &&
          Math.abs(deleteTouchEndY - deleteTouchStartY) < 20) {

        var confirmed = confirm("Вы действительно хотите удалить устройство?");
        if (confirmed == true) {


          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var sessionKey = loginInfo.session_key;

          window.api.call({
            method: 'settings.device.revoke.trust',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              device_id: device_id
            },
            scope: this,
            onSuccess: function (result) {

              console.log("DELETE DEVICE FROM TRUSTED RESPONSE", result);

              if (result[0][0].error == 0) {

                getTrustedDevicesList();
              }
              else {
                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;
                riot.update();
                componentAlertId.style.display = 'block';

              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        }
      } else {

      }
    };

    getTrustedDevicesList();

  </script>

</view-trusted-devices>
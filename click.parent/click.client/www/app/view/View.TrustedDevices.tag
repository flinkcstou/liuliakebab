<view-trusted-devices class="riot-tags-main-container">

  <div class="page-title">
    <p class="name-title">{languages.ViewTrustedDevicesTitle}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
         ontouchend="goToBackEnd()" class="back-button"></div>
    <div class="title-bottom-border">
    </div>
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
        <div id="{device.device_id}" class="trusted-devices-device-delete-icon" role="button"
             aria-label="{window.languages.ViewTrustedDevicesVoiceOverRemove}"
             ontouchend="deleteDeviceOnTouchEnd(this.id)" ontouchstart="deleteDeviceOnTouchStart(this.id)"></div>
      </div>
    </div>
  </div>

  <script>

    var scope = this,
      deleteTouchStartX,
      deleteTouchEndX,
      deleteTouchStartY,
      deleteTouchEndY;


    scope.showError = false;

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

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
              if (result[1].length == 0) {
                scope.devices = []

                scope.update()
              }
              if (result[1][0]) {
                console.log('TRUSTED DEVICES', result[1]);

                scope.devices = result[1];
                scope.update();
              }
              else {

              }
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    };

    deleteDeviceOnTouchStart = function (device_id) {

      document.getElementById(device_id).style.webkitTransform = 'scale(0.7)'

      deleteTouchStartX = event.changedTouches[0].pageX;
      deleteTouchStartY = event.changedTouches[0].pageY;

    };

    deleteDeviceOnTouchEnd = function (device_id) {

      document.getElementById(device_id).style.webkitTransform = 'scale(1)'

      console.log("DELETE DEVICE FROM TRUSTED STARTED");

      deleteTouchEndX = event.changedTouches[0].pageX;
      deleteTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(deleteTouchEndX - deleteTouchStartX) < 20 &&
        Math.abs(deleteTouchEndY - deleteTouchStartY) < 20) {

        scope.confirmNote = "Вы действительно хотите удалить устройство?";
        scope.confirmType = 'local';

        window.common.alert.show("componentConfirmId", {
          "confirmnote": scope.confirmNote,
          "confirmtype": scope.confirmType,
          parent: scope,
        });

        scope.update();

        scope.result = function (bool) {
          console.log(bool)
          if (bool) {
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
                  scope.showError = true;
                  scope.update();
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
          }
        };
      }
    };

    getTrustedDevicesList();

  </script>

</view-trusted-devices>
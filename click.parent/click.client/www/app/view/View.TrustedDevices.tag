<view-trusted-devices class="riot-tags-main-container">

  <div class="page-title">
    <p class="name-title">{languages.ViewTrustedDevicesTitle}</p>
    <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="backButtonTouchStart()"
         ontouchend="backButtonTouchEnd()" class="back-button"></div>
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

    function stopEventPropagation() {
      event.preventDefault();
      event.stopPropagation();
    }

    function setOnTouchStartAnimation(element) {
      if (element !== null)
        element.style.webkitTransform = 'scale(0.8)';
    }

    function setOnTouchEndAnimation(element) {
      if (element !== null)
        element.style.webkitTransform = 'scale(1)';
    }

    function checkElementIsTouched(touchStartX, touchStartY, touchEndX, touchEndY) {
      return Math.abs(touchStartX - touchEndX) <= 20 && Math.abs(touchStartY - touchEndY) <= 20;
    }

    backButtonTouchStart = function () {
      stopEventPropagation();

      setOnTouchStartAnimation(backButton);

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    };

    backButtonTouchEnd = function () {
      stopEventPropagation();

      setOnTouchEndAnimation(backButton);

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (checkElementIsTouched(goBackButtonStartX, goBackButtonStartY, goBackButtonEndX, goBackButtonEndY)) {
        onBackKeyDown();
        scope.unmount();
      }
    };

    getTrustedDevicesList = function () {
      console.log("Get trusted devices started !");

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

          console.log("Get trusted device response - ", result);

          if (result[0][0].error === 0) {
            if (result[1]) {
              if (result[1].length === 0) {
                scope.devices = [];
                scope.update()
              }
              if (result[1][0]) {
                console.log("Trusted device - ", result[1]);

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
      stopEventPropagation();

      setOnTouchStartAnimation(document.getElementById(device_id));

      deleteTouchStartX = event.changedTouches[0].pageX;
      deleteTouchStartY = event.changedTouches[0].pageY;

    };

    deleteDeviceOnTouchEnd = function (device_id) {
      stopEventPropagation();

      setOnTouchEndAnimation(document.getElementById(device_id));

      console.log("Delete device from trusted begin ...");

      deleteTouchEndX = event.changedTouches[0].pageX;
      deleteTouchEndY = event.changedTouches[0].pageY;

      if (checkElementIsTouched(deleteTouchStartX, deleteTouchStartY, deleteTouchEndX, deleteTouchEndY)) {

        if (isMyDevice(device_id)) {
          showConfirmAlert(window.languages.ViewTrustedDevicesDeleteSelfDevice, "local");
        } else {
          showConfirmAlert(window.languages.ViewTrustedDevicesDeleteOtherDevice, "local");
        }

        scope.update();

        scope.result = function (bool) {
          console.log(bool);
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
                console.log("Delete device from trusted response - ", result);

                if (result[0][0].error === 0) {
                  onSuccessRemoveDevice(device_id);
                }
                else {
                  onErrorRemoveDevice();
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

    function onErrorRemoveDevice() {
      scope.clickPinError = false;
      scope.errorNote = result[0][0].error_note;
      scope.showError = true;
      scope.update();
    }

    function onSuccessRemoveDevice(deviceId) {
      if (isMyDevice(deviceId)) {
        logOut();
      } else {
        getTrustedDevicesList();
      }
    }

    function isMyDevice(deviceId) {
      return localStorage.getItem("click_client_deviceID") === deviceId;
    }

    function showConfirmAlert(confirmNote, confirmType) {
      window.common.alert.show("componentConfirmId", {
        "confirmnote": confirmNote,
        "confirmtype": confirmType,
        parent: scope
      });
    }

    function logOut() {
      localStorage.clear();
      riotTags.innerHTML = "<view-registration-device>";
      riot.mount('view-registration-device');
      scope.unmount();
    }

    getTrustedDevicesList();

  </script>

</view-trusted-devices>
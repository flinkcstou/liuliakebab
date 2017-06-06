<component-bank-operations>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operation-button bank-operation-button-pay" ontouchstart="goToPayViewStart()"
           ontouchend="goToPayViewEnd()">
        <div class="bank-operation-icon operation-pay-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-pay">{window.languages.ComponentBankOperationsPay}</label>

      <div class="bank-operation-button bank-operation-button-transfer" ontouchstart="goToTransferViewStart()"
           ontouchend="goToTransferViewEnd()">
        <div class="bank-operation-icon operation-transfer-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-transfer">{window.languages.ComponentBankOperationsTransfer}</label>

      <div hidden class="bank-operation-button bank-operation-button-autopay" ontouchstart="goToAutoPayViewStart()"
           ontouchend="goToAutoPayViewEnd()">
        <div class="bank-operation-icon operation-autopay-icon">
        </div>
      </div>
      <label hidden
        class="bank-operation-label bank-operation-label-autopay">{window.languages.ComponentBankOperationsAutoPay}</label>

      <div class="bank-operation-button bank-operation-button-qr" ontouchstart="goToQrStart()"
           ontouchend="goToQrEnd()">
        <div class="bank-operation-icon operation-qr-icon">
        </div>
      </div>
      <label
        class="bank-operation-label bank-operation-label-qr">{window.languages.ComponentBankOperationsQr}</label>
    </div>

  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>

    var scope = this;
    var payStartX, payEndX, payStartY, payEndY;

    goToPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payStartX = event.changedTouches[0].pageX;
      payStartY = event.changedTouches[0].pageY;
    }

    goToPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payEndX = event.changedTouches[0].pageX;
      payEndY = event.changedTouches[0].pageY;

      if (Math.abs(payStartX - payEndX) <= 20 && Math.abs(payStartY - payEndY) <= 20) {
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay');
//        scope.unmount()
      }
      else return
    }

    var transferStartX, transferEndX, transferStartY, transferEndY;
    goToTransferViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      transferStartX = event.changedTouches[0].pageX;
      transferStartY = event.changedTouches[0].pageY;

    }

    goToTransferViewEnd = function () {
      transferEndX = event.changedTouches[0].pageX;
      transferEndY = event.changedTouches[0].pageY;

      if (Math.abs(transferStartX - transferEndX) <= 20 && Math.abs(transferStartY - transferEndY) <= 20) {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer');
//        scope.unmount()
      }
      else return;
    }

    var autoPayStartX, autoPayEndX, autoPayStartY, autoPayEndY;
    goToAutoPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      autoPayStartX = event.changedTouches[0].pageX;
      autoPayStartY = event.changedTouches[0].pageY;

    }

    goToAutoPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      autoPayEndX = event.changedTouches[0].pageX;
      autoPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(autoPayStartX - autoPayEndX) <= 20 && Math.abs(autoPayStartY - autoPayEndY) <= 20) {
        if(modeOfApp.demoVersion){
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else{
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }

        if (modeOfApp.onlineMode) {

          riotTags.innerHTML = "<view-auto-pay>";
          riot.mount('view-auto-pay');
//        scope.unmount();
        } else {
          scope.clickPinError = false;
          scope.errorNote = "Раздел автоплатежей доступен только в онлайн режиме";
          scope.showError = true;
          scope.update();
        }
      }
    }

    var qrPayStartX, qrPayEndX, qrPayStartY, qrPayEndY;

    goToQrStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrPayStartX = event.changedTouches[0].pageX;
      qrPayStartY = event.changedTouches[0].pageY;

    }

    goToQrEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrPayEndX = event.changedTouches[0].pageX;
      qrPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(qrPayStartX - qrPayEndX) <= 20 && Math.abs(qrPayStartY - qrPayEndY) <= 20) {
        if(modeOfApp.demoVersion){
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else{
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }
          if (device.platform != 'BrowserStand') {

            cordova.plugins.barcodeScanner.scan(
              function (result) {
                console.log(result)

                var string = result.text;
                if (string.indexOf('click.uz') != -1) {

                  string = string.split('?')[1]
                  string = string.split('&')
                  var id = '';
                  for (var i in string) {
                    if (string[i].split('=')[0] == 'id') {
                      id = string[i].split('=')[1];
                      console.log('ID', id)
                    }
                  }
                  if (id) {
                    if (modeOfApp.offlineMode) {
                      riotTags.innerHTML = "<view-qr>";
                      riot.mount('view-qr', {
//                      "name": result.format,
//                      "address": result.text,
                        "id": id,
                        "image": "resources/icons/ViewPay/logo_indoor.png"
                      });
//                      scope.unmount()
                    }
                    else {
                      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
                      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
                      var sessionKey = info.session_key;

                      window.api.call({
                        method: 'get.indoor.service',
                        input: {
                          phone_num: phoneNumber,
                          session_key: sessionKey,
                          service_id: id,

                        },

                        scope: this,

                        onSuccess: function (result) {
                          if (result[0][0].error == 0) {
                            if (result[1]) {
                              if (result[1][0]) {
                                closeMenu();
                                riotTags.innerHTML = "<view-qr>";
                                riot.mount('view-qr', result[1][0]);
//                                scope.unmount()
                              }
                            }
                            console.log("QR PAY", result);
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
                  }
                }
              },
              function (error) {
                scope.clickPinError = false;
                scope.errorNote = "Отсутствует доступ";
                scope.showError = true;
                scope.update();
              },
              {
                preferFrontCamera: false, // iOS and Android
                showFlipCameraButton: true, // iOS and Android
                showTorchButton: true, // iOS and Android
                torchOn: false, // Android, launch with the torch switched on (if available)
                prompt: "Установите QR код в поле сканирования", // Android
                resultDisplayDuration: 500, // Android, display scanned text for X ms. 0 suppresses it entirely, default 1500
                formats: "QR_CODE", // default: all but PDF_417 and RSS_EXPANDED
                orientation: "portrait", // Android only (portrait|landscape), default unset so it rotates with the device
                disableAnimations: true, // iOS
                disableSuccessBeep: false // iOS
              }
            );
          }
          else {
            var phoneNumber = localStorage.getItem("click_client_phoneNumber");
            var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
            var sessionKey = info.session_key;

            window.api.call({
              method: 'get.indoor.service',
              input: {
                phone_num: phoneNumber,
                session_key: sessionKey,
                service_id: 1234,

              },

              scope: this,

              onSuccess: function (result) {
                if (result[0][0].error == 0) {
                  if (result[1]) {
                    if (result[1][0]) {
                      closeMenu();
                      riotTags.innerHTML = "<view-qr>";
                      riot.mount('view-qr', result[1][0]);
//                    scope.unmount()
                    }
                  }
                  console.log("QR PAY", result);
                }
                else {

                  scope.showError = true;
                  scope.clickPinError = false;
                  scope.errorNote = result[0][0].error_note;
                  scope.update();
//                alert(result[0][0].error_note);
                }
              },

              onFail: function (api_status, api_status_message, data) {
                console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                console.error(data);
              }
            });
          }
//        scope.unmount();

      }
    }

  </script>
</component-bank-operations>
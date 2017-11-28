<component-bank-operations>
  <div class="bank-operations">
    <div class="top-operations-buttons">
      <div class="bank-operation-button bank-operation-button-pay" role="button"
           aria-label="{window.languages.ComponentBankOperationsPay}" ontouchstart="goToPayViewStart()"
           ontouchend="goToPayViewEnd()">
        <div id="payButtonId" class="bank-operation-icon operation-pay-icon">
        </div>
      </div>
      <label class="bank-operation-label bank-operation-label-pay">{window.languages.ComponentBankOperationsPay}</label>

      <div class="bank-operation-button bank-operation-button-transfer" role="button"
           aria-label="{window.languages.ComponentBankOperationsTransfer}" ontouchstart="goToTransferViewStart()"
           ontouchend="goToTransferViewEnd()">
        <div id="transferButtonId" class="bank-operation-icon operation-transfer-icon">
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

      <div class="bank-operation-button bank-operation-button-qr" role="button"
           aria-label="{window.languages.ComponentBankOperationsQr}" ontouchstart="goToQrStart()"
           ontouchend="goToQrEnd()">
        <div id="qrButtonId" class="bank-operation-icon operation-qr-icon">
        </div>
      </div>
      <label
          class="bank-operation-label bank-operation-label-qr">{window.languages.ComponentBankOperationsQr}</label>
    </div>

  </div>

  <div if="{window.checkShowingComponent != null}" class="iFrame-container">
    <div class="iFrame-toolbar-container">
      <p class="iFrame-title">QR сканер</p>
      <div id="iFrameBackButton" ontouchstart="hideIFrameStart(this.id)" ontouchend="hideIFrameEnd(this.id)"
           class="iFrame-back-button">
      </div>
    </div>
    <iframe id="iFrameExternalUrlId" class="iFrame-main" frameborder="0"></iframe>
  </div>

  <script>

    var closeIFrameStartX, closeIFrameEndX, closeIFrameStartY, closeIFrameEndY;

    hideIFrameStart = function (id) {
      closeIFrameStartX = event.changedTouches[0].pageX;
      closeIFrameStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    };

    hideIFrameEnd = function (id) {
      closeIFrameEndX = event.changedTouches[0].pageX;
      closeIFrameEndY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      if (Math.abs(closeIFrameStartX - closeIFrameEndX) <= 20 && Math.abs(closeIFrameStartY - closeIFrameEndY) <= 20) {
        console.log('qweweeee')
        window.checkShowingComponent = null;
        riot.update()
      }

    };

    var scope = this;
    var payStartX, payEndX, payStartY, payEndY;

    scope.showIFrame = false;

    goToPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payButtonId.style.webkitTransform = 'scale(0.7)';

      payStartX = event.changedTouches[0].pageX;
      payStartY = event.changedTouches[0].pageY;
    };

    goToPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      payButtonId.style.webkitTransform = 'scale(1)';

      payEndX = event.changedTouches[0].pageX;
      payEndY = event.changedTouches[0].pageY;

      if (Math.abs(payStartX - payEndX) <= 20 && Math.abs(payStartY - payEndY) <= 20) {
        riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay');
//        scope.unmount()
      }
      else return
    };

    var transferStartX, transferEndX, transferStartY, transferEndY;
    goToTransferViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      transferButtonId.style.webkitTransform = 'scale(0.7)';

      transferStartX = event.changedTouches[0].pageX;
      transferStartY = event.changedTouches[0].pageY;

    };

    goToTransferViewEnd = function () {
      transferEndX = event.changedTouches[0].pageX;
      transferEndY = event.changedTouches[0].pageY;

      transferButtonId.style.webkitTransform = 'scale(1)';

      if (Math.abs(transferStartX - transferEndX) <= 20 && Math.abs(transferStartY - transferEndY) <= 20) {
        riotTags.innerHTML = "<view-transfer>";
        riot.mount('view-transfer');
//        scope.unmount()
      }
      else return;
    };

    var autoPayStartX, autoPayEndX, autoPayStartY, autoPayEndY;
    goToAutoPayViewStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      autoPayStartX = event.changedTouches[0].pageX;
      autoPayStartY = event.changedTouches[0].pageY;

    };

    goToAutoPayViewEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(1)';

      autoPayEndX = event.changedTouches[0].pageX;
      autoPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(autoPayStartX - autoPayEndX) <= 20 && Math.abs(autoPayStartY - autoPayEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
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
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
          scope.update();
        }
      }
    };

    var qrPayStartX, qrPayEndX, qrPayStartY, qrPayEndY;

    goToQrStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      qrPayStartX = event.changedTouches[0].pageX;
      qrPayStartY = event.changedTouches[0].pageY;

    };

    goToQrEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(1)';

      qrPayEndX = event.changedTouches[0].pageX;
      qrPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(qrPayStartX - qrPayEndX) <= 20 && Math.abs(qrPayStartY - qrPayEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });
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
          window.pickContactFromNativeChecker = true;

          cordova.plugins.barcodeScanner.scan(
            function (result) {
              console.log('QR RESULT', result)

              var string = result.text;
              if (string.indexOf('click.uz') != -1) {

                string = string.split('?')[1]
                string = string.split('&')
                var id = '';
                var rkId = '';
                var rkAmount = '';
                var rkOrder = '';
                for (var i in string) {
                  if (string[i].split('=')[0] == 'id') {
                    id = string[i].split('=')[1];
                    console.log('ID', id)
                  }
                }

                if (!id) {
                  console.log('string', string)
                  try {
                    var decodeString = atob(string)
                  }
                  catch (e) {
                    console.log(e)
                  }
                  console.log("DECODED STRING", decodeString)
                  var splitedArray = decodeString.split('&');
                  for (var j in splitedArray) {
                    if (splitedArray[j].split("=")[0] == 'id')
                      id = splitedArray[j].split("=")[1]

                    if (splitedArray[j].split("=")[0] == 'amount')
                      rkAmount = splitedArray[j].split("=")[1]

                    if (splitedArray[j].split("=")[0] == 'order_id')
                      rkOrder = splitedArray[j].split("=")[1]
                  }

                  console.log('id', id)
                  console.log('rkAmount', rkAmount)
                  console.log('rkOrder', rkOrder)
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


                    if (device.platform != 'BrowserStand') {
                      var options = {dimBackground: true};

                      SpinnerPlugin.activityStart("Сканирование QR", options, function () {
                        console.log("Started");
                      }, function () {
                        console.log("closed");
                      });
                    }

                    var answerFromServer = false;

                    window.api.call({
                      method: 'get.indoor.service',
                      input: {
                        phone_num: phoneNumber,
                        session_key: sessionKey,
                        service_id: id,

                      },

                      scope: this,

                      onSuccess: function (result) {
                        answerFromServer = true;
                        if (result[0][0].error == 0) {
                          if (result[1]) {
                            if (result[1][0]) {

                              if (rkAmount) {
                                result[1][0].rk_amount = rkAmount
                              }
                              if (rkOrder) {
                                result[1][0].rk_order = rkOrder
                              }
                              riotTags.innerHTML = "<view-qr>";
                              riot.mount('view-qr', result[1][0]);
//                                scope.unmount()
                            }
                          }
                          console.log("QR PAY", result);
                        }
                        else {
                          if (result[0][0].error == -202) {
                            if (result[0][0].error_url) {

                              window.checkShowingComponent = scope;
                              scope.update()
                              iFrameExternalUrlId.src = result[0][0].error_url


//                               ref = cordova.InAppBrowser.open(result[0][0].error_url, '_blank', 'location=no');
//
//
//                              //injecting the CSS
//                              ref.addEventListener('loadstop', function () {
//                                //injecting the CSS
//                                ref.insertCSS({
//                                  "code": ".youtube_done_button { position: absolute; width: 100%; background-color:#00a8f1; color: white; height:" + 140 * heightK + "px; top:" + -140 * heightK + "px; font-size:" + 50 * heightK + "px;}"
//                                });
//
//                                ref.insertCSS({
//                                  "code": "body{position:absolute; width:" + 720 * widthK + "px; height:" + 1072 * heightK + "px; top:" + 140 * heightK + "px;}"
//                                });
//
//                                ref.insertCSS({
//                                  "code": "html{position:absolute; width:" + 720 * widthK + "px; height:" + 1232 * widthK + "px; top:" + 0 * heightK + "px;}"
//                                });
//
//                                //setting close to false when the InAppBrowser is opened
//                                ref.executeScript({
//                                  code: "localStorage.setItem('close', 'false');"
//                                });
//
//                                //creating and attaching a button with click listener to the opened page
//                                ref.executeScript({
//                                  code: "(function () {var body = document.querySelector('body');var button = document.createElement('div');button.innerHTML = 'Назад в CLICK';button.classList.add('youtube_done_button');body.appendChild(button);button.addEventListener('click', function () {console.log('QWERTY'); ref.close()})})();"
//                                });
//
//
//
//                              });

                              return
                            }
                          }

                          scope.clickPinError = false;
                          scope.errorNote = result[0][0].error_note;

                          window.common.alert.show("componentAlertId", {
                            parent: scope,
                            clickpinerror: scope.clickPinError,
                            errornote: scope.errorNote
                          });
                          scope.update();
                        }
                      },

                      onFail: function (api_status, api_status_message, data) {
                        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                        console.error(data);
                      }
                    });

                    setTimeout(function () {
                      if (!answerFromServer) {
                        if (device.platform != 'BrowserStand') {
                          console.log("Spinner Stop Compnent Bank Operations 415");
                          SpinnerPlugin.activityStop();
                        }
                      }

                      return
                    }, 15000)
                  }
                }
              }
            },
            function (error) {

              scope.clickPinError = false;
              scope.errorNote = "Отсутствует доступ";

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote
              });
              scope.update();
            },
            {
              preferFrontCamera: false, // iOS and Android
              showFlipCameraButton: false, // iOS and Android
              showTorchButton: true, // iOS and Android
              torchOn: false, // Android, launch with the torch switched on (if available)
              prompt: "Наведите камеру к QR коду", // Android
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

                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: scope.clickPinError,
                  errornote: scope.errorNote
                });
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
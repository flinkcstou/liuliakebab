<view-qr-only class="riot-tags-main-container">
  <div class="view-qr-blue-container page-title-shadow">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchend="goToBack()"
           class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="view-qr-company-icon" style="background-image: url({opts.image})"></div>
    <p class="view-qr-company-name">
      {opts.name}</p>
    <p class="view-qr-address-name">
      {opts.address}</p>
  </div>
  <div class="view-qr-container">

    <div class="view-qr-contact-phone-field-container">
      <div class="view-qr-only-container">

        <div class="view-qr-only-scan-instruction-label">{languages.QrOnlyStartQrText}</div>
        <div class="view-qr-only-scan-container">
          <div id="qrButtonId" class="view-qr-only-scan-button" ontouchstart="goToQrTouchStart()"
               ontouchend="goToQrTouchEnd()"></div>
          <div class="view-qr-only-scan-label">{languages.QrOnlyQrText}</div>
        </div>

      </div>
    </div>

  </div>

  <script>

    var scope = this;
    this.titleName = window.languages.ViewQrTitle;
    var touchStartAcceptX, touchStartAcceptY, touchStartDeclineX, touchStartDeclineY;
    scope.showPlaceHolderError = false;
    var qrPayStartX, qrPayEndX, qrPayStartY, qrPayEndY;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;

    window.saveHistory('view-qr-only', opts);

    console.log('QR OPTS', opts);


    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown();
      scope.unmount()
    };


    goToQrTouchStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      qrPayStartX = event.changedTouches[0].pageX;
      qrPayStartY = event.changedTouches[0].pageY;

    };

    goToQrTouchEnd = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(1)';

      qrPayEndX = event.changedTouches[0].pageX;
      qrPayEndY = event.changedTouches[0].pageY;

      if (Math.abs(qrPayStartX - qrPayEndX) <= 20 && Math.abs(qrPayStartY - qrPayEndY) <= 20 && !qrScaner.qrInited) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          scope.errorNote = question;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            clickpinerror: scope.clickPinError,
            errornote: scope.errorNote
          });

          scope.update();
          return
        }

        if (device.platform != 'BrowserStand') {
          window.pickContactFromNativeChecker = true;
          qrScaner.qrInited = true;
          console.log("qrScaner.qrInited =", qrScaner.qrInited);

          qrCodeScanner(scope);
        }
        else {

          window.api.call({
            method: 'get.indoor.service',
            input: {
              phone_num: phoneNumber,
              session_key: sessionKey,
              service_id: 1234
            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                if (result[1]) {
                  if (result[1][0]) {
                    result[1][0].menu = {
                      item: [{
                        name: "c 001 ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept " +
                        "ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept", count: "1", amount: "1000"
                      }, {
                        name: "c 002",
                        count: "1",
                        amount: "1000"
                      }, {name: "c 003", count: "1", amount: "1000"}, {
                        name: "c 004",
                        count: "1",
                        amount: "100010.33"
                      }, {
                        name: "c 005",
                        count: "1",
                        amount: "1000520"
                      }, {
                        name: "c 006 ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept " +
                        "ViewQrInfoTitleAccept ViewQrInfoTitleAccept ViewQrInfoTitleAccept", count: "1", amount: "1000"
                      }, {name: "c 007", count: "1", amount: "1000"}]
                    };
                    result[1][0].amount = "700";
                    riotTags.innerHTML = "<view-qr-info>";
                    riot.mount('view-qr-info', result[1][0]);
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
    };


  </script>
</view-qr-only>

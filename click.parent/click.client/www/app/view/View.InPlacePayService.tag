<view-inplace-pay-service>
  <div class="view-pay riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>

    <div class="inplace-pay-category-container" id="categoriesContainerId">

      <div class="inplace-pay-search-field" id="searchContainerId">
        <input class="inplace-pay-search-input-part" type="tel" id="searchInputId"/>
        <div id="searchIcon" class="inplace-pay-search-icon" ontouchstart="onTouchStartOfSearchService()"
             ontouchend="onTouchEndOfSearchService()"></div>
      </div>

      <div class="inplace-pay-inner-container">
        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in serviceList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode)}" class="inplace-pay-service-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfService()"
                 ontouchend="onTouchEndOfService(this.id)">
              <div class="inplace-pay-service-icon" style="background-image: url({i.image})"></div>
              <div class="inplace-pay-service-info">
                <div class="inplace-pay-service-name-field">{i.name}</div>
                <div class="inplace-pay-service-address-field">{i.address}</div>
                <div class="inplace-pay-service-distance-field">{i.distance}</div>
              </div>
              <div class="inplace-pay-service-icon-tick"></div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>

  <div id="qrButtonId" class="inplace-pay-gotoqr-button" ontouchstart="goToQrTouchStart()"
       ontouchend="goToQrTouchEnd()"></div>

  <script>

    console.log("OPTS", opts);

    var scope = this;
    scope.checkOfSearch = false;
    scope.titleName = opts.categoryName;
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;
    var goBackButtonStartX, goBackButtonEndX,
      goBackButtonStartY, goBackButtonEndY;
    var searchStartX, searchEndX, searchStartY, searchEndY;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;
    var latitude, longitude;


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-inplace-pay-service') {
      history.arrayOfHistory.push(
        {
          "view": 'view-inplace-pay-service',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    findLocation = function () {

      console.log("find location method");

      var geoOptions = {timeout: 5000, enableHighAccuracy: true};
      var onGeoSuccess = function (position) {
        console.log("Success in getting position", position);
        latitude = position.coords.latitude;
        longitude = position.coords.longitude;
        getServiceList(latitude, longitude);

      };

      // onError Callback receives a PositionError object
      //
      function onGeoError(error) {
        console.log("Error in getting position", error)
        alert("Убедитесь, что у вас включены геоданные");
      }

      navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError, geoOptions);
    };

    findLocation();

    getServiceList = function (lat, long) {
      if (modeOfApp.onlineMode) {

        scope.serviceList = [];

        window.api.call({
          method: 'get.indoor.service.list',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            category_id: opts.categoryId,
            location: lat + " " + long
          },
          scope: this,

          onSuccess: function (result) {
            if (result[0][0].error == 0)
              if (result[1][0]) {


                for (var i in result[1]) {

                  scope.serviceList.push(result[1][i]);

                }
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


    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    onTouchStartOfSearchService = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchIcon)
        searchIcon.style.webkitTransform = 'scale(0.7)';

      searchStartX = event.changedTouches[0].pageX;
      searchStartY = event.changedTouches[0].pageY;

    };

    onTouchEndOfSearchService = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchIcon)
        searchIcon.style.webkitTransform = 'scale(1)';

      searchEndX = event.changedTouches[0].pageX;
      searchEndY = event.changedTouches[0].pageY;

      if (Math.abs(searchStartX - searchEndX) <= 20 && Math.abs(searchStartY - searchEndY) <= 20) {
        console.log("string to search=", searchInputId.value);

        var searchWord = searchInputId.value;

        if (modeOfApp.onlineMode && searchWord) {

          scope.serviceList = [];
          latitude = 41.34994;
          longitude = 69.22582;

          window.api.call({
            method: 'get.indoor.service.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              category_id: 0,
              location: latitude + " " + longitude,
              search: searchWord
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                if (result[1][0]) {


                  for (var i in result[1]) {

                    scope.serviceList.push(result[1][i]);

                  }

                }

                console.log("Update");
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
    };

    goToQrTouchStart = function (e) {
      event.preventDefault();
      event.stopPropagation();

      qrButtonId.style.webkitTransform = 'scale(0.7)';

      qrPayStartX = event.changedTouches[0].pageX;
      qrPayStartY = event.changedTouches[0].pageY;

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

      if (Math.abs(qrPayStartX - qrPayEndX) <= 20 && Math.abs(qrPayStartY - qrPayEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
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
                              if (rkAmount) {
                                result[1][0].rk_amount = rkAmount
                              }
                              if (rkOrder) {
                                result[1][0].rk_order = rkOrder
                              }
                              riotTags.innerHTML = "<view-qr>";
                              riot.mount('view-qr', result[1][0]);
                            }
                          }
                        }
                        else {
                          if (result[0][0].error == -202) {
                            if (result[0][0].error_url) {

                              window.checkShowingComponent = scope;
                              scope.update();
                              iFrameExternalUrlId.src = result[0][0].error_url;

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
                      },
                      onTimeOut: function () {
                        timeOutTimer = setTimeout(function () {
                          window.stopSpinner();
                        }, 15000);
                        console.log('creating timeOut', timeOutTimer);
                      },
                      onEmergencyStop: function () {
                        console.log('Clearing timer emergencyStop', timeOutTimer);
                        window.clearTimeout(timeOutTimer);
                      }
                    }, 15000);
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


    scope.onTouchStartOfService = onTouchStartOfService = function () {
      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfService = onTouchEndOfService = function (id, element) {

      event.preventDefault();
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) {

        console.log(id, element);

        for (var i in scope.serviceList) {
          if (scope.serviceList[i].id == id) {
            riotTags.innerHTML = "<view-qr>";
            riot.mount('view-qr', scope.serviceList[i]);

            break;
          }

        }


      }
    };


  </script>
</view-inplace-pay-service>
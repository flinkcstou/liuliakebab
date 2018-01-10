<view-inplace-pay-service>
  <div class="view-pay riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>

    <div class="inplace-pay-category-container" id="categoriesContainerId">

      <div class="inplace-pay-search-container">
        <div class="inplace-pay-search-field" id="searchContainerId">
          <input class="inplace-pay-search-input-part" type="text" id="searchInputId"
                 placeholder="{window.languages.InPlaceSearchPlaceHolderText}"/>
          <div id="searchIcon" class="inplace-pay-search-icon" ontouchstart="onTouchStartOfSearchService()"
               ontouchend="onTouchEndOfSearchService()"></div>
        </div>
      </div>

      <div class="inplace-pay-service-inner-container" id="servicesBodyContainerId"
           ontouchmove="servicesBodyContainerTouchMove()" ontouchstart="servicesBodyContainerTouchStart()"
           ontouchend="servicesBodyContainerTouchEnd()">

        <div each="{i in serviceList}" if="{!(modeOfApp.offlineMode)}" class="inplace-pay-service-container"
             id="{i.id}"
             ontouchstart="onTouchStartOfService(this.id)"
             ontouchend="onTouchEndOfService(this.id)">
          <div class="inplace-pay-service-icon" style="background-image: url({i.image})"></div>
          <div class="inplace-pay-service-info">
            <div class="inplace-pay-service-name-field">{i.name}</div>
            <div class="inplace-pay-service-address-field">{i.address}</div>
            <div class="inplace-pay-service-distance-container" if="{i.distance && i.distance!=null}">
              <div class="inplace-pay-service-distance-icon"></div>
              <div class="inplace-pay-service-distance-field">{i.distance}</div>
            </div>
          </div>
          <div class="inplace-pay-service-icon-tick"></div>
        </div>

        <div if="{serviceList.length==0 && searchMode}" class="inplace-pay-search-no-match">Нет совпадений</div>
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
    var servicesStartX, servicesEndX,
      servicesStartY, servicesEndY;
    var searchStartX, searchEndX, searchStartY, searchEndY;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;
    var timeOutTimer = 0;
    var latitude = 0, longitude = 0;
    scope.pageNumber = 1;
    scope.serviceList = [];
    var pageToReturn = "view-inplace-pay-category";
    scope.searchMode = false;


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-inplace-pay-service') {
      history.arrayOfHistory.push(
        {
          "view": 'view-inplace-pay-service',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.on('mount', function () {
      console.log("viewPay.serviceContainerScrollTop=", viewPay.serviceContainerScrollTop)
      if (viewPay.serviceContainerScrollTop) {

        servicesBodyContainerId.scrollTop = viewPay.serviceContainerScrollTop;
        viewPay.serviceContainerScrollTop = null;
      }

    })

    findLocation = function () {

      window.startSpinner();

      console.log("find location method");

      try {
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
          console.log("Error in getting position", error);
//        window.common.alert.show("componentAlertId", {
//          parent: scope,
//          viewpage: "view-inplace-pay-category",
//          errornote: window.languages.InPlacePayGpsErrorText
//        });
          latitude = 0;
          longitude = 0;
          getServiceList(latitude, longitude);
        }

        navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError, geoOptions);

      } catch (e) {
        console.log("Geolocation error =", e);
      }
    };


    scope.getServiceList = getServiceList = function (lat, long) {

//      scope.serviceList = [];
      window.startSpinner();

      window.api.call({
        method: 'get.indoor.service.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          category_id: opts.categoryId,
          location: lat + " " + long,
          page_number: parseInt(scope.pageNumber)
        },
        scope: this,

        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          window.stopSpinner();

          if (result[0][0].error == 0) {
            if (result[1][0]) {

              for (var i in result[1]) {
                scope.serviceList.push(result[1][i]);
              }

            }
            sessionStorage.setItem('click_client_inPlacePayServiceList', JSON.stringify(scope.serviceList));
            console.log("Update");
            scope.update();
          } else {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              viewpage: pageToReturn,
              errornote: result[0][0].error_note
            });
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          window.common.alert.show("componentAlertId", {
            parent: scope,
            viewpage: pageToReturn,
            errornote: window.languages.ServiceUnavailableText
          });
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              viewpage: pageToReturn,
              errornote: window.languages.WaitingTimeExpiredText
            });
          }, 20000);
          console.log('creating timeOut', timeOutTimer);
        },
        onEmergencyStop: function () {
          console.log('Clearing timer emergencyStop', timeOutTimer);
          window.clearTimeout(timeOutTimer);
        }
      });

    };


    if (JSON.parse(sessionStorage.getItem('click_client_inPlacePayServiceList'))) {

      console.log('111');
      scope.serviceList = JSON.parse(sessionStorage.getItem('click_client_inPlacePayServiceList'));
      scope.update();

    } else if (opts.latitude && opts.longitude) {

      console.log('222');
      latitude = opts.latitude;
      longitude = opts.longitude;
      getServiceList(opts.latitude, opts.longitude);

    } else if (localStorage.getItem('location_find') && JSON.parse(localStorage.getItem('location_find'))) {

      console.log('333');
      findLocation();

    } else {

      console.log('444');
      latitude = 0;
      longitude = 0;
      getServiceList(latitude, longitude);

    }

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

          window.blurFields();
          window.startSpinner();
          scope.searchMode = false;
          scope.serviceList = [];
          scope.pageNumber = 1;

          window.api.call({
            method: 'get.indoor.service.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber,
              category_id: opts.categoryId,
              location: latitude + " " + longitude,
              search: searchWord
            },
            scope: this,

            onSuccess: function (result) {
              console.log('Clearing timer onSuccess', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              window.stopSpinner();
              scope.searchMode = true;

              if (result[0][0].error == 0) {
                if (result[1][0]) {

                  for (var i in result[1]) {
                    scope.serviceList.push(result[1][i]);
                  }

                }
                console.log("Update");
                scope.update();
              } else {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  viewpage: pageToReturn,
                  errornote: result[0][0].error_note,
                });
              }

            },
            onFail: function (api_status, api_status_message, data) {
              console.log('Clearing timer onFail', timeOutTimer);
              window.clearTimeout(timeOutTimer);
              window.common.alert.show("componentAlertId", {
                parent: scope,
                viewpage: pageToReturn,
                errornote: window.languages.ServiceUnavailableText
              });
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            },
            onTimeOut: function () {
              timeOutTimer = setTimeout(function () {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  viewpage: pageToReturn,
                  errornote: window.languages.WaitingTimeExpiredText
                });
              }, 20000);
              console.log('creating timeOut', timeOutTimer);
            },
            onEmergencyStop: function () {
              console.log('Clearing timer emergencyStop', timeOutTimer);
              window.clearTimeout(timeOutTimer);
            }
          }, 20000);

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


                    window.startSpinner();

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


    scope.onTouchStartOfService = onTouchStartOfService = function (id) {

      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {

      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) {

        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';

        setTimeout(function () {

          document.getElementById(id).style.backgroundColor = 'transparent';

          for (var i in scope.serviceList) {
            if (scope.serviceList[i].id == id) {
              viewPay.serviceContainerScrollTop = servicesBodyContainerId.scrollTop;
              riotTags.innerHTML = "<view-qr>";
              riot.mount('view-qr', scope.serviceList[i]);

              break;
            }

          }

        }, 50)

      }
    };


    servicesBodyContainerTouchMove = function () {

      if (device.platform == 'Android') {

        event.stopPropagation();

        if ((servicesBodyContainerId.scrollHeight - servicesBodyContainerId.scrollTop) == servicesBodyContainerId.offsetHeight && event.changedTouches[0].pageY < servicesStartY) {

          console.log("START ANIMATION", event.changedTouches[0].pageY + top);

          if (Math.abs(event.changedTouches[0].pageY + top) < 250 * widthK) {

            document.getElementById('servicesBodyContainerId').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('servicesBodyContainerId').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('servicesBodyContainerId').style.transform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";
            document.getElementById('servicesBodyContainerId').style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";

          }
        } else if (servicesBodyContainerId.scrollTop == 0 && event.changedTouches[0].pageY > servicesStartY) {

          console.log("upper swipe", event.changedTouches[0].pageY + top);
          if (Math.abs(event.changedTouches[0].pageY + top) < 250 * widthK) {

            document.getElementById('servicesBodyContainerId').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('servicesBodyContainerId').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('servicesBodyContainerId').style.transform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";
            document.getElementById('servicesBodyContainerId').style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";

          }
        } else {

          console.log("RETURNING");
          document.getElementById('servicesBodyContainerId').style.transition = '0s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('servicesBodyContainerId').style.webkitTransition = '0s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('servicesBodyContainerId').style.transform = "translate3d(0,0,0)";
          document.getElementById('servicesBodyContainerId').style.webkitTransform = "translate3d(0,0,0)";
        }

      }
    };

    var top;

    servicesBodyContainerTouchStart = function () {

      if (device.platform == 'Android') {

        servicesStartX = event.changedTouches[0].pageX;
        servicesStartY = event.changedTouches[0].pageY;

        top = -servicesStartY;
      }

    };

    servicesBodyContainerTouchEnd = function () {

      if (device.platform == 'Android') {

        servicesEndX = event.changedTouches[0].pageX;
        servicesEndY = event.changedTouches[0].pageY;

        if ((servicesBodyContainerId.scrollHeight - servicesBodyContainerId.scrollTop) == servicesBodyContainerId.offsetHeight) {

          console.log("END ANIMATION");
          document.getElementById('servicesBodyContainerId').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('servicesBodyContainerId').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('servicesBodyContainerId').style.transform = "translate3d(0,0,0)";
          document.getElementById('servicesBodyContainerId').style.webkitTransform = "translate3d(0,0,0)";

          setTimeout(function () {
            if (scope.serviceList.length % 20 == 0) {
              scope.pageNumber++;
              console.log("services container move pagenumber=", scope.pageNumber)
              getServiceList(latitude, longitude);
            }
          }, 300)

        } else if (servicesBodyContainerId.scrollTop == 0) {
          console.log("end swipe");

          scope.animating = false;
          document.getElementById('servicesBodyContainerId').style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('servicesBodyContainerId').style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('servicesBodyContainerId').style.transform = "translate3d(0,0,0)";
          document.getElementById('servicesBodyContainerId').style.webkitTransform = "translate3d(0,0,0)";


        }

      }

    };


  </script>
</view-inplace-pay-service>

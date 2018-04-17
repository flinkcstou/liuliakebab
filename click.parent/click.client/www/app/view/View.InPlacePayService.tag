<view-inplace-pay-service>
  <div class="view-pay riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>

    <div class="inplace-pay-category-container" id="categoriesContainerId"
         onscroll="servicesScroll()" ontouchmove="servicesBodyContainerTouchMove()"
         ontouchstart="servicesBodyContainerTouchStart()"
         ontouchend="servicesBodyContainerTouchEnd()">

      <div class="inplace-pay-search-container">
        <div class="inplace-pay-search-field" id="searchContainerId">
          <input class="inplace-pay-search-input-part"
                 type="text"
                 id="searchInputId"
                 onfocus="colorFieldInplaceSearch()"
                 onblur="blurFieldInplaceSearch()"
                 onkeydown="keyDownFieldInplaceSearch()"
                 oninput="onInputSearchField()"
                 placeholder="{window.languages.InPlaceSearchPlaceHolderText}"/>
          <div if="{showSearchIcon}" id="searchIcon"
               class="inplace-pay-search-icon"
               ontouchstart="onTouchStartOfSearchCategory()"
               ontouchend="onTouchEndOfSearchCategory()"></div>
          <div if="{!showSearchIcon}" id="searchRemoveIcon"
               class="inplace-pay-search-remove-icon"
               ontouchstart="onTouchStartOfSearchRemove()"
               ontouchend="onTouchEndOfSearchRemove()"></div>
        </div>
      </div>

      <div class="inplace-pay-service-inner-container" id="servicesBodyContainerId">

        <div each="{i in serviceList}" if="{!(modeOfApp.offlineMode)}" class="inplace-pay-service-container"
             id="{i.id}"
             ontouchstart="onTouchStartOfService(this.id)"
             ontouchend="onTouchEndOfService(this.id)">
          <img class="inplace-pay-service-icon" src="{i.image}"
               onload="iconLoaded(this)">
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

        <div if="{serviceList.length==0 && searchMode}" class="inplace-pay-search-no-match">
          {window.languages.InPlaceSearchNoMatchText}
        </div>
      </div>
    </div>
  </div>

  <div class="inplace-pay-gotoqr-container">
    <div id="qrButtonId" class="inplace-pay-gotoqr-button" ontouchstart="goToQrTouchStart()"
         ontouchend="goToQrTouchEnd()"></div>
  </div>

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
    var timeOutTimerTwo = 0;
    var timeOutTimerThree = 0;
    scope.pageNumber = 1;
    scope.serviceList = [];
    var pageToReturn = "view-inplace-pay-category";
    var stepBack = 1;
    scope.searchMode = false;
    scope.showSearchIcon = true;
    var searchFieldTimeout;

    window.saveHistory('view-inplace-pay-service', opts);

    scope.on('mount', function () {

      setTimeout(function () {
        window.blurFields();
      }, 500);
      console.log("viewPay.serviceContainerScrollTop=", viewPay.serviceContainerScrollTop)
      if (viewPay.serviceContainerScrollTop) {

        categoriesContainerId.scrollTop = viewPay.serviceContainerScrollTop;
        viewPay.serviceContainerScrollTop = null;
      }

    });

    findLocation = function () {

      window.startSpinner();

      console.log("find location method");

      try {
        var geoOptions = {timeout: 5000, enableHighAccuracy: true};
        var onGeoSuccess = function (position) {
          console.log("Success in getting position", position);
          inPlacePay.latitude = position.coords.latitude;
          inPlacePay.longitude = position.coords.longitude;
          getServiceList();

        };

        // onError Callback receives a PositionError object
        //
        function onGeoError(error) {
          console.log("Error in getting position", error);

          getServiceList();
        }

        navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError, geoOptions);

      } catch (e) {
        console.log("Geolocation error =", e);
      }
    };


    scope.getServiceList = getServiceList = function () {

//      scope.serviceList = [];
      window.startSpinner();

      window.api.call({
        method: 'get.indoor.service.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          category_id: opts.categoryId,
          location: inPlacePay.latitude + " " + inPlacePay.longitude,
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
              step_amount: stepBack,
              viewmount: true,
              errornote: result[0][0].error_note
            });
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          window.common.alert.show("componentAlertId", {
            parent: scope,
            step_amount: stepBack,
            viewmount: true,
            errornote: window.languages.ServiceUnavailableText
          });
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'get.indoor.service.list',
            });
            window.common.alert.show("componentAlertId", {
              parent: scope,
              step_amount: stepBack,
              viewmount: true,
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

      scope.serviceList = JSON.parse(sessionStorage.getItem('click_client_inPlacePayServiceList'));
      scope.update();

    } else if (inPlacePay.latitude && inPlacePay.longitude) {
      getServiceList();

    } else if (localStorage.getItem('location_find') && JSON.parse(localStorage.getItem('location_find'))) {
      findLocation();

    } else {
      getServiceList();
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

    colorFieldInplaceSearch = function () {
      searchContainerId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff";
      if (document.getElementById('searchIcon'))
        searchIcon.style.backgroundImage = 'url(resources/icons/ViewInPlacePay/indoor_search_blue.png)';
    };

    blurFieldInplaceSearch = function () {
      searchContainerId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb";
      if (document.getElementById('searchIcon'))
        searchIcon.style.backgroundImage = 'url(resources/icons/ViewInPlacePay/indoor_search.png)';
    };

    keyDownFieldInplaceSearch = function () {

      clearTimeout(searchFieldTimeout);

      searchFieldTimeout = setTimeout(function () {
        scope.pageNumber = 1;
        scope.serviceList = [];
        searchServiceByWord();
      }, 500);
    };

    onInputSearchField = function () {
      if (searchInputId.value.length == 0) {
        console.log("show searchIcon true");
        scope.showSearchIcon = true;
      } else {
        console.log("show searchIcon false");
        scope.showSearchIcon = false;
      }
      scope.update();
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

        searchInputId.autofocus;
        searchInputId.focus();
      }
    };

    onTouchStartOfSearchRemove = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchRemoveIcon)
        searchRemoveIcon.style.webkitTransform = 'scale(0.7)';

      searchStartX = event.changedTouches[0].pageX;
      searchStartY = event.changedTouches[0].pageY;

    };

    onTouchEndOfSearchRemove = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchRemoveIcon)
        searchRemoveIcon.style.webkitTransform = 'scale(1)';

      searchEndX = event.changedTouches[0].pageX;
      searchEndY = event.changedTouches[0].pageY;

      if (Math.abs(searchStartX - searchEndX) <= 20 && Math.abs(searchStartY - searchEndY) <= 20) {
        searchInputId.value = "";
        scope.showSearchIcon = true;
        scope.update();
        scope.pageNumber = 1;
        scope.serviceList = [];
        searchServiceByWord();
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
                        window.clearTimeout(timeOutTimerThree);
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
                        window.clearTimeout(timeOutTimerThree);
                        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                        console.error(data);
                      },
                      onTimeOut: function () {
                        timeOutTimerThree = setTimeout(function () {
                          window.stopSpinner();
                        }, 15000);
                        console.log('creating timeOut', timeOutTimerThree);
                      },
                      onEmergencyStop: function () {
                        console.log('Clearing timer emergencyStop', timeOutTimerThree);
                        window.clearTimeout(timeOutTimerThree);
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
              prompt: window.languages.ViewQrLabelOnScanner, // Android
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
        event.preventDefault();
        event.stopPropagation();

        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';
        window.clearTimeout(timeOutTimer);

        setTimeout(function () {

          document.getElementById(id).style.backgroundColor = 'transparent';

          for (var i in scope.serviceList) {
            if (scope.serviceList[i].id == id) {
              viewPay.serviceContainerScrollTop = categoriesContainerId.scrollTop;
              scope.serviceList[i].location = inPlacePay.latitude + " " + inPlacePay.longitude;
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

        if ((categoriesContainerId.scrollHeight - categoriesContainerId.scrollTop) == categoriesContainerId.offsetHeight && event.changedTouches[0].pageY < servicesStartY) {

          if (Math.abs(event.changedTouches[0].pageY + top) < 250 * widthK) {

            document.getElementById('categoriesContainerId').style.transition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('categoriesContainerId').style.webkitTransition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('categoriesContainerId').style.transform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";
            document.getElementById('categoriesContainerId').style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";

          }
        } else if (categoriesContainerId.scrollTop == 0 && event.changedTouches[0].pageY > servicesStartY) {

          if (Math.abs(event.changedTouches[0].pageY + top) < 250 * widthK) {
            document.getElementById('categoriesContainerId').style.transition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('categoriesContainerId').style.webkitTransition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
            document.getElementById('categoriesContainerId').style.transform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";
            document.getElementById('categoriesContainerId').style.webkitTransform = "translate3d(0," + (event.changedTouches[0].pageY + top) + 'px' + ", 0)";
          }
        } else {
          document.getElementById('categoriesContainerId').style.transition = '0s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('categoriesContainerId').style.webkitTransition = '0s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('categoriesContainerId').style.transform = "translate3d(0,0,0)";
          document.getElementById('categoriesContainerId').style.webkitTransform = "translate3d(0,0,0)";
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

        if ((categoriesContainerId.scrollHeight - categoriesContainerId.scrollTop) == categoriesContainerId.offsetHeight) {

          document.getElementById('categoriesContainerId').style.transition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('categoriesContainerId').style.webkitTransition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('categoriesContainerId').style.transform = "translate3d(0,0,0)";
          document.getElementById('categoriesContainerId').style.webkitTransform = "translate3d(0,0,0)";


        } else if (categoriesContainerId.scrollTop == 0) {

          document.getElementById('categoriesContainerId').style.transition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('categoriesContainerId').style.webkitTransition = '0.1s cubic-bezier(0.2, 0.05, 0.39, 0)';
          document.getElementById('categoriesContainerId').style.transform = "translate3d(0,0,0)";
          document.getElementById('categoriesContainerId').style.webkitTransform = "translate3d(0,0,0)";

        }

      }

    };


    servicesScroll = function () {

      if ((categoriesContainerId.scrollHeight - categoriesContainerId.scrollTop) == categoriesContainerId.offsetHeight) {

        if (scope.serviceList.length % 20 == 0) {
          scope.pageNumber++;
          if (scope.searchMode)
            searchServiceByWord();
          else
            getServiceList();
        }
      }

    };

    scope.searchServiceByWord = searchServiceByWord = function () {
      var searchWord = searchInputId.value;

      if (modeOfApp.onlineMode) {

        scope.searchMode = false;

        window.api.call({
          method: 'get.indoor.service.list',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            category_id: opts.categoryId,
            location: inPlacePay.latitude + " " + inPlacePay.longitude,
            search: searchWord,
            page_number: parseInt(scope.pageNumber)
          },
          scope: this,

          onSuccess: function (result) {

            scope.searchMode = true;

            if (result[0][0].error == 0) {
              if (result[1][0]) {

                for (var i in result[1]) {
                  scope.serviceList.push(result[1][i]);
                }

              }
              scope.update();
            } else {
              window.common.alert.show("componentAlertId", {
                parent: scope,
                step_amount: stepBack,
                viewmount: true,
                errornote: result[0][0].error_note
              });
            }

          },
          onFail: function (api_status, api_status_message, data) {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              step_amount: stepBack,
              viewmount: true,
              errornote: window.languages.ServiceUnavailableText
            });
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });

      }
    };

    iconLoaded = function (element) {
      element.style.backgroundImage = "";
    };


  </script>
</view-inplace-pay-service>

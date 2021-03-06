<view-inplace-pay-service>
  <div class="view-pay riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="back-button"></div>
      <div class="title-bottom-border">
      </div>
    </div>

    <div class="inplace-pay-category-container">

      <div class="inplace-pay-search-container">
        <div class="inplace-pay-search-field" id="searchContainerId">
          <input class="inplace-pay-search-input-part" value="{opts.searchWord}"
                 type="text"
                 id="searchInputId"
                 onfocus="colorFieldInplaceSearch()"
                 onblur="blurFieldInplaceSearch()"
                 onkeyup="keyUpFieldInplaceSearch()"
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

      <div class="inplace-pay-service-inner-container" id="categoriesContainerId"
           onscroll="servicesScroll()" ontouchmove="servicesBodyContainerTouchMove()"
           ontouchstart="servicesBodyContainerTouchStart()"
           ontouchend="servicesBodyContainerTouchEnd()">

        <div each="{i in serviceList}" if="{!(modeOfApp.offlineMode)}" class="inplace-pay-service-container"
             id="{i.id}"
             ontouchstart="onTouchStartOfService(this.id)"
             ontouchend="onTouchEndOfService(this.id)">
          <img id="{i.id+'_image'}" if="{i.image}"
               class="inplace-pay-service-icon" src="{i.image}"
               onload="clearLoaderOnIconLoad(this.id)">
          <img if="{!i.image}"
               class="loader-dots-pagination-in-container" src="resources/gifs/loader_dots.gif">
          <div class="inplace-pay-service-info">
            <div class="inplace-pay-service-name-field">{i.name}</div>
            <div class="inplace-pay-service-address-field">{i.address}</div>
            <div class="inplace-pay-service-distance-container" if="{i.distance && i.distance!=null}">
              <div class="inplace-pay-service-distance-icon"></div>
              <div class="inplace-pay-service-distance-field">{i.distance}</div>
            </div>
          </div>
          <div class="inplace-pay-service-icon-tick" if="{i.name}"></div>
          <div class="inplace-title-bottom-border" if="{i.name}"></div>
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
    <div class="inplace-pay-gotoqr-label">{window.languages.QrScanerText}</div>
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
    var scrollTimer = null;
    var scrolling = false;
    var isServiceClick = false;
    scope.pageNumber = 1;
    scope.serviceList = [];
    var pageToReturn = "view-inplace-pay-category";
    var stepBack = 1;
    scope.searchMode = false;
    scope.showSearchIcon = !opts.searchWord;
    var searchFieldTimeout, searchFieldActive = false, searchWord = opts.searchWord;
    qrScaner.qrInited = false;
    scope.requestSent = false;

    window.saveHistory('view-inplace-pay-service', opts);

    scope.on('mount', function () {

      setTimeout(function () {
        window.blurFields();
      }, 500);
      if (viewPay.serviceContainerScrollTop) {

        categoriesContainerId.scrollTop = viewPay.serviceContainerScrollTop;
        viewPay.serviceContainerScrollTop = null;
      }

    });

    findLocation = function () {

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


    scope.getServiceList = getServiceList = function (fromScroll) {

//      scope.serviceList = [];
//      window.startSpinner();
      scope.requestSent = true;

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
          window.stopLoaderDots();
          scope.requestSent = false;
          if (fromScroll) {
            scope.serviceList.pop();
          }

          if (result[0][0].error == 0) {
            if (result[1][0]) {

              for (var i in result[1]) {
                scope.serviceList.push(result[1][i]);
              }
              if (scope.serviceList.length % 20 == 0) {
                scope.serviceList.push({});
              }

            }
            sessionStorage.setItem('click_client_inPlacePayServiceList', JSON.stringify(scope.serviceList));
            console.log("Update", scope.serviceList);
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
          window.stopSpinner();
          window.stopLoaderDots();
          scope.requestSent = false;
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

    } else if (localStorage.getItem('location_find') && JSON.parse(localStorage.getItem('location_find'))) {
      //      window.startSpinner();
      window.startLoaderDots();
      findLocation();

    } else {
      //      window.startSpinner();
      window.startLoaderDots();
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
        console.log('clearing timer on goToBack');
        window.clearTimeout(timeOutTimer);
        window.clearTimeout(timeOutTimerThree);
        onBackKeyDown();
        scope.unmount()
      }
    };

    colorFieldInplaceSearch = function () {
      searchFieldActive = true;
      searchContainerId.style.borderBottom = "" + 3 * widthK + "px solid #01cfff";
      if (document.getElementById('searchIcon'))
        searchIcon.style.backgroundImage = 'url(resources/icons/ViewInPlacePay/indoor_search_blue.png)';
    };

    blurFieldInplaceSearch = function () {
      searchFieldActive = false;
      searchContainerId.style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb";
      if (document.getElementById('searchIcon'))
        searchIcon.style.backgroundImage = 'url(resources/icons/ViewInPlacePay/indoor_search.png)';
    };

    keyUpFieldInplaceSearch = function () {

      if (event.keyCode === input_codes.ENTER) {
        window.blurFields();
      }

      clearTimeout(searchFieldTimeout);

      searchFieldTimeout = setTimeout(function () {
        scope.pageNumber = 1;
        scope.serviceList = [];
        scope.update();
        scope.searchMode = false;
        console.log("key down");
        window.startLoaderDots();
        searchServiceByWord();
      }, 500);
    };

    onInputSearchField = function () {
      if (searchInputId.value.length == 0) {
        scope.showSearchIcon = true;
      } else {
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
        scope.searchMode = false;
        scope.pageNumber = 1;
        scope.serviceList = [];
        scope.update();
//        window.startSpinner();
        window.startLoaderDots();
        console.log("search remove");
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
                    result[1][0].fromQrScan = true;
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
      if (scrolling) {
        isServiceClick = false;
        return;
      }
      isServiceClick = true;

      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {
      if(!isServiceClick) return;

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

              history.arrayOfHistory = JSON.parse(sessionStorage.getItem('history'));
              history.arrayOfHistory[history.arrayOfHistory.length - 1].params.searchWord = searchWord;
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

              scope.serviceList[i].fromQrScan = false;
              console.log("service to open", scope.serviceList[i]);
              if (scope.serviceList[i].qr_only == 1) {
                riotTags.innerHTML = "<view-qr-only>";
                riot.mount('view-qr-only', scope.serviceList[i]);
              } else {
                riotTags.innerHTML = "<view-qr>";
                riot.mount('view-qr', scope.serviceList[i]);
              }

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

      console.log("touch start container");

      if (searchFieldActive) {
        console.log("bluring fields");
        window.blurFields();
        searchFieldActive = false;
      }

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
      scrolling = true;

      window.clearTimeout(scrollTimer);
      scrollTimer = setTimeout(function() {
        scrolling = false;
      }, 66);

      if ((categoriesContainerId.scrollHeight - categoriesContainerId.scrollTop) == categoriesContainerId.offsetHeight && categoriesContainerId.scrollTop != 0) {

        if (scope.serviceList.length % 20 == 1 && !scope.requestSent) {
          scope.pageNumber++;
//          window.startPaginationLoaderDots("categoriesContainerId");
          if (searchInputId.value.length != 0) {
            searchServiceByWord(true);
          }
          else {
            getServiceList(true);
          }
        }
      }

    };

    scope.searchServiceByWord = searchServiceByWord = function (fromScroll) {
      searchWord = searchInputId.value;

      if (modeOfApp.onlineMode) {

        scope.update();
        scope.requestSent = true;

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
            scope.requestSent = false;

            if (scope.pageNumber == 1)
              scope.serviceList = [];

            scope.searchMode = true;
            window.stopSpinner();
            window.stopLoaderDots();
            if (fromScroll) {
              scope.serviceList.pop();
            }

            if (result[0][0].error == 0) {
              if (result[1][0]) {

                for (var i in result[1]) {
                  scope.serviceList.push(result[1][i]);
                }
                if (scope.serviceList.length % 20 == 0) {
                  scope.serviceList.push({});
                }

              }
              sessionStorage.setItem('click_client_inPlacePayServiceList', JSON.stringify(scope.serviceList));
              console.log("search Update", scope.serviceList);
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
            window.stopSpinner();
            window.stopLoaderDots();
            scope.requestSent = false;
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


  </script>
</view-inplace-pay-service>

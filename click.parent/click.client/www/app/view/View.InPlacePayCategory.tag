<view-inplace-pay-category>
  <div class="view-pay riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="back-button"></div>
    </div>

    <div class="inplace-pay-category-container">

      <div class="inplace-pay-search-container">
        <div class="inplace-pay-search-field" id="searchContainerId">
          <input class="inplace-pay-search-input-part" type="text" id="searchInputId"
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

      <div class="inplace-pay-category-inner-container" if="{!searchServices}"
           ontouchstart="servicesBodyContainerTouchStart()">
        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in categoryList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode)}" class="inplace-pay-block-containter" title="{i.category_name}"
                 id="{i.category_id}"
                 ontouchstart="onTouchStartOfCategory(this.id)"
                 ontouchend="onTouchEndOfCategory(this.id, this.title)">
              <div class="inplace-pay-category-icon" style="background-image: url({i.icon})"></div>
              <div class="inplace-pay-category-name-field">{i.category_name}
              </div>
              <div class="inplace-pay-icon-tick"></div>
            </div>
          </li>
        </ul>
      </div>

      <div class="inplace-pay-service-inner-container" if="{searchServices}" id="categoriesContainerId"
           onscroll="servicesScroll()"
           ontouchmove="servicesBodyContainerTouchMove()"
           ontouchstart="servicesBodyContainerTouchStart()"
           ontouchend="servicesBodyContainerTouchEnd()">

        <div each="{i in serviceList}" if="{!(modeOfApp.offlineMode)}" class="inplace-pay-service-container"
             id="{i.id}"
             ontouchstart="onTouchStartOfService(this.id)"
             ontouchend="onTouchEndOfService(this.id)">
          <img id="{i.id+'_image'}"
               class="inplace-pay-service-icon" src="{i.image}"
               onload="clearLoaderOnIconLoad(this.id)">
          <div class="inplace-pay-service-info">
            <div class="inplace-pay-service-name-field">{i.name}</div>
            <div class="inplace-pay-service-address-field">{i.address}</div>
            <div class="inplace-pay-service-distance-container" if="{i.distance && i.distance!=null}">
              <div class="inplace-pay-service-distance-icon"></div>
              <div class="inplace-pay-service-distance-field">{i.distance}</div>
            </div>
          </div>
          <div class="inplace-pay-service-icon-tick"></div>
          <div class="inplace-title-bottom-border"></div>
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
    <div class="inplace-pay-gotoqr-label">Сканер QR</div>
  </div>


  <script>

    var scope = this;
    scope.checkOfSearch = false;
    scope.titleName = window.languages.ViewInPlacePayTitle;
    var onTouchStartY, onTouchStartX,
      onTouchEndY, onTouchEndX;
    var goBackButtonStartX, goBackButtonEndX,
      goBackButtonStartY, goBackButtonEndY;
    var qrPayStartX, qrPayEndX, qrPayStartY, qrPayEndY;
    var searchStartX, searchEndX, searchStartY, searchEndY;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;
    var mainPageToReturn = "view-main-page";
    var timeOutTimer = 0;
    var timeOutTimerThree = 0;
    scope.searchServices = false;
    scope.showSearchIcon = true;
    scope.pageNumber = 1;
    scope.serviceList = [];
    scope.searchMode = false;
    var stepBack = 1;
    var searchFieldTimeout, searchFieldActive = false, searchWord;
    qrScaner.qrInited = false;

    console.log("OPTS in InplacePayCategory", opts);
    window.saveHistory('view-inplace-pay-category', opts);

    scope.on('mount', function () {

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

        };

        // onError Callback receives a PositionError object
        //
        function onGeoError(error) {
          console.log("Error in getting position", error)
        }

        navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError, geoOptions);

      } catch (e) {
        console.log("Geolocation error =", e);
      }
    };

    console.log("location_find=", localStorage.getItem('location_find'));
    if (localStorage.getItem('location_find') && JSON.parse(localStorage.getItem('location_find')))
      findLocation();

    if (JSON.parse(sessionStorage.getItem('click_client_inPlacePayCategoryList'))) {
      scope.categoryList = JSON.parse(sessionStorage.getItem('click_client_inPlacePayCategoryList'));
      scope.update();
    }
    else if (modeOfApp.onlineMode) {

      scope.categoryList = [];
      window.startSpinner();

      window.api.call({
        method: 'get.indoor.category.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          console.log('Clearing timer onSuccess', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          window.stopSpinner();

          if (result[0][0].error == 0) {
            if (result[1][0]) {


              for (var i in result[1]) {

                scope.categoryList.push(result[1][i]);

              }
              sessionStorage.setItem('click_client_inPlacePayCategoryList', JSON.stringify(scope.categoryList));
              console.log("category list = ", scope.categoryList);
              scope.update();
            }
          } else {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              viewpage: mainPageToReturn,
              errornote: result[0][0].error_note
            });
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.log('Clearing timer onFail', timeOutTimer);
          window.clearTimeout(timeOutTimer);
          window.common.alert.show("componentAlertId", {
            parent: scope,
            viewpage: mainPageToReturn,
            errornote: window.languages.ServiceUnavailableText
          });
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        },
        onTimeOut: function () {
          timeOutTimer = setTimeout(function () {
            window.writeLog({
              reason: 'Timeout',
              method: 'get.indoor.category.list',
            });
            window.common.alert.show("componentAlertId", {
              parent: scope,
              viewpage: mainPageToReturn,
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

    onTouchStartOfSearchCategory = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchIcon)
        searchIcon.style.webkitTransform = 'scale(0.7)';

      searchStartX = event.changedTouches[0].pageX;
      searchStartY = event.changedTouches[0].pageY;

    };

    onTouchEndOfSearchCategory = function () {
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
        scope.update();
        scope.pageNumber = 1;
        scope.serviceList = [];
//        window.startSpinner();
        window.startLoaderDots();
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

    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {

      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id, name) {

      event.preventDefault();
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) {

        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';

        setTimeout(function () {
          document.getElementById(id).style.backgroundColor = 'transparent';
          console.log(id, name);

          sessionStorage.setItem('click_client_inPlacePayServiceList', JSON.stringify(null));
          window.clearTimeout(timeOutTimer);

          riotTags.innerHTML = "<view-inplace-pay-service>";
          riot.mount('view-inplace-pay-service', {
            categoryId: id,
            categoryName: name
          });
          scope.unmount();
        }, 50)

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

    keyDownFieldInplaceSearch = function () {

      if (event.keyCode === input_codes.ENTER) {
        window.blurFields();
      }

      clearTimeout(searchFieldTimeout);

      searchFieldTimeout = setTimeout(function () {
        scope.pageNumber = 1;
        scope.serviceList = [];
        scope.searchMode = false;
//        if (!scope.searchServices) scope.searchServices = true;
        window.saveHistory('view-inplace-pay-service', {categoryId: 0, categoryName: scope.titleName});
        scope.update();
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

    servicesScroll = function () {

      if ((categoriesContainerId.scrollHeight - categoriesContainerId.scrollTop) == categoriesContainerId.offsetHeight && categoriesContainerId.scrollTop != 0) {

        if (scope.serviceList.length % 20 == 0 && scope.searchServices) {
          scope.pageNumber++;
          window.startPaginationLoaderDots();
          searchServiceByWord();
        }
      }

    };

    servicesBodyContainerTouchMove = function () {

      if (device.platform == 'Android' && scope.searchServices) {

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

      if (device.platform == 'Android' && scope.searchServices) {

        servicesStartX = event.changedTouches[0].pageX;
        servicesStartY = event.changedTouches[0].pageY;

        top = -servicesStartY;
      }
    };

    servicesBodyContainerTouchEnd = function () {


      if (device.platform == 'Android' && scope.searchServices) {

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

    scope.searchServiceByWord = searchServiceByWord = function () {

      searchWord = searchInputId.value;

      if (modeOfApp.onlineMode) {

        scope.searchServices = true;
        scope.update();

        scope.searchMode = false;

        window.api.call({
          method: 'get.indoor.service.list',
          input: {
            session_key: sessionKey,
            phone_num: phoneNumber,
            category_id: 0,
            location: inPlacePay.latitude + " " + inPlacePay.longitude,
            search: searchWord,
            page_number: parseInt(scope.pageNumber)
          },
          scope: this,

          onSuccess: function (result) {

            console.log("pageNumber=", scope.pageNumber, ", list size=", scope.serviceList.length);
            if (scope.pageNumber == 1)
              scope.serviceList = [];

            scope.searchMode = true;
//            window.stopSpinner();
            window.stopLoaderDots();

            if (result[0][0].error == 0) {
              if (result[1][0]) {

                for (var i in result[1]) {
                  scope.serviceList.push(result[1][i]);
                }

              }
              sessionStorage.setItem('click_client_inPlacePayServiceList', JSON.stringify(scope.serviceList));
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
//            window.stopSpinner();
            window.stopLoaderDots();
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
              viewPay.searchServices = true;
              scope.serviceList[i].location = inPlacePay.latitude + " " + inPlacePay.longitude;

              history.arrayOfHistory = JSON.parse(sessionStorage.getItem('history'));
              history.arrayOfHistory[history.arrayOfHistory.length - 1].params.searchWord = searchWord;
              sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

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

  </script>
</view-inplace-pay-category>

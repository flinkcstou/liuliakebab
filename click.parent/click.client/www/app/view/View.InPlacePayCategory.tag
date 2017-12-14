<view-inplace-pay-category>
  <div id="viewPayId" class="view-pay riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>

    <div class="inplace-pay-category-container" id="categoriesContainerId">

      <div id="searchContainerId" class="inplace-pay-search-container">
        <input id="searchInputId" class="inplace-pay-search-input"/>
      </div>

      <div class="inplace-pay-inner-container">
        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in categoryList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode)}" class="inplace-pay-block-containter" id="{i.category_id}"
                 ontouchstart="onTouchStartOfCategory(this.id)"
                 onclick="onTouchEndOfCategory(this.id)">
              <div class="inplace-pay-category-icon" style="background-image: url({i.icon})"></div>
              <div class="inplace-pay-category-name-field">{i.category_name}
              </div>
              <div class="inplace-pay-icon-tick"></div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <script>

    var scope = this;
    scope.checkOfSearch = false;

    scope.titleName = window.languages.ViewInPlacePayTitle;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-inplace-pay-category') {
      history.arrayOfHistory.push(
        {
          "view": 'view-inplace-pay-category',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;

    if (JSON.parse(sessionStorage.getItem('click_client_inPlacePayCategoryList'))) {
      scope.categoryList = JSON.parse(sessionStorage.getItem('click_client_inPlacePayCategoryList'));
      scope.update();
    }
    else if (modeOfApp.onlineMode) {

      scope.categoryList = [];

      window.api.call({
        method: 'get.indoor.category.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0]) {


              for (var i in result[1]) {

                scope.categoryList.push(result[1][i]);

              }
              sessionStorage.setItem('click_client_inPlacePayCategoryList', JSON.stringify(scope.categoryList));
              scope.update();

            }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)'

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown()
        scope.unmount()
      }
    };

    findLocation = function () {

      console.log("find location method");

      // onSuccess Callback
      // This method accepts a Position object, which contains the
      // current GPS coordinates
      //

      var geoOptions = {timeout: 5000, enableHighAccuracy: true};
      var onGeoSuccess = function (position) {
        console.log("Success in getting position", position)
        alert('Latitude: ' + position.coords.latitude + '\n' +
          'Longitude: ' + position.coords.longitude + '\n' +
          'Altitude: ' + position.coords.altitude + '\n' +
          'Accuracy: ' + position.coords.accuracy + '\n' +
          'Altitude Accuracy: ' + position.coords.altitudeAccuracy + '\n' +
          'Heading: ' + position.coords.heading + '\n' +
          'Speed: ' + position.coords.speed + '\n' +
          'Timestamp: ' + position.timestamp + '\n');
      };

      // onError Callback receives a PositionError object
      //
      function onGeoError(error) {
        console.log("Error in getting position", error)
        alert('code: ' + error.code + '\n' +
          'message: ' + error.message + '\n');
      }

      navigator.geolocation.getCurrentPosition(onGeoSuccess, onGeoError, geoOptions);
    };

    //    findLocation();

    scope.index = -1;
    scope.show = false;
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {
      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {

//      if (scope.index != id)
//        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)'
//
//
//      setTimeout(function () {
//        document.getElementById(id).style.backgroundColor = 'transparent'
//      }, 100)
//
//
//      onTouchEndY = event.pageY;
//      onTouchEndX = event.pageX;
//
//
//      setTimeout(function () {
//
//
//        if ((Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) || scope.checkOfSearch) {
//
//
//          if (scope.index == id) {
//            scope.index = -1;
//          } else {
//            if (scope.index != -1) {
//              document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
//            }
//            scope.index = id;
//          }
//
//          scope.currentList = scope.servicesMapByCategory[id];
////        count = 1;
//
//
//          if (!scope.currentList) {
//            scope.show = false;
//          } else {
//            scope.show = true;
//            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
//          }
//
//          if (scope.index == id && scope.show) {
//            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
//            viewPay.categoryId = id;
//            opts.categoryId = id;
//            hintUpdate(scope.index);
//          }
//
//          document.getElementById(id).scrollIntoView();
////        categoriesContainerId.scrollIntoView(document.getElementById(id).offsetTop)
//
////        categoriesContainerId.scrollTop = event.changedTouches[0].pageY;
//
//          scope.update();
//        }
//      }, 100)
    };

    window.viewServicePinCards = {};


  </script>
</view-inplace-pay-category>

<view-inplace-pay-service>
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
          <li each="{i in serviceList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode)}" class="inplace-pay-service-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfCategory(this.id)"
                 onclick="onTouchEndOfCategory(this.id)">
              <div class="inplace-pay-service-icon" style="background-image: url({i.image})"></div>
              <div class="inplace-pay-service-name-field">{i.name}
              </div>
              <div class="inplace-pay-icon-tick"></div>
            </div>
          </li>
        </ul>
      </div>
    </div>
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
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;


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
        console.log("Success in getting position", position)
        alert('Latitude: ' + position.coords.latitude + '\n' +
          'Longitude: ' + position.coords.longitude + '\n' +
          'Altitude: ' + position.coords.altitude + '\n' +
          'Accuracy: ' + position.coords.accuracy + '\n' +
          'Altitude Accuracy: ' + position.coords.altitudeAccuracy + '\n' +
          'Heading: ' + position.coords.heading + '\n' +
          'Speed: ' + position.coords.speed + '\n' +
          'Timestamp: ' + position.timestamp + '\n');
        getServiceList(position.coords.latitude, position.coords.longitude);

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


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {
      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {


    };


  </script>
</view-inplace-pay-service>

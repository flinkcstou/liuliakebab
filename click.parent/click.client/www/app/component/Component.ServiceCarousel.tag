<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()"
       ontouchend="touchEndService()" ontouchmove="touchMoveService()">
    <div class="service-component">
      <div class="service-title">{window.languages.ComponentServiceTitle}</div>
      <div class="service-container">

        <div class="service-each-container" each="{i in popularServiceList}">
          <div id="{i.id}" class="service-buttons"
               ontouchend="goToServicePage(this.id)" style="background-image: url({i.image})">
          </div>
          <p class="service-labels">{i.name}</p>
        </div>


      </div>
    </div>
    <component-service style="left: {leftOfServiceCarousel}px"></component-service>
  </div>

  <script>

    var scope = this;
    var leftOfDelta;
    var cardNumberOfService = 0;
    scope.popularServiceList = JSON.parse(localStorage.getItem("click_client_popularServiceList"));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    scope.operatorKey = phoneNumber.substr(3, 2);


    if (!scope.popularServiceList) {
      scope.popularServiceList = [];
      window.api.call({
        method: 'get.popular.services',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            if (result[1][0]) {

//              if (device.platform != 'BrowserStand') {
//                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
//                  var j = -1;
//
//                  for (var i = 0; i < 3; i++) {
//
//                    scope.categoryList.push(result[1][i]);
//
//                    var icon = result[1][i].icon;
//                    var filename = icon.substr(icon.lastIndexOf('/') + 1);
//
//                    var newIconBool = checkImageURL;
//                    newIconBool('www/resources/icons/ViewPay/category/', filename, icon, j, function (bool, index, fileName) {
//
//                      if (bool) {
//                        scope.categoryList[index]['icon'] = cordova.file.dataDirectory + fileName;//
//                      } else {
//                        scope.categoryList[index]['icon'] = cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/category/' + fileName;
//                      }
//
//
//                      if (result[1].length == scope.categoryList.length) {
//                        console.log("save into localstorage, categoryList=", scope.categoryList);
//                        riot.update(scope.categoryList);
//                      }
//                    });
//                  }
//                }, onErrorLoadFs);
//              }
//              else {
              for (var i in result[1]) {
                console.log("FTYFJUKVG", result[1][i]);
                scope.popularServiceList.push(result[1][i]);
              }
              var myNumberObject = {};
              myNumberObject.name = 'Мой номер';
              myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
              myNumberObject.id = 'mynumber' + localStorage.getItem('myNumberOperatorId');
              scope.popularServiceList.push(myNumberObject);
              console.log("popular services", scope.popularServiceList);
              riot.update(scope.popularServiceList);
              localStorage.setItem('click_client_popularServiceList', JSON.stringify(scope.popularServiceList));
//              }
            }
          }
          else {
            alert(result[0][0].error_note);
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    scope.leftOfServiceCarousel = 640 * widthK;

    goToServicePage = function (id) {

      console.log("chosen id in pay view=", id);
      viewPay.chosenServiceId = id;
      event.stopPropagation();

      localStorage.setItem('chosenServiceId', id);
      riotTags.innerHTML = "<view-service-page>";
      riot.mount("view-service-page");
    }

    var delta;
    touchStartService = function () {
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(100 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    }

    touchEndService = function () {
      event.preventDefault();
      event.stopPropagation();
      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX)
        changePosition();
    }

    touchMoveService = function () {
      this.containerService.style.transition = '0s';
      this.containerService.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.containerService.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.containerService.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    }

    changePosition = function () {
      if (touchEndX < touchStartX) {
        cardNumberOfService = 1;
        this.containerService.style.transform = "translate3d(" + -100 * widthK + "px, 0, 0)";
        this.containerService.style.webkitTransform = "translate3d(" + -100 * widthK + "px, 0, 0)";
        this.containerService.style.transition = '0.3s';
        this.containerService.style.webkitTransition = '0.3s';
      }

      if (touchEndX > touchStartX) {
        cardNumberOfService = 0;
        this.containerService.style.transform = "translate3d(0, 0, 0)";
        this.containerService.style.webkitTransform = "translate3d(0, 0, 0)";
        this.containerService.style.transition = '0.3s';
        this.containerService.style.webkitTransition = '0.3s';
      }
    }


  </script>
</component-service-carousel>
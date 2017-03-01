<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()"
       ontouchend="touchEndService()" ontouchmove="touchMoveService()">
    <div class="service-component">
      <div class="service-title">{window.languages.ComponentPopularServicesTitle}</div>
      <div class="service-container">
        <div class="service-each-container" each="{i in popularServiceList}">
          <div id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfService()"
               ontouchend="ontouchEndOfService(this.id)" ontouchmove="ontouchMoveOfService()"
               style="background-image: url({i.image})">
          </div>
          <p class="service-labels">{i.name}</p>
        </div>
      </div>
    </div>

    <div class="service-component" style="left: {leftOfServiceCarousel}px">
      <div class="service-title">{window.languages.ComponentFavoritePaymentsTitle}</div>
      <div class="service-container" if="{hasFavorites}">
        <div class="service-each-container" each="{i in favPaymentsList}">
          <div id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfPayment()"
               ontouchend="ontouchEndOfPayment(this.id)" style="background-image: url({i.image})">
          </div>
          <p class="service-labels">{i.name}</p>
        </div>
      </div>
    </div>


  </div>

  <script>

    var scope = this;
    var leftOfDelta;
    var cardNumberOfService = 0;
    scope.popularServiceList = JSON.parse(localStorage.getItem("click_client_popularServiceList"));
    scope.favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;
    scope.operatorKey = phoneNumber.substr(3, 2);
    this.hasFavorites = false;


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
                if (scope.popularServiceList.length < 4) {
                  console.log("FTYFJUKVG", result[1][i]);
                  scope.popularServiceList.push(result[1][i]);
                }
              }
              if (scope.popularServiceList.length == 3) {
                var myNumberObject = {};
                myNumberObject.name = 'Мой номер';
                myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                myNumberObject.id = 'mynumber' + localStorage.getItem('myNumberOperatorId');
                scope.popularServiceList.push(myNumberObject);
              }

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


    if (scope.favoritePaymentsList) {
      console.log("list", scope.favoritePaymentsList);
      this.hasFavorites = true;
      scope.favPaymentsList = [];
      for (var i in scope.favoritePaymentsList) {
        if (scope.favPaymentsList.length < 4)
          scope.favPaymentsList.push(scope.favoritePaymentsList[i].service);
        else break;
      }
      riot.update(scope.favPaymentsList);
    }

    var delta;
    touchStartService = function () {
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
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
        this.containerService.style.transform = "translate3d(" + -540 * widthK + "px, 0, 0)";
        this.containerService.style.webkitTransform = "translate3d(" + -540 * widthK + "px, 0, 0)";
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


    scope.ontouchStartOfService = ontouchStartOfService = function () {
      event.stopPropagation();
      onTouchStartX = event.changedTouches[0].pageX;
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    scope.ontouchEndOfService = ontouchEndOfService = function (id) {
      event.stopPropagation();

      onTouchEndX = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX - onTouchEndX) <= 20) {
        console.log("chosen id in service carousel=", id);
        viewPay.chosenServiceId = id;
        event.stopPropagation();

        localStorage.setItem('chosenServiceId', id);
        riotTags.innerHTML = "<view-service-page>";
        riot.mount("view-service-page");
      }
      if (touchStartX != touchEndX)
        changePosition();
    };

    ontouchMoveOfService = function () {
      this.containerService.style.transition = '0s';
      this.containerService.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.containerService.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.containerService.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    }

    scope.ontouchStartOfPayment = ontouchStartOfPayment = function () {
      event.stopPropagation();
      onTouchStartX2 = event.changedTouches[0].pageX;
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    scope.ontouchEndOfPayment = ontouchEndOfPayment = function (id) {
      event.stopPropagation();

      onTouchEndX2 = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX2 - onTouchEndX2) <= 20) {
        console.log("chosen id in payments carousel=", id);
        for (var i in scope.favoritePaymentsList) {
          if (scope.favoritePaymentsList[i].service.id == id) {
            console.log("gnrf", scope.favoritePaymentsList[i].opts);
            viewPay.chosenServiceId = id;
            viewPay.categoryId = scope.favoritePaymentsList[i].categoryId;
            viewServicePage.firstFieldTitle = scope.favoritePaymentsList[i].firstFieldTitle;
            viewPayConfirm.isInFavorites = true;
            event.stopPropagation();
            this.riotTags.innerHTML = "<view-pay-confirm>";
            riot.mount('view-pay-confirm', [scope.favoritePaymentsList[i].opts[0], scope.favoritePaymentsList[i].opts[1]]);

          }

        }

      }
      if (touchStartX != touchEndX)
        changePosition();
    };


  </script>
</component-service-carousel>
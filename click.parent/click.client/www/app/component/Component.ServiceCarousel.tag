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
      <div class="service-container">
        <div class="service-each-container" each="{i in favPaymentsList}">
          <div id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfPayment()"
               ontouchend="ontouchEndOfPayment(this.id)" style="background-image: url({i.image})">
          </div>
          <p class="service-labels">{i.name}</p>
        </div>
        <div class="service-each-container" if="{addFavoriteBool}">
          <div id="addFavoriteButtonId" class="service-buttons" ontouchstart="ontouchStartOfPayment()"
               ontouchend="ontouchEndOfAddFavorite()"
               style="background-image: url('resources/icons/services/favorites_add.png'); background-size: 46%;">
          </div>
          <p class="service-labels">Добавить</p>
        </div>
      </div>
    </div>


  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>

    var scope = this;
    var leftOfDelta;
    var cardNumberOfService = 0;
    scope.popularServiceList = (modeOfApp.onlineMode) ? (JSON.parse(localStorage.getItem("click_client_popularServiceList"))) : (offlinePopularServiceList);
    scope.favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    if (JSON.parse(localStorage.getItem('click_client_loginInfo')) && modeOfApp.onlineMode)
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

    if (phoneNumber && modeOfApp.onlineMode)
      scope.operatorKey = phoneNumber.substr(3, 2);
    scope.addFavoriteBool = true;

    scope.showError = false;

    if (!scope.popularServiceList && modeOfApp.onlineMode) {
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

              if (device.platform != 'BrowserStand') {
                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                  var j = -1;

                  for (var i = 0; i < 3; i++) {
                    j++;
                    scope.popularServiceList.push(result[1][i]);

                    var icon = result[1][i].image;
                    var filename = icon.substr(icon.lastIndexOf('/') + 1);

                    var newIconBool = checkImageURL;
                    newIconBool('www/resources/icons/ViewPay/', 'ViewPay', filename, icon, j, function (bool, index, fileName) {

                      if (bool) {
                        scope.popularServiceList[index]['image'] = cordova.file.dataDirectory + fileName;
                        console.log("1.index=", index, ",imageUrl=", scope.popularServiceList[index]['image']);
                      } else {
                        scope.popularServiceList[index]['image'] = cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/service/' + fileName;
                        console.log("2.index=", index, ",imageUrl=", scope.popularServiceList[index]['image']);
                      }

                      if (scope.popularServiceList.length == 3) {
                        var myNumberObject = {};
                        myNumberObject.name = 'Мой номер';
                        myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                        myNumberObject.id = 'mynumber' + localStorage.getItem('myNumberOperatorId');
                        scope.popularServiceList.push(myNumberObject);
                        console.log("popular services", scope.popularServiceList);
                        riot.update(scope.popularServiceList);
                        localStorage.setItem('click_client_popularServiceList', JSON.stringify(scope.popularServiceList));
                      }
                    });
                  }


                }, onErrorLoadFs);
              }
              else {
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
              }
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            riot.update();
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
//      console.log("list", scope.favoritePaymentsList);
      scope.favPaymentsList = [];
      for (var i in scope.favoritePaymentsList) {
        if (scope.favPaymentsList.length < 4)
          scope.favPaymentsList.push(scope.favoritePaymentsList[i].service);
        else break;
      }
      if (scope.favPaymentsList.length >= 4)
        scope.addFavoriteBool = false;
      riot.update(scope.favPaymentsList);
      riot.update(scope.addFavoriteBool);
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

            if (modeOfApp.offlineMode) {
              var firstFieldText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].opts[2].firstFieldText)
              var amountText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].opts[5].amountText)
              var formtype = scope.favoritePaymentsList[i].opts[0].formtype
              var communalParam = scope.favoritePaymentsList[i].opts[4].communalParam
              var firstFieldId = scope.favoritePaymentsList[i].opts[1].firstFieldId


              var ussdQuery = scope.favoritePaymentsList[i].ussd;

              if (formtype == 1) {
                if (firstFieldText) {
                  ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                }
                else {
                  ussdQuery = ussdQuery.replace('*{param}', firstFieldText);
                }
                ussdQuery = ussdQuery.replace('{option}', firstFieldId);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
                console.log(ussdQuery)
              }

              if (formtype == 2) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
                console.log(ussdQuery)
              }

              if (formtype == 3) {
                ussdQuery = ussdQuery.replace('{communal_para}', communalParam);
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
                console.log(ussdQuery)
              }

              if (formtype == 4) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1)
                console.log(ussdQuery)
              }


              console.log(ussdQuery)

              phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
                ussdQuery + "%23",
                function (err) {
                  if (err == "empty") {
                    scope.clickPinError = false;
                    scope.errorNote = ("Unknown phone number");
                    scope.showError = true;
                    riot.update();
                  }
                  else console.log("Dialer Error:" + err);
                },
                function (success) {
                }
              );
              return
            }

            this.riotTags.innerHTML = "<view-service-pincards>";
            riot.mount('view-service-pincards', scope.favoritePaymentsList[i].opts);

          }

        }

      }
      if (touchStartX != touchEndX)
        changePosition();
    };

    scope.ontouchEndOfAddFavorite = ontouchEndOfAddFavorite = function () {
      event.stopPropagation();

      onTouchEndX2 = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX2 - onTouchEndX2) <= 20) {
        console.log("ADD NEW FAVORITE");
        event.stopPropagation();
        this.riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay', ['ADDFAVORITE']);
      }
      if (touchStartX != touchEndX)
        changePosition();
    };


  </script>
</component-service-carousel>
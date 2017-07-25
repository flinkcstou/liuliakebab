<component-service-carousel-new>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()"
       ontouchend="touchEndService()" ontouchmove="touchMoveService()">
    <div class="service-component" style="left: {leftOfServiceCarousel}px">
      <div class="service-title">{window.languages.ComponentPopularServicesTitle}</div>
      <div class="service-container">
        <div class="service-each-container" each="{i in popularServiceList}">
          <div id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfService(this.id)"
               ontouchend="ontouchEndOfService(this.id)" ontouchmove="ontouchMoveOfService()"
               style="background-image: url({i.image})">
          </div>
          <p class="service-labels">{i.name}</p>
        </div>
      </div>
    </div>

    <div class="service-component">
      <div id="openFavouriteId" class="service-title" ontouchstart="openFavouriteStart()"
           ontouchend="openFavouriteEnd()">{window.languages.ComponentFavoritePaymentsTitle}
        <div class="service-component-open-icon"></div>
      </div>
      <div class="service-container">
        <div class="service-each-container" each="{i in favoritePaymentsList}">
          <div id="{i.service.id+'index'}" class="service-buttons" ontouchstart="ontouchStartOfPayment(this.id)"
               ontouchend="ontouchEndOfPayment(this.id)" style="background-image: url({i.service.image})">
          </div>
          <p class="service-labels">{i.params.favoriteName?i.params.favoriteName: i.service.name}</p>
        </div>
        <div class="service-each-container" if="{addFavoriteBool}">
          <div id="addFavoriteButtonId" class="service-buttons" ontouchstart="ontouchStartOfPayment(this.id)"
               ontouchend="ontouchEndOfAddFavorite(this.id)"
               style="background-image: url('resources/icons/services/favorites_add.png'); background-size: 46%;">
          </div>
          <p class="service-labels">Добавить</p>
        </div>
      </div>
    </div>


  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <component-confirm if="{confirmShowBool}" confirmnote="{confirmNote}"
                     confirmtype="{confirmType}"></component-confirm>

  <script>

    var scope = this;
    var leftOfDelta;
    var cardNumberOfService = 0;
    window.viewServicePage = {};
    window.viewServicePinCards = {};
    localStorage.setItem('servicepage_fields', null);

    if (modeOfApp.offlineMode) {
      scope.popularServiceList = localStorage.getItem("click_client_popularServiceList") ? (JSON.parse(localStorage.getItem("click_client_popularServiceList"))) : (offlinePopularServiceList);
    }
    else {
      scope.popularServiceList = JSON.parse(localStorage.getItem("click_client_popularServiceList"));
      scope.update();
    }
    scope.favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);


    var phoneNumber = localStorage.getItem('click_client_phoneNumber');

    if (JSON.parse(localStorage.getItem('click_client_loginInfo')) && modeOfApp.onlineMode)
      var sessionKey = JSON.parse(localStorage.getItem('click_client_loginInfo')).session_key;

    if (phoneNumber && modeOfApp.onlineMode)
      scope.operatorKey = phoneNumber.substr(3, 2);
    scope.addFavoriteBool = true;

    scope.showError = false;

    if (!localStorage.getItem("click_client_popularServiceList") && modeOfApp.onlineMode) {
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
                        scope.popularServiceList[index].image = cordova.file.dataDirectory + fileName;
                        console.log("1.index=", index, ",imageUrl=", scope.popularServiceList[index].image);
                      } else {
                        scope.popularServiceList[index].image = 'resources/icons/ViewPay/' + fileName;
                        console.log("2.index=", index, ",imageUrl=", scope.popularServiceList[index]['image']);
                      }

                      if (scope.popularServiceList.length == 3) {
                        var myNumberObject = {};
                        myNumberObject.name = 'Мой номер';
                        myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                        myNumberObject.id = 'mynumber' + localStorage.getItem('myNumberOperatorId');
                        scope.popularServiceList.push(myNumberObject);
                        console.log("popular services", scope.popularServiceList);
                        scope.update();
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
                scope.update();
                localStorage.setItem('click_client_popularServiceList', JSON.stringify(scope.popularServiceList));
//              popularServiceImagesCaching();
              }
            }
          }
          else {
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            scope.update();
          }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }

    //    popularServiceImagesCaching = function () {
    //      if (device.platform != 'BrowserStand') {
    //        window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
    //          var j = -1, counter = 0;
    //
    //          for (var i = 0; i < 3; i++) {
    //            j++;
    //
    //            var icon = scope.popularServiceList[i].image;
    //            var filename = icon.substr(icon.lastIndexOf('/') + 1);
    //
    //            var newIconBool = checkImageURL;
    //            newIconBool('www/resources/icons/ViewPay/', 'ViewPay', filename, icon, j, function (bool, index, fileName) {
    //
    //              if (bool) {
    //                counter++;
    //                scope.popularServiceList[index].image = cordova.file.dataDirectory + fileName;
    //                console.log("popular service index=", index, ",imageUrl=", scope.popularServiceList[index].image);
    //
    //                if (counter == 3) {
    //
    //                  console.log("popular services CASHED", scope.popularServiceList);
    //                  scope.update();
    //                  localStorage.setItem('click_client_popularServiceList', JSON.stringify(scope.popularServiceList));
    //                }
    //
    //              }
    ////              else {
    ////                scope.popularServiceList[index]['image'] = 'resources/icons/ViewPay/' + fileName;
    ////                console.log("2.index=", index, ",imageUrl=", scope.popularServiceList[index]['image']);
    ////              }
    //
    //            });
    //          }
    //        }, onErrorLoadFs);
    //      }
    //    };


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
      scope.update();
    }


    var openFavouriteStartX, openFavouriteStartY, openFavouriteEndX, openFavouriteEndY;

    openFavouriteStart = function () {
      openFavouriteStartX = event.changedTouches[0].pageX;
      openFavouriteStartY = event.changedTouches[0].pageY;

      openFavouriteId.style.backgroundColor = 'rgba(150,150,150,0.5)'
    }
    openFavouriteEnd = function () {
      openFavouriteEndX = event.changedTouches[0].pageX;
      openFavouriteEndY = event.changedTouches[0].pageY

      openFavouriteId.style.backgroundColor = 'transparent'

      if (Math.abs(openFavouriteStartX - openFavouriteEndX) <= 20 && Math.abs(openFavouriteStartY - openFavouriteEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          scope.showError = true;
          scope.errorNote = question;
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }
        riotTags.innerHTML = "<view-favorites-new>";
        riot.mount("view-favorites-new");
      }
    }

    var delta, touchEndX, touchStartX;
    touchStartService = function () {
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    }

    touchEndService = function () {
      event.preventDefault();
      event.stopPropagation();

      console.log('TOUCH END SERVICE', touchEndX, touchStartX)
      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX) {
        changePositionOfServiceCarousel();
      }
    }

    touchMoveService = function () {
      this.containerService.style.transition = '0s';
      this.containerService.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.containerService.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.containerService.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    }

    changePositionOfServiceCarousel = function () {

      console.log('CHANGE POSITION', touchStartX)
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


    scope.ontouchStartOfService = ontouchStartOfService = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(0.7)'

      onTouchStartX = event.changedTouches[0].pageX;
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    scope.ontouchEndOfService = ontouchEndOfService = function (id) {
      event.stopPropagation();

      console.log('ID ID ID', id)

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      onTouchEndX = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;
//      if(modeOfApp.offlineMode && id.indexOf('mynumber') != -1){
//        return
//      }

      if (Math.abs(onTouchStartX - onTouchEndX) <= 20) {
        console.log("chosen id in service carousel NEW=", id);
        if (modeOfApp.offlineMode && id.indexOf('mynumber') != -1) {
          opts.chosenServiceId = 'mynumber';
        }
        else {
          opts.chosenServiceId = id;
          opts.id = id;
        }
        opts.mode = 'POPULAR';

        localStorage.setItem('chosenServiceId', id);
        riotTags.innerHTML = "<view-service-page-new>";
        riot.mount("view-service-page-new", opts);
        scope.unmount()
      }
      if (touchStartX != touchEndX)
        changePositionOfServiceCarousel();
    };

    ontouchMoveOfService = function () {
      this.containerService.style.transition = '0s';
      this.containerService.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.containerService.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.containerService.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    }

    scope.ontouchStartOfPayment = ontouchStartOfPayment = function (id) {
      console.log("chosen id in payments START=", id)
      document.getElementById(id).style.webkitTransform = 'scale(0.7)'
      event.stopPropagation();

      onTouchStartX2 = event.changedTouches[0].pageX;
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    scope.ontouchEndOfPayment = ontouchEndOfPayment = function (id) {
      console.log("chosen id in payments END=", id);
      document.getElementById(id).style.webkitTransform = 'scale(1)'

      id = id.split("index")[0]


      event.stopPropagation();

      onTouchEndX2 = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX2 - onTouchEndX2) <= 20) {
        console.log("chosen id in payments carousel=", id);
        for (var i in scope.favoritePaymentsList) {
          if (scope.favoritePaymentsList[i].service.id == id) {
            console.log("gnrf", scope.favoritePaymentsList[i].params);


            if (modeOfApp.offlineMode) {
              var firstFieldText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.firstFieldText);
              var amountText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.amountText);
              var formtype = scope.favoritePaymentsList[i].params.formtype;
              var communalParam = scope.favoritePaymentsList[i].params.communalParam;
              var firstFieldId = scope.favoritePaymentsList[i].params.firstFieldId;


              var ussdQuery = scope.favoritePaymentsList[i].ussd;

              if (formtype == 1 && ussdQuery) {
                if (firstFieldText) {
                  ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                }
                else {
                  ussdQuery = ussdQuery.replace('*{param}', firstFieldText);
                }
                ussdQuery = ussdQuery.replace('{option}', firstFieldId);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (formtype == 2 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (formtype == 3 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{communal_para}', communalParam);
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (formtype == 4 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (ussdQuery === null) {
                scope.clickPinError = false;
                scope.errorNote = ("Сервис временно недоступен!");
                scope.showError = true;
                scope.update();
                return
              }

              console.log(ussdQuery);

              phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
                ussdQuery + "%23",
                function (err) {
                  if (err == "empty") {
                    scope.clickPinError = false;
                    scope.errorNote = ("Unknown phone number");
                    scope.showError = true;
                    scope.update();
                  }
                  else console.log("Dialer Error:" + err);
                },
                function (success) {
                }
              );
              return
            }

            scope.service = scope.servicesMap[scope.favoritePaymentsList[i].params.chosenServiceId][0];

            if (scope.service.additional_information_type == 3) {
              this.riotTags.innerHTML = "<view-service-info>";
              riot.mount('view-service-info', scope.favoritePaymentsList[i].params);
              scope.unmount()
            } else {
              this.riotTags.innerHTML = "<view-service-pincards-new>";
              riot.mount('view-service-pincards-new', scope.favoritePaymentsList[i].params);
              scope.unmount()
            }


          }

        }

      }
      if (touchStartX != touchEndX)
        changePositionOfServiceCarousel();
    };

    scope.ontouchEndOfAddFavorite = ontouchEndOfAddFavorite = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      onTouchEndX2 = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX2 - onTouchEndX2) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
//        confirm(question)
          scope.confirmShowBool = true;
          scope.confirmNote = question;
          scope.confirmType = 'local';
          scope.result = function (bool) {
            if (bool) {
              localStorage.clear();
              window.location = 'index.html';
              scope.unmount();
              return
            }
            else {
              scope.confirmShowBool = false;
              return
            }
          };
          scope.update();

          return
        }
        console.log("ADD NEW FAVORITE");
        event.stopPropagation();
        opts.mode = 'ADDFAVORITE';
        this.riotTags.innerHTML = "<view-pay>";
        riot.mount('view-pay', opts);
        scope.unmount()
      }
      if (touchStartX != touchEndX)
        changePositionOfServiceCarousel();
    };


  </script>
</component-service-carousel-new>
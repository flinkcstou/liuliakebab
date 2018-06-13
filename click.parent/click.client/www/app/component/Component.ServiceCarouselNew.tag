<component-service-carousel-new>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()"
       ontouchend="touchEndService()" ontouchmove="touchMoveService()">
    <div class="service-component" style="left: {leftOfServiceCarousel}px">
      <div class="service-title">{window.languages.ComponentPopularServicesTitle}</div>
      <div class="service-container">
        <div class="service-each-container" each="{i in popularServiceList}">
          <div if="{false}" id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfService(this.id)"
               ontouchend="ontouchEndOfService(this.id)" ontouchmove="ontouchMoveOfService()"
               style="background-image: url({i.image})">
          </div>

          <img id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfService(this.id)"
               ontouchend="ontouchEndOfService(this.id)" ontouchmove="ontouchMoveOfService()" if="{i.image}"
               src="{i.image}" onload="clearLoaderOnIconLoad(this.id)">

          <p class="service-labels">{i.name}</p>
        </div>
      </div>
    </div>

    <div class="service-component">
      <div id="openFavouriteId" class="service-title" ontouchstart="openFavouriteStart()"
           ontouchend="openFavouriteEnd()">
        {window.languages.ComponentFavoritePaymentsTitle}
        <div class="service-component-open-icon"></div>
      </div>
      <div class="service-container">
        <div class="service-each-container" each="{i in favPaymentsList}">

          <div if="{false}" id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfPayment(this.id)"
               ontouchend="ontouchEndOfPayment(this.id)" style="background-image: url({i.service.image})" role="button"
               aria-label="{i.params.favoriteName?i.params.favoriteName: i.service.name}">
          </div>

          <img id="{i.id}" class="service-buttons" ontouchstart="ontouchStartOfPayment(this.id)"
               ontouchend="ontouchEndOfPayment(this.id)" ontouchmove="ontouchMoveOfService()" if="{i.service.image}"
               src="{i.service.image}" onload="clearLoaderOnIconLoad(this.id)">

          <p class="service-labels">{i.params.favoriteName?i.params.favoriteName: i.service.name}</p>
        </div>
        <div class="service-each-container" if="{addFavoriteBool}">
          <div id="addFavoriteButtonId" class="service-buttons" ontouchstart="ontouchStartOfPayment(this.id)"
               ontouchend="ontouchEndOfAddFavorite(this.id)" role="button" aria-label="{window.languages.Add}"
               style="background-image: url('resources/icons/services/favorites_add.png'); background-size: 46%;">
          </div>
          <p class="service-labels">{window.languages.Add}</p>
        </div>
      </div>
    </div>


  </div>

  <script>

    var scope = this;
    var leftOfDelta;
    var cardNumberOfService = 0;
    window.viewServicePage = {};
    window.viewServicePinCards = {};
    scope.leftOfServiceCarousel = 640 * widthK;
    var openFavouriteStartX, openFavouriteStartY, openFavouriteEndX, openFavouriteEndY;
    var delta, touchEndX, touchStartX;
    scope.internetPackageRequestSent = false;
    scope.internetPackagesArray = [];

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

    scope.updateWishList = function () {
      scope.favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
      fillFavorites();
    };

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
                      } else {
                        scope.popularServiceList[index].image = 'resources/icons/ViewPay/' + fileName;
                      }

                      if (scope.popularServiceList.length == 3) {
                        var myNumberObject = {};
                        myNumberObject.name = 'Мой номер';
                        myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                        myNumberObject.id = 'mynumber' + localStorage.getItem('myNumberOperatorId');
                        scope.popularServiceList.push(myNumberObject);
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
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: result[0][0].error_note
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


    fillFavorites = function () {
      if (scope.favoritePaymentsList) {
        scope.favPaymentsList = [];
        for (var i in scope.favoritePaymentsList) {
          if (!scope.favoritePaymentsList[i].id) {
            scope.favoritePaymentsList[i].id = Math.floor((Math.random() * 1000000) + 1);
            console.log("NO ID", scope.favoritePaymentsList[i])
          }
          if (scope.favPaymentsList.length < 4)
            scope.favPaymentsList.push(scope.favoritePaymentsList[i]);
          //else break;
        }
        localStorage.setItem('favoritePaymentsList', JSON.stringify(scope.favoritePaymentsList));
        if (scope.favPaymentsList.length >= 4)
          scope.addFavoriteBool = false;
        scope.update();
      }
    };

    fillFavorites();

    if (modeOfApp.onlineMode && !(sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true) &&
      (!localStorage.getItem('favoritePaymentsList') || (localStorage.getItem('version') !== AppVersion.version && localStorage.getItem('favoritePaymentsList')))) {

      window.api.call({
        method: 'get.wishlist',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          type: 1
        },

        scope: this,

        onSuccess: function (result) {

          if (result[0][0].error == 0) {

            if (result[1].length != 0 && !localStorage.getItem('favoritePaymentsList') && localStorage.getItem('click_client_servicesMap')) {
              scope.favoritePaymentsList = [];

              for (var j in result[1]) {
                var fav = JSON.parse(result[1][j].body);
                if (scope.servicesMap[fav.service.id]) {
                  fav.service.image = scope.servicesMap[fav.service.id][0].image;
                  scope.favoritePaymentsList.push(fav);
                  console.log("image changed for ", fav)
                }
              }
              favoritePaymentsListForApi = [];
              for (var i in scope.favoritePaymentsList)
                favoritePaymentsListForApi.push({
                  "id": scope.favoritePaymentsList[i].id,
                  "type": 1,
                  "body": JSON.stringify(scope.favoritePaymentsList[i])
                })

              localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));
              localStorage.setItem('favoritePaymentsList', JSON.stringify(scope.favoritePaymentsList));
              console.log("favs processed", scope.favoritePaymentsList);
              fillFavorites();
            } else if (result[1].length == 0 && localStorage.getItem('favoritePaymentsList')
              && localStorage.getItem('favoritePaymentsList').length > 2) {

              var favoritePaymentsList = JSON.parse(localStorage.getItem('favoritePaymentsList'));
              var favoritePaymentsListForApi = JSON.parse(localStorage.getItem('favoritePaymentsListForApi'));


              if (favoritePaymentsListForApi.length != favoritePaymentsList.length) {
                favoritePaymentsListForApi = [];
                for (var i in favoritePaymentsList)
                  favoritePaymentsListForApi.push({
                    "id": favoritePaymentsList[i].id,
                    "type": 1,
                    "body": JSON.stringify(favoritePaymentsList[i])
                  })

                localStorage.setItem('favoritePaymentsListForApi', JSON.stringify(favoritePaymentsListForApi));
              }

              window.api.call({
                method: 'add.favourite',
                input: {
                  session_key: sessionKey,
                  phone_num: phoneNumber,
                  wishlist_data: favoritePaymentsListForApi
                },

                scope: this,

                onSuccess: function (result) {

                  if (result[0][0].error == 0) {

                    console.log("SUCCESSFULLY ADDED")

                  }
                  else {
                    window.common.alert.show("componentAlertId", {
                      parent: scope,
                      clickpinerror: false,
                      errornote: result[0][0].error_note
                    });
                    scope.update();
                    console.log(result[0][0].error_note);
                  }
                },

                onFail: function (api_status, api_status_message, data) {
                  console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                  console.error(data);
                }
              });

            }

          }
          else {
            window.common.alert.show("componentAlertId", {
              parent: scope,
              clickpinerror: false,
              errornote: result[0][0].error_note
            });
            scope.update();
            console.log(result[0][0].error_note);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    openFavouriteStart = function () {
      openFavouriteStartX = event.changedTouches[0].pageX;
      openFavouriteStartY = event.changedTouches[0].pageY;

      openFavouriteId.style.webkitTransform = 'scale(0.8)';
    };

    openFavouriteEnd = function () {
      openFavouriteEndX = event.changedTouches[0].pageX;
      openFavouriteEndY = event.changedTouches[0].pageY;

      openFavouriteId.style.webkitTransform = 'scale(1)';

      if (Math.abs(openFavouriteStartX - openFavouriteEndX) <= 20 && Math.abs(openFavouriteStartY - openFavouriteEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();

          return
        }
        riotTags.innerHTML = "<view-favorites-new>";
        riot.mount("view-favorites-new");
      }
    };

    touchStartService = function () {
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    touchEndService = function () {
      event.preventDefault();
      event.stopPropagation();

      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX) {
        changePositionOfServiceCarousel();
      }
    };

    touchMoveService = function () {
      this.containerService.style.transition = '0s';
      this.containerService.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.containerService.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.containerService.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    };

    changePositionOfServiceCarousel = function () {

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
    };

    scope.ontouchStartOfService = ontouchStartOfService = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(0.7)';

      onTouchStartX = event.changedTouches[0].pageX;
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    scope.ontouchEndOfService = ontouchEndOfService = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      onTouchEndX = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX - onTouchEndX) <= 20) {

        if (modeOfApp.offlineMode && typeof id === "string" && id.indexOf('mynumber') != -1) {
          opts.chosenServiceId = 'mynumber';
          opts.id = 'mynumber';
        }
        else {
          opts.chosenServiceId = id;
          opts.id = id;
        }
        opts.mode = 'POPULAR';

        localStorage.setItem('chosenServiceId', id);
//        riotTags.innerHTML = "<view-service-page-new>";
//        riot.mount("view-service-page-new", opts);
        openPayServiceById(id, opts);
        scope.unmount();

        return
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
    };

    scope.ontouchStartOfPayment = ontouchStartOfPayment = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.7)';
      event.stopPropagation();

      onTouchStartX2 = event.changedTouches[0].pageX;
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    };

    scope.ontouchEndOfPayment = ontouchEndOfPayment = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      event.stopPropagation();

      onTouchEndX2 = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX2 - onTouchEndX2) <= 20) {

        for (var i in scope.favoritePaymentsList) {
          if (scope.favoritePaymentsList[i].id == id) {

            scope.favoritePaymentsList[i].params.favoriteId = scope.favoritePaymentsList[i].id;
            if (scope.favoritePaymentsList[i].params.transactionId)
              scope.favoritePaymentsList[i].params.transactionId = null;
            console.log("fav transaction id=", scope.favoritePaymentsList[i].params.transactionId);
            console.log("favorite to open ", scope.favoritePaymentsList[i]);

            if (modeOfApp.offlineMode) {
              var firstFieldText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.firstFieldText);
              var amountText = inputVerification.spaceDeleter(scope.favoritePaymentsList[i].params.amountText);
              var formtype = scope.favoritePaymentsList[i].params.formtype;
              var communalParam = scope.favoritePaymentsList[i].params.communalParam;
              var firstFieldId = scope.favoritePaymentsList[i].params.firstFieldId;
              var chosenPrefixId = scope.favoritePaymentsList[i].params.chosenPrefixId;


              var ussdQuery = scope.favoritePaymentsList[i].ussd;

              if (formtype == 1 && ussdQuery) {
                if (firstFieldText) {
                  ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                }
                else {
                  ussdQuery = ussdQuery.replace('*{param}', firstFieldText);
                }
                ussdQuery = ussdQuery.replace('{option}', chosenPrefixId);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (formtype == 2 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{option}', chosenPrefixId);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (formtype == 3 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{communal_para}', communalParam);
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{option}', chosenPrefixId);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }

              if (formtype == 4 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.replace('{option}', chosenPrefixId);
                ussdQuery = ussdQuery.replace('{amount}', amountText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery)
              }
              if (formtype == 6 && ussdQuery) {
                ussdQuery = ussdQuery.replace('{option}', chosenPrefixId);
                ussdQuery = ussdQuery.replace('{param}', firstFieldText);
                ussdQuery = ussdQuery.substring(0, ussdQuery.length - 1);
                console.log(ussdQuery);
              }

              if (ussdQuery === null) {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: "Сервис временно недоступен!"
                });
                scope.update();
                return
              }

              console.log(ussdQuery);

              phonedialer.dial(
//              "*880*1*" + opts.id + "*" + parseInt(amountForPayTransaction) + "%23",
                ussdQuery + "%23",
                function (err) {
                  if (err == "empty") {

                    window.common.alert.show("componentAlertId", {
                      parent: scope,
                      clickpinerror: false,
                      errornote: "Неизвестный номер телефона"
                    });
                    scope.update();
                  }
                  else console.log("Dialer Error:" + err);
                },
                function (success) {
                }
              );
              return
            }

            if (localStorage.getItem('click_client_cards')) {


              if (scope.favoritePaymentsList[i].service.form_type == 4 && scope.favoritePaymentsList[i].service.disable_cache
                && modeOfApp.onlineMode && !modeOfApp.demoVersion) {

                if (!scope.internetPackageRequestSent) {

                  var internetPackagesUpdate = internetPackagesSumUpdate;
                  internetPackagesUpdate(scope.favoritePaymentsList[i].service.id, i, function (index, result) {
                    if (result[5]) {
                      scope.internetPackageRequestSent = true;
                      scope.internetPackagesArray = result[5];
                      processFavoritePayment(index);
                    }
                  });
                } else {
                  processFavoritePayment(i);
                }

              } else {


                if (scope.favoritePaymentsList[i].service.additional_information_type == 3) {
                  localStorage.setItem('click_client_infoCacheEnabled', null)
                  this.riotTags.innerHTML = "<view-service-info-new>";
                  riot.mount('view-service-info-new', scope.favoritePaymentsList[i].params);
                  scope.unmount()
                } else {
                  this.riotTags.innerHTML = "<view-service-pincards-new>";
                  riot.mount('view-service-pincards-new', scope.favoritePaymentsList[i].params);
                  scope.unmount()
                }
              }

            } else {

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: "Подождите, данные для избранных платежей еще не подгрузились"
              });
              scope.update();

            }


          }

        }

      }
      if (touchStartX != touchEndX)
        changePositionOfServiceCarousel();
    };

    processFavoritePayment = function (index) {
      for (var j in scope.internetPackagesArray) {

        if (scope.internetPackagesArray[j].service_id === scope.favoritePaymentsList[index].service.id) {

          if (scope.internetPackagesArray[j].code === scope.favoritePaymentsList[index].params.internetPackageParam) {

            scope.favoritePaymentsList[index].params.intPartAmount = Math.floor(scope.internetPackagesArray[j].sum_cost.toString().replace(/\s/g, ''))
              .toFixed(0).toString();

            scope.favoritePaymentsList[index].params.fracPartAmount = window.getFractionalPart(scope.internetPackagesArray[j].sum_cost.toString());

            scope.favoritePaymentsList[index].params.amountText = window.amountTransform(
                window.inputVerification.spaceDeleter(scope.favoritePaymentsList[index].params.intPartAmount))
              + scope.favoritePaymentsList[index].params.fracPartAmount;

            localStorage.setItem('favoritePaymentsList', JSON.stringify(scope.favoritePaymentsList));
            if (scope.favoritePaymentsList[index].service.additional_information_type == 3) {
              if (scope.favoritePaymentsList[index].service.form_type == 7) {
                this.riotTags.innerHTML = "<view-formtype-seven-getinfo>";
                riot.mount('view-formtype-seven-getinfo', scope.favoritePaymentsList[index].params);
                scope.unmount()
              } else {
                this.riotTags.innerHTML = "<view-service-info>";
                riot.mount('view-service-info', scope.favoritePaymentsList[index].params);
                scope.unmount()
              }
            } else {
              this.riotTags.innerHTML = "<view-service-pincards-new>";
              riot.mount('view-service-pincards-new', scope.favoritePaymentsList[index].params);
              scope.unmount()
            }
            break;

          }
        }
      }
    };

    function internetPackagesSumUpdate(serviceId, index, callback) {

      window.api.call({
        method: 'get.service.parameters',
        stopSpinner: false,
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber,
          service_id: serviceId
        },

        scope: this,

        onSuccess: function (result) {
          window.stopSpinner();
          if (result[0][0].error == 0) {
            callback(index, result);
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    scope.ontouchEndOfAddFavorite = ontouchEndOfAddFavorite = function (id) {
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)';

      onTouchEndX2 = event.changedTouches[0].pageX;
      touchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartX2 - onTouchEndX2) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
//        confirm(question)
          window.common.alert.show("componentConfirmId", {
            parent: scope,
            "confirmnote": question,
            "confirmtype": "local"
          });
          scope.result = function (bool) {
            if (bool) {
              localStorage.clear();
              window.location = 'index.html';
              scope.unmount();
              return
            }
            else {
              window.common.alert.hide("componentConfirmId");
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
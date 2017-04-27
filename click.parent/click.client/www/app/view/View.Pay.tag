<view-pay>
  <div id="viewPayId" class="view-pay">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" ontouchend="goToBack()" class="pay-back-button"></div>
      <div id="rightButton" type="button" class="pay-search-button" ontouchend="search()"></div>
      <div style=""></div>
    </div>
    <div class="pay-category-container" id="categoriesContainerId">
      <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
        <li each="{i in categoryList}" style="overflow: hidden;">
          <div if="{!(modeOfApp.offlineMode && i.id == 11)}" class="pay-service-block-containter" id="{i.id}"
               ontouchstart="onTouchStartOfCategory()"
               ontouchend="onTouchEndOfCategory(this.id)"
               ontouchmove="onTouchMoveOfCategory()">
            <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
            <div class="pay-category-name-field">{i.name}
            </div>
            <div class="pay-icon-tick" id="tick{i.id}"></div>
            <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
              <li class="pay-service-containter" each="{j in currentList}">
                <div class="pay-service-icon" style="background-image: url({j.image})" id="{j.id}"
                     ontouchend="onTouchEndOfService(this.id)" ontouchstart="onTouchStartOfService()">
                  <div class="pay-service-name-field">{j.name}</div>
                </div>
              </li>
            </ul>
          </div>
        </li>
      </ul>
      <div class="pay-service-hint-containter" id="hintContainerId">
        <div class="pay-category-icon" style="background-image: url({showCategoryIcon})"></div>
        <div class="pay-category-name-field">{showCategoryName}
        </div>
      </div>
    </div>
  </div>
  <component-category-search></component-category-search>
  <script>
    //TODO: OPTIMIZE THIS PAGE SLOW DOWNLOADING CATEGORIES AND SERVICES
    var scope = this;
    scope.checkOfSearch = false;

    console.log('opts', opts)

    if (opts.mode == 'ADDAUTOPAY')
      this.titleName = window.languages.ViewAutoPayTitleName;
    else this.titleName = window.languages.ViewPayTitleName;

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-pay') {
      history.arrayOfHistory.push(
        {
          "view": 'view-pay',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    scope.categoryList = (JSON.parse(localStorage.getItem("click_client_payCategoryList"))) ? (JSON.parse(localStorage.getItem("click_client_payCategoryList"))) : (offlinePayCategoryList);
    scope.serviceList = (JSON.parse(localStorage.getItem("click_client_payServiceList"))) ? (JSON.parse(localStorage.getItem("click_client_payServiceList"))) : (offlinePayServiceList);
    scope.serviceNamesMap = (JSON.parse(localStorage.getItem("click_client_payServiceNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_payServiceNamesMap"))) : (offlinePayServiceNamesMap);
    scope.servicesMapByCategory = (JSON.parse(localStorage.getItem("click_client_servicesMapByCategory"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMapByCategory"))) : (offlineServicesMapByCategory);
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.servicesParams = (JSON.parse(localStorage.getItem("click_client_servicesParams"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParams"))) : (offlineServicesParams);
    scope.servicesParamsMapOne = (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);

    //    console.log("click_client_payCategoryList", localStorage.getItem("click_client_payCategoryList"));
    //    console.log("click_client_payServiceList", localStorage.getItem("click_client_payServiceList"));
    //    console.log("click_client_payServiceNamesMap", localStorage.getItem("click_client_payServiceNamesMap"));
    //    console.log("click_client_servicesMapByCategory", localStorage.getItem("click_client_servicesMapByCategory"));
    //    console.log("click_client_servicesMap", localStorage.getItem("click_client_servicesMap"));
    //    console.log("click_client_servicesParams", localStorage.getItem("click_client_servicesParams"));
    //    console.log("click_client_servicesParamsMapOne", localStorage.getItem("click_client_servicesParamsMapOne"));
    //    console.log("click_client_categoryNamesMap", localStorage.getItem("click_client_categoryNamesMap"));

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    if (phoneNumber) {

      scope.operatorKey = phoneNumber.substr(3, 2);
      phoneNumber = phoneNumber.substring(3, phoneNumber.length);
    }

    if (loginInfo) {

      var sessionKey = loginInfo.session_key;
    }

    goToBack = function () {
      event.preventDefault();
      event.stopPropagation();
      onBackKeyDown()
      scope.unmount()
    };
    if (localStorage.getItem("click_client_payCategoryList")) {
//      alert("in Category list of PAY");
      riot.update(scope.categoryList);
//      scope.categoryList = [];
//      scope.categoryNamesMap = {};
//      window.api.call({
//        method: 'get.service.category.list',
//        input: {
//          session_key: sessionKey,
//          phone_num: phoneNumber
//        },
//        scope: this,
//
//        onSuccess: function (result) {
//          if (result[0][0].error == 0)
//            if (result[1][0]) {
//
//              if (device.platform != 'BrowserStand') {
//                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
//                  var j = -1;
//
//                  for (var i in result[1]) {
//
//                    scope.categoryNamesMap[result[1][i].id] = {
//      "name": result[1][i].name,
//        "icon": result[1][i].icon
//    };
//                    j++;
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
//                        localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
//                        localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
//                      }
//                    });
//                  }
//                }, onErrorLoadFs);
//              }
//              else {
//                for (var i in result[1]) {
//
//                  scope.categoryList.push(result[1][i]);
//                  scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
//                }
//                riot.update(scope.categoryList);
//                localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
//                localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
//              }
//            }
//
//          scope.id = 0;
//
//        },
//        onFail: function (api_status, api_status_message, data) {
//          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//          console.error(data);
//        }
//      });
    }

    scope.index = -1;
    scope.show = false;
    var onTouchStartY;
    var onTouchEndY;
    var count = 1;

    scope.onTouchStartOfCategory = onTouchStartOfCategory = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;
//      console.log(onTouchEndY)


      if (Math.abs(onTouchStartY - onTouchEndY) <= 20 || scope.checkOfSearch) {
        if (scope.index == id) {
          scope.index = -1;
        } else {
          if (scope.index != -1)
            document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
          scope.index = id;
        }

        scope.currentList = scope.servicesMapByCategory[id];
        count = 1;


        if (!scope.currentList) {
          scope.show = false;
        } else {
          scope.show = true;
          document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
        }

        if (scope.index == id && scope.show) {
          document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
          viewPay.categoryId = id;
        }


        riot.update(scope.index);
        riot.update(scope.currentList);
        riot.update(scope.show);
      }
    };


    onTouchMoveOfCategory = function () {
      event.stopPropagation();

      var element = document.getElementById(scope.index);

      if (categoriesContainerId.scrollTop > element.offsetTop) {
        hintContainerId.style.display = 'block';
        scope.showCategoryIcon = scope.categoryNamesMap[scope.index].icon;
        scope.showCategoryName = scope.categoryNamesMap[scope.index].name;
        riot.update(hintContainerId);
      } else {
        hintContainerId.style.display = 'none';
        riot.update(hintContainerId);

      }

    }


    if ((localStorage.getItem("click_client_payServiceList") && scope.servicesMapByCategory && scope.servicesMap)) {
//      alert("in Service list of PAY");
//      scope.serviceList = [];
//      scope.servicesMapByCategory = {};
//      scope.servicesMap = {};
//      scope.serviceNamesMap = {};
//      window.api.call({
//        method: 'get.service.list',
//        input: {
//          session_key: sessionKey,
//          phone_num: phoneNumber
//        },
//        scope: this,
//
//        onSuccess: function (result) {
//          if (result[0][0].error == 0)
//            if (result[1][0]) {
//
//              var firstService, firstIndex, j = 0;
//              for (var i in result[1]) {
//                if (result[1][i].category_id == 1) {
//                  if (result[1][i].id == window.mOperators[scope.operatorKey] && j == 0) {
//                    break;
//                  }
//                  if (j == 0) {
//                    firstIndex = i;
//                    firstService = result[1][i];
//                  }
//                  j++;
//                  if (result[1][i].id == window.mOperators[scope.operatorKey]) {
//                    result[1][firstIndex] = result[1][i];
//                    result[1][i] = firstService;
//                    break;
//                  }
//                }
//              }
//              if (device.platform != 'BrowserStand') {
//                window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
//                  var inVisibleNum = 0, j = -1;
//
//                  for (var i in result[1]) {
//                    if (result[1][i].is_visible == 1) {
//
//                      scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
//                      j++;
//                      scope.serviceList.push(result[1][i]);
//
//                      var icon = result[1][i].image;
//                      var filename = icon.substr(icon.lastIndexOf('/') + 1);
//
//                      var newIconBool = checkImageURL;
//                      newIconBool('www/resources/icons/ViewPay/service/', filename, icon, j, function (bool, index, fileName) {
//
//                        if (bool) {
//                          scope.serviceList[index]['image'] = cordova.file.dataDirectory + fileName;//
//                        } else {
//                          scope.serviceList[index]['image'] = cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/service/' + fileName;
//                        }
//
//
//                        if (!scope.servicesMapByCategory[scope.serviceList[index].category_id]) {
//                          scope.servicesMapByCategory[scope.serviceList[index].category_id] = [];
//                          if (scope.serviceList[index].category_id == 1 && scope.serviceList[index].id == window.mOperators[scope.operatorKey]) {
//                            localStorage.setItem('myNumberOperatorId', scope.serviceList[index].id);
//
//                            var myNumberObject = {};
//                            myNumberObject.name = 'Мой номер';
//                            myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
//                            myNumberObject.id = 'mynumber' + scope.serviceList[index].id;
//                            scope.servicesMapByCategory[scope.serviceList[index].category_id].push(myNumberObject);
//
//                          }
//                          scope.servicesMapByCategory[scope.serviceList[index].category_id].push(scope.serviceList[index]);
//                        }
//                        else {
//                          scope.servicesMapByCategory[scope.serviceList[index].category_id].push(scope.serviceList[index]);
//                        }
//
//
//                        if (!scope.servicesMap[scope.serviceList[index].id + '']) {
//                          scope.servicesMap[scope.serviceList[index].id + ''] = [];
//                          scope.servicesMap[scope.serviceList[index].id + ''].push(scope.serviceList[index]);
//                        }
//                        else {
//                          scope.servicesMap[scope.serviceList[index].id + ''].push(scope.serviceList[index]);
//                        }
//
//
//                        if ((result[1].length - inVisibleNum) == scope.serviceList.length) {
//                          console.log("save into localstorage");
//                          localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
//                          localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
//                          localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
//                          localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
//                        }
//
//                      });
//                    } else
//                      inVisibleNum++;
//                  }
//                }, onErrorLoadFs);
//              } else {
//                for (var i in result[1]) {
//                  if (result[1][i].is_visible == 1) {
//                    console.log("service id=", result[1][i].id, ", element:", result[1][i]);
//
//                    scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
//                    scope.serviceList.push(result[1][i]);
//
//                    if (!scope.servicesMapByCategory[result[1][i].category_id]) {
//                      scope.servicesMapByCategory[result[1][i].category_id] = [];
//                      if (result[1][i].category_id == 1 && result[1][i].id == window.mOperators[scope.operatorKey]) {
//                        localStorage.setItem('myNumberOperatorId', result[1][i].id);
//                        var myNumberObject = {};
//                        myNumberObject.name = 'Мой номер';
//                        myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
//                        myNumberObject.id = 'mynumber' + result[1][i].id;
//                        scope.servicesMapByCategory[result[1][i].category_id].push(myNumberObject);
//                        //console.log("ID=", viewServicePage.myNumberOperatorId, ",,,Name=", viewServicePage.myNumberOperatorName, ",,,Image=", viewServicePage.myNumberOperatorImage);
//                      }
//                      scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
//                    }
//                    else {
//                      scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
//                    }
//                    if (!scope.servicesMap[result[1][i].id + '']) {
//                      scope.servicesMap[result[1][i].id + ''] = [];
//                      scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
//                    }
//                    else {
//                      scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
//                    }
//                  }
//                }
//                localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
//                localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
//                localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
//                localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
//
//              }
//            }
//
//
//          servicesParamsInit();
//        },
//        onFail: function (api_status, api_status_message, data) {
//          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
//          console.error(data);
//        }
//      })
    }

    //    servicesParamsInit = function () {
    //      alert("in Params list of PAY");
    //      scope.servicesParams = [];
    //      scope.servicesParamsMapOne = {};
    //      scope.servicesParamsMapTwo = {};
    //      scope.servicesParamsMapThree = {};
    //      scope.servicesParamsMapFour = {};
    //      scope.servicesParamsMapFive = {};
    //      window.api.call({
    //        method: 'get.service.parameters.list',
    //        input: {
    //          session_key: sessionKey,
    //          phone_num: phoneNumber
    //        },
    //
    //        scope: this,
    //
    //        onSuccess: function (result) {
    //          if (result[0][0].error == 0) {
    //            if (result[1])
    //              for (var i in result[1]) {
    //                console.log("1. service id=", result[1][i].service_id, "element:", result[1][i]);
    //                if (!scope.servicesParamsMapOne[result[1][i].service_id]) {
    //                  scope.servicesParamsMapOne[result[1][i].service_id] = [];
    //                  scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
    //                }
    //                else
    //                  scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
    //
    //
    //              }
    //            if (result[2])
    //              for (var i in result[2]) {
    //                console.log("2. service id=", result[2][i].service_id, "element:", result[2][i]);
    //                if (!scope.servicesParamsMapTwo[result[2][i].service_id]) {
    //                  scope.servicesParamsMapTwo[result[2][i].service_id] = [];
    //                  scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
    //                }
    //                else
    //                  scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
    //
    //              }
    //            if (result[3])
    //              for (var i in result[3]) {
    //                console.log("3. service id=", result[3][i].service_id, "element:", result[3][i]);
    //                if (!scope.servicesParamsMapThree[result[3][i].service_id]) {
    //                  scope.servicesParamsMapThree[result[3][i].service_id] = [];
    //                  scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
    //                }
    //                else
    //                  scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
    //
    //              }
    //            if (result[4])
    //              for (var i in result[4]) {
    //                console.log("4. service id=", result[4][i].service_id, "element:", result[4][i]);
    //                if (!scope.servicesParamsMapFour[result[4][i].service_id]) {
    //                  scope.servicesParamsMapFour[result[4][i].service_id] = [];
    //                  scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
    //                }
    //                else
    //                  scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
    //              }
    //            if (result[5])
    //              for (var i in result[5]) {
    //                console.log("5. service id=", result[5][i].service_id, "element:", result[5][i]);
    //                if (!scope.servicesParamsMapFive[result[5][i].service_id]) {
    //                  scope.servicesParamsMapFive[result[5][i].service_id] = [];
    //                  scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
    //                }
    //                else
    //                  scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
    //              }
    //            localStorage.setItem('click_client_servicesParams', JSON.stringify(result));
    //            localStorage.setItem('click_client_servicesParamsMapOne', JSON.stringify(scope.servicesParamsMapOne));
    //            localStorage.setItem('click_client_servicesParamsMapTwo', JSON.stringify(scope.servicesParamsMapTwo));
    //            localStorage.setItem('click_client_servicesParamsMapThree', JSON.stringify(scope.servicesParamsMapThree));
    //            localStorage.setItem('click_client_servicesParamsMapFour', JSON.stringify(scope.servicesParamsMapFour));
    //            localStorage.setItem('click_client_servicesParamsMapFive', JSON.stringify(scope.servicesParamsMapFive));
    //
    //          }
    //        },
    //
    //        onFail: function (api_status, api_status_message, data) {
    //          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
    //          console.error(data);
    //        }
    //      });
    //    };


    scope.onTouchStartOfService = onTouchStartOfService = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
    };

    console.log('OPTS', opts);

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {
      event.stopPropagation();
      onTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20 || scope.checkOfSearch) {
        console.log('ID ID ID', id)
        if (opts.mode == 'ADDAUTOPAY') {
          scope.autoPayData = {};
          viewPay.chosenServiceId = id;
          opts.id = id;
          if (id == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
            console.log("MYNUMBER WWW");
            scope.autoPayData.service_id = localStorage.getItem('myNumberOperatorId');
//            opts.id = localStorage.getItem('myNumberOperatorId');
          } else {
            scope.autoPayData.service_id = id;
          }
          event.preventDefault();
          event.stopPropagation();
          if (scope.servicesMap[scope.autoPayData.service_id][0].autopay_available) {
            localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
            riotTags.innerHTML = "<view-autopay-method>";
            riot.mount("view-autopay-method", opts);

            scope.unmount()
          } else {
            scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
            scope.autoPayData.autopay_type = 1;
            localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
//            localStorage.setItem('autoPayType', window.languages.ViewAutoPayMethodSchedulerText);
            riotTags.innerHTML = "<view-autopay-schedule-method>";
            riot.mount("view-autopay-schedule-method", opts);
            scope.unmount()
          }
        }
        else {
          if (!opts.mode) opts.mode = 'USUAL';
          console.log("chosen id in pay view=", id);
          viewPay.chosenServiceId = id;
          opts.id = id;
          event.stopPropagation();

          localStorage.setItem('chosenServiceId', id);
          riotTags.innerHTML = "<view-service-page>";
          riot.mount("view-service-page", opts);

          scope.unmount()
        }
      }
    };

  </script>
</view-pay>

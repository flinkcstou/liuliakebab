<view-pay>
  <div id="viewPayId" class="view-pay riot-tags-main-container">
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
        <div class="pay-hint-icon-tick"></div>
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
      scope.update(scope.categoryList);
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
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;
    var count = 1;

    scope.onTouchStartOfCategory = onTouchStartOfCategory = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;
//      console.log(onTouchEndY)


      if ((Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) || scope.checkOfSearch) {
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


        scope.update();
      }
    };


    onTouchMoveOfCategory = function () {
      event.stopPropagation();

      var element = document.getElementById(scope.index);

      if (element) {
        if (categoriesContainerId.scrollTop > element.offsetTop) {
          hintContainerId.style.display = 'block';
          scope.showCategoryIcon = scope.categoryNamesMap[scope.index].icon;
          scope.showCategoryName = scope.categoryNamesMap[scope.index].name;
          scope.update();
        } else {
          hintContainerId.style.display = 'none';
          scope.update();

        }
      }

    }


    scope.onTouchStartOfService = onTouchStartOfService = function () {
      event.stopPropagation();
      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    console.log('OPTS', opts);
    localStorage.setItem('autoPayData', null);

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {
      event.stopPropagation();
      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;

      if ((Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) || scope.checkOfSearch) {
        console.log('ID ID ID', id)
        if (opts.mode == 'ADDAUTOPAY') {
          scope.autoPayData = {};
          viewPay.chosenServiceId = id;
          opts.id = id;
          if (id == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
            scope.autoPayData.service_id = localStorage.getItem('myNumberOperatorId');
          } else {
            scope.autoPayData.service_id = id;
          }
          scope.autoPayData.fromView = 'PAY';
          scope.autoPayData.isNew = true;

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

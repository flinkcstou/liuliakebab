<view-pay>
  <div id="viewPayId" class="view-pay riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="back-button"></div>
      <div id="rightButton" role="button" aria-label="{window.languages.ViewPayVoiceOverSearch}" type="button"
           class="pay-search-button" ontouchstart="searchStart()"
           ontouchend="searchEnd()"></div>
      <div style=""></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="pay-service-hint-containter" id="hintContainerId" if="{hintShow}">
      <div class="pay-category-icon" style="background-image: url({showCategoryIcon})"></div>
      <div class="pay-category-name-field">{showCategoryName}
      </div>
      <div class="pay-hint-icon-tick"></div>
    </div>
    <div class="pay-category-container" id="categoriesContainerId" onscroll="onTouchMoveOfCategory()">
      <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
        <li each="{i in categoryList}" style="overflow: hidden;">
          <div if="{!(modeOfApp.offlineMode && i.id == 11)}" class="pay-service-block-containter" id="{i.id}"
               ontouchstart="onTouchStartOfCategory(this.id)"
               onclick="onTouchEndOfCategory(this.id)">
            <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
            <div class="pay-category-name-field">{i.name}
            </div>
            <div class="pay-icon-tick" id="tick{i.id}"></div>
            <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
              <li class="pay-service-containter" each="{j in currentList}">
                <div class="pay-service-icon" style="background-image: url({j.image})" id="{j.id}" role="button"
                     aria-label="{j.name}"
                     ontouchend="onTouchEndOfService(this.id)" ontouchstart="onTouchStartOfService(this.id)">
                  <div class="pay-service-name-field">{j.name}</div>
                </div>
              </li>
            </ul>
            <div class="title-bottom-border">
            </div>
          </div>
        </li>
      </ul>
    </div>
  </div>
  <component-category-search></component-category-search>
  <script>
    //TODO: OPTIMIZE THIS PAGE SLOW DOWNLOADING CATEGORIES AND SERVICES
    var scope = this;
    scope.checkOfSearch = false;

    if (opts.mode == 'ADDAUTOPAY')
      this.titleName = window.languages.ViewAutoPayTitleName;
    else this.titleName = window.languages.ViewPayTitleName;

    window.saveHistory('view-pay', opts);

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

    scope.on('mount', function () {
      console.log("OPTS in Pay", opts);
      if (opts.categoryId) {
        document.getElementById("tick" + viewPay.categoryId).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
        hintUpdate(viewPay.categoryId);
        scope.index = viewPay.categoryId;
        scope.show = true;
        scope.currentList = scope.servicesMapByCategory[viewPay.categoryId];
      }
      if (opts.categoryId)
        categoriesContainerId.scrollTop = viewPay.categoryScrollTop;

      setTimeout(function () {
        riot.update();
      }, 0);
    });

    scope.index = -1;
    scope.show = false;
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;
    //    var count = 1;


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {
      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {

      if (scope.index != id)
        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)'


      setTimeout(function () {
        document.getElementById(id).style.backgroundColor = 'transparent'
      }, 100)


      onTouchEndY = event.pageY;
      onTouchEndX = event.pageX;


      setTimeout(function () {


        if ((Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) || scope.checkOfSearch) {


          if (scope.index == id) {
            scope.index = -1;
          } else {
            if (scope.index != -1) {
              document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
            }
            scope.index = id;
          }

          scope.currentList = scope.servicesMapByCategory[id];
//        count = 1;


          if (!scope.currentList) {
            scope.show = false;
          } else {
            scope.show = true;
            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
          }

          if (scope.index == id && scope.show) {
            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
            viewPay.categoryId = id;
            opts.categoryId = id;
            hintUpdate(scope.index);
          }

          document.getElementById(id).scrollIntoView();
//        categoriesContainerId.scrollIntoView(document.getElementById(id).offsetTop)

//        categoriesContainerId.scrollTop = event.changedTouches[0].pageY;

          scope.update();
        }
      }, 100)
    };

    scope.hintShow = false;

    hintUpdate = function (index) {
//      console.log("in get top=", categoriesContainerId.scrollTop, document.getElementById(index).offsetTop);
      if (categoriesContainerId.scrollTop - 40 > document.getElementById(index).offsetTop) {
        scope.hintShow = true;
        scope.showCategoryIcon = scope.categoryNamesMap[scope.index].icon;
        scope.showCategoryName = scope.categoryNamesMap[scope.index].name;
        scope.update();
      } else {
        scope.hintShow = false;
        scope.update();
      }
    };


    onTouchMoveOfCategory = function () {

      event.stopPropagation();
      var element = document.getElementById(scope.index);

      if (element) {
        if (categoriesContainerId.scrollTop - 40 > element.offsetTop) {
          scope.hintShow = true;
          scope.showCategoryIcon = scope.categoryNamesMap[scope.index].icon;
          scope.showCategoryName = scope.categoryNamesMap[scope.index].name;
          scope.update();
        } else {
          scope.hintShow = false;
          scope.update();
        }
      }
      scope.update();
    };


    scope.onTouchStartOfService = onTouchStartOfService = function (id) {
      event.stopPropagation();
      event.preventDefault();
      if (document.getElementById(id))
        document.getElementById(id).style.webkitTransform = 'scale(0.8)'
      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };


    localStorage.setItem('autoPayData', null);
    window.viewServicePinCards = {};
    //opts = (!opts.mode || opts.mode == 'USUAL') ? {} : opts;

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {
      event.stopPropagation();
      event.preventDefault();

      if (document.getElementById(id))
        document.getElementById(id).style.webkitTransform = 'scale(1)'

      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;

      if ((Math.abs(onTouchStartY - onTouchEndY) <= 15 && Math.abs(onTouchStartX - onTouchEndX) <= 15) || scope.checkOfSearch) {
        viewPay.categoryScrollTop = categoriesContainerId.scrollTop;

        var newOpts = {};
        newOpts.mode = opts.mode;
        newOpts.categoryId = opts.categoryId;
        opts = JSON.parse(JSON.stringify(newOpts));
        newOpts = null;

        console.log('ID ID ID', id)
        if (opts.mode == 'ADDAUTOPAY') {
          scope.autoPayData = {};
          opts.chosenServiceId = id;
          opts.id = id;
          if (id == 'mynumber' + localStorage.getItem('myNumberOperatorId')) {
            scope.autoPayData.service_id = localStorage.getItem('myNumberOperatorId');
          } else {
            scope.autoPayData.service_id = id;
          }
          scope.autoPayData.fromView = 'PAY';
          scope.autoPayData.isNew = true;


          if (scope.servicesMap[scope.autoPayData.service_id][0].autopay_available) {
            localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
            event.stopPropagation();
            riotTags.innerHTML = "<view-autopay-method-new>";
            riot.mount("view-autopay-method-new", opts);
            scope.unmount()
          } else {
            scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
            scope.autoPayData.autopay_type = 1;
            localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
            event.stopPropagation();
            riotTags.innerHTML = "<view-autopay-schedule-method-new>";
            riot.mount("view-autopay-schedule-method-new", opts);
            scope.unmount()
          }
        }
        else {
          if (!opts.mode) opts.mode = 'USUAL';
          console.log("id in offline search", typeof id);
          if (modeOfApp.offlineMode && typeof id === "string" && id.indexOf('mynumber') != -1) {
            opts.chosenServiceId = 'mynumber';
          }
          else {
            opts.chosenServiceId = id;
            opts.id = id;
          }
          event.stopPropagation();
          riotTags.innerHTML = "<view-service-page-new>";
          riot.mount("view-service-page-new", opts);
          scope.unmount()
        }
      }
    };

  </script>
</view-pay>

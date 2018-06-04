<view-pay>
  <div id="viewPayId" class="view-pay riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="back-button"></div>
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
    <div class="pay-category-container">

      <div class="inplace-pay-search-container">
        <div class="inplace-pay-search-field" id="searchContainerId">
          <input class="inplace-pay-search-input-part" type="text" id="searchInputId" value="{opts.searchWord}"
                 onfocus="colorFieldInplaceSearch()"
                 onblur="blurFieldInplaceSearch()"
                 onkeyup="keyUpFieldInplaceSearch()"
                 oninput="onInputSearchField()"
                 placeholder="{window.languages.InPlaceSearchPlaceHolderText}"/>
          <div if="{showSearchIcon}" id="searchIcon"
               class="inplace-pay-search-icon"
               ontouchstart="onTouchStartOfSearchCategory()"
               ontouchend="onTouchEndOfSearchCategory()"></div>
          <div if="{!showSearchIcon}" id="searchRemoveIcon"
               class="inplace-pay-search-remove-icon"
               ontouchstart="onTouchStartOfSearchRemove()"
               ontouchend="onTouchEndOfSearchRemove()"></div>
        </div>
      </div>

      <div class="inplace-pay-category-inner-container" if="{searchServices}" id="categoriesContainerId">

        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in suggestions}" style="overflow: hidden;">
            <div class="pay-service-block-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfService(this.id)"
                 onclick="onTouchEndOfService(this.id, true)">
              <div class="pay-search-services-icon" style="background-image: url({i.image})"></div>
              <div class="pay-category-name-field">{i.name}
              </div>
              <div class="title-bottom-border">
              </div>
            </div>
          </li>
        </ul>
      </div>

      <div class="inplace-pay-category-inner-container" if="{!searchServices}" id="categoriesContainerId"
           onscroll="onTouchMoveOfCategory()">

        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;" if="{opts.mode == 'ADDAUTOPAY'}">
          <li each="{i in categoryList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode && i.id == 11)}" class="pay-service-block-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfCategory(this.id)"
                 onclick="onTouchEndOfCategory(this.id)">
              <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
              <div class="pay-category-name-field">{i.name}
              </div>
              <div class="pay-icon-tick" id="tick{i.id}"></div>
              <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
                <li class="pay-service-containter"
                    each="{j in currentList}"
                    if="{j.autopay_available_schedule || j.autopay_available || !j.form_type}">
                  <div class="pay-service-icon" style="background-image: url({j.image})" id="{j.id}" role="button"
                       aria-label="{j.name}"
                       onclick="onTouchEndOfService(this.id)" ontouchstart="onTouchStartOfService(this.id)">
                    <div class="pay-service-name-field">{j.name}</div>
                  </div>
                </li>
              </ul>
              <div class="title-bottom-border">
              </div>
            </div>
          </li>
        </ul>

        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;" if="{opts.mode != 'ADDAUTOPAY'}">
          <li each="{i in categoryList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode && i.id == 11)}" class="pay-service-block-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfCategory(this.id)"
                 onclick="onTouchEndOfCategory(this.id)">
              <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
              <div class="pay-category-name-field">{i.name}
              </div>
              <div class="pay-icon-tick" id="tick{i.id}"></div>
              <ul class="pay-services-block" if="{index == i.id && show}" style="list-style:none">
                <li class="pay-service-containter"
                    each="{j in currentList}">
                  <div class="pay-service-icon" style="background-image: url({j.image})" id="{j.id}" role="button"
                       aria-label="{j.name}"
                       onclick="onTouchEndOfService(this.id)" ontouchstart="onTouchStartOfService(this.id)">
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
  </div>
  <script>
    //TODO: OPTIMIZE THIS PAGE SLOW DOWNLOADING CATEGORIES AND SERVICES
    var scope = this;
    scope.checkOfSearch = false;
    scope.scrolling = false;

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
    scope.searchServices = false;
    scope.showSearchIcon = !opts.searchWord;
    var searchFieldTimeout;
    var arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);
    scope.suggestions = sessionStorage.getItem('click_client_suggestions') ? JSON.parse(sessionStorage.getItem('click_client_suggestions')) : [];

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
      console.log("OPTS in Pay", opts, opts.mode);
      if (opts.categoryId && !viewPay.searchServices) {
        document.getElementById("tick" + viewPay.categoryId).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
        hintUpdate(viewPay.categoryId);
        scope.index = viewPay.categoryId;
        scope.show = true;
        scope.currentList = scope.servicesMapByCategory[viewPay.categoryId];
      }
      if (opts.categoryId || viewPay.searchServices) {
        categoriesContainerId.scrollTop = viewPay.categoryScrollTop;
        viewPay.categoryScrollTop = null;
      }

      console.log("viewPay.categoryScrollTop = ", viewPay.categoryScrollTop);

      setTimeout(function () {
        scope.update();
      }, 0);
    });

    scope.index = -1;
    scope.show = false;
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;
    //    var count = 1;


    colorFieldInplaceSearch = function () {
      searchFieldActive = true;
      document.getElementById('searchContainerId').style.borderBottom = "" + 3 * widthK + "px solid #01cfff";
      if (document.getElementById('searchIcon'))
        searchIcon.style.backgroundImage = 'url(resources/icons/ViewInPlacePay/indoor_search_blue.png)';
    };

    blurFieldInplaceSearch = function () {
      searchFieldActive = false;
      document.getElementById('searchContainerId').style.borderBottom = "" + 3 * widthK + "px solid #cbcbcb";
      if (document.getElementById('searchIcon'))
        searchIcon.style.backgroundImage = 'url(resources/icons/ViewInPlacePay/indoor_search.png)';
    };

    keyUpFieldInplaceSearch = function () {

      console.log("search suggestions 1", event.target.value);

      if (event.keyCode === input_codes.ENTER) {
        window.blurFields();
      }

      scope.searchWord = event.target.value.toLowerCase();
      clearTimeout(searchFieldTimeout);

      searchFieldTimeout = setTimeout(function () {
        if (!scope.searchServices) scope.searchServices = true;

//      scope.update();
        window.saveHistory('view-pay-services', {searchWord: scope.searchWord});

        scope.suggestions = [];

        if (scope.searchWord.length != 0)
          arrayOfConnectedSuggestion.filter(function (service) {

            var index = service.name.toLowerCase().search(scope.searchWord.toString());
            if (index != -1 && service.is_visible) {
              if (opts.mode != "ADDAUTOPAY" || (opts.mode == "ADDAUTOPAY" && (service.autopay_available_schedule || service.autopay_available || !service.form_type))) {
                console.log("service is visible=", service.is_visible);
                console.log("found ", index, service.name);
                scope.suggestions.push(service);
                sessionStorage.setItem('click_client_suggestions', JSON.stringify(scope.suggestions));
              }
            }
          });
        console.log("array ", scope.suggestions);
        scope.update();
      });

    };

    onInputSearchField = function () {
      if (document.getElementById('searchInputId').value.length == 0) {
        scope.showSearchIcon = true;
      } else {
        scope.showSearchIcon = false;
      }
      scope.update();
    };

    onTouchStartOfSearchRemove = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchRemoveIcon)
        searchRemoveIcon.style.webkitTransform = 'scale(0.7)';

      searchStartX = event.changedTouches[0].pageX;
      searchStartY = event.changedTouches[0].pageY;

    };

    onTouchEndOfSearchRemove = function () {
      event.preventDefault();
      event.stopPropagation();

      if (searchRemoveIcon)
        searchRemoveIcon.style.webkitTransform = 'scale(1)';

      searchEndX = event.changedTouches[0].pageX;
      searchEndY = event.changedTouches[0].pageY;

      if (Math.abs(searchStartX - searchEndX) <= 20 && Math.abs(searchStartY - searchEndY) <= 20) {
        searchInputId.value = "";
        scope.showSearchIcon = true;
        scope.searchMode = false;
        scope.searchServices = false;
        scope.update();
      }
    };


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {
      event.stopPropagation();

      window.blurFields();
      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {

      if (scope.index != id)
        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';


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

          console.log("currentList=", scope.currentList);


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
      } else {
        scope.hintShow = false;
      }
//      scope.update();
    };


    onTouchMoveOfCategory = function () {

      event.stopPropagation();

      // For preventing click to service on stop scrolling categories
      scope.scrolling = true;
      setTimeout(function () {
        scope.scrolling = false;
      }, 350);

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

      window.blurFields();
      // For preventing click to service on stop scrolling categories
      if (scope.scrolling) {
        event.stopPropagation();
        event.preventDefault();
        onTouchStartY = 0;
        onTouchStartX = 0;
        return;
      }

      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };


    localStorage.setItem('autoPayData', null);
    window.viewServicePinCards = {};
    //opts = (!opts.mode || opts.mode == 'USUAL') ? {} : opts;

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {

      // For preventing click to service on stop scrolling categories
      if (scope.scrolling) {
        event.stopPropagation();
        event.preventDefault();
        return;
      }

      onTouchEndY = event.pageY;
      onTouchEndX = event.pageX;

      if ((Math.abs(onTouchStartY - onTouchEndY) <= 15 && Math.abs(onTouchStartX - onTouchEndX) <= 15) || scope.checkOfSearch) {

        event.preventDefault();
        event.stopPropagation();

        if (document.getElementById(id)) {
          if (searchInputId.value.length == 0)
            document.getElementById(id).style.webkitTransform = 'scale(0.8)';
          else
            document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';

        }

        setTimeout(function () {

          if (document.getElementById(id)) {
            if (searchInputId.value.length == 0)
              document.getElementById(id).style.webkitTransform = 'scale(1)';
            else
              document.getElementById(id).style.backgroundColor = 'transparent';
          }

          var newOpts = {};
          newOpts.mode = opts.mode;
          newOpts.categoryId = opts.categoryId;
          opts = JSON.parse(JSON.stringify(newOpts));
          newOpts = null;

          viewPay.categoryScrollTop = categoriesContainerId.scrollTop;
          opts.searchWord = searchInputId.value;

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
              riotTags.innerHTML = "<view-autopay-method-new>";
              riot.mount("view-autopay-method-new", opts);
              scope.unmount()
            } else {
              scope.autoPayData.title = window.languages.ViewAutoPayMethodSchedulerText;
              scope.autoPayData.autopay_type = 1;
              localStorage.setItem('autoPayData', JSON.stringify(scope.autoPayData));
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

            opts.categoryContainerScroll = categoriesContainerId.scrollTop;

            if (scope.servicesMap[id] && scope.servicesMap[id][0]) {
              console.log("form type=", scope.servicesMap[id][0].form_type, scope.servicesMap[id][0]);
              if (scope.servicesMap[id][0].form_type == 7) {
                riotTags.innerHTML = "<view-formtype-seven>";
                riot.mount("view-formtype-seven", opts);
              }
              else if (scope.servicesMap[id][0].form_type == 2) {
                riotTags.innerHTML = "<view-formtype-two>";
                riot.mount("view-formtype-two", opts);
              }
              else {
                riotTags.innerHTML = "<view-service-page-new>";
                riot.mount("view-service-page-new", opts);
                scope.unmount()
              }
            } else {
              riotTags.innerHTML = "<view-service-page-new>";
              riot.mount("view-service-page-new", opts);
              scope.unmount()
            }


          }
        }, 50);


      }
    };


    moveToService = function () {
      console.log(categoriesContainerId);
    };

  </script>
</view-pay>

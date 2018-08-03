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
    <div class="pay-service-hint-containter" id="hintContainerId" if="{false && hintShow}">
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
                 onkeydown="keyDownFieldInplaceSearch()"
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

      <div class="inplace-pay-category-inner-container" style="height: 91%;" if="{searchServices}"
           id="categoriesContainerId">


        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in suggestions}" style="overflow: hidden;">
            <div class="pay-service-block-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfService(this.id)"
                 ontouchend="onTouchEndOfService(this.id, true)">
              <img id="{i.id+'_sgn'}" if="{i.image}"
                   class="{pay-search-services-icon: !i.image_cached,pay-search-services-icon-noloader: i.image_cached}"
                   src="{i.image}" onload="clearLoaderOnIconLoad(this.id)"
                   onloadeddata="clearLoaderOnIconLoad(this.id)" onerror="errorDownloadImage(this.id)">
              <div class="pay-category-name-field">{i.name}
              </div>
            </div>
          </li>
        </ul>
        <div if="{suggestions.length==0}" class="inplace-pay-search-no-match">
          {window.languages.InPlaceSearchNoMatchText}
        </div>
      </div>

      <div class="inplace-pay-category-inner-container" style="height: auto;" if="{!searchServices}"
           id="categoriesContainerId"
           onscroll="onTouchMoveOfCategory()">

        <div each="{i in categoryList}"
             if="{!(modeOfApp.offlineMode && i.id == 11) && i.currentList && i.currentList.length !=0}"
             class="pay-service-block-containter" id="{i.id}"
             ontouchstart="onTouchStartOfCategory(this.id)"
             ontouchend="onTouchEndOfCategory(this.id)">
          <img id="{i.id+'_icon'}" if="{i.icon}"
               class="{pay-category-icon: !i.icon_cached, pay-category-icon-noloader: i.icon_cached}" src="{i.icon}"
               onload="clearLoaderOnIconLoad(this.id)"
               onloadeddata="clearLoaderOnIconLoad(this.id)" onerror="errorDownloadImage(this.id)">
          <div class="pay-category-name-field">{i.name}
          </div>
          <div class="pay-icon-tick" id="tick{i.id}"></div>
          <div class="pay-services-block" if="{index == i.id}" style="list-style:none">
            <div class="pay-service-containter"
                 each="{j in i.currentList}">

              <div class="pay-service-icon" id="{j.id}"
                   role="button"
                   aria-label="{j.name}"
                   ontouchend="onTouchEndOfService(this.id)" ontouchstart="onTouchStartOfService(this.id)">


                <div if="{j.image}"
                     id="{j.id + '_image_container'}"
                     class="{pay-service-image-container: true,
                            pay-service-image-nologo: !j.image_cached}">

                  <img id="{j.id+'_image'}" if="{j.image && !j.image_cached}"
                       class="pay-service-image"
                       src="{j.image}"
                       onload="onServiceImageLoaded('{j.id}')"
                       onloadeddata="onServiceImageLoaded('{j.id}')"
                       onerror="onServiceImageLoadError('{j.id}')">

                  <img hidden id="{j.id+'_image'}" if="{j.image && j.image_cached}"
                       class="pay-service-image pay-service-image-cached"
                       src="{j.image}"
                       onload="onServiceCachedImageLoaded('{j.id}')"
                       onloadeddata="onServiceCachedImageLoaded('{j.id}')"
                       onerror="onServiceImageLoadError('{j.id}')">

                </div>

                <div class="pay-service-name-field">{j.name}</div>

              </div>
            </div>
          </div>
        </div>


      </div>

    </div>
  </div>
  <script>
    //TODO: OPTIMIZE THIS PAGE SLOW DOWNLOADING CATEGORIES AND SERVICES
    var scope = this;
    scope.checkOfSearch = false;
    scope.scrolling = false;
    scope.titleName = opts.mode == 'ADDAUTOPAY' ? window.languages.ViewAutoPayTitleName : window.languages.ViewPayTitleName;

    window.saveHistory('view-pay', opts);

    var categoryList = localStorage.getItem("click_client_payCategoryList");
    var serviceList = localStorage.getItem("click_client_payServiceList");
    console.log("mode ", modeOfApp.onlineMode, modeOfApp.offlineMode);

    scope.categoryList = modeOfApp.onlineMode ? (categoryList ? JSON.parse(categoryList) : offlinePayCategoryList) : offlinePayCategoryList;
    scope.serviceList = modeOfApp.onlineMode ? (serviceList ? JSON.parse(serviceList) : offlinePayServiceList) : offlinePayServiceList;
    scope.serviceNamesMap = localStorage.getItem("click_client_payServiceNamesMap") ? (JSON.parse(localStorage.getItem("click_client_payServiceNamesMap"))) : (offlinePayServiceNamesMap);
    scope.servicesMapByCategory = localStorage.getItem("click_client_servicesMapByCategory") ? (JSON.parse(localStorage.getItem("click_client_servicesMapByCategory"))) : (offlineServicesMapByCategory);
    scope.servicesMap = localStorage.getItem("click_client_servicesMap") ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.servicesParamsMapOne = localStorage.getItem("click_client_servicesParamsMapOne") ? (JSON.parse(localStorage.getItem("click_client_servicesParamsMapOne"))) : (offlineServicesParamsMapOne);
    scope.categoryNamesMap = localStorage.getItem("click_client_categoryNamesMap") ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);
    scope.searchServices = false;
    scope.showSearchIcon = !opts.searchWord;
    var searchFieldTimeout;
    var arrayOfConnectedSuggestion = scope.serviceList;
    scope.suggestions = sessionStorage.getItem('suggestions') ? JSON.parse(sessionStorage.getItem('suggestions')) : [];

    // При клике на сервис, срабатывает ontouchend у родителького элемента. Этот булеан используется
    // чтобы определить был ли кликнут сервис, или блок категории
    scope.isServiceClicked = false;

    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    if (phoneNumber) {
      scope.operatorKey = phoneNumber.substr(3, 2);
      phoneNumber = phoneNumber.substring(3, phoneNumber.length);
    }

    if (loginInfo) {
      var sessionKey = loginInfo.session_key;
    }

    for (var j in scope.categoryList) {
      scope.categoryList[j].currentList = [];
      var id = scope.categoryList[j].id;
      for (var i in scope.servicesMapByCategory[id]) {
        if ((opts.mode != 'ADDAUTOPAY' && (modeOfApp.onlineMode || scope.servicesMapByCategory[id][i].id.toString().search('mynumber') != -1 || (modeOfApp.offlineMode && scope.servicesParamsMapOne[scope.servicesMapByCategory[id][i].id] && scope.servicesParamsMapOne[scope.servicesMapByCategory[id][i].id][0].ussd_query))) ||
          (opts.mode == 'ADDAUTOPAY' && (scope.servicesMapByCategory[id][i].autopay_available_schedule || scope.servicesMapByCategory[id][i].autopay_available || !scope.servicesMapByCategory[id][i].form_type))) {
          scope.categoryList[j].currentList.push(scope.servicesMapByCategory[id][i]);
        }
      }
    }

    console.log("scope.categoryList = ", scope.categoryList);


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
//        hintUpdate(viewPay.categoryId);
        scope.index = viewPay.categoryId;
        scope.show = true;
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
    var onCategoryTouchStartY, onCategoryTouchStartX;
    var onCategoryTouchEndY, onCategoryTouchEndX;
    var onServiceTouchStartY, onServiceTouchStartX;
    var onServiceTouchEndY, onServiceTouchEndX;
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

        window.saveHistory('view-pay-services', {searchWord: scope.searchWord});

        scope.suggestions = [];

        if (scope.searchWord.length != 0 && scope.searchWord != ' ') {

          var translitSearchWord = transliterateText(scope.searchWord);

          arrayOfConnectedSuggestion.filter(function (service) {
            var index = service.name.toLowerCase().search(scope.searchWord.toString());
            var translitBool = translitSearchWord.test(service.name);
            if ((index != -1 || translitBool) && service.is_visible && (modeOfApp.onlineMode || (modeOfApp.offlineMode && scope.servicesParamsMapOne[service.id] && scope.servicesParamsMapOne[service.id][0].ussd_query))) {
              if (opts.mode != "ADDAUTOPAY" || (opts.mode == "ADDAUTOPAY" && (service.autopay_available_schedule || service.autopay_available || !service.form_type))) {
                scope.suggestions.push(service);
              }
            }
          });
          scope.update();
        } else {
          scope.showSearchIcon = true;
          scope.searchMode = false;
//          scope.searchServices = false;
          scope.update();
//          onBackKeyDown();
        }
        sessionStorage.setItem('suggestions', JSON.stringify(scope.suggestions));
        console.log("array ", scope.suggestions);
        scope.update();
      }, 500);

    };

    keyDownFieldInplaceSearch = function () {
      scope.update();
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
        scope.suggestions = [];
        scope.showSearchIcon = true;
        scope.searchMode = false;
//        scope.searchServices = false;
        scope.update();
//        onBackKeyDown();
      }
    };


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {
      console.log('View.Pay.tag.onTouchStartOfCategory()')
      scope.isServiceClicked = false;
      event.stopPropagation();

      window.blurFields();
      onCategoryTouchStartY = event.changedTouches[0].pageY;
      onCategoryTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {
      if(scope.isServiceClicked) return;
      console.log('View.Pay.tag.onTouchEndOfCategory():', id);

      console.log(scope.categoryList);

      onCategoryTouchEndY = event.changedTouches[0].pageY;
      onCategoryTouchEndX = event.changedTouches[0].pageX;

      const isTap = (Math.abs(onCategoryTouchStartY - onCategoryTouchEndY) <= 20
        && Math.abs(onCategoryTouchStartX - onCategoryTouchEndX) <= 20);

      if(scope.index != id && isTap)
        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';

      if(isTap) {
        setTimeout(function () {
          document.getElementById(id).style.backgroundColor = 'transparent'
        }, 100);
      }

      setTimeout(function () {

        if (isTap || scope.checkOfSearch) {

          if (scope.index == id) {
            scope.index = -1;
            scope.update();
            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
          } else {
            if (scope.index != -1) {
              document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
              scope.update();
            }

            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";

            scope.index = id;

            viewPay.categoryId = id;
            opts.categoryId = id;

            scope.update();
            document.getElementById(id).scrollIntoView();

            setTimeout(function () {
              document.getElementById(id).scrollIntoView();
              console.log(scope.index)
            }, 50);
          }
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

//      var element = document.getElementById(scope.index);
//
//      if (element) {
//        if (categoriesContainerId.scrollTop - 40 > element.offsetTop) {
//          scope.hintShow = true;
//          scope.showCategoryIcon = scope.categoryNamesMap[scope.index].icon;
//          scope.showCategoryName = scope.categoryNamesMap[scope.index].name;
//          scope.update();
//        } else {
//          scope.hintShow = false;
//          scope.update();
//        }
//      }
      scope.update();
    };


    scope.onTouchStartOfService = onTouchStartOfService = function (id) {
      console.log('View.Pay.tag.onTouchStartOfService()')
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

      onServiceTouchStartY = event.changedTouches[0].pageY;
      onServiceTouchStartX = event.changedTouches[0].pageX;
    };


    localStorage.setItem('autoPayData', null);
    window.viewServicePinCards = {};
    //opts = (!opts.mode || opts.mode == 'USUAL') ? {} : opts;

    scope.onTouchEndOfService = onTouchEndOfService = function (id) {
      console.log('View.Pay.tag.onTouchEndOfService()')
      scope.isServiceClicked = true;

      // For preventing click to service on stop scrolling categories
      if (scope.scrolling) {
        event.stopPropagation();
        event.preventDefault();
        return;
      }

      onServiceTouchEndY = event.changedTouches[0].pageY;
      onServiceTouchEndX = event.changedTouches[0].pageX;

      if ((Math.abs(onServiceTouchStartY - onServiceTouchEndY) <= 15 && Math.abs(onServiceTouchStartX - onServiceTouchEndX) <= 15) || scope.checkOfSearch) {

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

            openPayServiceById(id, opts);

            scope.unmount()

          }
        }, 50);


      }
    };

    onServiceImageLoaded = function(serviceId) {
      console.log('View.Pay.tag.onServiceImageLoaded()', serviceId)
      document.getElementById(serviceId + '_image').style.opacity = 1;
      document.getElementById(serviceId + '_image_container').style.backgroundImage = "none";
    };

    onServiceCachedImageLoaded = function(serviceId) {
      console.log('View.Pay.tag.onServiceImageLoadError()', serviceId);
      document.getElementById(serviceId + '_image').hidden = false;
    };

    onServiceImageLoadError = function(serviceId) {
      console.log('View.Pay.tag.onServiceImageLoadError()', serviceId);
      document.getElementById(serviceId + '_image').hidden = true;
      document.getElementById(serviceId + '_image_container').classList.add("pay-service-image-nologo");
    };

    moveToService = function () {
      console.log(categoriesContainerId);
    };

  </script>
</view-pay>

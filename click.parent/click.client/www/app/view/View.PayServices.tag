<view-pay-services>
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

      <div class="inplace-pay-category-inner-container" id="categoriesContainerId">

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
        <div if="{suggestions.length==0}" class="inplace-pay-search-no-match">
          {window.languages.InPlaceSearchNoMatchText}
        </div>
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

    window.saveHistory('view-pay-services', opts);

    scope.categoryList = (JSON.parse(localStorage.getItem("click_client_payCategoryList"))) ? (JSON.parse(localStorage.getItem("click_client_payCategoryList"))) : (offlinePayCategoryList);
    scope.serviceList = (JSON.parse(localStorage.getItem("click_client_payServiceList"))) ? (JSON.parse(localStorage.getItem("click_client_payServiceList"))) : (offlinePayServiceList);
    scope.servicesMap = (JSON.parse(localStorage.getItem("click_client_servicesMap"))) ? (JSON.parse(localStorage.getItem("click_client_servicesMap"))) : (offlineServicesMap);
    scope.showSearchIcon = !opts.searchWord;
    var searchFieldTimeout;
    var arrayOfConnectedSuggestion = scope.categoryList.concat(scope.serviceList);
    scope.suggestions = sessionStorage.getItem('suggestions') ? JSON.parse(sessionStorage.getItem('suggestions')) : [];


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
      console.log("OPTS in Pay services", opts, opts.mode);

      categoriesContainerId.scrollTop = viewPay.categoryScrollTop;
      viewPay.categoryScrollTop = null;


      console.log("viewPay.categoryScrollTop = ", viewPay.categoryScrollTop);

      setTimeout(function () {
        riot.update();
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

      if (event.keyCode === input_codes.ENTER) {
        window.blurFields();
      }

      scope.searchWord = event.target.value.toLowerCase();
      clearTimeout(searchFieldTimeout);

      searchFieldTimeout = setTimeout(function () {

        scope.suggestions = [];
        console.log("emtying");

        if (scope.searchWord.length != 0) {
          arrayOfConnectedSuggestion.filter(function (service) {

            var index = service.name.toLowerCase().search(scope.searchWord.toString());
            if (index != -1 && service.is_visible) {
              if (opts.mode != "ADDAUTOPAY" || (opts.mode == "ADDAUTOPAY" && (service.autopay_available_schedule || service.autopay_available || !service.form_type))) {
                scope.suggestions.push(service);
              }
            }
          });
          scope.update();
        } else {
          scope.suggestions = scope.serviceList;
        }
        sessionStorage.setItem('suggestions', JSON.stringify(scope.suggestions));
        console.log("array ", scope.suggestions);
        scope.update();

      }, 500);
    };

    keyDownFieldInplaceSearch = function () {
      scope.update();
    }

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
//        searchInputId.value = "";
//        scope.showSearchIcon = true;
//        scope.searchMode = false;
//        scope.update();

        onBackKeyDown();
      }
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

        event.stopPropagation();
        event.preventDefault();

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

            openPayServiceById(id, opts);
          }
        }, 50);


      }
    };

  </script>
</view-pay-services>

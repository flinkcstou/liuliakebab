<view-inplace-pay>
  <div id="viewPayId" class="view-pay riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>

    <div class="inplace-pay-category-container" id="categoriesContainerId">
      <div class="inplace-pay-inner-container">
        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in categoryList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode)}" class="pay-service-block-containter" id="{i.id}"
                 ontouchstart="onTouchStartOfCategory(this.id)"
                 onclick="onTouchEndOfCategory(this.id)">
              <div class="pay-category-icon" style="background-image: url({i.icon})"></div>
              <div class="pay-category-name-field">{i.name}
              </div>
              <div class="pay-icon-tick" id="tick{i.id}"></div>
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

    scope.titleName = window.languages.ViewInPlacePayTitle;

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
    scope.categoryNamesMap = (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) ? (JSON.parse(localStorage.getItem("click_client_categoryNamesMap"))) : (offlineCategoryNamesMap);


    var phoneNumber = localStorage.getItem('click_client_phoneNumber');
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    if (phoneNumber) {
      scope.operatorKey = phoneNumber.substr(3, 2);
      phoneNumber = phoneNumber.substring(3, phoneNumber.length);
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


    scope.index = -1;
    scope.show = false;
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function (id) {
      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id) {

//      if (scope.index != id)
//        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)'
//
//
//      setTimeout(function () {
//        document.getElementById(id).style.backgroundColor = 'transparent'
//      }, 100)
//
//
//      onTouchEndY = event.pageY;
//      onTouchEndX = event.pageX;
//
//
//      setTimeout(function () {
//
//
//        if ((Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) || scope.checkOfSearch) {
//
//
//          if (scope.index == id) {
//            scope.index = -1;
//          } else {
//            if (scope.index != -1) {
//              document.getElementById("tick" + scope.index).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
//            }
//            scope.index = id;
//          }
//
//          scope.currentList = scope.servicesMapByCategory[id];
////        count = 1;
//
//
//          if (!scope.currentList) {
//            scope.show = false;
//          } else {
//            scope.show = true;
//            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catopen.png)";
//          }
//
//          if (scope.index == id && scope.show) {
//            document.getElementById("tick" + id).style.backgroundImage = "url(resources/icons/ViewPay/catclose.png)";
//            viewPay.categoryId = id;
//            opts.categoryId = id;
//            hintUpdate(scope.index);
//          }
//
//          document.getElementById(id).scrollIntoView();
////        categoriesContainerId.scrollIntoView(document.getElementById(id).offsetTop)
//
////        categoriesContainerId.scrollTop = event.changedTouches[0].pageY;
//
//          scope.update();
//        }
//      }, 100)
    };


    localStorage.setItem('autoPayData', null);
    window.viewServicePinCards = {};


  </script>
</view-inplace-pay>

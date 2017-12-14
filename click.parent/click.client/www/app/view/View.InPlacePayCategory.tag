<view-inplace-pay-category>
  <div id="viewPayId" class="view-pay riot-tags-main-container">
    <div class="pay-page-title">
      <p class="pay-name-title">{titleName}</p>
      <div id="backButton" role="button" aria-label="{window.languages.Back}" ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()" class="pay-back-button"></div>
    </div>

    <div class="inplace-pay-category-container" id="categoriesContainerId">

      <div id="searchContainerId" class="inplace-pay-search-container">
        <input id="searchInputId" class="inplace-pay-search-input"/>
      </div>

      <div class="inplace-pay-inner-container">
        <ul style="list-style:none; padding: 0; margin: 0; overflow: hidden;">
          <li each="{i in categoryList}" style="overflow: hidden;">
            <div if="{!(modeOfApp.offlineMode)}" class="inplace-pay-block-containter" title="{i.category_name}"
                 id="{i.category_id}"
                 ontouchstart="onTouchStartOfCategory()"
                 ontouchend="onTouchEndOfCategory(this.id, this.title)">
              <div class="inplace-pay-category-icon" style="background-image: url({i.icon})"></div>
              <div class="inplace-pay-category-name-field">{i.category_name}
              </div>
              <div class="inplace-pay-icon-tick"></div>
            </div>
          </li>
        </ul>
      </div>

    </div>

  </div>
  <script>

    var scope = this;
    scope.checkOfSearch = false;
    scope.titleName = window.languages.ViewInPlacePayTitle;
    var onTouchStartY, onTouchStartX;
    var onTouchEndY, onTouchEndX;
    var goBackButtonStartX, goBackButtonEndX,
      goBackButtonStartY, goBackButtonEndY;
    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
    var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    var sessionKey = loginInfo.session_key;


    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-inplace-pay-category') {
      history.arrayOfHistory.push(
        {
          "view": 'view-inplace-pay-category',
          "params": opts
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    if (JSON.parse(sessionStorage.getItem('click_client_inPlacePayCategoryList'))) {
      scope.categoryList = JSON.parse(sessionStorage.getItem('click_client_inPlacePayCategoryList'));
      scope.update();
    }
    else if (modeOfApp.onlineMode) {

      scope.categoryList = [];

      window.api.call({
        method: 'get.indoor.category.list',
        input: {
          session_key: sessionKey,
          phone_num: phoneNumber
        },
        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0)
            if (result[1][0]) {


              for (var i in result[1]) {

                scope.categoryList.push(result[1][i]);

              }
              sessionStorage.setItem('click_client_inPlacePayCategoryList', JSON.stringify(scope.categoryList));
              scope.update();

            }

        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };


    scope.onTouchStartOfCategory = onTouchStartOfCategory = function () {
      event.preventDefault();
      event.stopPropagation();


      onTouchStartY = event.changedTouches[0].pageY;
      onTouchStartX = event.changedTouches[0].pageX;
    };

    scope.onTouchEndOfCategory = onTouchEndOfCategory = function (id, name) {
      event.preventDefault();
      event.stopPropagation();

      onTouchEndY = event.changedTouches[0].pageY;
      onTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(onTouchStartY - onTouchEndY) <= 20 && Math.abs(onTouchStartX - onTouchEndX) <= 20) {

        console.log(id, name);

        riotTags.innerHTML = "<view-inplace-pay-service>";
        riot.mount('view-inplace-pay-service', {categoryId: id, categoryName: name});

      }
    };


  </script>
</view-inplace-pay-category>

<view-main-page class="riot-tags-main-container">
  <div class="side-menu-block-for-swipe" ontouchend="blockForSwipeTouchEnd()"
       ontouchstart="blockForSwipeTouchStart()" ontouchmove="blockForSwipeTouchMove()"></div>
  <component-menu></component-menu>

  <div id="mainPageId" class="view-main-page">
    <component-toolbar></component-toolbar>
    <component-bank-operations></component-bank-operations>
    <component-service-carousel-new></component-service-carousel-new>
    <component-card-carousel></component-card-carousel>
    <component-footer></component-footer>

    <view-news if="{!modeOfApp.offlineMode}"></view-news>

    <div class="bank-operation-button-my-cards">
      <div id="myCardButtonId" class="bank-operation-button-my-cards-container" if="{!viewMainPage.addFirstCardBool}">
        <div class="bank-operation-button-my-cards-icon"></div>
        <div class="bank-operation-button-my-cards-label">
          {window.languages.BankOperationsAutoPay}
        </div>
        <div class="bank-operation-button-container"
             ontouchend="myCardListTouchEnd()"
             ontouchstart="myCardListTouchStart()"></div>
      </div>
    </div>
  </div>

  <component-tour view="mainpage"></component-tour>
  <script>

    viewMainPage.atMainPage = true;
    viewTransfer.check = false;
    viewServicePinCards.friendHelpPaymentMode = false;
    viewServicePinCards.chosenFriendForHelp = [];
    componentMenu.check = false;
    viewServicePage.amountWithoutSpace = 0;
    viewServicePage.amountTex = 0;
    onBackParams.opts = null;
    viewMainPage.myCards = false;
    viewTransfer.phoneNumber = '';
    viewTransfer.cardNumber = '';
    viewTransfer.type = 2;
    viewTransferStepTwo.sum = '';

    var touchStartX, touchEndX, touchMoveX;
    var timeStartX, timeEndX;
    var width = window.innerWidth;

    var myCardListStartX, myCardListEndX, myCardListStartY, myCardListEndY;


    this.on('mount', function () {
      if (device.platform !== 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");

      localStorage.setItem("click_client_authorized", true);

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).mainpage) {
        componentTourId.style.display = "block";
        if (device.platform !== 'BrowserStand')
          StatusBar.backgroundColorByHexString("#004663");
      }

      if (opts) {
        if (opts.view === "news" || (sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true)) {
          console.log("mainPage news");
          viewNewsId.style.display = 'block';
          scope.tags['view-news'].showNewsFunction(1);


          if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view !== 'view-news') {
            history.arrayOfHistory.push(
              {
                "view": 'view-news',
                "params": opts
              }
            );
            sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
          }
        }
      }
    });


    var scope = this;


    localStorage.setItem('cardNumber', 1);

    history.arrayOfHistory = [];
    history.arrayOfHistory.push(
      {
        "view": 'view-main-page',
        "params": opts
      }
    );
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


    myCardListTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      myCardButtonId.style.webkitTransform = 'scale(0.7)';

      myCardListStartX = event.changedTouches[0].pageX;
      myCardListStartY = event.changedTouches[0].pageY;
    };
    myCardListTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      myCardButtonId.style.webkitTransform = 'scale(1)';

      myCardListEndX = event.changedTouches[0].pageX;
      myCardListEndY = event.changedTouches[0].pageY;

      if (Math.abs(myCardListStartX - myCardListEndX) <= 20 && Math.abs(myCardListStartY - myCardListEndY) <= 20) {

        this.riotTags.innerHTML = "<view-mycard-list>";
        riot.mount('view-mycard-list');

        scope.unmount()

      }
      else return
    };

    blockForSwipeTouchStart = function () {
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);
      sideMenuId.style.webkitTransition = '0s';
      mainPageId.style.webkitTransition = '0s';
      sideMenuBackPageId.style.webkitTransition = '0s';
    };

    blockForSwipeTouchEnd = function () {
      event.stopPropagation();

      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      console.log('touchMoveX', touchMoveX);
      console.log('widthK', 269 * widthK);
      if (touchMoveX > 269 * widthK) {
        menuOpenTouchEnd(true);
      }
      else {
        if (timeEndX - timeStartX < 500 && touchEndX - touchStartX > 20) {
          menuOpenTouchEnd(true);
        }
        else
          closeMenu()
      }
    };

    blockForSwipeTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      var deltaForSideMenuBack = event.changedTouches[0].pageX.toFixed(0) / width;
      var deltaForMainPage = 1 - deltaForSideMenuBack;
      if (deltaForMainPage < 0.1)
        deltaForMainPage = 0.1;
      if (event.changedTouches[0].pageX - 538 * widthK <= 0) {
        sideMenuId.style.webkitTransform = 'translate3d(' + (event.changedTouches[0].pageX - 538 * widthK) + 'px,0,0)'
        touchMoveX = event.changedTouches[0].pageX;
      }
      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
      mainPageId.style.opacity = deltaForMainPage;
    };

    if (!localStorage.getItem('push_registered')) {
      window.pushNotificationInitialize();
    }


  </script>
</view-main-page>


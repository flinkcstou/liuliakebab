<view-main-page class="riot-tags-main-container">
  <div class="side-menu-block-for-swipe" ontouchend="blockForSwipeTouchEnd()"
       ontouchstart="blockForSwipeTouchStart()" ontouchmove="blockForSwipeTouchMove()"></div>
  <component-menu></component-menu>

  <div id="mainPageId" class="view-main-page">
    <component-toolbar></component-toolbar>
    <component-bank-operations></component-bank-operations>
    <component-service-carousel></component-service-carousel>
    <component-card-carousel></component-card-carousel>
    <component-footer></component-footer>

    <view-news></view-news>

    <div class="bank-operation-button-my-cards">
      <div class="bank-operation-button-my-cards-container">
        <div class="bank-operation-button-my-cards-icon"></div>
        <div class="bank-operation-button-my-cards-label">
          {window.languages.BankOperationsAutoPay}
        </div>
        <div class="bank-operation-button-container" ontouchend="myCardListTouchEnd()"
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

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).mainpage) {
        componentTourId.style.display = "block";
        StatusBar.backgroundColorByHexString("#002334");
      }
    });

    var scope = this;
    //
    //        function sum(arg1, arg2, callback) {
    //
    //            var my_number = arg1 + arg2;
    //
    //            callback(my_number);
    //        }
    //
    //        sum(5, 15, function(num) {
    //            console.log("callback SUM " + num);
    //        });

    localStorage.setItem('cardNumber', 0);

    history.arrayOfHistory = [];
    history.arrayOfHistory.push(
      {
        "view": 'view-main-page',
        "params": opts
      }
    );
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

    viewMainPage.myCards = false;
    viewTransfer.phoneNumber = '';
    viewTransfer.cardNumber = '';
    viewTransfer.type = 2;
    viewTransferStepTwo.sum = '';

    var touchStartX, touchEndX, touchMoveX;
    var timeStartX, timeEndX;
    var width = window.innerWidth;


    var myCardListStartX, myCardListEndX, myCardListStartY, myCardListEndY

    myCardListTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      myCardListStartX = event.changedTouches[0].pageX;
      myCardListStartY = event.changedTouches[0].pageY;
    }
    myCardListTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

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
      event.stopPropagation()

      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

//      if (touchEndX - touchStartX > 20) {
//        menuOpen();
//      }

      console.log('touchMoveX', touchMoveX)
      console.log('widthK', 269 * widthK)
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
    }

    blockForSwipeTouchMove = function () {
      event.preventDefault()
      event.stopPropagation()
      var deltaForSideMenuBack = event.changedTouches[0].pageX.toFixed(0) / width;
      var deltaForMainPage = 1 - deltaForSideMenuBack;
      if (deltaForMainPage < 0.1)
        deltaForMainPage = 0.1
      if (event.changedTouches[0].pageX - 538 * widthK <= 0) {
        sideMenuId.style.webkitTransform = 'translate3d(' + (event.changedTouches[0].pageX - 538 * widthK) + 'px,0,0)'
        touchMoveX = event.changedTouches[0].pageX;
      }
      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
      mainPageId.style.opacity = deltaForMainPage;
    }


  </script>
</view-main-page>


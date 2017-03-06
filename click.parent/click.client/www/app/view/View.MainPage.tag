<view-main-page>
  <div class="side-menu-block-for-swipe" ontouchend="blockForSwipeTouchEnd()"
       ontouchstart="blockForSwipeTouchStart()" ontouchmove="blockForSwipeTouchMove()"></div>
  <component-menu></component-menu>

  <div id="mainPageId" class="view-main-page">
    <component-toolbar></component-toolbar>
    <component-bank-operations></component-bank-operations>
    <component-service-carousel></component-service-carousel>
    <component-footer></component-footer>
    <component-card-carousel>
    </component-card-carousel>

    <div id="myalt" style="visibility:hidden; position:absolute; left:0; top:0; border-style:solid; border-color:'#000000';
    border-width:1px; width:400px; height:10px; background-color:'#f5f5f5'; padding:3px; z-Index:3"></div>

    <div class="bank-operation-button-my-cards">
      <div class="bank-operation-button-my-cards-container">
        <div class="bank-operation-button-my-cards-icon"></div>
        <div class="bank-operation-button-my-cards-label">
          {window.languages.BankOperationsAutoPay}
        </div>
        <div class="bank-operation-button-container" ontouchend="myCardList()"></div>
      </div>
    </div>
  </div>
  <component-success></component-success>
  <script>
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
        "params": ''
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

    myCardList = function () {
      event.preventDefault();
      event.stopPropagation();
      this.riotTags.innerHTML = "<view-mycard-list>";
      riot.mount('view-mycard-list');
    }

    blockForSwipeTouchStart = function () {
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);
      sideMenuId.style.webkitTransition = '0s';
      mainPageId.style.webkitTransition = '0s';
      sideMenuBackPageId.style.webkitTransition = '0s';

      console.log('TOUCH START', event)
    }

    blockForSwipeTouchEnd = function () {
      event.preventDefault()
      event.stopPropagation()

      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      console.log('TOUCH END', event)

//      if (touchEndX - touchStartX > 20) {
//        menuOpen();
//      }

      console.log('touchMoveX', touchMoveX)
      console.log('widthK', 269 * widthK)
      if (touchMoveX > 269 * widthK) {
        menuOpen();
      }
      else {
        if (timeEndX - timeStartX < 100 && touchEndX - touchStartX > 20) {
          menuOpen();
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
      console.log('deltaForMainPage', deltaForMainPage)
      mainPageId.style.opacity = deltaForMainPage;
      //console.log('touchMoveX', event)
    }


  </script>
</view-main-page>


<view-main-page class="riot-tags-main-container">
  <component-menu></component-menu>

  <div id="mainPageId" class="view-main-page">
    <component-toolbar></component-toolbar>
    <component-bank-operations></component-bank-operations>
    <component-service-carousel-new></component-service-carousel-new>
    <component-card-carousel></component-card-carousel>
    <component-footer></component-footer>

    <view-news if="{!modeOfApp.offlineMode}"></view-news>

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
    viewServicePage.amountWithoutSpace = 0;
    viewServicePage.amountTex = 0;

    this.on('mount', function () {
      if (device.platform != 'BrowserStand')
        StatusBar.backgroundColorByHexString("#00a8f1");

      if (JSON.parse(localStorage.getItem("tour_data")) && !JSON.parse(localStorage.getItem("tour_data")).mainpage) {
        componentTourId.style.display = "block";
        if (device.platform != 'BrowserStand')
          StatusBar.backgroundColorByHexString("#004663");
      }

      if (opts) {
        if (opts.view == "news") {
          viewNewsId.style.display = 'block'

//          window.News.newsCounter = 0;

          if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-news') {
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

    localStorage.setItem('cardNumber', 1);

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


  </script>
</view-main-page>


<component-tour id="componentTourId" style="display:none;">


  <div id="monthContainerId" class="view-reports-months-container" ontouchstart="monthContainerTouchStart()"
       ontouchend="monthContainerTouchEnd()"
       ontouchmove="monthContainerTouchMove()">
    <div class="view-reports-month-info-container" each="{i in monthsArray}"
         style="left:{50*i.count}%;">
      <p class="view-reports-month-info-name">{i.name}</p>
    </div>
  </div>

  <script>

    //    <div class="tour-card-carousel" ontouchend="endTouchTourCarousel()"
    //    ontouchmove="moveTouchTourCarousel()"
    //    ontouchstart="startTouchTourCarousel()">
    //
    //      <div id="tourCards">
    //      <component-tour-card each="{i in tourCardsArray}"
    //    operationmessage="{i.text}"
    //    countcard="{i.counter}"></component-tour-card>
    //      </div>
    //      </div>

    var scope = this;
    var tourOnTouchStartY, tourOnTouchStartX, tourOnTouchEndY, tourOnTouchEndX;
    console.log("component tour");

    scope.monthsArray = window.languages.ViewReportMonthsArray;
    console.log("monthsArray", scope.monthsArray);
    scope.update(scope.monthsArray);
    scope.count = 12;
    scope.mNumber = 0;
    var mCarouselTouchStartX, mCarouselTouchStartY, mCarouselTouchEndX, mCarouselTouchEndY
    var left;
    var delta;

    monthContainerTouchStart = function () {

      console.log("in start touch=", scope.mNumber);
      mCarouselTouchStartX = event.changedTouches[0].pageX;
      mCarouselTouchStartY = event.changedTouches[0].pageY;

      percentageTouche = (mCarouselTouchStartX * 100.0) / window.innerHeight;

      console.log("touche started at %", percentageTouche);

      left = -(50 * scope.mNumber) - percentageTouche;
      delta = left;
    };


    monthContainerTouchEnd = function () {


      event.preventDefault();
      event.stopPropagation();

      mCarouselTouchEndX = event.changedTouches[0].pageX;
      mCarouselTouchEndY = event.changedTouches[0].pageY;
      console.log(Math.abs(mCarouselTouchStartX - mCarouselTouchEndX))
      console.log(Math.abs(mCarouselTouchStartY - mCarouselTouchEndY))
      if (Math.abs(mCarouselTouchStartX - mCarouselTouchEndX) > 20) {
        console.log('Touch end of carousel')
        changePosition();
      }
      else {
        monthChanged = false;
      }
    };


    var toucheInPercentage;
    monthContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();


      toucheInPercentage = (event.changedTouches[0].pageX * 100.0) / window.innerHeight;

      this.monthContainerId.style.transition = '0s';
      this.monthContainerId.style.webkitTransition = '0s';
      this.monthContainerId.style.transform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";
      this.monthContainerId.style.webkitTransform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";

    };


    changePosition = function () {
      console.log("One")
      console.log("scope.count", scope.count)

      monthChanged = true;
      if (mCarouselTouchEndX < mCarouselTouchStartX && scope.mNumber < scope.count - 1) {
        ++scope.mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (mCarouselTouchEndX > mCarouselTouchStartX && scope.mNumber == 0) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (mCarouselTouchEndX < mCarouselTouchStartX && scope.mNumber == scope.count - 1) {
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }

      if (mCarouselTouchEndX > mCarouselTouchStartX && scope.mNumber > 0) {
        --scope.mNumber;
        this.monthContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.monthContainerId.style.transform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
        this.monthContainerId.style.webkitTransform = "translate3d(" + (-scope.mNumber * 50) + '%' + ", 0, 0)";
      }


      localStorage.setItem('mNumber', scope.mNumber);
    }


    closeTour = function () {
      event.preventDefault();
      event.stopPropagation();
      componentTourId.style.display = 'none';
    }

    scope.cardNumber = 0, count = 3;
    scope.tourCardsArray = [{counter: 1, text: "Hello"}, {counter: 2, text: "World"}, {
      counter: 3,
      text: "And others!"
    }];


    startTouchTourCarousel = function () {
//      console.log("Start Touch Carousel", scope.cardNumber);

      tourOnTouchStartX = event.changedTouches[0].pageX;
      left = -((540 * scope.cardNumber) * widthK) - tourOnTouchStartX;
      delta = left;
    }

    //    moveTouchTourCarousel = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //      this.tourCards.style.transition = '0s';
    //      this.tourCards.style.webkitTransition = '0s';
    //      this.tourCards.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
    //      this.tourCards.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta ) + 'px' + ", 0, 0)";
    //    }
    //
    //    endTouchTourCarousel = function () {
    //
    //      event.preventDefault();
    //      event.stopPropagation();
    //      tourOnTouchEndX = event.changedTouches[0].pageX;
    //      if (Math.abs(tourOnTouchStartX - tourOnTouchEndX) > 20) {
    //        changePosition();
    //      }
    //    }
    //
    //    function changePosition() {
    //
    //      console.log(tourOnTouchEndX, tourOnTouchStartX, count, count)
    //
    //      if (tourOnTouchEndX < tourOnTouchStartX && scope.cardNumber < count - 1) {
    //
    //        console.log("Move Touch Carousel1", scope.cardNumber);
    //
    //        ++scope.cardNumber;
    ////        riot.update(scope.cardNumber);
    //        this.tourCards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //        this.tourCards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //
    //      }
    //
    //      if (tourOnTouchEndX > tourOnTouchStartX && scope.cardNumber == 0) {
    //
    //        console.log("Move Touch Carousel2", scope.cardNumber);
    //
    //        this.tourCards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //        this.tourCards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //      }
    //
    //      if (tourOnTouchEndX < tourOnTouchStartX && scope.cardNumber == count - 1) {
    //
    //        console.log("Move Touch Carousel3", scope.cardNumber);
    //
    //        this.tourCards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //        this.tourCards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //
    //      }
    //
    //      if (tourOnTouchEndX > tourOnTouchStartX && scope.cardNumber > 0) {
    //
    //        console.log("Move Touch Carousel4", scope.cardNumber);
    //
    //        --scope.cardNumber;
    ////        riot.update(scope.cardNumber);
    //        this.tourCards.style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
    //        this.tourCards.style.transform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //        this.tourCards.style.webkitTransform = "translate3d(" + (-scope.cardNumber * 540) * widthK + 'px' + ", 0, 0)";
    //      }
    //
    //
    ////      localStorage.setItem('cardNumber', scope.cardNumber);
    //    }

  </script>
</component-tour>


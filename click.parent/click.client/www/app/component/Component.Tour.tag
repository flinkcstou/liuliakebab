<component-tour id="componentTourId" style="display: none;">

  <div class="component-tour">

    <p class="tour-title-text" id="tourTitleId">{tourTitle}</p>

    <div id="firstCloseButtonId" role="button" aria-label="{window.languages.Close}" type="button"
         class="tour-close-icon"
         ontouchstart="closeTourStart(this.id)" ontouchend="closeTourEnd(this.id)"></div>


    <div id="tourContainerId"
         class="tour-card-carousel"
         ontouchstart="tourContainerTouchStart()"
         ontouchend="tourContainerTouchEnd()"
         ontouchmove="tourContainerTouchMove()">


      <div class="component-tour-card"
           each="{i in tourCardsArray}"
           style="left:{84+100*(i.counter-1)}%;">
        <div class="component-card-upper-container" style="background-color: {i.back_color};">
          <div
            class="{classForPages}"
            style="background-image: url({i.image});background-size: {i.icon_size}%;background-position-y: {i.icon_y}%;"></div>
        </div>
        <div class="component-card-lower-container">
          <p class="component-card-lower-title-text">{i.title}</p>
          <p class="component-card-lower-body-text">{i.text}</p>
        </div>
      </div>

    </div>

    <div class="component-tour-bottom">
      <div class="tour-circles-container" if="{tourCirclesShow}"
           style="width: {((tourCardsArray.length) * 40 + 52)*widthK}px">

        <div id="circle{i.counter-1}" style="left: {(i.counter)*40*widthK }px;" class="tour-circles"
             each="{i in tourCardsArray}"></div>

      </div>

      <div class="tour-buttons-container" if="{!registrButton}">
        <div id="secondCloseButtonId" class="tour-next-button tour-close-button" ontouchstart="closeTourStart(this.id)"
             ontouchend="closeTourEnd(this.id)">
          <p class="tour-button-label tour-close-button-label">{window.languages.ComponentTourCloseButtonText}</p>
        </div>
        <div id="nextTourCardId" class="tour-next-button" ontouchstart="nextTourCardStart(this.id)"
             ontouchend="nextTourCardEnd(this.id)">
          <p class="tour-button-label">{window.languages.ComponentTourNextButtonText}</p>
        </div>
      </div>

      <div class="tour-buttons-container" if="{registrButton}">
        <div
          id="thirdCloseButtonId"
          class="tour-registration-button"
          ontouchstart="closeTourStart(this.id)" ontouchend="closeTourEnd(this.id)">
          <p class="tour-registration-button-label">
            {window.languages.ComponentTourCloseButtonTextIn}</p>
        </div>
      </div>
    </div>


  </div>

  <div id="tourBackPageId" class="tour-back-page"></div>


  <script>


    var scope = this;
    scope.classForPages = '';

    if (opts.view == 'registration') {
      scope.classForPages = "component-card-upper-icon";
    }
    else
      scope.classForPages = "component-card-upper-icon-in";
    scope.update();

    if (opts.view == "registration") {
      scope.tourCardsArray = tourCards.registration;
      scope.tourTitle = window.languages.ComponentTourRegistrationTitleText;
      scope.count = 5;
      scope.update();
    } else if (opts.view == "mainpage") {
      scope.tourCardsArray = tourCards.mainpage;
      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 2;
      scope.update();
    } else if (opts.view == "transfer") {
      scope.tourCardsArray = tourCards.transfer;
      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 3;
      scope.update();
    } else if (opts.view == "invoice") {
      scope.tourCardsArray = tourCards.invoice;
      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 2;
      scope.update();
    } else if (opts.view == "autopaymethod") {
      scope.tourCardsArray = tourCards.autopaymethod;
      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 2;
      scope.update();
    } else if (opts.view == "calculator") {
      scope.tourCardsArray = tourCards.calculator;
      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 1;
      scope.update();
    } else if (opts.view == "friendhelp") {
      scope.tourCardsArray = tourCards.friendhelp;
      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 1;
      scope.update();
    }


    scope.tNumber = 0;
    var tourCarouselTouchStartX, tourCarouselTouchStartY, tourCarouselTouchEndX, tourCarouselTouchEndY;
    var left;
    var delta;
    scope.registrButton = false;
    scope.tourCirclesShow = true;

    scope.on('mount', function () {
//      if (device.platform != 'BrowserStand') {
//       StatusBar.backgroundColorByHexString("#002334");
//      }
      document.getElementById("circle" + scope.tNumber).style.backgroundColor = '#c1c1c1';
      document.getElementById('tourTitleId').style.color = scope.tourCardsArray[scope.tNumber].title_color;
      if (scope.count == 1) {
        scope.registrButton = true;
        scope.tourCirclesShow = false;
      }
      scope.update();
    });

    tourContainerTouchStart = function () {

      tourCarouselTouchStartX = event.changedTouches[0].pageX;
      tourCarouselTouchStartY = event.changedTouches[0].pageY;

      percentageTouche = (tourCarouselTouchStartX * 100.0) / window.innerHeight;


      left = -(100 * scope.tNumber) - percentageTouche;
      delta = left;
    };


    tourContainerTouchEnd = function () {


      event.preventDefault();
      event.stopPropagation();

      tourCarouselTouchEndX = event.changedTouches[0].pageX;
      tourCarouselTouchEndY = event.changedTouches[0].pageY;
      console.log(Math.abs(tourCarouselTouchStartX - tourCarouselTouchEndX));
      console.log(Math.abs(tourCarouselTouchStartY - tourCarouselTouchEndY));
      if (Math.abs(tourCarouselTouchStartX - tourCarouselTouchEndX) > 20) {
        changePosition();
      }
    };


    var toucheInPercentage;
    tourContainerTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();


      toucheInPercentage = (event.changedTouches[0].pageX * 100.0) / window.innerHeight;

      this.tourContainerId.style.transition = '0s';
      this.tourContainerId.style.webkitTransition = '0s';
      this.tourContainerId.style.transform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";
      this.tourContainerId.style.webkitTransform = "translate3d(" + (toucheInPercentage + delta ) + '%' + ", 0, 0)";

    };

    scope.shift = 100;

    var nextStartX, nextEndX, nextStartY, nextEndY;

    nextTourCardStart = function (id) {
      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      nextStartX = event.changedTouches[0].pageX;
      nextStartY = event.changedTouches[0].pageY;
    }

    nextTourCardEnd = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      nextEndX = event.changedTouches[0].pageX;
      nextEndY = event.changedTouches[0].pageY;

      if (Math.abs(nextStartX - nextEndX) <= 20 && Math.abs(nextStartY - nextEndY) <= 20) {

        changePositionWithButton();
      }
    }

    changePosition = function () {

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber == scope.count - 2) {
        scope.registrButton = true;
        scope.update();
      } else if (tourCarouselTouchEndX > tourCarouselTouchStartX && scope.tNumber == scope.count - 1 && scope.count > 1) {
        scope.registrButton = false;
        scope.update();
      }

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber < scope.count - 1) {
        if (scope.tourCirclesShow)
          document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'gainsboro';
        ++scope.tNumber;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        if (scope.tourCirclesShow)
          document.getElementById("circle" + scope.tNumber).style.backgroundColor = '#c1c1c1';
        this.tourTitleId.style.color = scope.tourCardsArray[scope.tNumber].title_color;
      }

      if (tourCarouselTouchEndX > tourCarouselTouchStartX && scope.tNumber == 0) {
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
      }

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber == scope.count - 1) {
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
      }

      if (tourCarouselTouchEndX > tourCarouselTouchStartX && scope.tNumber > 0) {
        if (scope.tourCirclesShow)
          document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'gainsboro';
        --scope.tNumber;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        if (scope.tourCirclesShow)
          document.getElementById("circle" + scope.tNumber).style.backgroundColor = '#c1c1c1';
        this.tourTitleId.style.color = scope.tourCardsArray[scope.tNumber].title_color;
      }

    }

    changePositionWithButton = function () {

      if (scope.tNumber == scope.count - 2) {
        scope.registrButton = true;
        scope.update();
      }

      if (scope.tNumber < scope.count - 1) {
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'gainsboro';
        ++scope.tNumber;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = '#c1c1c1';
      }

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber == scope.count - 1) {
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
      }


    }

    var closeStartX, closeEndX, closeStartY, closeEndY;

    closeTourStart = function (id) {

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'

      closeStartX = event.changedTouches[0].pageX;
      closeStartY = event.changedTouches[0].pageY;

    }


    closeTourEnd = function (id) {
      event.preventDefault();
      event.stopPropagation();

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      closeEndX = event.changedTouches[0].pageX;
      closeEndY = event.changedTouches[0].pageY;

      if (Math.abs(closeStartX - closeEndX) <= 20 && Math.abs(closeStartY - closeEndY) <= 20) {

        if (scope.tourCirclesShow)
          document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'gainsboro';
        scope.tNumber = 0;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        if (scope.tourCirclesShow)
          document.getElementById("circle" + scope.tNumber).style.backgroundColor = '#c1c1c1';
        this.tourTitleId.style.color = scope.tourCardsArray[scope.tNumber].title_color;
        scope.registrButton = false;
        scope.update();
        if (opts.view != "registration") {
          scope.tourData = JSON.parse(localStorage.getItem("tour_data"));
          scope.tourData[opts.view] = true;
          localStorage.setItem("tour_data", JSON.stringify(scope.tourData));
        }

        if (device.platform != 'BrowserStand') {
          StatusBar.backgroundColorByHexString("#ffffff");
        }
        componentTourId.style.display = 'none';
        if (opts.focusfield) {
          scope.parent.focusFieldAfterTourClosed();
        }
      }
    }


  </script>
</component-tour>


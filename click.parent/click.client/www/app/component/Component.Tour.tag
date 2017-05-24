<component-tour id="componentTourId" class="component-tour">

  <p class="tour-title-text">{tourTitle}</p>

  <div type="button" class="tour-close-icon" ontouchend="closeTour()"></div>


  <div id="tourContainerId" class="tour-card-carousel" ontouchstart="tourContainerTouchStart()"
       ontouchend="tourContainerTouchEnd()"
       ontouchmove="tourContainerTouchMove()">


    <div class="component-tour-card" each="{i in tourCardsArray}"
         style="left:{78+100*(i.counter-1)}%;background-image: url({i.text})"></div>


  </div>

  <div class="tour-circles-container"
       style="width: {(tourCardsArray.length) * 40*widthK + 52}px">

    <div id="circle{i.counter-1}" style="left: {(i.counter)*40*widthK }px;" class="tour-circles pincode-pin-one"
         each="{i in tourCardsArray}"></div>


  </div>

  <div class="tour-buttons-container" if="{!registrButton}">
    <div class="tour-next-button tour-close-button" ontouchend="closeTour()">
      <p class="tour-button-label tour-close-button-label">{window.languages.ComponentTourCloseButtonText}</p>
    </div>
    <div class="tour-next-button" ontouchend="nextTourCard()">
      <p class="tour-button-label">{window.languages.ComponentTourNextButtonText}</p>
    </div>
  </div>

  <div class="tour-buttons-container" if="{registrButton}">
    <div
      class="{tour-registration-button: opts.view=='registration', tour-close-button-center:opts.view!='registration'}"
      ontouchend="closeTour()">
      <p class="tour-registration-button-label">
        {opts.view == "registration"?
        window.languages.ComponentTourRegistrationButtonText:window.languages.ComponentTourCloseButtonText}</p>
    </div>
  </div>


  <script>


    var scope = this;

    console.log("component tour view=", opts.view);

    if (opts.view == "registration") {
      scope.tourCardsArray = [{counter: 1, text: "resources/icons/ComponentTour/tutorial_1.png"}, {
        counter: 2,
        text: "resources/icons/ComponentTour/tutorial_2.png"
      }, {
        counter: 3,
        text: "resources/icons/ComponentTour/tutorial_3.png"
      }, {
        counter: 4,
        text: "resources/icons/ComponentTour/tutorial_4.png"
      },
        {
          counter: 5,
          text: "resources/icons/ComponentTour/tutorial_5.png"
        }
      ];

      scope.tourTitle = window.languages.ComponentTourRegistrationTitleText;
      scope.count = 5;
    } else if (opts.view == "mainpage") {
      scope.tourCardsArray = [{counter: 1, text: "resources/icons/ComponentTour/tutorial_main_1.png"}, {
        counter: 2,
        text: "resources/icons/ComponentTour/tutorial_main_2.png"
      }];

      scope.tourTitle = window.languages.ComponentTourMainPageTitleText;
      scope.count = 2;
    }


    scope.tNumber = 0;
    var tourCarouselTouchStartX, tourCarouselTouchStartY, tourCarouselTouchEndX, tourCarouselTouchEndY;
    var left;
    var delta;
    scope.registrButton = false;

    scope.on('mount', function () {
      document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'grey';
    });

    tourContainerTouchStart = function () {

      tourCarouselTouchStartX = event.changedTouches[0].pageX;
      tourCarouselTouchStartY = event.changedTouches[0].pageY;

      percentageTouche = (tourCarouselTouchStartX * 100.0) / window.innerHeight;

      console.log("touche started at %", percentageTouche);

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

    nextTourCard = function () {
      changePositionWithButton();

    }

    changePosition = function () {

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber == scope.count - 2) {
        scope.registrButton = true;
        scope.update();
      } else if (tourCarouselTouchEndX > tourCarouselTouchStartX && scope.tNumber == scope.count - 1) {
        scope.registrButton = false;
        scope.update();
      }

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber < scope.count - 1) {
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'lightgray';
        ++scope.tNumber;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'grey';
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
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'lightgray';
        --scope.tNumber;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'grey';
      }


//      localStorage.setItem('tNumber', scope.tNumber);
    }

    changePositionWithButton = function () {

      if (scope.tNumber == scope.count - 2) {
        scope.registrButton = true;
        scope.update();
      }

      if (scope.tNumber < scope.count - 1) {
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'lightgray';
        ++scope.tNumber;
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'grey';
      }

      if (tourCarouselTouchEndX < tourCarouselTouchStartX && scope.tNumber == scope.count - 1) {
        this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
        this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
        this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
      }


    }


    closeTour = function () {
      event.preventDefault();
      event.stopPropagation();
      document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'lightgray';
      scope.tNumber = 0;
      this.tourContainerId.style.transition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
      this.tourContainerId.style.webkitTransition = '0.3s cubic-bezier(0.3, 0.05, 0.39, 1.5)';
      this.tourContainerId.style.transform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
      this.tourContainerId.style.webkitTransform = "translate3d(" + (-scope.tNumber * scope.shift) + '%' + ", 0, 0)";
      document.getElementById("circle" + scope.tNumber).style.backgroundColor = 'grey';
      scope.registrButton = false;
      scope.update();
      if (opts.view != "registration") {
        scope.tourData = JSON.parse(localStorage.getItem("tour_data"));
        scope.tourData[opts.view] = true;
        console.log("New tourData", scope.tourData);
        localStorage.setItem("tour_data", JSON.stringify(scope.tourData));
      }

      componentTourId.style.display = 'none';
    }


  </script>
</component-tour>


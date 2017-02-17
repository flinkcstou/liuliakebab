<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()"
       ontouchend="touchEndService()" ontouchmove="touchMoveService()">
    <component-service></component-service>
    <component-service style="left: {leftOfServiceCarousel}px"></component-service>
  </div>

  <script>
    var scope = this;
    var leftOfDelta;
    var cardNumberOfService = 0;

    scope.leftOfServiceCarousel = 640 * widthK;

    var delta;
    touchStartService = function () {
      touchStartX = event.changedTouches[0].pageX;
      leftOfDelta = -(540 * cardNumberOfService * widthK) - touchStartX;
      delta = leftOfDelta;
    }

    touchEndService = function () {
      event.preventDefault();
      event.stopPropagation();
      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX)
        changePosition();
    }

    touchMoveService = function () {
      this.containerService.style.transition = '0s';
      this.containerService.style.webkitTransition = '0s';
      event.preventDefault();
      event.stopPropagation();
      this.containerService.style.transform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
      this.containerService.style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + delta) + 'px' + ", 0, 0)";
    }

    changePosition = function () {
      if (touchEndX < touchStartX) {
        cardNumberOfService = 1;
        this.containerService.style.transform = "translate3d(" + -540 * widthK + "px, 0, 0)";
        this.containerService.style.webkitTransform = "translate3d(" + -540 * widthK + "px, 0, 0)";
        this.containerService.style.transition = '0.3s';
        this.containerService.style.webkitTransition = '0.3s';
      }

      if (touchEndX > touchStartX) {
        cardNumberOfService = 0;
        this.containerService.style.transform = "translate3d(0, 0, 0)";
        this.containerService.style.webkitTransform = "translate3d(0, 0, 0)";
        this.containerService.style.transition = '0.3s';
        this.containerService.style.webkitTransition = '0.3s';
      }
    }
  </script>
</component-service-carousel>
<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()"
       ontouchend="touchEndService()" ontouchmove="touchMoveService()">
    <component-service></component-service>
    <component-service style="left: 340px"></component-service>
  </div>

  <script>


    touchStartService = function () {
      touchStartX = event.changedTouches[0].pageX;
      delta = this.containerCard.getBoundingClientRect().left - touchStartX;
    }

    touchEndService = function () {
      event.preventDefault();
      event.stopPropagation();
      touchEndX = event.changedTouches[0].pageX;
      if (touchStartX != touchEndX)
        changePosition();
    }

    changePosition = function () {
      if (touchEndX < touchStartX && cardNumber < count - 1) {
        ++cardNumber;
        this.containerCard.style.transform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.containerCard.style.webkitTransform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.containerCard.style.transition = '0.3s';
        this.containerCard.style.webkitTransition = '0.3s';
      }

      if (touchEndX > touchStartX && cardNumber == 0) {
        this.containerCard.style.transform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.containerCard.style.webkitTransform = "translate3d(" + (-cardNumber * 260) + 'px' + ", 0, 0)";
        this.containerCard.style.transition = '0.3s';
        this.containerCard.style.webkitTransition = '0.3s';
      }
    }

    touchMoveService = function () {

    }
  </script>
</component-service-carousel>
<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStart()" ontouchend="touchEnd()"
       onscroll={onScroll}>
    <component-service></component-service>
    <component-service style="left: 340px"></component-service>
  </div>

  <script>
    var changed = false;

    touchStart = function () {
      this.containerService.style.overflow = "auto";
    }

    touchEnd = function () {
      this.containerService.style.overflow = "hidden";
      changePosition(this.containerService.scrollLeft);
    }

    changePosition = function (position) {

    }
  </script>
</component-service-carousel>
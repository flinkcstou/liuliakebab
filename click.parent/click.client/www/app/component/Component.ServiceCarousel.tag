<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStartService()" ontouchend="touchEndService()"
       onscroll={onScroll}>
    <component-service></component-service>
    <component-service style="left: 340px"></component-service>
  </div>

  <script>
    var scope = this;
    var changed = false, pos = 0;

    touchStartService = function () {
      scope.containerService.style.overflow = "auto";
      changed = true;
    }

    touchEndService = function () {
      scope.containerService.style.overflow = "hidden";
      changePosition(scope.containerService.scrollLeft);
    }

    changePosition = function (position) {
      var block = Math.round(position / 320);
      pos = block * 320;
      scope.containerService.scrollLeft = pos;
      changed = false;
    }

    onScroll()
    {
      if (!changed) {
        scope.containerService.scrollLeft = pos;
      }
    }
  </script>
</component-service-carousel>
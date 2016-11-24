<component-service-carousel>
  <div id="containerService" class="service-carousel" ontouchstart="touchStart()" ontouchend="touchEnd()"
       onscroll={onScroll}>
    <component-service></component-service>
    <component-service style="left: 340px"></component-service>
  </div>

  <script>
    var changed = false, pos = 0;

    touchStart = function () {
      this.containerService.style.overflow = "auto";
      changed = true;
    }

    touchEnd = function () {
      this.containerService.style.overflow = "hidden";
      changePosition(this.containerService.scrollLeft);
    }

    changePosition = function (position) {
      var block = Math.round(position / 320);
      pos = block * 320;
      this.containerService.scrollLeft = pos;
      changed = false;
    }

    onScroll()
    {
      if(!changed){
        this.containerService.scrollLeft = pos;
      }
    }
  </script>
</component-service-carousel>
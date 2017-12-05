<component-transfer-card-carousel-top>
  <div id="containerCard" class="transfer-new-card-carousel"
       ontouchend="endTouchCarouselTransferTop(this)"
       ontouchmove="moveTouchCarouselTransferTop(this)"
       ontouchstart="startTouchCarouselTransferTop()">
    <div id="{opts.carouselid}" class="cards">
      <component-transfer-card each="{i in cardsarray}"
                      countcard="{i.countCard}"
                      name="{i.name}" salary="{i.salary}" currency="{i.currency}"
                      numberpartone="{i.numberPartOne}"
                      numbermiddletwo="{i.numberMiddleTwo}"
                      numberparttwo="{i.numberPartTwo}"
                      bankname="{i.bankName}" url="{i.url}"
                      background="{(i.card_background_url)?(i.card_background_url):('resources/icons/cards/all.png')}"
                      fontcolor="{i.font_color}"
                      error_message="{i.error_message}"></component-transfer-card>
    </div>
  </div>

  <script>

    var scope = this;
    var carouselTouchStartX, carouselTouchEndX;
    scope.carouselidTop = 0;
    scope.cardNumberTop = 1;
    scope.leftTop = 0;
    scope.deltaTop = 0;
    scope.count = 1;




    scope.on("mount", function () {
      if (opts && JSON.stringify(opts) !== '{}') {
        scope.cardNumberTop = parseInt(opts.cardnumber);
        scope.cardsarray = opts.cardsarray;
        scope.carouselidTop = opts.carouselid;
        scope.count = opts.cardcounter + 1;
        console.log(opts, scope);
      }
      document.getElementById(scope.carouselidTop).style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      document.getElementById(scope.carouselidTop).style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      document.getElementById(scope.carouselidTop).style.transform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
      document.getElementById(scope.carouselidTop).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
      if (scope.parent.cardChangedTop){
        scope.parent.cardChangedTop(scope.cardNumberTop);
      }
      scope.update();
    });

    startTouchCarouselTransferTop = function () {
      carouselTouchStartX = event.changedTouches[0].pageX;
      scope.leftTop = -((420 * scope.cardNumberTop) * heightK) - carouselTouchStartX;
      scope.deltaTop = scope.leftTop;
    };

    endTouchCarouselTransferTop = function (id) {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 0) {
        changePositionCardCarouselTransferTop(id.childNodes[1].id);
      }
    };

    moveTouchCarouselTransferTop = function (id) {
      event.preventDefault();
      event.stopPropagation();
      document.getElementById(id.childNodes[1].id).style.transition = '0s';
      document.getElementById(id.childNodes[1].id).style.webkitTransition = '0s';
      document.getElementById(id.childNodes[1].id).style.transform = "translate3d(" + (event.changedTouches[0].pageX + scope.deltaTop ) + 'px' + ", 0, 0)";
      document.getElementById(id.childNodes[1].id).style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + scope.deltaTop ) + 'px' + ", 0, 0)";

    };

    changePositionCardCarouselTransferTop = function (id) {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumberTop < scope.count - 1) {
        ++scope.cardNumberTop;
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumberTop >= scope.count - 1) {
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumberTop > 1) {
        --scope.cardNumberTop;
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumberTop === 1) {
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 420) * heightK + 'px' + ", 0, 0)";
      }

      if (scope.parent.cardChangedTop){
        scope.parent.cardChangedTop(scope.cardNumberTop);
      }

      scope.update();
    };
  </script>
</component-transfer-card-carousel-top>


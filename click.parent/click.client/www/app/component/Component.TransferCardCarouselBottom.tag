<component-transfer-card-carousel-bottom>
  <div id="containerCard" class="transfer-new-card-carousel"
       ontouchend="endTouchCarouselTransferBottom(this)"
       ontouchmove="moveTouchCarouselTransferBottom(this)"
       ontouchstart="startTouchCarouselTransferBottom()">
    <div id="{opts.carouselid}" class="cards">
      <component-transfer-card each="{i in cardsarray}"
                      countcard="{i.countCard}"
                      name="{i.name}" salary="{i.salary}" currency="{i.currency}"
                      numberpartone="{i.numberPartOne}"
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
    scope.carouselidBottom = opts.carouselid;
    scope.cardNumberBottom = 1;
    scope.leftBottom = 0;
    scope.deltaBottom = 0;
    if (localStorage.getItem('click_client_cards')) {
      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
      scope.update();
    }

    scope.count = localStorage.getItem('click_client_countCard');
    if (!scope.count)
      scope.count = 1;

    scope.on("mount", function () {
      document.getElementById(scope.carouselidBottom).style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      document.getElementById(scope.carouselidBottom).style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      document.getElementById(scope.carouselidBottom).style.transform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
      document.getElementById(scope.carouselidBottom).style.webkitTransform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
      if (scope.parent.cardChangedBottom){
        scope.parent.cardChangedBottom(scope.cardNumberBottom);
      }
    });

    startTouchCarouselTransferBottom = function () {
      carouselTouchStartX = event.changedTouches[0].pageX;
      scope.leftBottom = -((404 * scope.cardNumberBottom) * widthK) - carouselTouchStartX;
      scope.deltaBottom = scope.leftBottom;
    };

    endTouchCarouselTransferBottom = function (id) {
      event.preventDefault();
      event.stopPropagation();
      carouselTouchEndX = event.changedTouches[0].pageX;
      if (Math.abs(carouselTouchStartX - carouselTouchEndX) > 0) {
        changePositionCardCarouselTransferBottom(id.childNodes[1].id);
      }
    };

    moveTouchCarouselTransferBottom = function (id) {
      event.preventDefault();
      event.stopPropagation();
      document.getElementById(id.childNodes[1].id).style.transition = '0s';
      document.getElementById(id.childNodes[1].id).style.webkitTransition = '0s';
      document.getElementById(id.childNodes[1].id).style.transform = "translate3d(" + (event.changedTouches[0].pageX + scope.deltaBottom ) + 'px' + ", 0, 0)";
      document.getElementById(id.childNodes[1].id).style.webkitTransform = "translate3d(" + (event.changedTouches[0].pageX + scope.deltaBottom ) + 'px' + ", 0, 0)";

    };

    changePositionCardCarouselTransferBottom = function (id) {
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumberBottom < scope.count - 1) {
        ++scope.cardNumberBottom;
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumberBottom >= scope.count - 1) {
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumberBottom > 1) {
        --scope.cardNumberBottom;
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
      }
      
      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumberBottom === 1) {
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberBottom * 404) * widthK + 'px' + ", 0, 0)";
      }

      if (scope.parent.cardChangedBottom){
        scope.parent.cardChangedBottom(scope.cardNumberBottom);
      }

      scope.update();
    };

  </script>
</component-transfer-card-carousel-bottom>


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
    var carouselTouchStartX, carouselTouchEndX
    scope.carouselidTop = opts.carouselid;
    scope.cardNumberTop = 1;
    scope.leftTop = 0;
    scope.deltaTop = 0;

    scope.count = localStorage.getItem('click_client_countCard');
    if (!scope.count)
      scope.count = 1;

    if (localStorage.getItem('click_client_cards')) {
      scope.cardsarray = JSON.parse(localStorage.getItem('click_client_cards'));
      checkCardPermissionTop();
      scope.update();
    }

    scope.on("mount", function () {
      document.getElementById(scope.carouselidTop).style.transition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      document.getElementById(scope.carouselidTop).style.webkitTransition = '0.3s cubic-bezier(0.7, 0.05, 0.39, 1.5)';
      document.getElementById(scope.carouselidTop).style.transform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
      document.getElementById(scope.carouselidTop).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
      if (scope.parent.cardChangedTop){
        scope.parent.cardChangedTop(scope.cardNumberTop);
      }
    });

    startTouchCarouselTransferTop = function () {
      carouselTouchStartX = event.changedTouches[0].pageX;
      scope.leftTop = -((404 * scope.cardNumberTop) * heightK) - carouselTouchStartX;
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
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX < carouselTouchStartX && scope.cardNumberTop >= scope.count - 1) {
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";

      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumberTop > 1) {
        --scope.cardNumberTop;
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
      }

      if (carouselTouchEndX > carouselTouchStartX && scope.cardNumberTop === 1) {
        document.getElementById(id).style.transition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.webkitTransition = '0.3s cubic-bezier(0.2, 0.05, 0.39, 1.5)';
        document.getElementById(id).style.transform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
        document.getElementById(id).style.webkitTransform = "translate3d(" + (-scope.cardNumberTop * 404) * heightK + 'px' + ", 0, 0)";
      }

      if (scope.parent.cardChangedTop){
        scope.parent.cardChangedTop(scope.cardNumberTop);
      }

      scope.update();
    };

    function checkCardPermissionTop() {
      for (var i in scope.cardsarray) {
        scope.cardsarray[i].permission = opts.usefor === "p2p" && scope.cardsarray[i].p2p_allowed == 1;
        if (opts.usefor === "payment" && scope.cardsarray[i].payment_allowed == 1) {
          scope.cardsarray[i].permission = true;
        }
        if (opts.usefor === "all") {
          scope.cardsarray[i].permission = true;
        }

        if (scope.cardsarray[i].permission === false) {
          console.log("Cardsarray in permission check function:", scope.cardsarray[i]);
          scope.count--;
          delete scope.cardsarray[i];
          console.log(scope.cardsarray, scope.count);
        }
      }
    };

  </script>
</component-transfer-card-carousel-top>


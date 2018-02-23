<component-click-pass-cards>
  <div id="clickPassCardsMenuBackPageId"
       ontouchend="clickPassCardsMenuTouchEnd(true)"
       ontouchstart="clickPassCardsMenuTouchStart()"
       ontouchmove="clickPassCardsMenuTouchMove()"
       class="side-menu-back-page"></div>
  <div ontouchend="clickPassCardsMenuTouchEnd()"
       ontouchstart="clickPassCardsMenuTouchStart()"
       ontouchmove="clickPassCardsMenuTouchMove()"
       id="clickPassCardsMenuId"
       class="click-pass-help-menu">

    <div class="page-title">
      <div id="closeClickPassCardsMenuButtonId"
           role="button"
           aria-label="{window.languages.Close}"
           class="click-pass-help-menu-close-button"
           ontouchstart="closeClickPassCardsMenuStart()"
           ontouchend="closeClickPassCardsMenu()"></div>
    </div>
  </div>


  <script>
    var scope = this;

    closeClickPassCardsMenuStart = function () {
      closeClickPassCardsMenuButtonId.style.webkitTransform = 'scale(0.8)';
    };

    closeClickPassCardsMenu = function () {

      closeClickPassCardsMenuButtonId.style.webkitTransform = 'scale(1)';

      this.clickPassHelpMenuBackPageId.style.zIndex = '';

      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      componentClickPassCards.checkOpen = false;

      clickPassCardsMenuId.style.webkitTransition = '0.3s';
      clickPassCardsMenuBackPageId.style.opacity = '0';
      clickPassCardsMenuBackPageId.style.webkitTransition = '0';
      clickPassCardsMenuId.style.webkitTransform = "translate3d(" + window.innerWidth + "px, 0, 0)";
      clickPassCardsMenuId.style.Transform = "translate3d(" + window.innerWidth + "px, 0, 0)";
      clickPassPageId.style.opacity = '1';
      clickPassPageId.style.zIndex = '0';
      scope.update();
    };

    var cardsTouchStartX, cardsTouchEndX, cardsTouchMoveX, cardsTouchEndMove, cardsTimeStartX, cardsTimeEndX;
    var width = window.innerWidth;

    clickPassCardsMenuTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      clickPassCardsMenuId.style.webkitTransition = '0s';
      clickPassPageId.style.webkitTransition = '0s';
      clickPassCardsMenuBackPageId.style.webkitTransition = '0s';
      cardsTouchStartX = event.changedTouches[0].pageX;
      cardsTimeStartX = event.timeStamp.toFixed(0);
      console.log('START', cardsTouchStartX);
    };

    clickPassCardsMenuTouchEnd = function (bool) {
      event.preventDefault();
      event.stopPropagation();

      cardsTouchEndX = event.changedTouches[0].pageX;
      cardsTimeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(cardsTouchEndMove) > 230 * widthK)) {
        closeClickPassCardsMenu();
      }
      else {
        console.log('END', cardsTouchEndX);
        if (Math.abs(cardsTouchStartX - cardsTouchEndX) < 20 && bool) {
          closeClickPassCardsMenu();
          return;
        }
        if (cardsTimeEndX - cardsTimeStartX < 500 && cardsTouchEndX - cardsTouchStartX > 20) {
          closeClickPassCardsMenu();
        } else {
          clickPassCardsMenuOpenTouchEnd(true);
        }
      }
    };

    clickPassCardsMenuTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      cardsTouchMoveX = event.changedTouches[0].pageX;
      console.log('MOVE', cardsTouchMoveX);
      if (cardsTouchMoveX < cardsTouchStartX)
        return;
      var cardsDeltaForMainPage = Math.abs((cardsTouchStartX - cardsTouchMoveX).toFixed(0) / width * 2);
      var cardsDeltaForSideMenuBack = 1 - cardsDeltaForMainPage;
      if (cardsDeltaForSideMenuBack < 0.1)
        cardsDeltaForSideMenuBack = 0.1;

      clickPassCardsMenuBackPageId.style.opacity = cardsDeltaForSideMenuBack;
      clickPassPageId.style.opacity = cardsDeltaForMainPage;

      if (cardsTouchStartX - cardsTouchMoveX <= 0) {
        clickPassCardsMenuId.style.webkitTransform = 'translate3d(' + (cardsTouchMoveX - cardsTouchStartX) + 'px,0,0)';
        cardsTouchEndMove = cardsTouchMoveX - cardsTouchStartX;
        componentClickPassCards.checkOpen = true;
      }
    };

  </script>
</component-click-pass-cards>
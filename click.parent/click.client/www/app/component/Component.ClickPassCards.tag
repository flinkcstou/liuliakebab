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
      <p class="name-title">{window.languages.ViewClickPassChoseCard}</p>
      <div id="closeClickPassCardsMenuButtonId"
           role="button"
           aria-label="{window.languages.Close}"
           class="click-pass-help-menu-close-button"
           ontouchstart="closeClickPassCardsMenuStart()"
           ontouchend="closeClickPassCardsMenu()"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="click-pass-cards-list-container">
      <div class="click-pass-card-in-list" each="{i in cardsArray}"
           id="{i.card_id}"
           ontouchstart="changeCardTouchStart()"
           ontouchend="changeCardTouchEnd(this.id)">
        <div class="click-pass-chosen-card-logo-container"
             style="background-image: url({i.url})"></div>
        <div class="click-pass-chosen-card-info-container">
          <p class="click-pass-chosen-card-info-text-one"
             style="{'top: 22%': !cardListShowBalance}">{i.name}</p>
          <div class="click-pass-chosen-card-balance-currency-container">
            <p if="{cardListShowBalance}" class="click-pass-chosen-card-balance">{(i.salary) ? (i.salary) :
              (window.languages.ComponentCardCarouselBalanceError)}<span
                class="click-pass-chosen-card-balance-fractional">{(i.salary_fractional) ? (i.salary_fractional) : ''}</span>
            </p>
            <p if="{cardListShowBalance && chosenCard.salary}" class="click-pass-chosen-card-currency">{i.currency}</p>
          </div>
          <p class="click-pass-chosen-card-info-text-three">{i.numberPartOne} **** {i.numberPartTwo}</p>
        </div>
        <div class="click-pass-chosen-card-background" if="{false}"></div>
      </div>
    </div>
  </div>


  <script>
    var scope = this;
    scope.chosenCard = {};

    var changeCardStartX, changeCardStartY,
      changeCardEndX, changeCardEndY;


    scope.on('mount', function () {
      scope.cardListShowBalance = opts.show_balance;
      scope.cardsArray = scope.parent.cardsArray;
      scope.chosenCard = scope.parent.chosenCard;

      if (opts.update_balance) {
        window.updateBalanceGlobalFunction2(scope, scope.cardsArray);
      }
      scope.update();
    });

    changeCardTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      changeCardStartX = event.changedTouches[0].pageX;
      changeCardStartY = event.changedTouches[0].pageY;
    };

    changeCardTouchEnd = function (id) {

      event.preventDefault();
      event.stopPropagation();

      changeCardEndX = event.changedTouches[0].pageX;
      changeCardEndY = event.changedTouches[0].pageY;
      if (Math.abs(changeCardStartX - changeCardEndX) <= 20 && Math.abs(changeCardStartY - changeCardEndY) <= 20) {
        document.getElementById(id).style.backgroundColor = 'rgba(231,231,231,0.5)';
        setTimeout(function () {
          document.getElementById(id).style.backgroundColor = 'transparent';
          scope.parent.changeChosenCard(id);
          closeClickPassCardsMenu();
        }, 100);
      }
    };

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
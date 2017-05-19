<component-tour id="componentTourId" class="component-tour">


  <div id="containerCard" class="card-carousel" ontouchend="endTouchTourCarousel()"
       ontouchmove="moveTouchTourCarousel()"
       ontouchstart="startTouchTourCarousel()">
    <div></div>
    <div id="cards" class="cards">


      <component-card each="{i in cardsarray}"
                      countcard="{i.countCard}"
                      name="{i.name}" salary="{i.salary}" currency="{i.currency}"
                      numberpartone="{i.numberPartOne}"
                      numberparttwo="{i.numberPartTwo}"
                      bankname="{i.bankName}" url="{i.url}"
                      background="{(i.card_background_url)?(i.card_background_url):('resources/icons/cards/all.png')}"
                      fontcolor="{i.font_color}"></component-card>
    </div>
  </div>

  <script>
    var scope = this;

    closeTour = function () {
      event.preventDefault();
      event.stopPropagation();
      componentTourId.style.display = 'none';
    }

    startTouchTourCarousel = function () {
      console.log("Start Touch Carousel", scope.cardNumber);

      carouselTouchStartX = event.changedTouches[0].pageX;
      left = -((540 * scope.cardNumber) * widthK) - carouselTouchStartX;
      delta = left;

    }

    moveTouchTourCarousel = function () {

    }

    endTouchTourCarousel = function () {

    }

  </script>
</component-tour>


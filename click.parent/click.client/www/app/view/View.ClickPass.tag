<view-click-pass class="riot-tags-main-container">

  <component-click-pass-help></component-click-pass-help>

  <div id="clickPassPageId" class="view-click-pass">
    <div class="page-title">
      <p class="name-title">{window.languages.ViewClickPassTitle}</p>
      <div id="backButton"
           ontouchstart="goToBackStart()"
           ontouchend="goToBackEnd()"
           class="back-button">
      </div>
      <div id="helpButtonId" role="button"
           type="button"
           class="click-pass-help-button"
           ontouchstart="openHelpTouchStart()"
           ontouchend="clickPassHelpMenuOpenTouchEnd()">
      </div>
      <div class="title-bottom-border">
      </div>
    </div>
  </div>

  <script>

    var goBackButtonStartX, goBackButtonEndX,
      goBackButtonStartY, goBackButtonEndY;

    var openHelpTouchStartX,
      openHelpTouchStartY,
      openHelpTouchEndX,
      openHelpTouchEndY;


    window.saveHistory('view-click-pass', opts);

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)';

      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;

    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      if (backButton)
        backButton.style.webkitTransform = 'scale(1)';

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    openHelpTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      helpButtonId.style.webkitTransform = 'scale(0.7)';

      openHelpTouchStartX = event.changedTouches[0].pageX;
      openHelpTouchStartY = event.changedTouches[0].pageY;
    };

    clickPassHelpMenuOpenTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      helpButtonId.style.webkitTransform = 'scale(1)'

      openHelpTouchEndX = event.changedTouches[0].pageX;
      openHelpTouchEndY = event.changedTouches[0].pageY;

      if ((Math.abs(openHelpTouchStartX - openHelpTouchEndX) <= 20 && Math.abs(openHelpTouchStartY - openHelpTouchEndY) <= 20)) {

        componentClickPassHelp.checkOpen = true;

        this.clickPassHelpMenuBackPageId.style.webkitTransition = '0.3s';
        this.clickPassPageId.style.webkitTransition = '0.3s';
        this.clickPassPageId.style.zIndex = '-1';
        this.clickPassPageId.style.opacity = '0.1';
        this.clickPassHelpMenuId.style.webkitTransition = '0.3s';
        this.clickPassHelpMenuId.style.transform = "translate3d(0, 0, 0)";
        this.clickPassHelpMenuId.style.webkitTransform = "translate3d(0, 0, 0)";

        this.clickPassHelpMenuBackPageId.style.opacity = '1';
      }
    };

  </script>
</view-click-pass>
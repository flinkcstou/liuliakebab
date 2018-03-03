<view-payment-monitor>
  <div class="riot-tags-main-container">
    <div class="page-title">
      <p class="name-title">{window.languages.ViewPaymentMonitorTitle}</p>
      <div id="backButton" ontouchstart="goToBackStart()" ontouchend="goToBackEnd()"
           class="back-button" role="button" aria-label="{window.languages.Back}"></div>
      <div class="title-bottom-border">
      </div>
    </div>
    <div class="payment-monitor-container">

      <div class="payment-monitor-about-container page-title-shadow">
        <p class="payment-monitor-about-text">
          {window.languages.ViewPaymentMonitorAbout}
        </p>
      </div>

      <div class="payment-monitor-cost-container">
        <p class="payment-monitor-cost-text">
          {window.languages.ViewPaymentMonitorCostFirstPart + info.monitoring_amount + window.languages.ViewPaymentMonitorCostSecondPart}
        </p>
        <p class="payment-monitor-cost-offer"
           ontouchend="openPublicOffer(&quot;{monitorOffer}&quot;)">
          {window.languages.ViewPaymentMonitorOffer}
        </p>
      </div>

      <div class="payment-monitor-cards-container">
        <div class="payment-monitor-card" each="{i in cardsArray}"
             id="{i.card_id}" if="{i.access == 2}">
          <div class="payment-monitor-card-logo-container"
               style="background-image: url({i.url})"></div>
          <div class="payment-monitor-card-info-container">
            <p class="payment-monitor-card-info-text-one">{i.name}</p>
            <p class="payment-monitor-card-info-text-three">{i.numberPartOne} **** {i.numberPartTwo}</p>
          </div>
          <div class="payment-monitor-card-checkbox-container">
            <div class="payment-monitor-card-checkbox">
              <div class="toggle-round">
                <input type="checkbox" name="check{i.card_id}" id="check{i.card_id}"/>
                <label for="check{i.card_id}"></label>
              </div>
            </div>
          </div>
          <div class="title-bottom-border">
          </div>
        </div>
      </div>

    </div>
  </div>
  <script>

    var goBackButtonStartX, goBackButtonEndX, goBackButtonStartY, goBackButtonEndY;

    window.saveHistory('view-payment-monitor', opts);

    scope.cardsArray = localStorage.getItem('click_client_cards') ? JSON.parse(localStorage.getItem('click_client_cards')) : [];
    scope.info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
    if (localStorage.getItem("click_client_agreement")) {
      scope.monitorOffer = JSON.parse(localStorage.getItem("click_client_agreement")).monitoring_offer_url;
    } else {
      scope.monitorOffer = '';
    }

    goToBackStart = function () {
      event.preventDefault();
      event.stopPropagation();
      if (backButton)
        backButton.style.webkitTransform = 'scale(0.7)'
      goBackButtonStartX = event.changedTouches[0].pageX;
      goBackButtonStartY = event.changedTouches[0].pageY;
    };

    goToBackEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      backButton.style.webkitTransform = 'scale(1)'

      goBackButtonEndX = event.changedTouches[0].pageX;
      goBackButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(goBackButtonStartX - goBackButtonEndX) <= 20 && Math.abs(goBackButtonStartY - goBackButtonEndY) <= 20) {
        onBackKeyDown();
      }
    };

    openPublicOffer = function (LinkToPublicOffer) {
      console.log("Link to Offer", LinkToPublicOffer);
      window.open(LinkToPublicOffer, '_system', 'location=no');
    }

  </script>


</view-payment-monitor>
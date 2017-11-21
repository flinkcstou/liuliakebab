<component-transfer-between>
  <div class="transfer-new-between-amount-field">
    <p class="transfer-new-between-text-field">{window.languages.ViewTransferDetailTitleSum}</p>
    <input id="betweenAmountId"
           class="transfer-new-between-amount-input"
           type="tel">
    <p if="{!showPlaceHolderError && !modeOfApp.offlineMode}" class="transfer-new-between-input-commission">
      {window.languages.ViewTransferTwoTax} 1000
      {window.languages.Currency}</p>
  </div>

  <div id="cardFromId"
       class="transfer-new-card-from">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsFrom}</p>
    <component-transfer-card-carousel-top
      carouselid="1"
      style="position: relative;
      right:{16 * widthK}px;
      top:{16 * widthK}px">
    </component-transfer-card-carousel-top>
  </div>

  <div class="transfer-new-between-cards-arrow">
  </div>

  <div id="cardToId"
       class="transfer-new-card-to">
    <p class="transfer-new-between-from-text-field">{window.languages.ViewPayTransferBetweenCardsTo}</p>
    <component-transfer-card-carousel-bottom
    carouselid="2"
    style="position: relative;
      right:{16 * widthK}px;
      top:{11 * widthK}px">
    </component-transfer-card-carousel-bottom>
  </div>
  <script>
  var scope = this;
  scope.cardNumberTop = 0;
  scope.cardNumberBottom = 0;


  </script>
</component-transfer-between>
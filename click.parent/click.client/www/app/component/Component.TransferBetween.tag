<component-transfer-between>
  <div class="transfer-new-between-amount-field">
    <p class="transfer-new-between-text-field">{window.languages.ViewTransferDetailTitleSum}</p>
    <input id="betweenAmountId"
           class="transfer-new-contact-number-input-part"
           type="tel">
    <p if="{!showPlaceHolderError && !modeOfApp.offlineMode}" class="transfer-new-between-input-commission">
      {window.languages.ViewTransferTwoTax} 1000
      {window.languages.Currency}</p>
  </div>

  <div id="cardFromId">
    <component-transfer-card-carousel
      carouselId="1">
    </component-transfer-card-carousel>
  </div>

  <div id="cardToId">
    <component-transfer-card-carousel
    carouselId="2">
    </component-transfer-card-carousel>
  </div>
  <script>

  </script>
</component-transfer-between>
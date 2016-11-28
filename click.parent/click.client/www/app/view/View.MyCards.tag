<view-my-cards>
  <component-page-title title="{titleName}" backbutton="{backbuttoncheck}" rightbutton="{rightbuttoncheck}">
  </component-page-title>
  <div class="my-cards-carousel">
  <component-card-carousel>
  </component-card-carousel>
  </div>

  <div class="my-cards-button-container">
    <div class="my-cards-button-field my-cards-button-field-transfer">
      <div class="my-cards-button-icon my-cards-button-icon-transfer">
      </div>

      <div class="my-cards-button-label">Переводы с карты на карту
      </div>
      </div>

    <div class="my-cards-button-field my-cards-button-field-payment">
      <div class="my-cards-button-icon my-cards-button-icon-payment">
      </div>

      <div class="my-cards-button-label">Оплата с карты
      </div>
    </div>

    <div class="my-cards-button-field my-cards-button-field-report">
      <div class="my-cards-button-icon my-cards-button-icon-report">
      </div>

      <div class="my-cards-button-label">Отчеты по карте
      </div>
    </div>
  </div>

  <div class="my-cards-button-block-card">
    <div class="my-cards-button-block-card-label">Заблокировать карту</div>
  </div>

  <div class="my-cards-last-operations">
    <div class="my-cards-last-operations-container-label">
      <p class="my-cards-last-operations-label">Последние операции</p>
    </div>

    <div class="my-cards-last-operations-info"></div>

  </div>


  <script>
    scope = this;
    scope.backbuttoncheck = true;
    scope.rightbuttoncheck = true;
    scope.cardsArray = JSON.parse(localStorage.getItem('cards'));
    window.myCards = true;


    this.titleName = 'ЗАРПЛАТНАЯ КАРТА';
  </script>
</view-my-cards>
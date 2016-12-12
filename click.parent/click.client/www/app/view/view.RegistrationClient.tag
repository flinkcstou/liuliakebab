<view-registration-client>
  <p class="registration-client-text-field">Заполните данные вашей первой карты</p>
  <div class="registration-client-card-field">
    <p class="registration-client-card-text" style="top: 20px;left: 20px;">Номер карты</p>
    <input class="registration-client-card-number" type="text">

    <p class="registration-client-card-text" style="top: 83px;left: 20px;">Дата окончания</p>
    <input class="registration-client-card-date" type="text">

    <p class="registration-client-card-text" style="top: 83px;left: 150px;">Пинкод</p>
    <input class="registration-client-card-pin" type="text">
  </div>

  <div class="registration-keyboard-field keyboard-field" style="top: 100px">
    <div class="registration-button-help">Помощь</div>
    <component-keyboard></component-keyboard>
  </div>

  <div class="registration-buttons-container" style="top: 180px">
    <div class="registration-container-offline">
      <div class="registration-button-offline">Офлайн режим</div>
    </div>
    <a href="stand/index-stand.html" id="demoContainer" class="registration-container-demo-version"
       ontouchstart="goToDemo()">
      <div class="registration-button-demo-version">Демо версия</div>
    </a>
  </div>

  <script>
    history.arrayOfHistory.push('view-registration-client');
    sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))

     var phoneNumber = localStorage.getItem('click_client_phoneNumber');
     var cardNumber;
     var cardData;
     var pin;

    window.api.call({
      method: 'registration',
      input : {
        phone_num: phoneNumber,
        card_number: cardNumber,
        card_data : cardData,
        pin : pin
      },
      scope : this,

      onSuccess: function (result) {
        console.log(result);

      },
      onFail   : function (api_status, api_status_message, data) {
        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
        console.error(data);
      }
    })
  </script>
</view-registration-client>
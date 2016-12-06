<component-registration-client>

  <script>
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
</component-registration-client>
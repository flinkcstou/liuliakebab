<view-settings-support-part-two class="view-settings-support-part-two">

  <div class="settings-support-part-two-container">
    <div class="settings-support-part-two-page-title">
      <div class="settings-support-part-two-x-button" ontouchend="closeSettingsSupportPartTwoTouchEnd()"></div>
    </div>

    <p class="settings-support-part-two-container-title">{window.languages.VewSettingsSupportPartTwoTheme}
      {opts.title}</p>
    <div class="settings-support-part-two-input-container">
      <textarea id="commentHelpTextId" maxlength="255" class="settings-support-part-two-input"
                type="text" placeholder={comment}></textarea>
    </div>
    <div class="settings-support-part-two-send-button" ontouchend="sendMessageTouchEnd()">
      {window.languages.VewSettingsSupportPartTwoSend}
    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>

  <script>
    var scope = this;
    scope.showError = false;

    history.arrayOfHistory.splice(history.arrayOfHistory.length - 1, 1);

    if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-settings-support-part-two') {
      history.arrayOfHistory.push(
          {
            "view": 'view-settings-support-part-two',
            "params": ''
          }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }


    scope.comment = 'Опишите вашу проблему';

    closeSettingsSupportPartTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      onBackKeyDown()
    }

    sendMessageTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = info.session_key;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
      var firstName = loginInfo.firstname;
      var lastName = loginInfo.lastname;
      var name = firstName + ' ' + lastName;
      var type = opts.key;
      var description = commentHelpTextId.value;

      window.api.call({
        method: 'send.ticket',
        input: {
          phone_num: phoneNumber,
          session_key: sessionKey,
          client_name: name,
          type: type,
          description: description,

        },

        scope: this,

        onSuccess: function (result) {
          if (result[0][0].error == 0) {
            console.log("SUPPORT", result);
            alert('Удачно отправлено');
          }
          else {
//            alert(result[0][0].error_note);
            scope.clickPinError = false;
            scope.errorNote = result[0][0].error_note;
            scope.showError = true;
            riot.update();
          }
        },

        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      });
    }


  </script>
</view-settings-support-part-two>

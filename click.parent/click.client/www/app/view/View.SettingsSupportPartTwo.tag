<view-settings-support-part-two class="view-settings-support-part-two riot-tags-main-container">

  <div class="settings-support-part-two-container">
    <div class="settings-support-part-two-page-title">
      <div id="closeButtonId" role="button" aria-label="{window.languages.Close}"
           class="settings-support-part-two-x-button"
           ontouchstart="closeSettingsSupportTwoTouchStart()" ontouchend="closeSettingsSupportTwoTouchEnd()"></div>
    </div>

    <p class="settings-support-part-two-container-title">{window.languages.VewSettingsSupportPartTwoTheme}
      {opts.title}</p>
    <div class="settings-support-part-two-input-container">
      <textarea id="commentHelpTextId" maxlength="255" class="settings-support-part-two-input"
                type="text" placeholder={comment}></textarea>
    </div>
    <div id="sendButtonId" class="settings-support-part-two-send-button" ontouchstart="sendMessageTouchStart()"
         ontouchend="sendMessageTouchEnd()">
      {window.languages.VewSettingsSupportPartTwoSend}
    </div>
  </div>

  <script>

    var scope = this;

    window.saveHistory('view-settings-support-part-two', opts);

    this.on('mount', function () {
      if (device.platform == 'Android') {
        setTimeout(function () {
          commentHelpTextId.focus();
        }, 0)
      }
      else {
        commentHelpTextId.autofocus = true;
        commentHelpTextId.focus();
      }

    })


    scope.comment = 'Опишите вашу проблему';

    var closeButtonStartX, closeButtonEndX, closeButtonStartY, closeButtonEndY;

    closeSettingsSupportTwoTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      closeButtonId.style.webkitTransform = 'scale(0.8)'

      closeButtonStartX = event.changedTouches[0].pageX;
      closeButtonStartY = event.changedTouches[0].pageY;

    };

    closeSettingsSupportTwoTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      closeButtonId.style.webkitTransform = 'scale(1)'

      closeButtonEndX = event.changedTouches[0].pageX;
      closeButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(closeButtonStartX - closeButtonEndX) <= 20 && Math.abs(closeButtonStartY - closeButtonEndY) <= 20) {
        onBackKeyDown();
        scope.unmount()
      }
    };

    var sendButtonStartX, sendButtonEndX, sendButtonStartY, sendButtonEndY;

    sendMessageTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      sendButtonId.style.webkitTransform = 'scale(0.8)'

      sendButtonStartX = event.changedTouches[0].pageX;
      sendButtonStartY = event.changedTouches[0].pageY;
    }

    sendMessageTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      sendButtonId.style.webkitTransform = 'scale(1)'

      sendButtonEndX = event.changedTouches[0].pageX;
      sendButtonEndY = event.changedTouches[0].pageY;

      if (Math.abs(sendButtonStartX - sendButtonEndX) <= 20 && Math.abs(sendButtonStartY - sendButtonEndY) <= 20) {
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
              scope.clickPinError = false;
              scope.errorNote = 'Удачно отправлено';

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote,
                step_amount: 0
              });

              scope.update();
//            alert('Удачно отправлено');
            }
            else {
//            alert(result[0][0].error_note);
              scope.clickPinError = false;
              scope.errorNote = result[0][0].error_note;

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: scope.clickPinError,
                errornote: scope.errorNote,
                step_amount: 0
              });

              scope.update();
            }
          },

          onFail: function (api_status, api_status_message, data) {
            console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
            console.error(data);
          }
        });
      }
    }


  </script>
</view-settings-support-part-two>

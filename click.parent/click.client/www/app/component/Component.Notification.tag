<component-notification id="notificationPushId"
                        class="component-notification {component-notification-show: show, component-notification-set-transition: setTransition}">

  <div style="display: none" class="component-notification-icon"></div>
  <p class="component-notification-text">{notificationText}</p>

  <div class="component-notification-buttons-container">
    <p class="component-notification-button-cancel" ontouchend="onTouchEndNotificationDecline()"
       ontouchstart="onTouchStartNotificationDecline()">
      ЗАКРЫТЬ</p>
    <p class="component-notification-button-accept" ontouchend="onTouchEndNotificationAccept()"
       ontouchstart="onTouchStartNotificationAccept()">
      ДЕТАЛИ</p>
  </div>


  <script>
    var scope = this;

    scope.show = false;
    scope.setTransition = false;
    scope.notificationText = "";
    scope.notificationAction = "";

    var numberOfMessage = 0;

    setTimeout(function () {

      scope.setTransition = true;
      riot.update();
    }, 1000);

    if (device.platform != 'BrowserStand') {
      window.FirebasePlugin.onNotificationOpen(function (notification) {
        console.log("PUSH NOTIFICATION OBJECT", notification);
        ++numberOfMessage;

        scope.notificationText = notification.body;
        scope.notificationAction = notification.action;
        scope.notificationElementId = notification.notify_id;

        var authorized = localStorage.getItem("click_client_authorized");
        authorized = JSON.parse(authorized);

        if (notification.tap && !authorized) {

          var background_notification = {};

          if (scope.notificationAction == "invoice") {

            background_notification.action = "getInvoiceFunction";
            background_notification.params = scope.notificationElementId;

            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));
          }

          if (scope.notificationAction == "card.add") {


            background_notification.action = "refreshCardCarousel";
            background_notification.params = scope.notificationElementId;

            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));
          }

          if (scope.notificationAction == "payment") {

            background_notification.action = "getPaymentList";
            background_notification.params = scope.notificationElementId;

            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));
          }
        }
        else {

          scope.show = true;
        }

        riot.update();

        window.FirebasePlugin.setBadgeNumber(numberOfMessage);

      }, function (error) {
        console.error(error);
      });
    }

    onTouchEndNotificationAccept = function () {
    };
    onTouchEndNotificationDecline = function () {
    };

    onTouchStartNotificationDecline = function () {

      scope.show = false;
      scope.notificationText = "";
      riot.update();
    };

    onTouchStartNotificationAccept = function () {

      scope.show = false;
      scope.notificationText = "";
      riot.update();

      if (scope.notificationAction == "invoice") {


        window.pushNotificationActions.getInvoiceFunction(scope.notificationElementId);
      }

      if (scope.notificationAction == "card.add") {


        window.pushNotificationActions.refreshCardCarousel(scope.notificationElementId);
      }

      if (scope.notificationAction == "payment") {

        window.pushNotificationActions.getPaymentList(scope.notificationElementId);
      }
    };

  </script>
</component-notification>
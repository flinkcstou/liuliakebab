<component-notification id="notificationPushId"
                        class="component-notification {component-notification-show: show, component-notification-set-transition: setTransition}">

  <div style="display: none" class="component-notification-icon"></div>
  <p id="pushNotificationText" class="component-notification-text">
    {notificationText}</p>

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
    scope.notificationAction = "";

    var numberOfMessage = 0;
    //    var notificationText = "";

    setTimeout(function () {

      scope.setTransition = true;
//      pushNotificationText.innerHTML = "";
      scope.update();
    }, 1000);

    if (device.platform !== 'BrowserStand') {
      window.FirebasePlugin.onNotificationOpen(function (notification) {

        console.log("any alert open? " + window.common.alert.anyOpen());
        if (window.common.alert.anyOpen()) return;
        console.log("not returned ");
        window.scannerCanBeAsked = false;

        if (notification.message) {
          try {
            scope.notificationNew = JSON.parse(notification.message);
            scope.notificationNew.tap = notification.tap;
            scope.notificationNew.body = scope.notificationNew.body ? scope.notificationNew.body : scope.notificationNew.text;
//            alert("New notification=" + JSON.stringify(scope.notificationNew));
          } catch (e) {
//            alert("message parsing error " + e)
//            alert("message = " + JSON.stringify(notification))
          }
          console.log("New notification=", scope.notificationNew);


        }

        if (!scope.show) {
          if (scope.notificationNew) {
            sessionStorage.setItem("push_notification_real", JSON.stringify(scope.notificationNew));
          } else {
            sessionStorage.setItem("push_notification_real", JSON.stringify(notification));
          }
          console.log("push object after saving into sessionStorage", JSON.parse(sessionStorage.getItem("push_notification_real")));
        }
        else {
          return
        }

        console.log("PUSH NOTIFICATION OBJECT", notification);
        ++numberOfMessage;

        console.log("numberOfMessage", numberOfMessage);

        if (device.platform === "iOS") {

          try {
            var temp = JSON.parse(sessionStorage.getItem("push_notification_real"));
            notificationText = temp.notification ? temp.notification.body : (temp.aps ? temp.aps.alert : "");
          } catch (e) {
//            alert("error " + e)
          }

        } else {

          notificationText = JSON.parse(sessionStorage.getItem("push_notification_real")).body;
        }
//        alert("Notification text 78" + notificationText);
        scope.notificationAction = JSON.parse(sessionStorage.getItem("push_notification_real")).action;
        scope.notificationElementId = JSON.parse(sessionStorage.getItem("push_notification_real")).notify_id;

        var authorized = JSON.parse(localStorage.getItem("click_client_authorized"));
//        authorized = JSON.parse(authorized);

        if (notification.tap) {

          var background_notification = {};

          if (scope.notificationAction === "invoice") {

            background_notification.action = "getInvoiceFunction";
            background_notification.params = scope.notificationElementId;

            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));
          }

          if (scope.notificationAction === "card.add") {


            background_notification.action = "refreshCardCarousel";
            background_notification.params = scope.notificationElementId;

            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));
          }

          if (scope.notificationAction === "payment") {

            background_notification.action = "getPaymentList";
            background_notification.params = scope.notificationElementId;

            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));
          }

          if (scope.notificationAction === "news") {

//            window.News.newsCounter++;
//            riot.update();
//
//            background_notification.action = "getNewsFunction";
//            background_notification.params = scope.notificationElementId;
//
//            sessionStorage.setItem("push_notification", JSON.stringify(background_notification));

            window.News.newsCounter = 0;

            sessionStorage.setItem("push_news", true);

            console.log('running news', JSON.parse(sessionStorage.getItem("push_notification_real")).notify_id, scope.notificationElementId);
            var news_id = JSON.parse(sessionStorage.getItem("push_notification_real")).notify_id;
            console.log("news_id=", news_id)

//            if (news_id) {
//            console.log(" opening with news_id");
            riotTags.innerHTML = "<view-main-page>";
            riot.mount("view-main-page", {view: "news", news_id: news_id});
//            } else {
//              console.log("without news_id");
//              riotTags.innerHTML = "<view-main-page>";
//              riot.mount("view-main-page", {view: "news"});
//            }
            return


          }

          window.pushNotificationActions.retrievePushNotification();
        }
        else {

          scope.show = true;
          if (device.platform === "iOS") {
            try {
              var temp = JSON.parse(sessionStorage.getItem("push_notification_real"));
              notificationText = temp.notification ? temp.notification.body : (temp.aps ? temp.aps.alert : "");
//              notificationText = temp.aps.alert;
            } catch (e) {
//              alert("error " + e)
            }
          } else {

            notificationText = JSON.parse(sessionStorage.getItem("push_notification_real")).body;
          }
          scope.notificationText = JSON.stringify(notificationText);
//          pushNotificationText.innerHTML = JSON.stringify(notificationText);

          console.log('NOTIFICATION TEXT', scope.notificationText)
//          alert('NOTIFICATION TEXT 153' + scope.notificationText)

          numberOfMessage = 0;

          scope.update();

          if (modeOfApp.offlineMode) {
            window.FirebasePlugin.setBadgeNumber(0);
          }
        }


        window.FirebasePlugin.logEvent(scope.notificationText, {
          content_type: scope.notificationAction,
          item_id: scope.notificationElementId
        });
        if (localStorage.getItem('click_client_phoneNumber')) {
          window.FirebasePlugin.setUserId(localStorage.getItem('click_client_phoneNumber'));
        }

        window.FirebasePlugin.setBadgeNumber(numberOfMessage);

      }, function (error) {
        window.FirebasePlugin.logEvent(scope.notificationText, {
          content_type: scope.notificationAction,
          item_id: 'crash'
        });
        console.error(error);
      });
    }

    onTouchEndNotificationAccept = function () {
      event.preventDefault();
      event.stopPropagation();
    };
    onTouchEndNotificationDecline = function () {
      event.preventDefault();
      event.stopPropagation();
    };

    onTouchStartNotificationDecline = function () {
      event.preventDefault();
      event.stopPropagation();

      window.FirebasePlugin.logEvent("DECLINE", {
        content_type: scope.notificationAction,
        item_id: scope.notificationElementId
      });
      if (localStorage.getItem('click_client_phoneNumber')) {
        window.FirebasePlugin.setUserId(localStorage.getItem('click_client_phoneNumber'));
      }
      scope.show = false;
//      scope.notificationText = "";
      scope.update();
    };

    onTouchStartNotificationAccept = function () {

      event.preventDefault();
      event.stopPropagation();

      if (localStorage.getItem('click_client_phoneNumber')) {
        window.FirebasePlugin.setUserId(localStorage.getItem('click_client_phoneNumber'));
      }

      scope.show = false;
//      scope.notificationText = "";
      scope.update();

      var authorized = false,
        notification;

      try {

        authorized = JSON.parse(localStorage.getItem("click_client_authorized"));
      } catch (error) {

        console.error(error);
      }

      if (scope.notificationAction == "invoice") {


        if (authorized) {

          window.pushNotificationActions.getInvoiceFunction(scope.notificationElementId);
        } else {

          notification = {
            action: "getInvoiceFunction",
            params: scope.notificationElementId
          };

          sessionStorage.setItem("push_notification", JSON.stringify(notification));
        }
      }

      if (scope.notificationAction == "card.add") {

        if (authorized) {

          window.pushNotificationActions.refreshCardCarousel(scope.notificationElementId);
        } else {

          notification = {
            action: "refreshCardCarousel",
            params: scope.notificationElementId
          };

          sessionStorage.setItem("push_notification", JSON.stringify(notification));
        }
      }

      if (scope.notificationAction == "payment") {

        if (authorized) {

          window.pushNotificationActions.getPaymentList(scope.notificationElementId);
        } else {

          notification = {
            action: "getPaymentList",
            params: scope.notificationElementId
          };

          sessionStorage.setItem("push_notification", JSON.stringify(notification));
        }
      }

      if (scope.notificationAction == "news") {

//        if (authorized) {

        window.pushNotificationActions.getNewsFunction(scope.notificationElementId);
//        } else {
//
//          notification = {
//            action: "getNewsFunction",
//            params: scope.notificationElementId
//          };
//
//          sessionStorage.setItem("push_notification", JSON.stringify(notification));
//
//          console.log(JSON.parse(sessionStorage.getItem("push_notification")));
//        }

        return
      }

      window.FirebasePlugin.logEvent("ACCEPT", {
        content_type: scope.notificationAction,
        item_id: scope.notificationElementId
      });

      if (!authorized) {

        riotTags.innerHTML = "<view-authorization>";
        riot.mount("view-authorization");
      }
    };

  </script>
</component-notification>
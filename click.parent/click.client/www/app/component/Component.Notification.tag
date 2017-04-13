<component-notification id="notificationPushId" class="component-notification">

    <div class="component-notification-icon"></div>
    <p class="component-notification-text"></p>

    <div class="component-notification-buttons-container">
      <p class="component-notification-button-cancel" ontouchend="onTouchEndDecline()"
         ontouchstart="onTouchStartDecline()">
        ЗАКРЫТЬ</p>
      <p class="component-notification-button-accept" ontouchend="onTouchEndAccept()"
         ontouchstart="onTouchStartAccept()">
        ДЕТАЛИ</p>
    </div>


  <script>
    var scope = this;


  </script>
</component-notification>
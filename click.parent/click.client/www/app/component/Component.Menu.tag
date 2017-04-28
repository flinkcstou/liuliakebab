<component-menu>
  <div id="sideMenuBackPageId" ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>
  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="sideMenuId" class="side-menu">

    <div class="side-menu-inside-button" ontouchend="closeMenu()"></div>
    <div class="side-menu-user-info-container">
      <div class="side-menu-user-icon" style="background-image: url({photo})" ontouchend="userIconTouchEnd()"></div>
      <p class="side-menu-user-second-name">{firstName}</p>
      <p class="side-menu-user-first-name">{lastName}</p>
    </div>
    <div if="{device.platform != 'iOS'}" id="changeModeContainerId" class="side-menu-change-mode">
      <div id="changeModeIconId" class="side-menu-change-mode-icon"></div>
      <p class="side-menu-change-mode-text">{modeOfApplication}</p>
      <label class="switch-menu" ontouchstart="changeModeTouchStart()" ontouchend="changeModeTouchEnd()">
        <input onchange="changeMode()"
               id="checkBoxChangeId" type="checkbox" checked="{checkModeOfApplication}">
        <div class="slider-menu round"></div>
      </label>
    </div>
    <div class="side-menu-billings-container" ontouchstart="goToBillingsTouchStart()"
         ontouchend="goToBillingsTouchEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-billings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-billings">Выставленные счета</div>
    </div>

    <div class="side-menu-favorite-container" ontouchstart="goToFavoritesStart()" ontouchend="goToFavoritesEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-favorite"></div>
      <div class="side-menu-containers-name side-menu-containers-name-favorite">Избранные</div>
    </div>

    <div if="{!modeOfApp.offlineMode}" class="side-menu-auto-pay-container" ontouchstart="goToAutoPayStart()"
         ontouchend="goToAutoPayEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-autopayment"></div>
      <div class="side-menu-containers-name side-menu-containers-name-autopayment">Автоплатеж</div>
    </div>

    <div class="side-menu-scanner-qr-container" ontouchstart="goToQrScannerStart()" ontouchend="goToQrScannerEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-scanner-qr"></div>
      <div class="side-menu-containers-name side-menu-containers-name-scanner-qr">Сканер QR-кода</div>
    </div>

    <div if="{!modeOfApp.offlineMode}" class="side-menu-settings-container" ontouchstart="goToSettingsStart()"
         ontouchend="goToSettingsEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-settings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-settings">Настройки</div>
    </div>

    <div class="side-menu-call-container" ontouchend="callToClickTouchEnd()" ontouchstart="callToClickTouchStart()">
      <div class="side-menu-containers-icon side-menu-containers-icon-call"></div>
      <div class="side-menu-containers-name side-menu-containers-name-call">Позвонить в Click</div>
    </div>
  </div>

  <component-alert if="{showError}" clickpinerror="{clickPinError}"
                   errornote="{errorNote}"></component-alert>
  <script>
    var scope = this;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    if (loginInfo) {
      scope.firstName = loginInfo.firstname;
      scope.lastName = loginInfo.lastname;
      scope.photo = loginInfo.profile_image_url;

    }

    if (modeOfApp.offlineMode) {
      scope.photo = "resources/icons/icon/icon.png"
    }

    scope.showError = false;

    if (modeOfApp.onlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
      scope.checkModeOfApplication = true;
    }
    if (modeOfApp.offlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
      scope.checkModeOfApplication = false;
    }

    this.on('mount', function () {
      if (modeOfApp.onlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
        scope.checkModeOfApplication = true;
        changeModeContainerId.style.backgroundColor = '#92bf3a'
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
      }
      if (modeOfApp.offlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
      }
      scope.update();
    })

    userIconTouchEnd = function () {
      closeMenu();
      event.preventDefault();
      event.stopPropagation();
      if (modeOfApp.offlineMode)return
      riotTags.innerHTML = "<view-general-settings>";
      scope.mount("view-general-settings");
//      scope.unmount()
    }

    closeMenu = function () {

      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      componentMenu.checkOpen = false;

      sideMenuId.style.webkitTransition = '0.3s';
      sideMenuBackPageId.style.opacity = '0';
      sideMenuBackPageId.style.webkitTransition = '0';
      sideMenuId.style.webkitTransform = "translate3d(-100%, 0, 0)";
      sideMenuId.style.Transform = "translate3d(-100%, 0, 0)";
      mainPageId.style.opacity = '1';
      mainPageId.style.zIndex = '0';
      scope.update();
    }

    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndXs;
    var width = window.innerWidth;

    sideMenuTouchStart = function () {
      sideMenuId.style.webkitTransition = '0s';
      mainPageId.style.webkitTransition = '0s';
      sideMenuBackPageId.style.webkitTransition = '0s';
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);

    }

    sideMenuTouchEnd = function () {
//      event.preventDefault();
//      event.stopPropagation();
      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeMenu();
      }
      else {
        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
          closeMenu();
        }
        else
          menuOpen()
      }
    }

    sideMenuTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      touchMoveX = event.changedTouches[0].pageX;
      if (touchStartX < touchMoveX) return
      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
      var deltaForSideMenuBack = 1 - deltaForMainPage;
      if (deltaForSideMenuBack < 0.1)
        deltaForSideMenuBack = 0.1

      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
      //console.log('deltaForMainPage', deltaForMainPage)
      mainPageId.style.opacity = deltaForMainPage;

      if (touchMoveX - touchStartX <= 0) {
        sideMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)'
        touchEndMove = touchMoveX - touchStartX
        componentMenu.checkOpen = true;
      }

    }

    var changeModeStart, changeModeEnd;
    changeModeTouchStart = function () {
      console.log("QWe")
      event.preventDefault();
      event.stopPropagation();

      changeModeStart = event.changedTouches[0].pageX;

    }

    changeModeTouchEnd = function () {

      event.preventDefault();
      event.stopPropagation();

      changeModeEnd = event.changedTouches[0].pageX;

      if (Math.abs(changeModeStart - changeModeEnd) < 20) {
        console.log('QQ')
        if (checkBoxChangeId.checked) {
          checkBoxChangeId.checked = false;
        }
        else {
          checkBoxChangeId.checked = true;
        }
        changeMode()
      }
      else sideMenuTouchEnd()

    }

    changeMode = function () {
      console.log('asd')
      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }
      console.log(checkBoxChangeId.checked)
      if (checkBoxChangeId.checked) {
        modeOfApp.onlineMode = true
        modeOfApp.offlineMode = false;
        if (localStorage.getItem('click_client_token')) {
          this.riotTags.innerHTML = "<view-authorization>";
          riot.mount('view-authorization');
//          scope.unmount()
        }
        else {
          this.riotTags.innerHTML = "<view-registration-device>";
          riot.mount('view-registration-device');
//          scope.unmount()
        }
        return
      }
      else {
        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;
      }
      if (modeOfApp.onlineMode) {
        scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
        changeModeContainerId.style.backgroundColor = '#92bf3a'
        scope.checkModeOfApplication = true;
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
      }
      if (modeOfApp.offlineMode) {

        scope.parent.tags['component-card-carousel'].switchToOfflineMode();

        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
      }
      scope.update()
    }

    //    menuBackPageTouchEnd = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //      console.log(event.changedTouches[0].pageX)
    //      if (event.changedTouches[0].pageX > 550 * widthK)
    //        closeMenu()
    //      else return
    //    }

    var callTouchStartX, callTouchEndX
    callToClickTouchEnd = function () {
      callTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(callTouchStartX - callTouchEndX) < 20) {
        closeMenu()
        componentMenu.checkOpen = false;
        window.open('tel:+998712310880')
      }
      else sideMenuTouchEnd()

    }

    callToClickTouchStart = function () {
      callTouchStartX = event.changedTouches[0].pageX;
    }

    var autoPayTouchStartX, autoPayTouchEndX;
    goToAutoPayEnd = function () {
      autoPayTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(autoPayTouchStartX - autoPayTouchEndX) < 20) {
        closeMenu();
        riotTags.innerHTML = "<view-auto-pay>";
        riot.mount('view-auto-pay');
//        scope.unmount()
      }
      else sideMenuTouchEnd()

    }

    goToAutoPayStart = function () {
      autoPayTouchStartX = event.changedTouches[0].pageX;
    }


    var qrScannerTouchStartX, qrScannerTouchEndX

    goToQrScannerEnd = function () {


      qrScannerTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(qrScannerTouchStartX - qrScannerTouchEndX) < 20) {
//        closeMenu()
        if (device.platform != 'BrowserStand') {

          cordova.plugins.barcodeScanner.scan(
            function (result) {
              console.log(result)

              var string = result.text;
              if (string.indexOf('click.uz') != -1) {

                string = string.split('?')[1]
                string = string.split('&')
                var id = '';
                for (var i in string) {
                  if (string[i].split('=')[0] == 'id') {
                    id = string[i].split('=')[1];
                    console.log('ID', id)
                  }
                }
                if (id) {
                  if (modeOfApp.offlineMode) {
                    riotTags.innerHTML = "<view-qr>";
                    riot.mount('view-qr', {
//                      "name": result.format,
//                      "address": result.text,
                      "id": id,
                      "image": "resources/icons/ViewPay/logo_indoor.png"
                    });
//                      scope.unmount()
                  }
                  else {
                    var phoneNumber = localStorage.getItem("click_client_phoneNumber");
                    var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
                    var sessionKey = info.session_key;

                    window.api.call({
                      method: 'get.indoor.service',
                      input: {
                        phone_num: phoneNumber,
                        session_key: sessionKey,
                        service_id: id,

                      },

                      scope: this,

                      onSuccess: function (result) {
                        if (result[0][0].error == 0) {
                          if (result[1]) {
                            if (result[1][0]) {
                              closeMenu();
                              riotTags.innerHTML = "<view-qr>";
                              riot.mount('view-qr', result[1][0]);
//                                scope.unmount()
                            }
                          }
                          console.log("QR PAY", result);
                        }
                        else {
                          scope.clickPinError = false;
                          scope.errorNote = result[0][0].error_note;
                          scope.showError = true;
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
              }
            },
            function (error) {
              scope.clickPinError = false;
              scope.errorNote = "Scanning failed: " + error;
              scope.showError = true;
              scope.update();
            },
            {
              preferFrontCamera: false, // iOS and Android
              showFlipCameraButton: true, // iOS and Android
              showTorchButton: true, // iOS and Android
              torchOn: false, // Android, launch with the torch switched on (if available)
              prompt: "Установите QR код в поле сканирования", // Android
              resultDisplayDuration: 500, // Android, display scanned text for X ms. 0 suppresses it entirely, default 1500
              formats: "QR_CODE", // default: all but PDF_417 and RSS_EXPANDED
              orientation: "portrait", // Android only (portrait|landscape), default unset so it rotates with the device
              disableAnimations: true, // iOS
              disableSuccessBeep: false // iOS
            }
          );
        }
        else {
          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var sessionKey = info.session_key;

          window.api.call({
            method: 'get.indoor.service',
            input: {
              phone_num: phoneNumber,
              session_key: sessionKey,
              service_id: 1234,

            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                if (result[1]) {
                  if (result[1][0]) {
                    closeMenu();
                    riotTags.innerHTML = "<view-qr>";
                    riot.mount('view-qr', result[1][0]);
//                    scope.unmount()
                  }
                }
                console.log("QR PAY", result);
              }
              else {

                scope.showError = true;
                scope.clickPinError = false;
                scope.errorNote = result[0][0].error_note;
                scope.update();
//                alert(result[0][0].error_note);
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        }

      }
      else sideMenuTouchEnd()

    }

    goToQrScannerStart = function () {
      qrScannerTouchStartX = event.changedTouches[0].pageX;
    }

    var settingsTouchStartX, settingsTouchEndX

    goToSettingsEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsTouchEndX = event.changedTouches[0].pageX;

      console.log('settingsTouchStartX', settingsTouchStartX)
      console.log('settingsTouchEndX', settingsTouchEndX)

      if (Math.abs(settingsTouchStartX - settingsTouchEndX) < 20) {
        closeMenu()
        riotTags.innerHTML = "<view-settings>";
        riot.mount("view-settings");
//        scope.unmount()
        return
      }
      else sideMenuTouchEnd()

    }

    goToSettingsStart = function () {
      settingsTouchStartX = event.changedTouches[0].pageX;
    }


    goToBillingsTouchStart = function () {

      billingsTouchStartX = event.changedTouches[0].pageX;
    };

    goToBillingsTouchEnd = function () {

      billingsTouchEndX = event.changedTouches[0].pageX;

      if (Math.abs(billingsTouchEndX - billingsTouchStartX) < 20) {
        closeMenu();
        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*00*98767" + "%23",
            function (err) {
              if (err == "empty") {
                scope.clickPinError = false;
                scope.errorNote = ("Unknown phone number");
                scope.showError = true;
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }

        var params = {

          toUser: true
        };

        history.arrayOfHistory.push({view: "view-invoice-list", params: params});
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));
        riotTags.innerHTML = "<view-invoice-list>";
        riot.mount("view-invoice-list", params);
//        scope.unmount()
        return
      }
    };

    var favoritesTouchStartX, favoritesTouchEndX;

    goToFavoritesEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      favoritesTouchEndX = event.changedTouches[0].pageX;

      console.log('settingsTouchStartX', favoritesTouchStartX)
      console.log('settingsTouchEndX', favoritesTouchEndX)

      if (Math.abs(favoritesTouchStartX - favoritesTouchEndX) < 20) {
        closeMenu();
        riotTags.innerHTML = "<view-favorites>";
        riot.mount("view-favorites");
//        scope.unmount()
        return
      }
      else sideMenuTouchEnd()

    }

    goToFavoritesStart = function () {
      favoritesTouchStartX = event.changedTouches[0].pageX;
    }


  </script>
</component-menu>
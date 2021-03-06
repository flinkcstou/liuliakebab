<component-menu>
  <div id="sideMenuBackPageId" ontouchend="sideMenuTouchEnd(true)" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>
  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="sideMenuId" class="side-menu">

    <div id="closeMenuButtonId" role="button" aria-label="{window.languages.Close}" class="side-menu-inside-button"
         ontouchstart="closeMenuStart()"
         ontouchend="closeMenu()"></div>

    <div hidden="{device.platform == 'iOS'}" id="changeModeContainerId" class="side-menu-change-mode"
         ontouchstart="changeModeTouchStart()" ontouchend="changeModeTouchEnd()">
      <div id="changeModeIconId" class="side-menu-change-mode-icon"></div>
      <p class="side-menu-change-mode-text">{modeOfApplication}</p>
      <p class="side-menu-change-mode-hint-text">{modeOfAplicationHint}</p>

      <label id="modeSwitch" class="switch-menu">
        <input onchange="changeMode()"
               id="checkBoxChangeId" type="checkbox" checked="{checkModeOfApplication}">
        <div id="checkBoxRoundId" class="slider-menu online round"></div>
      </label>
    </div>

    <div id="reportsButtonId" class="side-menu-reports-container" ontouchstart="goToReportsTouchStart()"
         ontouchend="goToReportsTouchEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-reports"></div>
      <div class="side-menu-containers-name side-menu-containers-name-reports">Отчеты</div>
    </div>

    <div id="billngsButtonId" class="side-menu-billings-container" ontouchstart="goToBillingsTouchStart()"
         ontouchend="goToBillingsTouchEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-billings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-billings">Выставленные счета</div>
    </div>

    <div id="favouriteButtonId" class="side-menu-favorite-container" ontouchstart="goToFavoritesStart()"
         ontouchend="goToFavoritesEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-favorite"></div>
      <div class="side-menu-containers-name side-menu-containers-name-favorite">Избранные платежи</div>
    </div>

    <div id="autoPayButtonId" if="{!modeOfApp.offlineMode}" class="side-menu-auto-pay-container"
         ontouchstart="goToAutoPayStart()"
         ontouchend="goToAutoPayEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-autopayment"></div>
      <div class="side-menu-containers-name side-menu-containers-name-autopayment">Автоплатеж</div>
    </div>

    <div class="side-menu-action-container">
      <div id="qrScannerButtonId" class="side-menu-scanner-qr-container" ontouchstart="goToQrScannerStart()"
           ontouchend="goToQrScannerEnd()">

        <img src="resources/icons/menu/menu_qr.png" alt="" class="side-menu-action-image">

        <p class="side-menu-containers-name-scanner-qr">Оплата на местах</p>
        <p class="side-menu-containers-hint-scanner-qr">
          Отсканируйте QR-код и с легкостью оплатите
        </p>
      </div>

      <div class="side-menu-action-container-separator"></div>

      <div id="clickPassButtonId" class="side-menu-click-pass-container" ontouchstart="goToClickPassStart()"
           ontouchend="goToClickPassEnd()">

        <img src="resources/icons/menu/menu_scanner.png" alt="" class="side-menu-action-image">

        <p class="side-menu-containers-name-click-pass">CLICK PASS</p>
        <p class="side-menu-containers-hint-click-pass">
          Оплата товаров и услуг по QR-коду CLICK
        </p>
      </div>
    </div>

    <div id="settingsButtonId" if="{!modeOfApp.offlineMode}" class="side-menu-settings-container"
         ontouchstart="goToSettingsStart()"
         ontouchend="goToSettingsEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-settings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-settings">Настройки</div>
    </div>

    <div id="newsButtonId" if="{!modeOfApp.offlineMode}" class="side-menu-news-container"
         ontouchstart="goToNewsTouchStart()"
         ontouchend="goToNewsTouchEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-news"></div>
      <div class="side-menu-containers-name side-menu-containers-name-news">Новости</div>
    </div>

    <div id="callButtonId" class="side-menu-call-container" ontouchend="callToClickTouchEnd()"
         ontouchstart="callToClickTouchStart()">
      <div class="side-menu-containers-icon side-menu-containers-icon-call"></div>
      <div class="side-menu-containers-name side-menu-containers-name-call">Позвонить в CLICK</div>
    </div>

    <div if="{device.platform != 'iOS'}" id="exitButtonId" class="side-menu-exit-container"
         ontouchend="exitFromAppTouchEnd()"
         ontouchstart="exitFromAppTouchStart()">
      <div class="side-menu-containers-icon side-menu-containers-icon-exit"></div>
      <div class="side-menu-containers-name side-menu-containers-name-call"
           style="color:rgb(229, 108, 71)">Выход
      </div>
    </div>
  </div>


  <script>
    var scope = this;
    qrScaner.qrInited = false;
    var width = window.innerWidth;
    var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));

    var changeModeStart, changeModeEnd;
    var touchStartX, touchEndX, touchMoveX, touchEndMove, timeStartX, timeEndXs;

    var callTouchStartX, callTouchStartY, callTouchEndX, callTouchEndY;
    var newsTouchStartX, newsTouchStartY, newsTouchEndX, newsTouchEndY;
    var reportsTouchStartX, reportsTouchStartY, reportsTouchEndX, reportsTouchEndY;
    var autoPayTouchStartX, autoPayTouchStartY, autoPayTouchEndX, autoPayTouchEndY;
    var exitModeTouchStartX, exitModeTouchStartY, exitModeTouchEndX, exitModeTouchEndY;
    var billingsTouchStartX, billingsTouchStartY, billingsTouchEndX, billingsTouchEndY;
    var settingsTouchStartX, settingsTouchStartY, settingsTouchEndX, settingsTouchEndY;
    var favoritesTouchStartX, favoritesTouchStartY, favoritesTouchEndX, favoritesTouchEndY;
    var qrScannerTouchStartX, qrScannerTouchStartY, qrScannerTouchEndX, qrScannerTouchEndY;
    var clickPassTouchStartX, clickPassTouchStartY, clickPassTouchEndX, clickPassTouchEndY;

    if (loginInfo) {
      scope.firstName = loginInfo.firstname;
      scope.lastName = loginInfo.lastname;
      scope.photo = loginInfo.profile_image_url;
    }

    if (modeOfApp.onlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOnlineMode;
      scope.modeOfAplicationHint = window.languages.ComponentMenuOnlineModeHint;
      scope.checkModeOfApplication = true;
    }
    if (modeOfApp.offlineMode) {
      scope.photo = "resources/icons/icon/icon.png"
      scope.modeOfApplication = window.languages.ComponentMenuOfflineMode;
      scope.modeOfAplicationHint = window.languages.ComponentMenuOfflineModeHint;
      scope.checkModeOfApplication = false;
    }

    this.on('mount', function () {
      try {
        if (modeOfApp.onlineMode) {
          scope.modeOfApplication = window.languages.ComponentMenuOnlineMode;
          scope.modeOfAplicationHint = window.languages.ComponentMenuOnlineModeHint;
          scope.checkModeOfApplication = true;

          modeSwitch.style.borderColor = '#92bf3a';
          checkBoxRoundId.className = 'slider-menu online round';

          changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
        }
        if (modeOfApp.offlineMode) {
          scope.modeOfApplication = window.languages.ComponentMenuOfflineMode;
          scope.modeOfAplicationHint = window.languages.ComponentMenuOfflineModeHint
          scope.checkModeOfApplication = false;
          modeSwitch.style.borderColor = '#e56c47';
          checkBoxRoundId.className = 'slider-menu offline round';

          changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
        }
        scope.update();
      } catch (e) {
        console.log(e)
      }
    });

    sideMenuTouchStart = function () {
      sideMenuId.style.webkitTransition = '0s';
      mainPageId.style.webkitTransition = '0s';
      sideMenuBackPageId.style.webkitTransition = '0s';
      touchStartX = event.changedTouches[0].pageX;
      timeStartX = event.timeStamp.toFixed(0);

    };

    sideMenuTouchMove = function () {
      event.preventDefault();
      event.stopPropagation();
      touchMoveX = event.changedTouches[0].pageX;
      if (touchStartX < touchMoveX) return;
      var deltaForMainPage = Math.abs((touchStartX - touchMoveX).toFixed(0) / width * 2);
      var deltaForSideMenuBack = 1 - deltaForMainPage;
      if (deltaForSideMenuBack < 0.1)
        deltaForSideMenuBack = 0.1;

      sideMenuBackPageId.style.opacity = deltaForSideMenuBack;
      mainPageId.style.opacity = deltaForMainPage;

      if (touchMoveX - touchStartX <= 0) {
        sideMenuId.style.webkitTransform = 'translate3d(' + (touchMoveX - touchStartX) + 'px,0,0)';
        touchEndMove = touchMoveX - touchStartX;
        componentMenu.checkOpen = true;
      }

    };

    sideMenuTouchEnd = function (bool) {

      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeMenu();
      }
      else {
        console.log('START END', touchStartX, touchEndX);
        if (Math.abs(touchStartX - touchEndX) < 20 && bool) {
          closeMenu();
          return
        }
        if (timeEndX - timeStartX < 500 && touchStartX - touchEndX > 20) {
          closeMenu();
        }
        else
          menuOpenTouchEnd(true)
      }
    };

    closeMenuStart = function () {
      closeMenuButtonId.style.webkitTransform = 'scale(0.8)'
    };

    closeMenu = function () {

      closeMenuButtonId.style.webkitTransform = 'scale(1)';

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
      getToolbarScope().update();
    };

    exitFromAppTouchStart = function () {

      exitButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      exitModeTouchStartX = event.changedTouches[0].pageX;
      exitModeTouchStartY = event.changedTouches[0].pageY;
    };

    changeModeTouchStart = function () {
      event.preventDefault();
      event.stopPropagation();

      changeModeStart = event.changedTouches[0].pageX;

    };

    changeModeTouchEnd = function () {

      event.preventDefault();
      event.stopPropagation();

      changeModeEnd = event.changedTouches[0].pageX;

      if (Math.abs(changeModeStart - changeModeEnd) < 20) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;

          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();
          return
        }

        if (checkBoxChangeId.checked) {
          checkBoxChangeId.checked = false;
        }
        else {
          checkBoxChangeId.checked = true;
        }
        changeMode()
      }
      else sideMenuTouchEnd();

    };

    changeMode = function () {

      if (event) {
        event.preventDefault();
        event.stopPropagation();
      }

      if (checkBoxChangeId.checked) {
        goOnline();
        return
      }
      else {
        modeOfApp.onlineMode = false;
        modeOfApp.offlineMode = true;
      }

      if (modeOfApp.onlineMode) {
        scope.parent.tags['component-bank-operations-new'].updateOperations();
        scope.modeOfApplication = window.languages.ComponentMenuOnlineMode;
        scope.modeOfAplicationHint = window.languages.ComponentMenuOnlineModeHint

        modeSwitch.style.borderColor = '#92bf3a';
        checkBoxRoundId.className = 'slider-menu online round';

        scope.checkModeOfApplication = true;
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
      }
      if (modeOfApp.offlineMode) {

        scope.parent.tags['component-card-carousel'].switchToOfflineMode();
        scope.parent.tags['component-bank-operations-new'].updateOperations();

        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode;
        modeSwitch.style.borderColor = '#F24746';
        checkBoxRoundId.className = 'slider-menu offline round';

        scope.checkModeOfApplication = false;
        scope.modeOfAplicationHint = window.languages.ComponentMenuOfflineModeHint

        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
      }

      scope.update()
    };

    goToReportsTouchStart = function () {
      reportsButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      reportsTouchStartX = event.changedTouches[0].pageX;
      reportsTouchStartY = event.changedTouches[0].pageY;
    };

    goToReportsTouchEnd = function () {

      billngsButtonId.style.backgroundColor = 'transparent';

      reportsTouchEndX = event.changedTouches[0].pageX;
      reportsTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(reportsTouchEndX, reportsTouchStartX, reportsTouchStartY, reportsTouchEndY)) {

        closeMenu();

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();

          return
        }

        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*00*3" + "%23",
            function (err) {
              if (err == "empty") {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: "Unknown phone number"
                });
                scope.update();
              }
              else console.log("Dialer Error:" + err);
            },
            function (success) {
            }
          );
          return
        }
        this.riotTags.innerHTML = '<view-info>';
        riot.mount('view-info');
//        scope.unmount()
      }
    };

    goToBillingsTouchStart = function () {

      billngsButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      billingsTouchStartX = event.changedTouches[0].pageX;
      billingsTouchStartY = event.changedTouches[0].pageY;
    };

    goToBillingsTouchEnd = function () {

      billngsButtonId.style.backgroundColor = 'transparent';

      billingsTouchEndX = event.changedTouches[0].pageX;
      billingsTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(billingsTouchEndX, billingsTouchStartX, billingsTouchStartY, billingsTouchEndY)) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();

          return
        }
        closeMenu();
        if (modeOfApp.offlineMode) {
          phonedialer.dial(
            "*880*00*98767" + "%23",
            function (err) {
              if (err == "empty") {
                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: "Неверный номер"
                });
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
        return
      }
    };

    goToFavoritesStart = function () {

      favouriteButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      favoritesTouchStartX = event.changedTouches[0].pageX;
      favoritesTouchStartY = event.changedTouches[0].pageY;
    };

    goToFavoritesEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      favouriteButtonId.style.backgroundColor = 'transparent';

      favoritesTouchEndX = event.changedTouches[0].pageX;
      favoritesTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(favoritesTouchStartX, favoritesTouchEndX, favoritesTouchStartY, favoritesTouchEndY)) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();

          return
        }
        closeMenu();
        riotTags.innerHTML = "<view-favorites-new>";
        riot.mount("view-favorites-new");
        return
      }
      else sideMenuTouchEnd()

    };

    goToAutoPayStart = function () {

      autoPayButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      autoPayTouchStartX = event.changedTouches[0].pageX;
      autoPayTouchStartY = event.changedTouches[0].pageY;
    };

    goToAutoPayEnd = function () {

      autoPayButtonId.style.backgroundColor = 'transparent';

      autoPayTouchEndX = event.changedTouches[0].pageX;
      autoPayTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(autoPayTouchStartX, autoPayTouchEndX, autoPayTouchStartY, autoPayTouchEndY)) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();

          return
        }

        closeMenu();
        riotTags.innerHTML = "<view-auto-pay-new>";
        riot.mount('view-auto-pay-new');
      }
      else sideMenuTouchEnd()
    };

    goToQrScannerStart = function () {

      console.log('qrButtonId', qrButtonId);

      qrScannerButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      qrScannerTouchStartX = event.changedTouches[0].pageX;
      qrScannerTouchStartY = event.changedTouches[0].pageY;
    };

    goToQrScannerEnd = function () {

      qrScannerButtonId.style.backgroundColor = 'transparent';

      qrScannerTouchEndX = event.changedTouches[0].pageX;
      qrScannerTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(qrScannerTouchStartX, qrScannerTouchEndX, qrScannerTouchStartY, qrScannerTouchEndY) && !qrScaner.qrInited) {

        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();
          return
        }

        window.pickContactFromNativeChecker = true;
        qrScaner.qrInited = true;
        console.log("qrScaner.qrInited =", qrScaner.qrInited);

        if (device.platform != 'BrowserStand') {

          qrCodeScanner(scope);
        }
        else {

//
//          closeMenu();
//          qrScaner.qrInited = false;
//          if (modeOfApp.offlineMode) {
//            console.log("*880*010185999002*" + 62504932073062 + "%23");
//            phonedialer.dial(
//              "*880*010185999002*" + 62504932073062 + "%23",
//              function (err) {
//                if (err == "empty") {
//                  scope.clickPinError = false;
//                  scope.errorNote = ("Неверный номер");
//                  window.common.alert.show("componentAlertId", {
//                    parent: scope,
//                    clickpinerror: scope.clickPinError,
//                    errornote: scope.errorNote
//                  });
//                  scope.update();
//                }
//                else console.log("Ошибка USSD:" + err);
//              },
//              function (success) {
//
//              }
//            );
//          } else {
//            localStorage.setItem('click_client_infoCacheEnabled', null);
//            riotTags.innerHTML = "<view-service-info-new>";
//            riot.mount('view-service-info-new', {
//              "formtype": 6,
//              "firstFieldText": 62504932073062,
//              "chosenPrefixName": "",
//              "chosenServiceId": 10185,
//              "firstFieldId": 536870912,
//              "is_qr_notary" : true,
//              "firstFieldTitle": "Номер квитанции:",
//            });
//          }
//          console.log('FFFFFFFFFFFFFFFFFFFFAALse');
//          return;
//

          var phoneNumber = localStorage.getItem("click_client_phoneNumber");
          var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
          var sessionKey = info.session_key;

          window.api.call({
            method: 'get.indoor.service',
            input: {
              phone_num: phoneNumber,
              session_key: sessionKey,
              service_id: 1234

            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                if (result[1]) {
                  if (result[1][0]) {
                    closeMenu();
                    riotTags.innerHTML = "<view-qr>";
                    riot.mount('view-qr', result[1][0]);
                  }
                }
                console.log("QR PAY", result);
              }
              else {

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: result[0][0].error_note
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
      else sideMenuTouchEnd()

    };

    goToClickPassStart = function () {

      clickPassButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      clickPassTouchStartX = event.changedTouches[0].pageX;
      clickPassTouchStartY = event.changedTouches[0].pageY;
    };

    goToClickPassEnd = function () {
      clickPassButtonId.style.backgroundColor = 'transparent';

      clickPassTouchEndX = event.changedTouches[0].pageX;
      clickPassTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(clickPassTouchStartX, clickPassTouchEndX, clickPassTouchStartY, clickPassTouchEndY)) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();
          return;
        }
        if (!localStorage.getItem("click_client_loginInfo") || !localStorage.getItem('click_client_otp_time')) {
          var question = 'Для работы раздела CLICK PASS необходимо один раз зайти в онлайн режим';
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();
          return;
        }
        if (modeOfApp.offlineMode) {
          riotTags.innerHTML = "<view-pin-code>";
          riot.mount('view-pin-code', ['view-click-pass']);
          return;
        } else {
          closeMenu();
          riotTags.innerHTML = "<view-click-pass>";
          riot.mount('view-click-pass');
        }
      }
      else {
        sideMenuTouchEnd();
      }
    };

    goToSettingsStart = function () {
      settingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      settingsTouchStartX = event.changedTouches[0].pageX;
      settingsTouchStartY = event.changedTouches[0].pageY;
    };

    goToSettingsEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsButtonId.style.backgroundColor = 'transparent';

      settingsTouchEndX = event.changedTouches[0].pageX;
      settingsTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(settingsTouchStartX, settingsTouchEndX, settingsTouchStartY, settingsTouchEndY)) {
        if (modeOfApp.demoVersion) {
          var question = window.languages.DemoModeConstraintText;

          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });

          scope.update();

          return
        }
        closeMenu();
        riotTags.innerHTML = "<view-settings>";
        riot.mount("view-settings");
        return
      }
      else sideMenuTouchEnd()
    };

    goToNewsTouchStart = function () {
      reportsButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      newsTouchStartX = event.changedTouches[0].pageX;
      newsTouchStartY = event.changedTouches[0].pageY;
    };

    goToNewsTouchEnd = function () {

      billngsButtonId.style.backgroundColor = 'transparent';

      newsTouchEndX = event.changedTouches[0].pageX;
      newsTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(newsTouchStartX, newsTouchEndX, newsTouchStartY, newsTouchEndY)) {

        closeMenu();

        containerCard.style.filter = 'blur(5px)';
        viewNewsId.style.display = 'block';

        window.News.newsCounter = 0;
        window.saveHistory('view-news', opts);

        scope.parent.tags['view-news'].showNewsFunction(1);

      }
    };

    callToClickTouchStart = function () {

      callButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)';

      callTouchStartX = event.changedTouches[0].pageX;
      callTouchStartY = event.changedTouches[0].pageY;
    };

    callToClickTouchEnd = function () {

      callButtonId.style.backgroundColor = 'transparent';

      callTouchEndX = event.changedTouches[0].pageX;
      callTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(callTouchStartX, callTouchEndX, callTouchStartY, callTouchEndY)) {
        closeMenu();
        componentMenu.checkOpen = false;
        window.open('tel:+998712310880')
      }
      else sideMenuTouchEnd()

    };

    exitFromAppTouchEnd = function () {

      exitButtonId.style.backgroundColor = 'transparent';

      exitModeTouchEndX = event.changedTouches[0].pageX;
      exitModeTouchEndY = event.changedTouches[0].pageY;

      if (isTouch(exitModeTouchStartX, exitModeTouchEndX, exitModeTouchStartY, exitModeTouchEndY)) {
        navigator.app.exitApp();
      }

    };

    isTouch = function (startX, endX, startY, endY) {
      return (Math.abs(startX - endX) <= 20 && Math.abs(startY - endY) <= 20);
    }

  </script>
</component-menu>
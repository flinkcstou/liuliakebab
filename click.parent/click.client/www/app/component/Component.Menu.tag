<component-menu>
  <div id="sideMenuBackPageId" ontouchend="sideMenuTouchEnd(true)" ontouchstart="sideMenuTouchStart()"
       ontouchmove="sideMenuTouchMove()" class="side-menu-back-page"></div>
  <div ontouchend="sideMenuTouchEnd()" ontouchstart="sideMenuTouchStart()" ontouchmove="sideMenuTouchMove()"
       id="sideMenuId" class="side-menu">

    <div id="closeMenuButtonId" role="button" aria-label="{window.languages.Close}" class="side-menu-inside-button"
         ontouchstart="closeMenuStart()"
         ontouchend="closeMenu()"></div>
    <div class="side-menu-user-info-container">
      <div class="side-menu-user-icon" role="button" aria-label="{window.languages.ComponentMenuAriaLabelPersonalInfo}"
           style="background-image: url({photo})" ontouchend="userIconTouchEnd()"></div>
      <p class="side-menu-user-second-name">{firstName}</p>
      <p class="side-menu-user-first-name">{lastName}</p>
    </div>
    <div hidden="{device.platform == 'iOS'}" id="changeModeContainerId" class="side-menu-change-mode"
         ontouchstart="changeModeTouchStart()" ontouchend="changeModeTouchEnd()">
      <div id="changeModeIconId" class="side-menu-change-mode-icon"></div>
      <p class="side-menu-change-mode-text">{modeOfApplication}</p>
      <label class="switch-menu">
        <input onchange="changeMode()"
               id="checkBoxChangeId" type="checkbox" checked="{checkModeOfApplication}">
        <div class="slider-menu round"></div>
      </label>
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

    <div id="qrScannerButtonId" class="side-menu-scanner-qr-container" ontouchstart="goToQrScannerStart()"
         ontouchend="goToQrScannerEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-scanner-qr"></div>
      <div class="side-menu-containers-name side-menu-containers-name-scanner-qr">Сканер QR-кода</div>
    </div>

    <div id="clickPassButtonId" class="side-menu-scanner-qr-container" ontouchstart="goToClickPassStart()"
         ontouchend="goToClickPassEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-scanner-qr"></div>
      <div class="side-menu-containers-name side-menu-containers-name-scanner-qr">Click Pass</div>
    </div>

    <div id="settingsButtonId" if="{!modeOfApp.offlineMode}" class="side-menu-settings-container"
         ontouchstart="goToSettingsStart()"
         ontouchend="goToSettingsEnd()">
      <div class="side-menu-containers-icon side-menu-containers-icon-settings"></div>
      <div class="side-menu-containers-name side-menu-containers-name-settings">Настройки</div>
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
      <div class="side-menu-containers-name side-menu-containers-name-call">Выход</div>
    </div>
  </div>

  <div if="{window.checkShowingComponent != null}" class="iFrame-container">
    <div class="iFrame-toolbar-container">
      <p class="iFrame-title">QR сканер</p>
      <div id="iFrameBackButtonId" ontouchstart="hideIFrameStart(this.id)" ontouchend="hideIFrameEnd(this.id)"
           class="iFrame-back-button">
      </div>
    </div>
    <iframe id="iFrameExternalUrlId" class="iFrame-main" frameborder="0"></iframe>
  </div>

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

    scope.showIFrame = false;

    if (modeOfApp.onlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
      scope.checkModeOfApplication = true;
    }
    if (modeOfApp.offlineMode) {
      scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
      scope.checkModeOfApplication = false;
    }

    this.on('mount', function () {
      try {
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
      } catch (e) {
        console.log(e)
      }
    })


    var closeIFrameStartX, closeIFrameEndX, closeIFrameStartY, closeIFrameEndY;
    var timeOutTimer = 0;

    hideIFrameStart = function (id) {
      closeIFrameStartX = event.changedTouches[0].pageX;
      closeIFrameStartY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(0.8)'
    }

    hideIFrameEnd = function (id) {
      closeIFrameEndX = event.changedTouches[0].pageX;
      closeIFrameEndY = event.changedTouches[0].pageY;

      document.getElementById(id).style.webkitTransform = 'scale(1)'

      if (Math.abs(closeIFrameStartX - closeIFrameEndX) <= 20 && Math.abs(closeIFrameStartY - closeIFrameEndY) <= 20) {
        console.log('qweweeee')
        window.checkShowingComponent = null;

        //scope.update() troubles
        riot.update()
      }

    }

    userIconTouchEnd = function () {
      if (modeOfApp.offlineMode) return
      closeMenu();
      event.preventDefault();
      event.stopPropagation();
      if (modeOfApp.demoVersion) {
        var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'

        window.common.alert.show("componentAlertId", {
          parent: scope,
          errornote: question
        });
//        confirm(question)
//        scope.confirmShowBool = true;
//        scope.confirmNote = question;
//        scope.confirmType = 'local';
//        scope.result = function (bool) {
//          if (bool) {
//            localStorage.clear();
//            window.location = 'index.html'
//            scope.unmount()
//            return
//          }
//          else {
//            scope.confirmShowBool = false;
//            return
//          }
//        };
        scope.update();

        return
      }
      riotTags.innerHTML = "<view-general-settings>";
      riot.mount("view-general-settings");
//      scope.unmount()
    }


    var exitModeTouchStartX, exitModeTouchStartY, exitModeTouchEndX, exitModeTouchEndY;

    exitFromAppTouchStart = function () {

      exitButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      exitModeTouchStartX = event.changedTouches[0].pageX
      exitModeTouchStartY = event.changedTouches[0].pageY
    }

    exitFromAppTouchEnd = function () {

      exitButtonId.style.backgroundColor = 'transparent'

      exitModeTouchEndX = event.changedTouches[0].pageX
      exitModeTouchEndY = event.changedTouches[0].pageY

      if (Math.abs(exitModeTouchStartX - exitModeTouchEndX) <= 20 && Math.abs(exitModeTouchStartY - exitModeTouchEndY) <= 20) {
        navigator.app.exitApp();
      }

    }

    closeMenuStart = function () {
      closeMenuButtonId.style.webkitTransform = 'scale(0.8)'
    }

    closeMenu = function () {

      closeMenuButtonId.style.webkitTransform = 'scale(1)'

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

    sideMenuTouchEnd = function (bool) {
//      event.preventDefault();
//      event.stopPropagation();
      touchEndX = event.changedTouches[0].pageX;
      timeEndX = event.timeStamp.toFixed(0);

      if ((Math.abs(touchEndMove) > 230 * widthK)) {
        closeMenu();
      }
      else {
        console.log('START END', touchStartX, touchEndX)
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

        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
//        confirm(question)
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }


        console.log('QQ')
        if (checkBoxChangeId.checked) {
          checkBoxChangeId.checked = false;
        }
        else {
          checkBoxChangeId.checked = true;
        }
//        scope.update();
        changeMode()
      }
      else sideMenuTouchEnd()

    }

    changeMode = function () {
      console.log('asd')
      console.log('MENU PARENT', scope.parent)
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
        scope.parent.tags['component-bank-operations-new'].updateOperations();
        scope.modeOfApplication = window.languages.ComponentMenuOnlineMode
        changeModeContainerId.style.backgroundColor = '#92bf3a'
        scope.checkModeOfApplication = true;
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_online.png)';
      }
      if (modeOfApp.offlineMode) {

        scope.parent.tags['component-card-carousel'].switchToOfflineMode();
        scope.parent.tags['component-bank-operations-new'].updateOperations();

        scope.modeOfApplication = window.languages.ComponentMenuOfflineMode
        scope.checkModeOfApplication = false;
        changeModeContainerId.style.backgroundColor = '#e56c47'
        changeModeIconId.style.backgroundImage = 'url(resources/icons/menu/menu_ussd.png)';
      }
      scope.update()
    };

    //    menuBackPageTouchEnd = function () {
    //      event.preventDefault();
    //      event.stopPropagation();
    //      console.log(event.changedTouches[0].pageX)
    //      if (event.changedTouches[0].pageX > 550 * widthK)
    //        closeMenu()
    //      else return
    //    }

    var callTouchStartX, callTouchStartY, callTouchEndX, callTouchEndY
    callToClickTouchEnd = function () {

      callButtonId.style.backgroundColor = 'transparent'

      callTouchEndX = event.changedTouches[0].pageX;
      callTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(callTouchStartX - callTouchEndX) < 20 && Math.abs(callTouchStartY - callTouchEndY) < 20) {
        closeMenu()
        componentMenu.checkOpen = false;
        window.open('tel:+998712310880')
      }
      else sideMenuTouchEnd()

    }

    callToClickTouchStart = function () {

      callButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      callTouchStartX = event.changedTouches[0].pageX;
      callTouchStartY = event.changedTouches[0].pageY;
    }

    var autoPayTouchStartX, autoPayTouchStartY, autoPayTouchEndX, autoPayTouchEndY;
    goToAutoPayEnd = function () {

      autoPayButtonId.style.backgroundColor = 'transparent'

      autoPayTouchEndX = event.changedTouches[0].pageX;
      autoPayTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(autoPayTouchStartX - autoPayTouchEndX) <= 20 && Math.abs(autoPayTouchStartY - autoPayTouchEndY) <= 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }

        closeMenu();
        riotTags.innerHTML = "<view-auto-pay-new>";
        riot.mount('view-auto-pay-new');
//        scope.unmount()
      }
      else sideMenuTouchEnd()

    }

    goToAutoPayStart = function () {

      autoPayButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      autoPayTouchStartX = event.changedTouches[0].pageX;
      autoPayTouchStartY = event.changedTouches[0].pageY;
    };


    var qrScannerTouchStartX, qrScannerTouchStartY, qrScannerTouchEndX, qrScannerTouchEndY

    goToQrScannerEnd = function () {

      qrScannerButtonId.style.backgroundColor = 'transparent'

      qrScannerTouchEndX = event.changedTouches[0].pageX;
      qrScannerTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(qrScannerTouchStartX - qrScannerTouchEndX) < 20 && Math.abs(qrScannerTouchStartY - qrScannerTouchEndY) < 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }
        window.pickContactFromNativeChecker = true;
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
                var rkId = '';
                var rkAmount = '';
                var rkOrder = '';
                for (var i in string) {
                  if (string[i].split('=')[0] == 'id') {
                    id = string[i].split('=')[1];
                    console.log('ID', id)
                  }
                }

                if (!id) {
                  console.log('string', string)
                  try {
                    var decodeString = atob(string)
                  }
                  catch (e) {
                    console.log(e)
                  }
                  console.log("DECODED STRING", decodeString)
                  var splitedArray = decodeString.split('&');
                  for (var j in splitedArray) {
                    if (splitedArray[j].split("=")[0] == 'id')
                      id = splitedArray[j].split("=")[1]

                    if (splitedArray[j].split("=")[0] == 'amount')
                      rkAmount = splitedArray[j].split("=")[1]

                    if (splitedArray[j].split("=")[0] == 'order_id')
                      rkOrder = splitedArray[j].split("=")[1]
                  }

                  console.log('id', id)
                  console.log('rkAmount', rkAmount)
                  console.log('rkOrder', rkOrder)
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

                    if (device.platform != 'BrowserStand') {
                      var options = {dimBackground: true};

                      SpinnerPlugin.activityStart("Сканирование QR", options, function () {
                        console.log("Started");
                      }, function () {
                        console.log("closed");
                      });
                    }

                    window.api.call({
                      method: 'get.indoor.service',
                      input: {
                        phone_num: phoneNumber,
                        session_key: sessionKey,
                        service_id: id,
                      },

                      scope: this,
                      onSuccess: function (result) {
                        console.log('Clearing timer onSuccess', timeOutTimer);
                        window.clearTimeout(timeOutTimer);

                        if (result[0][0].error == 0) {
                          if (result[1]) {
                            if (result[1][0]) {
                              closeMenu();
                              if (rkAmount) {
                                result[1][0].rk_amount = rkAmount
                              }
                              if (rkOrder) {
                                result[1][0].rk_order = rkOrder
                              }
                              riotTags.innerHTML = "<view-qr>";
                              riot.mount('view-qr', result[1][0]);
//                                scope.unmount()
                            }
                          }
                          console.log("QR PAY", result);
                        }
                        else {
                          if (result[0][0].error == -202) {
                            window.checkShowingComponent = scope;
                            scope.update();
                            iFrameExternalUrlId.src = result[0][0].error_url
                            return
                          }
                          window.common.alert.show("componentAlertId", {
                            parent: scope,
                            clickpinerror: false,
                            errornote: result[0][0].error_note
                          });
                          scope.update();
                        }
                      },
                      onFail: function (api_status, api_status_message, data) {
                        console.log('Clearing timer onFail', timeOutTimer);
                        window.clearTimeout(timeOutTimer);
                        console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
                        console.error(data);
                      },
                      onTimeOut: function () {
                        timeOutTimer = setTimeout(function () {
                          window.stopSpinner();
                          return;
                        }, 15000)
                        console.log('creating timeOut', timeOutTimer);
                      },
                      onEmergencyStop: function () {
                        console.log('Clearing timer emergencyStop', timeOutTimer);
                        window.clearTimeout(timeOutTimer);
                      }
                    }, 15000);
                  }
                }
              }
            },
            function (error) {

              window.common.alert.show("componentAlertId", {
                parent: scope,
                clickpinerror: false,
                errornote: "Отсутствует доступ"
              });
              scope.update();
            },
            {
              preferFrontCamera: false, // iOS and Android
              showFlipCameraButton: true, // iOS and Android
              showTorchButton: true, // iOS and Android
              torchOn: false, // Android, launch with the torch switched on (if available)
              prompt: window.languages.ViewQrLabelOnScanner, // Android
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

                window.common.alert.show("componentAlertId", {
                  parent: scope,
                  clickpinerror: false,
                  errornote: result[0][0].error_note
                });
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

      console.log('qrButtonId', qrButtonId)

      qrScannerButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      qrScannerTouchStartX = event.changedTouches[0].pageX;
      qrScannerTouchStartY = event.changedTouches[0].pageY;
    }

    var clickPassTouchStartX, clickPassTouchStartY, clickPassTouchEndX, clickPassTouchEndY;

    goToClickPassEnd = function () {
      clickPassButtonId.style.backgroundColor = 'transparent';

      clickPassTouchEndX = event.changedTouches[0].pageX;
      clickPassTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(clickPassTouchStartX - clickPassTouchEndX) < 20 && Math.abs(clickPassTouchStartY - clickPassTouchEndY) < 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!';
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
          scope.update();
          return;
        }
        console.log('button is working');
        closeMenu();
        riotTags.innerHTML = "<view-click-pass>";
        riot.mount('view-click-pass');
      }
      else {
        sideMenuTouchEnd();
      }
    };

    goToClickPassStart = function () {

      clickPassButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      clickPassTouchStartX = event.changedTouches[0].pageX;
      clickPassTouchStartY = event.changedTouches[0].pageY;
    };

    var settingsTouchStartX, settingsTouchStartY, settingsTouchEndX, settingsTouchEndY

    goToSettingsEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      settingsButtonId.style.backgroundColor = 'transparent'

      settingsTouchEndX = event.changedTouches[0].pageX;
      settingsTouchEndY = event.changedTouches[0].pageY;

      console.log('settingsTouchStartX', settingsTouchStartX)
      console.log('settingsTouchEndX', settingsTouchEndX)

      if (Math.abs(settingsTouchStartX - settingsTouchEndX) < 20 && Math.abs(settingsTouchStartY - settingsTouchEndY) < 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'

          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }
        closeMenu()
        riotTags.innerHTML = "<view-settings>";
        riot.mount("view-settings");
//        scope.unmount()
        return
      }
      else sideMenuTouchEnd()

    }

    goToSettingsStart = function () {
      settingsButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      settingsTouchStartX = event.changedTouches[0].pageX;
      settingsTouchStartY = event.changedTouches[0].pageY;
    }

    var billingsTouchStartX, billingsTouchStartY, billingsTouchEndX, billingsTouchEndY;
    goToBillingsTouchStart = function () {

      billngsButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      billingsTouchStartX = event.changedTouches[0].pageX;
      billingsTouchStartY = event.changedTouches[0].pageY;
    };

    goToBillingsTouchEnd = function () {

      billngsButtonId.style.backgroundColor = 'transparent'

      billingsTouchEndX = event.changedTouches[0].pageX;
      billingsTouchEndY = event.changedTouches[0].pageY;

      if (Math.abs(billingsTouchEndX - billingsTouchStartX) < 20 && Math.abs(billingsTouchStartY - billingsTouchEndY) < 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
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
//        scope.unmount()
        return
      }
    };

    var favoritesTouchStartX, favoritesTouchStartY, favoritesTouchEndX, favoritesTouchEndY;

    goToFavoritesEnd = function () {
      event.preventDefault();
      event.stopPropagation();

      favouriteButtonId.style.backgroundColor = 'transparent'

      favoritesTouchEndX = event.changedTouches[0].pageX;
      favoritesTouchEndY = event.changedTouches[0].pageY;

      console.log('settingsTouchStartX', favoritesTouchStartX)
      console.log('settingsTouchEndX', favoritesTouchEndX)

      if (Math.abs(favoritesTouchStartX - favoritesTouchEndX) < 20 && Math.abs(favoritesTouchStartY - favoritesTouchEndY) < 20) {
        if (modeOfApp.demoVersion) {
          var question = 'Внимание! Для совершения данного действия необходимо авторизоваться!'
          window.common.alert.show("componentAlertId", {
            parent: scope,
            errornote: question
          });
//        confirm(question)
//          scope.confirmShowBool = true;
//          scope.confirmNote = question;
//          scope.confirmType = 'local';
//          scope.result = function (bool) {
//            if (bool) {
//              localStorage.clear();
//              window.location = 'index.html'
//              scope.unmount()
//              return
//            }
//            else {
//              scope.confirmShowBool = false;
//              return
//            }
//          };
          scope.update();

          return
        }
        closeMenu();
        riotTags.innerHTML = "<view-favorites-new>";
        riot.mount("view-favorites-new");
//        scope.unmount()
        return
      }
      else sideMenuTouchEnd()

    }

    goToFavoritesStart = function () {

      favouriteButtonId.style.backgroundColor = 'rgba(231,231,231,0.15)'

      favoritesTouchStartX = event.changedTouches[0].pageX;
      favoritesTouchStartY = event.changedTouches[0].pageY;
    }


  </script>
</component-menu>
<view-authorization class="view-authorization">

  <div class="authorization-flex-container">
    <div class="authorization-unchangable-container">
      <div class="authorization-enter-pin-label">{window.languages.ViewAuthorizationClickPinLabel}</div>
      <div class="authorization-pin-container">
        <div class="authorization-pin-field">
          <div id="circleOne" class="authorization-pin-circles authorization-pin-one"></div>
          <div id="circleTwo" class="authorization-pin-circles authorization-pin-two"></div>
          <div id="circleThree" class="authorization-pin-circles authorization-pin-three"></div>
          <div id="circleFour" class="authorization-pin-circles authorization-pin-four"></div>
          <div id="circleFive" class="authorization-pin-circles authorization-pin-five"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="authorization-keyboard-field keyboard-field">
    <component-keyboard></component-keyboard>
  </div>

  <div class="authorization-buttons-container">
    <div id="TESTID" class="authorization-button-forget-pin" ontouchend="pinReset()">
      {window.languages.ViewAuthorizationForgetPinLabel}
    </div>
    <div class="authorization-button-registration" ontouchend="resetLocalStorageTouchEnd()">
      {window.languages.ViewAuthorizationResetLocalStorageLabel}
    </div>
  </div>
  <div if="{checkAndroid}" class="authorization-button-offline" ontouchstart="offlineMode()">
    {window.languages.ViewAuthorizationOfflineModeLabel}
  </div>

  <component-pin-reset></component-pin-reset>

  <script>
    //    TEST = function () {
    //      CardIO.scan({
    //        "expiry": true,
    //        "cvv": true,
    //        "zip": false,
    //        "suppressManual": false,
    //        "suppressConfirm": false,
    //        "hideLogo": true
    //      }, onCardIOComplete, onCardIOCancel);
    //    };
    //
    //    if (device.platform != 'BrowserStand')
    //      CardIO.canScan(onCardIOCheck);
    //
    //    function onCardIOComplete(response) {
    //      var cardIOResponseFields = [
    //        "card_type",
    //        "redacted_card_number",
    //        "card_number",
    //        "expiry_month",
    //        "expiry_year",
    //        "cvv",
    //        "zip"
    //      ];
    //
    //      var len = cardIOResponseFields.length;
    //      console.log("card.io scan complete");
    //      for (var i = 0; i < len; i++) {
    //        var field = cardIOResponseFields[i];
    //        alert(field + ": " + response[field]);
    //      }
    //    }
    //
    //    function onCardIOCancel(error) {
    //      console.log("card.io scan cancelled");
    //      console.log(error)
    //    }
    //
    //    function onCardIOCheck(canScan) {
    //      console.log("card.io canScan? " + canScan);
    //      if (!canScan) {
    //        console.log('can Scan false')
    //      }
    //    }


    var scope = this;
    scope.checkAndroid = false;

    if (history.arrayOfHistory.length != 0) {
      if (history.arrayOfHistory[history.arrayOfHistory.length - 1].view != 'view-authorization') {
        history.arrayOfHistory.push(
          {
            "view": 'view-authorization',
            "params": ''
          }
        );
        sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
      }
    }
    else {
      history.arrayOfHistory.push(
        {
          "view": 'view-authorization',
          "params": ''
        }
      );
      sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory))
    }

    if (device.platform == 'Android') {
      scope.checkAndroid = true;
    }

    pinReset = function () {
      componentPinResetId.style.display = 'block';
    };

    resetLocalStorageTouchEnd = function () {
      event.preventDefault();
      event.stopPropagation();
      var question = 'Подтвердите удаление данных'
      var result = confirm(question)
      if (result) {
        localStorage.clear();
        this.riotTags.innerHTML = "<view-registration-device>";
        riot.mount('view-registration-device');
        return
      }
    };

    var pin;
    var enteredPin = '';
    var checkSessionKey = false;

    componentKeyboard.returnValue = function (myValue) {
      event.preventDefault();
      event.stopPropagation();

      if (enteredPin.length < 5 && myValue != 'x') {
        enteredPin += myValue;
      }
      if (myValue == 'x' && enteredPin != 4) {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }

      riot.update();
      updateEnteredPin();
    }

    offlineMode = function () {
      event.preventDefault();
      event.stopPropagation();
      modeOfApp.onlineMode = false
      modeOfApp.offlineMode = true;
      var loginInfo = JSON.parse(localStorage.getItem('click_client_loginInfo'));
//      console.log('sessionKey', sessionKey)
      if (loginInfo) {
        this.riotTags.innerHTML = "<view-main-page>";
        riot.mount('view-main-page');
      }
      else alert('Do first enter with Internet')

    };

    updateEnteredPin = function () {

      if (enteredPin.length == 0) {
        circleOne.style.backgroundColor = 'transparent';
        circleTwo.style.backgroundColor = 'transparent';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }
      if (enteredPin.length == 1) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = 'transparent';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }
      if (enteredPin.length == 2) {
        circleOne.style.backgroundColor = '#01cfff';
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = 'transparent';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 3) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = 'transparent';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 4) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = 'transparent';
      }

      if (enteredPin.length == 5) {
        circleOne.style.backgroundColor = '#01cfff';
        circleTwo.style.backgroundColor = '#01cfff';
        circleThree.style.backgroundColor = '#01cfff';
        circleFour.style.backgroundColor = '#01cfff';
        circleFive.style.backgroundColor = '#01cfff';
        pin = enteredPin;
        enter();
      }
    }

    enter = function () {

      var phoneNumber = localStorage.getItem('click_client_phoneNumber');
      var deviceId = localStorage.getItem('click_client_deviceID');
      var date = parseInt(Date.now() / 1000);
//      console.log(date);
      var token = localStorage.getItem('click_client_token');
      var password = hex_sha512(token + date + hex_md5(pin));
      localStorage.setItem("pinForStand", pin);
      authorization(phoneNumber, deviceId, password, date);
    }

    function authorization(phoneNumber, deviceId, password, date) {
      window.api.call({
        method: 'app.login',
        input: {
          phone_num: phoneNumber,
          device_id: deviceId,
          password: password,
          datetime: date
        },
        scope: this,

        onSuccess: function (result) {
//          console.log(result[0][0])
          if (result[0][0].error == 0) {
            if (!result[1][0].error) {
//              console.log("APP LOGIN RESULT", result);
              localStorage.setItem('myNumberOperatorId', result[1][0].my_service_id);
              modeOfflineMode.check = false;
              var JsonInfo = JSON.stringify(result[1][0]);
              localStorage.setItem('click_client_loginInfo', JsonInfo);
              checkSessionKey = true;
              viewAuthorization.check = false;
              getAccount();
            }
          }
          else {
            alert(result[0][0].error_note)
            enteredPin = '';
            updateEnteredPin();
            return
          }
        },
        onFail: function (api_status, api_status_message, data) {
          console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
          console.error(data);
        }
      })
    }

    if (checkSessionKey) {
      var phoneNumber = localStorage.getItem("click_client_phoneNumber");
      var loginInfo = JSON.parse(localStorage.getItem("click_client_loginInfo"));
      var sessionKey = loginInfo.session_key;
    }

    var balance;
    var arrayAccountInfo = [];
    getAccount = function (e) {
      if (JSON.parse(localStorage.getItem("click_client_loginInfo"))) {
        var phoneNumber = localStorage.getItem("click_client_phoneNumber");
        var info = JSON.parse(localStorage.getItem("click_client_loginInfo"));
        var sessionKey = info.session_key;

        if (!localStorage.getItem("click_client_accountInfo")) {
          window.api.call({
            method: 'get.accounts',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },

            scope: this,

            onSuccess: function (result) {

              if (result[0][0].error == 0) {

                if (device.platform != 'BrowserStand') {
                  window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                    var j = -1, count = 0;
                    for (var i = 0; i < result[1].length; i++) {

                      j++;
                      arrayAccountInfo.push(result[1][i]);

                      var icon = result[1][i].card_background_url;

                      var filename = icon.substr(icon.lastIndexOf('/') + 1);
//                      alert("filename=" + filename);

                      var newIconBool = checkImageURL;
                      newIconBool('www/resources/icons/cards/', 'cards', filename, icon, j, function (bool, index, fileName) {

                        if (bool) {
                          count++;
//                          alert("(1)new file name=" + fileName + "," + count);
                          arrayAccountInfo[index].card_background_url = cordova.file.dataDirectory + fileName;
                        } else {
                          count++;
//                          alert("(2)new file name=" + fileName + "," + count);
                          arrayAccountInfo[index].card_background_url = cordova.file.applicationDirectory + 'www/resources/icons/cards/' + fileName;
                        }

                        var icon2 = arrayAccountInfo[index].image_url;
                        var filename2 = icon2.substr(icon2.lastIndexOf('/') + 1);
                        var newIcon = checkImageURL;
                        newIcon('www/resources/icons/cards/logo/', 'logo', filename2, icon2, index, function (bool2, index2, fileName2) {

                          if (bool2) {
                            count++;
//                            alert("(11)new file name=" + fileName2 + "," + count);
                            arrayAccountInfo[index2].image_url = cordova.file.dataDirectory + fileName2;
                          } else {
                            count++;
//                            alert("(12)new file name=" + fileName2 + "," + count);
                            arrayAccountInfo[index2].image_url = cordova.file.applicationDirectory + 'www/resources/icons/cards/logo/' + fileName2;
                          }

                          if (count == (result[1].length * 2)) {
//                            alert("GHVCHGFUIHOI:JIJsave into localstorage");
                            var accountInfo = JSON.stringify(arrayAccountInfo);
                            localStorage.setItem("click_client_accountInfo", accountInfo);
                            this.riotTags.innerHTML = "<view-main-page>";
                            riot.mount('view-main-page');
                          }

                        });

                      });

                    }
                  }, onErrorLoadFs);
                } else {
                  for (var i = 0; i < result[1].length; i++)
                    arrayAccountInfo.push(result[1][i])
                  var accountInfo = JSON.stringify(arrayAccountInfo);
                  localStorage.setItem("click_client_accountInfo", accountInfo);
                  this.riotTags.innerHTML = "<view-main-page>";
                  riot.mount('view-main-page');
                }
              }
              else
                alert(result[0][0].error_note);
            },


            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          })
        } else {
          this.riotTags.innerHTML = "<view-main-page>";
          riot.mount('view-main-page');
        }

        if (!localStorage.getItem("click_client_payCategoryList")) {

          scope.categoryList = [];
          scope.categoryNamesMap = {};
          window.api.call({
            method: 'get.service.category.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0)
                if (result[1][0]) {

                  if (device.platform != 'BrowserStand') {
                    window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                      var j = -1;

                      for (var i in result[1]) {

                        scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
                        j++;
                        scope.categoryList.push(result[1][i]);

                        var icon = result[1][i].icon;
                        var filename = icon.substr(icon.lastIndexOf('/') + 1);

                        var newIconBool = checkImageURL;
                        newIconBool('www/resources/icons/ViewPay/category/', 'category', filename, icon, j, function (bool, index, fileName) {

                          if (bool) {
                            scope.categoryList[index]['icon'] = cordova.file.dataDirectory + fileName;//
                          } else {
                            scope.categoryList[index]['icon'] = cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/category/' + fileName;
                          }


                          if (result[1].length == scope.categoryList.length) {
//                            console.log("save into localstorage, categoryList=", scope.categoryList);
                            riot.update(scope.categoryList);
                            localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                            localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
                          }
                        });
                      }
                    }, onErrorLoadFs);
                  }
                  else {
                    for (var i in result[1]) {

                      scope.categoryList.push(result[1][i]);
                      scope.categoryNamesMap[result[1][i].id] = result[1][i].name;
                    }
//                    riot.update(scope.categoryList);
                    localStorage.setItem('click_client_payCategoryList', JSON.stringify(scope.categoryList));
                    localStorage.setItem('click_client_categoryNamesMap', JSON.stringify(scope.categoryNamesMap));
                  }
                }

              scope.id = 0;

            },
            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        }

        /*
         * Убрана проверка, так как по требованию в онлайн режиме всегда производится вызов сервисов.
         * */
//        if (!(localStorage.getItem("click_client_payServiceList") && localStorage.getItem("click_client_servicesMapByCategory")
//            && localStorage.getItem("click_client_servicesMap"))) {
        refreshServiceList = function () {
//          console.log("IN SERVICE LIST FUNC");
          scope.serviceList = [];
          scope.servicesMapByCategory = {};
          scope.servicesMap = {};
          scope.serviceNamesMap = {};
          scope.operatorKey = phoneNumber.substr(3, 2);
//          console.log("MOPERATORS!!!!!!!!!!!!!!", window.mOperators[scope.operatorKey]);
          window.api.call({
            method: 'get.service.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },
            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0)
                if (result[1][0]) {

                  var firstService;

                  if (device.platform != 'BrowserStand') {
                    window.requestFileSystem(window.TEMPORARY, 1000, function (fs) {
                      var inVisibleNum = 0, j = -1;

                      for (var i in result[1]) {
                        if (result[1][i].is_visible == 1) {

                          console.log("service id=", result[1][i].id, ", element:", result[1][i]);

                          scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
                          j++;
                          scope.serviceList.push(result[1][i]);

                          var icon = result[1][i].image;
                          var filename = icon.substr(icon.lastIndexOf('/') + 1);

                          var newIconBool = checkImageURL;
                          newIconBool('www/resources/icons/ViewPay/service/', 'service', filename, icon, j, function (bool, index, fileName) {

                            if (bool) {
                              scope.serviceList[index]['image'] = cordova.file.dataDirectory + fileName;//
                            } else {
                              scope.serviceList[index]['image'] = cordova.file.applicationDirectory + 'www/resources/icons/ViewPay/service/' + fileName;
                            }

                            if (!scope.servicesMapByCategory[scope.serviceList[index].category_id]) {
                              scope.servicesMapByCategory[scope.serviceList[index].category_id] = [];
                              if (scope.serviceList[index].category_id === 1 && (scope.serviceList[index].id === window.mOperators[scope.operatorKey])) {
                                localStorage.setItem('myNumberOperatorId', scope.serviceList[index].id);
//                                console.log("MY NUMBER ID", scope.serviceList[index].id);

                                var myNumberObject = {};
                                myNumberObject.name = 'Мой номер';
                                myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                                myNumberObject.id = 'mynumber' + scope.serviceList[index].id;
                                scope.servicesMapByCategory[scope.serviceList[index].category_id].push(myNumberObject);

                              } else if (scope.serviceList[index].category_id === 1) {
                                firstService = scope.serviceList[index];
//                                console.log("FIRST SERVICE=", firstService);
                              }
                              scope.servicesMapByCategory[scope.serviceList[index].category_id].push(scope.serviceList[index]);
                            }
                            else {
                              if (scope.serviceList[index].category_id === 1 && (scope.serviceList[index].id === window.mOperators[scope.operatorKey])) {
                                localStorage.setItem('myNumberOperatorId', scope.serviceList[index].id);
//                                console.log("MY NUMBER ID", scope.serviceList[index].id);

                                var myNumberObject = {};
                                myNumberObject.name = 'Мой номер';
                                myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                                myNumberObject.id = 'mynumber' + scope.serviceList[index].id;
                                scope.servicesMapByCategory[scope.serviceList[index].category_id][0] = myNumberObject;
                                scope.servicesMapByCategory[scope.serviceList[index].category_id].push(firstService);
                              }
                              scope.servicesMapByCategory[scope.serviceList[index].category_id].push(scope.serviceList[index]);
                            }


                            if (!scope.servicesMap[scope.serviceList[index].id + '']) {
                              scope.servicesMap[scope.serviceList[index].id + ''] = [];
                              scope.servicesMap[scope.serviceList[index].id + ''].push(scope.serviceList[index]);
                            }
                            else {
                              scope.servicesMap[scope.serviceList[index].id + ''].push(scope.serviceList[index]);
                            }


                            if ((result[1].length - inVisibleNum) == scope.serviceList.length) {
//                              console.log("save into localstorage");
                              localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
                              localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
                              localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
                              localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));
                            }

                          });
                        } else
                          inVisibleNum++;
                      }
                    }, onErrorLoadFs);
                  } else {

                    for (var i in result[1]) {
                      if (result[1][i].is_visible == 1) {
//                        console.log("service id=", result[1][i].id, ", element:", result[1][i]);

                        scope.serviceNamesMap[result[1][i].id] = result[1][i].name;
                        scope.serviceList.push(result[1][i]);

                        if (!scope.servicesMapByCategory[result[1][i].category_id]) {
                          scope.servicesMapByCategory[result[1][i].category_id] = [];
                          if (result[1][i].category_id == 1 && result[1][i].id == window.mOperators[scope.operatorKey]) {
//                            console.log("MY NUMBER");
                            localStorage.setItem('myNumberOperatorId', result[1][i].id);
//                            console.log("MY NUMBER ID", result[1][i].id);
                            var myNumberObject = {};
                            myNumberObject.name = 'Мой номер';
                            myNumberObject.image = 'resources/icons/ViewPay/myphone.png';
                            myNumberObject.id = 'mynumber' + result[1][i].id;
                            scope.servicesMapByCategory[result[1][i].category_id].push(myNumberObject);
                            //console.log("ID=", viewServicePage.myNumberOperatorId, ",,,Name=", viewServicePage.myNumberOperatorName, ",,,Image=", viewServicePage.myNumberOperatorImage);
                          }
                          scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                        }
                        else {
                          scope.servicesMapByCategory[result[1][i].category_id].push(result[1][i]);
                        }
                        if (!scope.servicesMap[result[1][i].id + '']) {
                          scope.servicesMap[result[1][i].id + ''] = [];
                          scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
                        }
                        else {
                          scope.servicesMap[result[1][i].id + ''].push(result[1][i]);
                        }
                      }
                    }
                    localStorage.setItem('click_client_payServiceList', JSON.stringify(scope.serviceList));
                    localStorage.setItem('click_client_payServiceNamesMap', JSON.stringify(scope.serviceNamesMap));
                    localStorage.setItem('click_client_servicesMapByCategory', JSON.stringify(scope.servicesMapByCategory));
                    localStorage.setItem('click_client_servicesMap', JSON.stringify(scope.servicesMap));

                  }
                }


              servicesParamsInit();
            },
            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          })
        };

        refreshServiceList();

        servicesParamsInit = function () {
//          console.log("IN SERVICES PARAMS INIT");
          scope.servicesParams = [];
          scope.servicesParamsMapOne = {};
          scope.servicesParamsMapTwo = {};
          scope.servicesParamsMapThree = {};
          scope.servicesParamsMapFour = {};
          scope.servicesParamsMapFive = {};
          window.api.call({
            method: 'get.service.parameters.list',
            input: {
              session_key: sessionKey,
              phone_num: phoneNumber
            },

            scope: this,

            onSuccess: function (result) {
              if (result[0][0].error == 0) {
                if (result[1])
                  for (var i in result[1]) {
//                    console.log("1. service id=", result[1][i].service_id, "element:", result[1][i]);
                    if (!scope.servicesParamsMapOne[result[1][i].service_id]) {
                      scope.servicesParamsMapOne[result[1][i].service_id] = [];
                      scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);
                    }
                    else
                      scope.servicesParamsMapOne[result[1][i].service_id].push(result[1][i]);


                  }
                if (result[2])
                  for (var i in result[2]) {
//                    console.log("2. service id=", result[2][i].service_id, "element:", result[2][i]);
                    if (!scope.servicesParamsMapTwo[result[2][i].service_id]) {
                      scope.servicesParamsMapTwo[result[2][i].service_id] = [];
                      scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);
                    }
                    else
                      scope.servicesParamsMapTwo[result[2][i].service_id].push(result[2][i]);

                  }
                if (result[3])
                  for (var i in result[3]) {
//                    console.log("3. service id=", result[3][i].service_id, "element:", result[3][i]);
                    if (!scope.servicesParamsMapThree[result[3][i].service_id]) {
                      scope.servicesParamsMapThree[result[3][i].service_id] = [];
                      scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);
                    }
                    else
                      scope.servicesParamsMapThree[result[3][i].service_id].push(result[3][i]);

                  }
                if (result[4])
                  for (var i in result[4]) {
//                    console.log("4. service id=", result[4][i].service_id, "element:", result[4][i]);
                    if (!scope.servicesParamsMapFour[result[4][i].service_id]) {
                      scope.servicesParamsMapFour[result[4][i].service_id] = [];
                      scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                    }
                    else
                      scope.servicesParamsMapFour[result[4][i].service_id].push(result[4][i]);
                  }
                if (result[5])
                  for (var i in result[5]) {
//                    console.log("5. service id=", result[5][i].service_id, "element:", result[5][i]);
                    if (!scope.servicesParamsMapFive[result[5][i].service_id]) {
                      scope.servicesParamsMapFive[result[5][i].service_id] = [];
                      scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                    }
                    else
                      scope.servicesParamsMapFive[result[5][i].service_id].push(result[5][i]);
                  }
                localStorage.setItem('click_client_servicesParams', JSON.stringify(result));
                localStorage.setItem('click_client_servicesParamsMapOne', JSON.stringify(scope.servicesParamsMapOne));
                localStorage.setItem('click_client_servicesParamsMapTwo', JSON.stringify(scope.servicesParamsMapTwo));
                localStorage.setItem('click_client_servicesParamsMapThree', JSON.stringify(scope.servicesParamsMapThree));
                localStorage.setItem('click_client_servicesParamsMapFour', JSON.stringify(scope.servicesParamsMapFour));
                localStorage.setItem('click_client_servicesParamsMapFive', JSON.stringify(scope.servicesParamsMapFive));
              }
            },

            onFail: function (api_status, api_status_message, data) {
              console.error("api_status = " + api_status + ", api_status_message = " + api_status_message);
              console.error(data);
            }
          });
        };


      }
    }

    //    if (device.platform == 'Android') {
    //
    //      function isAvailableSuccess(result) {
    //        console.log("FingerprintAuth available: " + JSON.stringify(result));
    //        result.isAvailable = true;
    //        if (result.isAvailable) {
    //          var encryptConfig = {
    //            clientId: "myAppName",
    //            username: "currentUser",
    //            password: "currentUserPassword"
    //
    //          }; // See config object for required parameters
    //          FingerprintAuth.encrypt(encryptConfig, encryptSuccessCallback, encryptErrorCallback);
    //        }
    //      }
    //
    //      function isAvailableError(message) {
    //        console.log("isAvailableError(): " + message);
    //      }
    //
    //      function encryptSuccessCallback(result) {
    //        console.log("successCallback(): " + JSON.stringify(result));
    //        if (result.withFingerprint) {
    //          console.log("Successfully encrypted credentials.");
    //          console.log("Encrypted credentials: " + result.token);
    //          pin = '11111';
    //          enter();
    //        } else if (result.withBackup) {
    //          console.log("Authenticated with backup password");
    //        }
    //      }
    //
    //      function encryptErrorCallback(error) {
    //        if (error === "Cancelled") {
    //          console.log("FingerprintAuth Dialog Cancelled!");
    //        } else {
    //          console.log("FingerprintAuth Error: " + error);
    //        }
    //      }
    //
    //      FingerprintAuth.isAvailable(isAvailableSuccess, isAvailableError);
    //
    //    }
    //
    //    if (device.platform == 'iOS') {
    //      function successCallback(success) {
    //        alert('success', success)
    //        var text = 'hello';
    //        touchid.authenticate(successCallbackOfAuth, failureCallbackOfAuth, text);
    //      }
    //
    //      function notSupportedCallback(error) {
    //        alert('error', error)
    //      }
    //
    //      touchid.checkSupport(successCallback, notSupportedCallback);
    //
    //      function successCallbackOfAuth(success) {
    //        alert(success)
    //      }
    //
    //      function failureCallbackOfAuth(error) {
    //        alert(error)
    //      }
    //
    //    }


  </script>
</view-authorization>
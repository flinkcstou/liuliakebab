window.api = {};

window.api.sessionErrorChecker = false;
window.api.spinnerOn = false;

window.api.callBacks = {};

window.api.forceClose = function () {
  this.socket.onclose = function () {
    console.log("Socket closed forcefully");
    window.isConnected = false;
  };
  window.api.socket.close();
};

window.api.call = function (params, timeout) {
  console.log("Function call:", params, timeout);


  if (timeout === undefined)
    timeout = 30000;
  setTimeout(function () {
    if (!stateCheckerCleared) {
      clearInterval(stateChecker);
      console.log('clearing interval-sender - time out', stateChecker);
    }
  }, timeout);

  if (params.onTimeOut !== undefined) {
    console.log('Calling onTimeOut in webApi');
    params.onTimeOut.call();
  }

  if (!window.isConnected) {
    window.api.init();
  }
  var stateCheckerCleared = false;
  var stateChecker = setInterval(function () {
    console.log("in interval of web api", window.api.socket, window.isConnected);
    if (window.api.socket.readyState === 1) {
      window.api.send(params);
      stateCheckerCleared = true;
      console.log("Clearing interval-sender - sending request", stateChecker);
      clearInterval(stateChecker);
    }
    if (window.api.socket.readyState === 0) {
      console.log("Connection in state 0, checking again");
    }
    if (window.api.socket.readyState === 3) {
      console.log("Connection in state 3");
      window.isConnected = false;
      stateCheckerCleared = true;
      clearInterval(stateChecker);
    }
  }, 300);

};

window.api.init = function () {
  if (!window.isConnected) {
    try {
      window.api.socket = new WebSocket("wss://my.click.uz:8443");
      window.isConnected = true;
      console.log("SOCKET =", window.api.socket);
      window.api.initSocket();
    } catch (error) {
      console.error("error on establishing connection", error);
    }
  }
};

window.api.initSocket = function () {
  this.socket.onopen = function () {
    console.log('WebSocket is opened and ');
    window.isConnected = true;
    if (modeOfApp.onlineMode) {
      switch (window.api.socket.readyState) {
        case 1:
          console.log("connected");
          break;
        case 0:
          console.log("connecting");
          break;
        case 2:
          console.log("closing");
          break;
        case 3:
          console.log("closed");
          break;
      }
    }
  };

  this.socket.onclose = function (event) {
    console.log('Connection is closed');
    console.log(event);
    window.isConnected = false;
    if (navigator.connection.type !== Connection.NONE && navigator.connection.type !== Connection.UNKNOWN) {
      window.api.init();
    }
  };

  var me = this;

  this.socket.onmessage = function (event) {
    if (modeOfApp.offlineMode) return;
    var parsedData = JSON.parse(event.data);

    try {
      var method = parsedData.data[0][0].method;
      console.log("Received data:", method, parsedData);
      var callBack = me.callBacks[method];
      if (parsedData.api_status === 0)
        try {
          if (parsedData.api_status === 0) {
            callBack.ok(parsedData.data);
            return;
          }
        }
        catch (ERROR) {
          console.log("Error on socket initializing: ", ERROR);
          try {
            var error = parsedData.data[0][0].error_note;
            var error_code = parsedData.data[0][0].error;
            console.log("Error in answer from server", error_code);
            if (error_code === -31) {
              if (device.platform !== 'BrowserStand') {
                console.log("Spinner stop in webApi (session is broken)");
                SpinnerPlugin.activityStop();
              }
              localStorage.setItem('session_broken', true);
              localStorage.setItem("click_client_authorized", false);

              riot.update();
              showAlertComponent("Сессия была прервана");
              return;
            }
            if (!window.api.sessionErrorChecker) {
              window.api.sessionErrorChecker = true;
              if (!error) {
                riot.update();
                showAlertComponent("Произошла непредвиденная ошибка. Свяжитесь с нашей службой поддержки +998 71 2310880")
              }
              else {
                if (sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true)
                  return;
                showAlertComponent(error);
              }
              return
            }
          } catch (error) {
            console.error("Error on parsing parsedData.data[0][0].error_note", error);
          }
        }
      try {
        callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
      } catch (error) {
        console.error("Error on socket initializing: ", error);
      }
    } catch (error) {
      console.error("Error on parsing response: ", error);
    }
  };

  this.socket.onerror = function (error) {
    console.error("Onerror event in InitSocket", error);
    window.isConnected = false;
    if (modeOfApp.offlineMode) return;
    try {
      callBack.socketErr();
    } catch (error) {
      console.error("Error on call socketErr callBack: ", error);
    }
    console.log('number of attemps', window.numberOfAttemps)
    if (navigator.connection.type !== Connection.NONE && navigator.connection.type !== Connection.UNKNOWN) {
      if (window.numberOfAttemps == 3){
      showAlertComponent("Связь с сервером потеряна. Повторите попытку.");
        window.numberOfAttemps = 0;
      } else {
        window.numberOfAttemps++;
        window.api.init();
      }
    }
    riot.update();
  };
};

window.api.send = function (params) {
  window.api.sessionErrorChecker = false;
  window.api.spinnerOn = true;

  var method = params.method;
  var input = params.input;
  var stopSpinner = params.stopSpinner === undefined ? true : params.stopSpinner;
  var onSuccess = params.onSuccess;
  var onFail = params.onFail;
  var scope = params.scope || window;
  console.log('METHOD', method);
  console.log("Sending information:", input);
  this.callBacks[method] = {
    ok: function (data) {
      if (stopSpinner) {
        window.api.spinnerOn = false;
        window.stopSpinner();
      }
      onSuccess.call(scope, data);
    },
    err: function (api_status, api_status_message, data) {
      window.stopSpinner();
      console.log("CONNECTION ERROR WEB SOCKET ON FAIL CALL");
      onFail.call(scope, api_status, api_status_message, data);
    },
    socketErr: function () {
      window.stopSpinner();
      if (params.onEmergencyStop !== undefined) {
        onEmergencyStop.call();
      }
    }
  };

  console.log("Sending method");
  this.socket.send(JSON.stringify({
    method: method,
    parameters: input
  }));
};

function onlineDetector() {
  if (!window.isConnected) {
    console.log("Online detector, window.isConnected:", window.isConnected);
    if (modeOfApp.onlineMode)
      window.api.init();
  }
}

function offlineDetector() {
  window.isConnected = false;
  window.stopSpinner();
  window.clearTimers();
  if (device.platform === 'Android')
    showConfirmComponent("Интернет-соединение отсутствует.\nПерейти в офлайн режим ?", 'internet');
  else {
    showAlertComponent("Интернет-соединение отсутствует. Проверьте подключение.");
  }
  console.log("Offline detector, window.isConnected:", window.isConnected);
}

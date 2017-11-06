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

window.api.init = function () {
  if (!window.isConnected)
  try {
    window.api.socket = new WebSocket("wss://my.click.uz:8443");
    console.log("SOCKET =", JSON.stringify(window.api.socket));
    window.api.initSocket();
  }
  catch (error) {
    console.error("error on establishing connection", error);
    if (modeOfApp.onlineMode)
      window.api.init();
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
          window.api.init();
          break;
      }
    }
  };

  this.socket.onclose = function (event) {

    console.log('Connection is closed');
    console.log(event);
    if (device.platform !== 'BrowserStand') {
      console.log("Spinner stop in webApi (socket on close)");
      SpinnerPlugin.activityStop();
    }
    if (modeOfApp.offlineMode) return;
    if (!event.wasClean) {
      if (window.isConnected === true || modeOfApp.offlineMode === true) {
        showAlertComponent("Сервер временно недоступен");
        return
      }
      window.componentFlags.result = false;
      riot.update();
      if (device.platform === 'Android')
        showConfirmComponent("Сервер временно недоступен.\nПерейти в оффлайн режим ?", 'internet');
      else {
        showAlertComponent("Сервер временно недоступен");
      }
    }
    window.isConnected = false;
  };

  var me = this;

  this.socket.onmessage = function (event) {

    if (modeOfApp.offlineMode) return;

    var parsedData = JSON.parse(event.data);
    console.log("Received data:", parsedData);
    try {
      var method = parsedData.data[0][0].method;
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
            if (!window.api.sessionErrorChecker) {
              window.api.sessionErrorChecker = true;
              if (!error) {
                window.componentFlags.result = false;
                riot.update();
                showAlertComponent("Произошла непредвиденная ошибка. Свяжитесь с нашей службой поддержки +998 71 2310880")
              }
              else {
                if (sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true) return;
                console.log("Session is broken");
                if (device.platform !== 'BrowserStand') {
                  console.log("Spinner stop in webApi (session is broken)");
                  SpinnerPlugin.activityStop();
                }
                localStorage.setItem('session_broken', true);
                window.componentFlags.result = false;
                riot.update();
                showAlertComponent("Сессия была прервана");
              }
              return
            }
          } catch (error) {
            console.log(error);
          }
        }
      try {
        callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
      }
      catch (error) {
        console.log("Error on socket initializing: ", error);
      }
    } catch (error) {
      console.log("Error on parsing response: ", error);
    }

  };

  this.socket.onerror = function (error) {
    window.isConnected = false;
    if (modeOfApp.offlineMode) return;
    console.log('Error with socket ' + error.message);
    window.componentFlags.result = false;
    riot.update();
    if (device.platform === 'Android')
      showConfirmComponent("Сервер временно недоступен.\nПерейти в оффлайн режим ?", 'internet');
    else {
      showAlertComponent("Сервер временно недоступен");
    }
  };
};

window.api.call = function (params) {

  if (!window.isConnected && modeOfApp.onlineMode)
    window.api.init();

  window.api.sessionErrorChecker = false;
  window.api.spinnerOn = true;

  var method = params.method;
  console.log('METHOD', method);
  var input = params.input;
  var stopSpinner = params.stopSpinner === undefined ? true : params.stopSpinner;
  console.log("Stop spinner parameter:", params.stopSpinner);
  var onSuccess = params.onSuccess;
  var onFail = params.onFail;
  var scope = params.scope || window;
  console.log("Sending information:", input);
  this.callBacks[method] = {
    ok: function (data) {

      if (stopSpinner) {
        window.api.spinnerOn = false;
        if (device.platform !== 'BrowserStand') {
          console.log("Stopping spinner from webApi on answer of api")
          SpinnerPlugin.activityStop();
        }
      }
      onSuccess.call(scope, data);
    },
    err: function (api_status, api_status_message, data) {
      if (device.platform !== 'BrowserStand') {
        console.log("Spinner Stop in err function of WebApi");
        SpinnerPlugin.activityStop();
      }
      console.log("CONNECTION ERROR WEB SOCKET ON FAIL CALL");
      onFail.call(scope, api_status, api_status_message, data);
    }
  };

  console.log('Online mode:', modeOfApp.onlineMode)
  console.log('Window is connected:', window.isConnected)
  console.log('Socket:', window.api.socket)

  if (modeOfApp.onlineMode && window.isConnected && window.api.socket) {
    console.log("Sending method");
    this.socket.send(JSON.stringify({
      method: method,
      parameters: input
    }));
  }
};

function onlineDetector() {
  if (!window.isConnected) {
    console.log("Online detector, window.isConnected:", window.isConnected);
    if (modeOfApp.onlineMode)
      window.api.init();
  }
}

function offlineDetector() {
  console.log("navigator connection", navigator.connection.type, Connection.NONE);
  if (navigator.connection.type === Connection.NONE) {
    window.isConnected = false;
    console.log("Offline detector, window.isConnected:", window.isConnected);
  }
}

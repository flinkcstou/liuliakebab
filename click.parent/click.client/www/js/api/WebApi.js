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
  try {
    window.api.socket = new WebSocket("wss://my.click.uz:8443");
    window.api.initSocket();
  }
  catch (error) {
    if (modeOfApp.onlineMode)
      window.api.init();
  }
};

window.api.initSocket = function () {

  this.socket.onopen = function () {
    console.log('WebSocket is opened');
    if (!window.isConnected && modeOfApp.onlineMode) {
      if (window.lastSocketMethodToSend) {
        if (window.api.socket.readyState == 1) {
          console.log("Sending last saved method");
          window.api.socket.send(window.lastSocketMethodToSend);
          window.lastSocketMethodToSend = undefined;
        }
        else {
          switch (window.api.socket.readyState) {
            case 0:
              console.log("Is connecting");
              break;
            case 2:
              console.log("Is closing");
              window.isConnected = false;
              window.api.init();
              break;
            case 3:
              console.log("Is closed");
              window.isConnected = false;
              window.api.init();
              break;
          }
        }
      }
    }
    window.isConnected = true;
    console.log("window.isConnected =", window.isConnected);
  };

  this.socket.onclose = function (event) {

    console.log('Connection is closed');
    console.log(event);
    if (device.platform != 'BrowserStand') {
      console.log("Spinner stop in webApi (socket on close)");
      SpinnerPlugin.activityStop();
    }

    if (event.wasClean) {
      return;
    }
    else
      if (modeOfApp.onlineMode) {

        if (window.isConnected == true || modeOfApp.offlineMode == true) {
            return
        }

        if (device.platform == 'Android')
            showConfirmComponent("Сервер временно недоступен.\nПерейти в оффлайн режим ?", 'internet');
        else {
            showAlertComponent("Сервер временно недоступен");
        }
        return
      }
  };

  var me = this;

  this.socket.onmessage = function (event) {

    if (modeOfApp.offlineMode) return;

    var parsedData = JSON.parse(event.data);
    console.log("Received data:", parsedData);
    var method = parsedData.data[0][0].method;
    var callBack = me.callBacks[method];
    if (parsedData.api_status == 0)
      try {
        if (parsedData.api_status == 0) {
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
              showAlertComponent("Произошла непредвиденная ошибка. Свяжитесь с нашей службой поддержки +998 71 2310880")
            }
            else {
              if (sessionStorage.getItem("push_news") && JSON.parse(sessionStorage.getItem("push_news")) === true) return
              console.log("Session is broken");
              if (device.platform != 'BrowserStand') {
                console.log("Spinner stop in webApi (session is broken)");
                SpinnerPlugin.activityStop();
              }
              localStorage.setItem('session_broken', true);
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
  };

  this.socket.onerror = function (error) {
    window.isConnected = false;
    if (modeOfApp.offlineMode) return
    console.log('Error with socket ' + error.message);
    if (device.platform == 'Android')
      showConfirmComponent("Сервер временно недоступен.\nПерейти в оффлайн режим ?", 'internet');
    else {
      showAlertComponent("Сервер временно недоступен");
    }
    return
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

        if (device.platform != 'BrowserStand') {
          console.log("Stopping spinner from webApi on answer of api")
          SpinnerPlugin.activityStop();
        }
      }
      onSuccess.call(scope, data);
    },
    err: function (api_status, api_status_message, data) {
      if (device.platform != 'BrowserStand') {
        console.log("Spinner Stop WebApi 224");
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
    if (window.api.socket.readyState == 1) {
      console.log("Sending method");
      this.socket.send(JSON.stringify({
        method: method,
        parameters: input
      }));
    }
    else {
      console.log("Saving last method to send, socket ready state:", window.api.socket.readyState);
      window.lastSocketMethodToSend = JSON.stringify({
          method: method,
          parameters: input
      });
      switch (window.api.socket.readyState) {
        case 0:
          console.log("Is connecting");
          break;
        case 2:
          console.log("Is closing");
          window.isConnected = false;
          window.api.init();
          break;
        case 3:
          console.log("Is closed");
          window.isConnected = false;
          window.api.init();
          break;
      }
    }
  }
  else {
    if (modeOfApp.onlineMode && !window.isConnected && window.api.socket.readyState != 1) {
      console.log("Saving last method to send (socket not connected)");
      window.lastSocketMethodToSend = JSON.stringify({
        method: method,
        parameters: input
      });
      if (device.platform != 'BrowserStand') {
        console.log("Spinner stop in web api (not connected)");
        SpinnerPlugin.activityStop();
      }
    }
    window.api.init();
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
  window.isConnected = false;
  console.log("Offline detector, window.isConnected:", window.isConnected);
}

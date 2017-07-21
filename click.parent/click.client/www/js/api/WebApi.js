window.api = {};

window.api.sessionErrorChecker = false;
window.api.spinnerOn = false;

window.api.callBacks = {};

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

    console.log('WebSocket is connected');

    if (!window.isConnected && modeOfApp.onlineMode) {

      if (window.lastSocketMethodToSend) {
        window.api.socket.send(window.lastSocketMethodToSend);
        window.lastSocketMethodToSend = undefined;
      }
    }

    console.log("window.isConnected onopen before", window.isConnected);
    window.isConnected = true;
    console.log("window.isConnected onopen after", window.isConnected);


    if (device.platform != 'BrowserStand')
      SpinnerPlugin.activityStop();
  };
  this.socket.onclose = function (event) {

    console.log('Connection is closed');
    console.log(event);

    if (device.platform != 'BrowserStand') {
      SpinnerPlugin.activityStop();
    }

    if (event.wasClean) {
      return
    }
    else if (modeOfApp.onlineMode) {

      if (window.isConnected) {
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

    if (device.platform != 'BrowserStand')
      SpinnerPlugin.activityStop();

    var parsedData = JSON.parse(event.data);
    console.log(parsedData);
    if (parsedData.api_status == 0)
      try {

        var method = parsedData.data[0][0].method;
        var callBack = me.callBacks[method];

        if (parsedData.api_status == 0) {
          callBack.ok(parsedData.data);
          return;
        }


      }
      catch (ERROR) {

        console.log("ERROR", window.isConnected);
        console.log("ERROR", ERROR);

        try {

          var error = parsedData.data[0][0].error_note;

          if (!window.api.sessionErrorChecker) {

            window.api.sessionErrorChecker = true;

            if (!error) {
              showAlertComponent("Ooooops! Что-то пошло не так. При возникновении этой ошибки ещё раз, свяжитесь со службой поддержки по номеру +998 71 2310880.")
            }
            else {
              //showConfirmComponent(error, 'session');
              localStorage.setItem('session_broken', true)
              riotTags.innerHTML = "<view-authorization>";
              riot.mount('view-authorization');
              return
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
      console.log("error", error);
    }
  };

  this.socket.onerror = function (error) {
    window.isConnected = false;

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

  var onSuccess = params.onSuccess;
  var onFail = params.onFail;
  var scope = params.scope || window;
  console.log("IT IS INPUT ", input);
  this.callBacks[method] = {
    ok: function (data) {
      window.api.spinnerOn = false;
      //console.log('ANSWER OF API ', data);


      if (device.platform != 'BrowserStand') {
        SpinnerPlugin.activityStop();
      }

      onSuccess.call(scope, data);
    },
    err: function (api_status, api_status_message, data) {


      console.log("CONNECTION ERROR WEB SOCKET ON FAIL CALL");

      onFail.call(scope, api_status, api_status_message, data);
    }
  };

  console.log('modeOfApp.onlineMode', modeOfApp.onlineMode)
  console.log('window.isConnected', window.isConnected)
  console.log('window.isConnected', window.api.socket)

  if (modeOfApp.onlineMode && window.isConnected && window.api.socket) {

    if (window.api.socket.readyState == 1) {
      this.socket.send(JSON.stringify({
        method: method,
        parameters: input
      }));
    } else {

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
  } else if (modeOfApp.onlineMode && !window.isConnected && window.api.socket.readyState != 1) {

    window.lastSocketMethodToSend = JSON.stringify({
      method: method,
      parameters: input
    });

    if (device.platform != 'BrowserStand')
      SpinnerPlugin.activityStop();
    window.api.init();
  }
  else {
    window.api.init();
  }
};

function onlineDetector() {

  if (!window.isConnected) {

    console.log("window.isConnected", window.isConnected);

    if (modeOfApp.onlineMode)
      window.api.init();
  }
}

function offlineDetector() {
  window.isConnected = false;
  console.log('offline')
}

window.api = {};


window.api.callBacks = {};

window.api.init = function () {


  try {


    window.api.socket = new WebSocket("wss://my.click.uz:8443");


    window.api.initSocket();


  }
  catch (error) {



    //while (!window.isConnected) {
    //}
  }


};

window.api.initSocket = function () {


  this.socket.onopen = function () {


    console.log('WebSocket is connected');

    if (!window.isConnected) {

      alert("Соединение установлено");
    }

    window.isConnected = true;

    if (device.platform != 'BrowserStand')
      SpinnerPlugin.activityStop();
  };
  this.socket.onclose = function (event) {

    console.log('Connection is closed');
    console.log(event);
  };
  var me = this;

  this.socket.onmessage = function (event) {


    if (device.platform != 'BrowserStand')
      SpinnerPlugin.activityStop();

    var parsedData = JSON.parse(event.data);
    console.log(parsedData)
    try {


      var method = parsedData.data[0][0].method;
      //console.log("PARSED DATA", parsedData)

      var callBack = me.callBacks[method];
      //console.log('method', method)
      if (method == 'get.payments')
        var callBack = me.callBacks['get.payments'];
      //console.log('CALLBACK', callBack)


      if (parsedData.api_status == 0) {


        callBack.ok(parsedData.data);
        window.isConnected = true;
        return;
      }


    }
    catch (ERROR) {



      //var options = {dimBackground: true};
      //
      //SpinnerPlugin.activityStart(languages.ConnectionSocket, options, function () {
      //  window.api.init();
      //  console.log("Started");
      //}, function () {
      //  console.log("closed");
      //});

      console.log("ERROR", window.isConnected);
      console.log("ERROR", ERROR);

      if (window.isConnected) {


        window.isConnected = false;

        var result = confirm(parsedData.data[0][0].error_note);
        if (result) {

          riotTags.innerHTML = "<view-authorization>";
          riot.mount('view-authorization');
        }
        else {

          navigator.app.exitApp();
        }
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


    console.log("ENTERED_SADASDASDASDA_WEB_API_ERROR");

    console.log('Error with socket ' + error.message);
  };
};

window.api.call = function (params) {

  var method = params.method;
  console.log('METHOD', method)
  var input = params.input;

  var onSuccess = params.onSuccess;
  var onFail = params.onFail;
  var scope = params.scope || window;
  console.log("IT IS INPUT ", input);
  this.callBacks[method] = {
    ok: function (data) {
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

  if (modeOfApp.onlineMode && window.isConnected) {

    if (device.platform != 'BrowserStand' && method != "get.balance") {
      var options = {dimBackground: true};

      SpinnerPlugin.activityStart(languages.Downloading, options, function () {
        console.log("Started");
      }, function () {
        console.log("closed");
      });
    }

    if (window.api.socket.readyState == 1) {
      this.socket.send(JSON.stringify({
        method: method,
        parameters: input
      }));
    } else {

      switch (window.api.socket.readyState) {

        case 0:
          console.log("Is connection");
          break;
        case 2:
          console.log("Is closing");
          break;
        case 3:
          console.log("Is closed");
          break;
      }
    }
  } else {

    alert("Возможно отсутствует соединение с интернетом");
  }
};

function onlineDetector() {

  if (!window.isConnected) {

    console.log("window.isConnected", window.isConnected);

    window.api.init();
  }
}

function offlineDetector() {

  if (modeOfApp.onlineMode && window.isConnected) {

    alert("Возможно отсутствует соединение с интернетом");
  }

  console.log("OFFLINE DETECTOR");
  window.isConnected = false;

  if (window.api.socket.readyState == 1) {

    window.api.socket.close();
  }
}
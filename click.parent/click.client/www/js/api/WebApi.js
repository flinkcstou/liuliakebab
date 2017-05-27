window.api = {};

window.api.sessionErrorChecker = false;
window.api.spinnerOn = false;

window.api.callBacks = {};

window.api.init = function () {


  try {


    window.api.socket = new WebSocket("wss://my.click.uz:8443");
    //window.api.socket = new WebSocket("ws://localhost:8080/WebSocketTest/open");


    window.api.initSocket();


  }
  catch (error) {
    window.api.init();


    //while (!window.isConnected) {
    //}
  }


};

window.api.initSocket = function () {

  this.socket.onopen = function () {

    console.log('WebSocket is connected');

    if (!window.isConnected) {

      //showAlertComponent("Соединение установлено");

      //alert("Соединение установлено");

      if (window.api.socket.readyState == 1 && window.lastSocketMethodToSend) {
        window.api.socket.send(window.lastSocketMethodToSend);
        window.lastSocketMethodToSend = undefined;
      } else {

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

    console.log("window.isConnected onopen before", window.isConnected);
    window.isConnected = true;
    console.log("window.isConnected onopen after", window.isConnected);


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
    console.log(parsedData);
    if (parsedData.api_status == 0)
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

        try {

          var error = parsedData.data[0][0].error_note;

          if (!window.api.sessionErrorChecker) {

            window.api.sessionErrorChecker = true;

            //var result =
            showConfirmComponent(error, 'session');

          }
        } catch (error) {

          console.log(error);
        }
      }


    try {

      callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
    }
    catch (error) {
      if (!window.api.sessionErrorChecker) {

        window.api.sessionErrorChecker = true;

        //var result =
        if (parsedData.api_status == 0)
          showConfirmComponent(error, 'session');

      }

      console.log("error", error);
    }
  };
  this.socket.onerror = function (error) {
    window.isConnected = false;
    window.api.init();


    console.log("ENTERED_SADASDASDASDA_WEB_API_ERROR");

    console.log('Error with socket ' + error.message);
  };
};

window.api.call = function (params) {

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

  if (modeOfApp.onlineMode && window.isConnected) {

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
  } else if (modeOfApp.onlineMode) {

    window.lastSocketMethodToSend = JSON.stringify({
      method: method,
      parameters: input
    });

    if (device.platform != 'BrowserStand')
      SpinnerPlugin.activityStop();

    if (device.platform == 'Android')
      showConfirmComponent("Отсутствует соединение с интернетом.\nПерейти в оффлайн режим ?", 'internet');
    else {
      showAlertComponent("Отсутствует соединение с интернетом");
    }

    //if (result) {
    //
    //  modeOfApp.offlineMode = true;
    //  modeOfApp.onlineMode = false;
    //
    //  riotTags.innerHTML = "<view-main-page>";
    //  riot.mount('view-main-page');
    //  riot.update()
    //}
  }

  setTimeout(function(){
    if (device.platform != 'BrowserStand')
      if(window.api.spinnerOn) {
        SpinnerPlugin.activityStop();
      }

  }, 5000);
};

function onlineDetector() {

  if (!window.isConnected) {

    console.log("window.isConnected", window.isConnected);

    window.api.init();
  }
}

function offlineDetector() {

  if (window.isConnected) window.api.socket.close()
  if (modeOfApp.onlineMode && window.isConnected) {

    //if (device.platform == 'Android')
    //  showConfirmComponent("Отсутствует соединение с интернетом.\nПерейти в оффлайн режим ?", 'internet');
    //else {
    //  showAlertComponent("Отсутствует соединение с интернетом");
    //}
    //if (result) {
    //
    //  modeOfApp.offlineMode = true;
    //  modeOfApp.onlineMode = false;
    //
    //  riotTags.innerHTML = "<view-main-page>";
    //  riot.mount('view-main-page');
    //  riot.update()
    //}
  }

  console.log("OFFLINE DETECTOR");

  console.log("window.isConnected offlineDetector before", window.isConnected);

  window.isConnected = false;

  console.log("window.isConnected offlineDetector after", window.isConnected);
}
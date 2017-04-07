window.api = {};
window.api.callBacks = {};

window.api.init = function () {

  var options = {dimBackground: true};
  SpinnerPlugin.activityStart(languages.ConnectionSocket, options, function () {
    alert("OK");
  }, function () {
    alert("Error");
  });

  window.api.socket = new WebSocket("wss://my.click.uz:8443");
  window.api.initSocket();
};

window.api.initSocket = function () {

  this.socket.onopen = function () {
    console.log('WebSocket is connected');
    var options = {dimBackground: true};
    SpinnerPlugin.activityStop();
  };
  this.socket.close = function (event) {
    console.log('Connection is closed');
    console.log(event);
  };
  var me = this;
  this.socket.onmessage = function (event) {
    var parsedData = JSON.parse(event.data);
    console.log(parsedData)
    if (parsedData.data[0][0].error == 0) {

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
    else {
      var result = confirm(parsedData.data[0][0].error_note)
      if (result) {
        riotTags.innerHTML = "<view-authorization>";
        riot.mount('view-authorization');
      }
      else {
        navigator.app.exitApp();
      }
      return
    }
    callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
  };
  this.socket.onerror = function (error) {
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
      onSuccess.call(scope, data);
    },
    err: function (api_status, api_status_message, data) {
      onFail.call(scope, api_status, api_status_message, data);
    }
  };


  this.socket.send(JSON.stringify({
    method: method,
    parameters: input
  }));
};



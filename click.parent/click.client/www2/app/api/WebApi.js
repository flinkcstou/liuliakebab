window.api = {};
window.api.callBacks = {};

window.api.init = function () {
  window.api.socket = new WebSocket("wss://api.click.uz:8443");
  window.api.initSocket();
};

window.api.initSocket = function () {
  this.socket.onopen = function () {
    console.log('WebSocket is connected');
  };
  this.socket.close = function (event) {
    console.log('Connection is closed');
    console.log(event);
  };
  var me = this;
  this.socket.onmessage = function (event) {
    var parsedData = JSON.parse(event.data);
    console.log(parsedData);

    var method = parsedData.data[0][0].method;

    var callBack = me.callBacks[method];
    me.callBacks[method] = null;

    if (parsedData.api_status == 0) {
      callBack.ok(parsedData.data);
      return;
    }

    callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
  };
  this.socket.onerror = function (error) {
    console.log('Error with socket ' + error.message);
  };
};


window.api.call = function (params) {
  var method = params.method;
  var input = params.input;
  var onSuccess = params.onSuccess;
  var onFail = params.onFail;
  var scope = params.scope || window;
  console.log("IT IS INPUT " ,input);
  this.callBacks[method] = {
    ok : function (data) {
      onSuccess.call(scope, data);
    },
    err: function (api_status, api_status_message, data) {
      onFail.call(scope, api_status, api_status_message, data);
    }
  };

  this.socket.send(JSON.stringify({
    method    : method,
    parameters: input
  }));
};



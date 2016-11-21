var socket = new WebSocket("wss://api.click.uz:8443");
callBacks = {}

socket.onopen = function () {
  console.log('WebSocket is connected');
};

socket.close = function (event) {
  console.log('Connection is closed');
  console.log(event);
};

socket.onmessage = function (event) {

  var parsedData = JSON.parse(event.data);
  console.log(parsedData);

  var method = parsedData.data[0][0].method;

  var callBack = this.callBacks[method];

  if (parsedData.api_status == 0) {
    callBack.ok(parsedData.data);
    return;
  }

  callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
};

socket.onerror = function (error) {
  console.log('Error with socket ' + error.message);
};


call = function (params) {
  var method = params.method;
  var input = params.input;
  console.log(params.input);
  var onSuccess = params.onSuccess;
  var onFail = params.onFail;
  var scope = params.scope || window;

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



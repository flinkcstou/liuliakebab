Ext.define('Click.store.Api', {

  statics: {

    create: function () {
      return Ext.create('Click.store.Api', {
        url: 'wss://api.click.uz:8443',
      });
    },

  },

  config: {
    url: null,
  },

  constructor: function (config) {
    this.initConfig(config);

    if (window.fakedSocket) {
      this.socket = window.fakedSocket.start();
    } else {
      return;
      this.socket = new WebSocket(this.getUrl());
    }

    var me = this;

    this.socket.onopen = function () {
      console.log("WebSocket opened")
    };
    this.socket.onclose = function (event) {
      console.log("WebSocket connection closed");
      console.log(event);
    };
    this.socket.onmessage = function (event) {
      me.onMessage(event.data);
    };
  },

  callBacks: {},

  call: function (params) {
    var method = params.method;
    var input = params.input;
    var onSuccess = params.onSuccess;
    var onFail = params.onFail;
    var scope = params.scope || window;

    this.callBacks[method] = {
      ok : function (data) {
        onSuccess.call(scope, data);
      },
      err: function (api_status, api_status_message, data) {
        onFail.call(scope, api_status, api_status_message, data);
      },
    };

    this.socket.send(JSON.stringify({
      method    : method,
      parameters: input,
    }));
  },

  onMessage: function (eventData) {
    var parsedData = JSON.parse(eventData);

    var method = parsedData.data[0][0].method;

    var callBack = this.callBacks[method];

    if (parsedData.api_status == 0) {
      callBack.ok(parsedData.data);
      return;
    }

    callBack.err(parsedData.api_status, parsedData.api_status_message, parsedData.data);
  },

});

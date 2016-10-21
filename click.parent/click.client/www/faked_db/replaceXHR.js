window.STAND = "STAND/";

window.service = function (ref) {
  return window.STAND + ref;
};

function param(val) {
  var result = null,
      tmp = [];
  location.search
      .substr(1)
      .split("&")
      .forEach(function (item) {
        tmp = item.split("=");
        if (tmp[0] === val) result = decodeURIComponent(tmp[1]);
      });
  return result;
}

//========================== FakeRequest ============================================

window.FakeRequest = function (method, fakedService) {
  this._method_ = method;
  this._fakedService_ = fakedService;

  this.readyState = 1;
};

FakeRequest.prototype.send = function (input) {
  this._input_ = input;
  var __me__ = this;
  window.setTimeout(function () {
    __me__._fakedService_.execute(__me__, __me__._method_, __me__._input_);
    __me__.readyState = 4;
    __me__.onreadystatechange.apply(window);
  }, this.getRequestTime());
};

FakeRequest.requestTimeIndex = 0;

FakeRequest.prototype.getRequestTime = function () {
  var requestTimes = window.FakeRequest.requestTimes;
  if (!requestTimes) {
    requestTimes = [];
    var t = param('t');
    if (t) t.split(',').forEach(function (item) {
      requestTimes.push(parseInt(item));
    });
    window.FakeRequest.requestTimes = requestTimes;
  }
  if (requestTimes.length == 0) return 0;
  return requestTimes[window.FakeRequest.requestTimeIndex++ % requestTimes.length];
};

FakeRequest.prototype.getAllResponseHeaders = function () {
  return "";
};

//========================== MyXmlHttpRequest ============================================

window.OriginalXmlHttpRequest = window.XMLHttpRequest;

window.MyXmlHttpRequest = function () {
  this.traceId = MyXmlHttpRequest.nextTraceId++;
  this.trace("new window.RealXmlHttpRequest()");
  this.__real__ = new window.OriginalXmlHttpRequest();
};
MyXmlHttpRequest.nextTraceId = 1;

window.XMLHttpRequest = window.MyXmlHttpRequest;

MyXmlHttpRequest.prototype.trace = function (message) {
  console.log("TRACE " + this.traceId + ' ' + message);
};

MyXmlHttpRequest.prototype.target = function () {
  if (this._fakeRequest_) return this._fakeRequest_;
  return this.__real__;
};

MyXmlHttpRequest.prototype.tryFakeRequest = function (method, url, async) {
  if (!async) return null;

  //noinspection JSUnresolvedFunction
  if (!url.startsWith(window.STAND)) return null;

  var location = url.substring(window.STAND.length);

  {
    var index = location.indexOf('?');
    if (index > -1) {
      location = location.substring(0, index);
    }
  }

  var fakedService = window.faked.get(location);

  if (!fakedService) return null;

  return new FakeRequest(method, fakedService);
};

//--------------- overridden methods --------------------

MyXmlHttpRequest.prototype.open = function () {
  var method = arguments[0];
  var url = arguments[1];
  var async = arguments[2];

  this._fakeRequest_ = this.tryFakeRequest(method, url, async);
  if (this._fakeRequest_) {
    this.trace("faked call open method = " + method + ", url = " + url + " -- " + async);
    return;
  }

  this.trace("call open method = " + method + ", url = " + url + " -- " + async);
  this.target().open.apply(this.target(), arguments);
};
MyXmlHttpRequest.prototype.send = function () {
  this.trace("call send(" + arguments[0] + ")");
  return this.target().send.apply(this.target(), arguments);
};

MyXmlHttpRequest.prototype.getAllResponseHeaders = function () {
  this.trace("call getAllResponseHeaders");
  return this.target().getAllResponseHeaders.apply(this.target(), arguments);
};

MyXmlHttpRequest.prototype.abort = function () {
  this.trace("call abort");
  return this.target().abort.apply(this.target(), arguments);
};

//--------------- overridden properties --------------------

MyXmlHttpRequest.prototype.__defineGetter__("onreadystatechange", function () {
  this.trace("get onreadystatechange");
  return this.target().onreadystatechange;
});
MyXmlHttpRequest.prototype.__defineSetter__("onreadystatechange", function (value) {
  this.trace("set onreadystatechange");
  return this.target().onreadystatechange = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("onprogress", function () {
  this.trace("get onprogress");
  return this.target().onprogress;
});
MyXmlHttpRequest.prototype.__defineSetter__("onprogress", function (value) {
  this.trace("set onprogress");
  return this.target().onprogress = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("onerror", function () {
  this.trace("get onerror");
  return this.target().onerror;
});
MyXmlHttpRequest.prototype.__defineSetter__("onerror", function (value) {
  this.trace("set onerror");
  return this.target().onerror = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("onabort", function () {
  this.trace("get onabort");
  return this.target().onabort;
});
MyXmlHttpRequest.prototype.__defineSetter__("onabort", function (value) {
  this.trace("set onabort");
  return this.target().onabort = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("onload", function () {
  this.trace("get onload");
  return this.target().onload;
});
MyXmlHttpRequest.prototype.__defineSetter__("onload", function (value) {
  this.trace("set onload");
  return this.target().onload = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("onloadend", function () {
  this.trace("get onloadend");
  return this.target().onloadend;
});
MyXmlHttpRequest.prototype.__defineSetter__("onloadend", function (value) {
  this.trace("set onloadend");
  return this.target().onloadend = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("onloadstart", function () {
  this.trace("get onloadstart");
  return this.target().onloadstart;
});
MyXmlHttpRequest.prototype.__defineSetter__("onloadstart", function (value) {
  this.trace("set onloadstart");
  return this.target().onloadstart = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("ontimeout", function () {
  this.trace("get ontimeout");
  return this.target().ontimeout;
});
MyXmlHttpRequest.prototype.__defineSetter__("ontimeout", function (value) {
  this.trace("set ontimeout");
  return this.target().ontimeout = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("readyState", function () {
  var readyState = this.target().readyState;
  this.trace("get readyState " + readyState);
  return readyState;
});
MyXmlHttpRequest.prototype.__defineSetter__("readyState", function (value) {
  this.trace("set readyState");
  return this.target().readyState = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("response", function () {
  this.trace("get response");
  return this.target().response;
});
MyXmlHttpRequest.prototype.__defineSetter__("response", function (value) {
  this.trace("set response");
  return this.target().response = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("responseText", function () {
  this.trace("get responseText");
  return this.target().responseText;
});
MyXmlHttpRequest.prototype.__defineSetter__("responseText", function (value) {
  this.trace("set responseText");
  return this.target().responseText = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("responseType", function () {
  var responseType = this.target().responseType;
  this.trace("get responseType = " + responseType);
  return responseType;
});
MyXmlHttpRequest.prototype.__defineSetter__("responseType", function (value) {
  this.trace("set responseType");
  return this.target().responseType = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("responseURL", function () {
  this.trace("get responseURL");
  return this.target().responseURL;
});
MyXmlHttpRequest.prototype.__defineSetter__("responseURL", function (value) {
  this.trace("set responseURL");
  return this.target().responseURL = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("responseXML", function () {
  this.trace("get responseXML");
  return this.target().responseXML;
});
MyXmlHttpRequest.prototype.__defineSetter__("responseXML", function (value) {
  this.trace("set responseXML");
  return this.target().responseXML = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("status", function () {
  var status = this.target().status;
  this.trace("get status = " + status);
  return status;
});
MyXmlHttpRequest.prototype.__defineSetter__("status", function (value) {
  this.trace("set status");
  return this.target().status = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("statusText", function () {
  var statusText = this.target().statusText;
  this.trace("get statusText = " + statusText);
  return statusText;
});
MyXmlHttpRequest.prototype.__defineSetter__("statusText", function (value) {
  this.trace("set statusText");
  return this.target().statusText = value;
});

MyXmlHttpRequest.prototype.__defineGetter__("timeout", function () {
  this.trace("get timeout");
  return this.target().timeout;
});
MyXmlHttpRequest.prototype.__defineSetter__("timeout", function (value) {
  this.trace("set timeout");
  return this.target().timeout = value;
});

//========================== FakeServiceManager ============================================

window.FakeServiceManager = function () {
  this.registeredServices = {};
};

FakeServiceManager.prototype.register = function (uri, responseConvertType, executeFunction) {
  var service = this.registeredServices[uri];
  if (service) throw new Error("Already registered, faked service " + uri);

  this.registeredServices[uri] = new FakeServiceManager.Service(uri, responseConvertType, executeFunction);
};

FakeServiceManager.prototype.get = function (uri) {
  return this.registeredServices[uri];
};

window.faked = new window.FakeServiceManager();

//========================== FakeServiceManager.Service ============================================

FakeServiceManager.Service = function (uri, responseConvertType, executeFunction) {
  this.uri = uri;
  this.responseConvertType = responseConvertType;
  this.executeFunction = executeFunction;
  this.checkFields();
};
FakeServiceManager.Service.prototype.checkFields = function () {
  if (typeof this.uri !== 'string') throw new Error("uri must be string");
  this.checkResponseConvertType();
  if (typeof this.executeFunction !== 'function') throw new Error("executeFunction must be function");
};
FakeServiceManager.Service.prototype.checkResponseConvertType = function () {
  if (this.responseConvertType === 'json') return;
  throw new Error("Unknown value of this.responseConvertType == " + this.responseConvertType);
};
FakeServiceManager.Service.prototype.execute = function (resultTarget, method, input) {
  var result;

  try {
    result = this.executeFunction(method, input);
  } catch (e) {
    console.error(e.stack);
    return;
  }

  if (this.responseConvertType === 'json') {
    resultTarget.response = result;
    resultTarget.responseText = JSON.stringify(result);
    resultTarget.responseType = "json";
    resultTarget.status = 200;
    return;
  }

  throw new Error("Unknown responseConvertType === " + this.responseConvertType);
};

window.parseToMap = function (params) {
  var ret = {};
  params.split('&').forEach(function (item) {
    var index = item.indexOf('=');
    if (index < 0) {
      ret[item] = null;
    } else {
      ret[item.substring(0, index)] = decodeURIComponent(item.substring(index + 1));
    }
  });
  return ret;
};
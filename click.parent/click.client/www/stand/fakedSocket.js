window.fakedSocket = {
    callbacks: {}
};

window.fakedSocket.start = function () {

    setTimeout(function () {
        if (window.fakedSocket.onopen) {
            window.fakedSocket.onopen();
            console.log("Faked socket opened");
        }
    }, 0);

    return window.fakedSocket;
};

window.fakedSocket.register = function (method, callback) {
    window.fakedSocket.callbacks[method] = callback;
    //console.log()
};

window.fakedSocket.send = function (message) {
    //console.log(message);
    var parsedMessage = JSON.parse(message);


    var method = parsedMessage.method;

    var callback = window.fakedSocket.callbacks[method];

    if (!callback) throw new Error("No registered callback for method = " + method);

    setTimeout(function () {
        var retData;
        var arrayOfAnswer = [];
        try {
            var result = callback(parsedMessage);
            //console.log('result ', result)
            for (var i = 0; i < result.length; i++) {
                arrayOfAnswer.push(result[i]);
            }
            retData = {
                api_status: 0,
                api_status_message: 'ok',

                data:arrayOfAnswer,
            };
            //console.log('result of fake API', retData)
            //Chtobi dobavlyali dinamichno vse objecti
            //for (var i = 1; i < result.length; i++)
            //    retData.data.push(result[i]);


        } catch (e) {
            retData = {
                api_status: 1,
                api_status_message: 'error',

                data: [
                    [{method: method, success: 1, error: 0, error_note: ''}],
                    [e]
                ],
            };
        }

        if (window.fakedSocket.onmessage) {
            window.fakedSocket.onmessage({data: JSON.stringify(retData)});
            //console.log(retData);
        }
        else console.error("No onMessage")
    }, window.fakedSocket.getCallbackTimeout());
};

window.fakedSocket.param = function (val) {
    var result = null,
        tmp = [];
    location.search
        .substr(1)
        .split("&")
        .forEach(function (item) {
            tmp = item.split("=");
            if (tmp[0] === val) result = decodeURIComponent(tmp[1]);
        });
    //console.log("RESULT ", result);
    return result;
};

window.fakedSocket.getCallbackTimeout = function () {
    var callbackTimeoutArray = window.fakedSocket.callbackTimeoutArray;
    if (!callbackTimeoutArray) {
        window.fakedSocket.callbackTimeoutArray = window.fakedSocket.calculateCallbackTimeoutArray();
        callbackTimeoutArray = window.fakedSocket.callbackTimeoutArray;
        window.fakedSocket.callbackTimeoutArrayIndex = 0;
    }
    var index = window.fakedSocket.callbackTimeoutArrayIndex + 1;
    if (index >= callbackTimeoutArray.length) {
        index = 0;
    }
    window.fakedSocket.callbackTimeoutArrayIndex = index;
    return callbackTimeoutArray[index];
};

window.fakedSocket.calculateCallbackTimeoutArray = function () {

    var ret = [];
    var t = window.fakedSocket.param('t');
    if (t) t.split(',').forEach(function (item) {
        ret.push(parseInt(item));
    });
    if (ret.length > 0) return ret;
    return [0];
};

window.api.init = function () {
    window.api.socket = window.fakedSocket.start();
    window.api.initSocket();
};

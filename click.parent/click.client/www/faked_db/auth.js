window.faked.register('auth/sendSmsToCheckPhone', 'json', function (method, params) {
  var paramsMap = parseToMap(params);

  console.log(paramsMap);
  var phone = paramsMap.phone;
  console.log("Sending sms with code to " + phone);

  if (phone === '22222222222') throw new Error('asd');
});

window.faked.register('auth/checkSmsCode', 'json', function (method, params) {
  params = parseToMap(params);

  var smsCode = params.smsCode;
  console.log("Checking sms code = " + smsCode);

  if ("1111" == smsCode) return {success: true};

  return {success: false};
});

window.faked.register('auth/login', 'json', function (method, params) {
  params = parseToMap(params);

  var name = params.name;
  var password = params.password;

  if ("111" !== password) return {
    success: false,
    message: 'Use password 111',
  };

  if ("asd" !== name) return {
    success: false,
    message: 'Use name asd',
  };

  return {success: true};
});


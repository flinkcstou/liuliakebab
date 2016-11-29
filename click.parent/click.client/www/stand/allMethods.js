window.fakedSocket.register("device.register.request", function (input) {
  console.log("Input of REGISTER REQUEST ", input);
  return {
    "confirm_needed": true,
    "device_id"     : "9989094641336AC091D93CD5E",
    "language"      : "UZ"
  };
});

window.fakedSocket.register("device.register.confirm", function (input) {
  console.log("SMS_CODE ", input.parameters.sms_code);
  if (input.parameters.sms_code == '12345')
    return {
      "method"    : "device.register.confirm",
      "success"   : 1,
      "error"     : 0,
      "error_note": ""
    };
  return {
    "method"    : "device.register.confirm",
    "success"   : 1,
    "error"     : -4,
    "error_note": 'Neverniy sms'
  };
});

window.fakedSocket.register("sms.resend", function (input) {
  return {
    "method"    : "device.register.confirm",
    "success"   : 1,
    "error"     : 0,
    "error_note": "sms pereotpravleno"
  };
});

window.fakedSocket.register("app.login", function (input) {
  if (localStorage.getItem("pinForStand") != "11111") {
    return {
      "method"    : "app.login",
      "success"   : 1,
      "error"     : -4,
      "error_note": 'Neverniy PIN CODE'
    };
  }
  else
    return {
      "session_key"      : "987654321",
      "language"         : "UZ",
      "default_account"  : "123456789",
      "visibility"       : "",
      "help_status"      : "",
      "firstname"        : "test",
      "lastname"         : "testov",
      "gender"           : "male",
      "profile_image_url": "",
      "update_categories": "",
      "update_services"  : "",
      "update_faq"       : "",
      "update_terms"     : "",
      "p2p_comission"    : ""
    };
});

window.fakedSocket.register("get.accounts", function (input) {
  if (localStorage.getItem("click_client_token"))
    return {
      "accno"           : "",
      "description"     : "",
      "branch"          : "",
      "bank_name"       : "",
      "currency"        : "",
      "currency_code"   : "",
      "currency_name"   : "",
      "acc_abs"         : "",
      "access"          : "",
      "short_name"      : "",
      "card_num"        : "",
      "expire_date"     : "",
      "image_url"       : "",
      "card_num_crypted": "",
      "card_num_hash"   : "",
      "ls_uzcard"       : ""
    };
  return {"method": "app.login", "success": 1, "error": -4, "error_note": 'Dostup zapreshen'};
});

window.fakedSocket.register("get.balance", function (input) {
  if (localStorage.getItem("click_client_token"))
    return {"balance": 6000};
  return {"method": "app.login", "success": 1, "error": -4, "error_note": 'Nevozmozhno poluchit balans zapreshen'};
});

window.fakedSocket.register("get.payments.by.account", function (input) {
  if (localStorage.getItem("click_client_token"))
    return {
      "payment_id"       : '123124213',
      "amount"           : '',
      "cntrg_info_param2": '',
      "cntrg_info_param3": '',
      "cntrg_info_param4": '',
      "cntrg_info_param5": '',
      "status_note"      : '',
      "state"            : '',
      "paydoc_state"     : '',
      "service_name"     : '',
      "created"          : '',
      "created_timestamp": '',
      "abs_type"         : '',
      "description"      : '',
      "account_id"       : '',
      "service_id"       : '',
      "is_invoice"       : '',
      "comission_amount" : ''
    };
  return {"method": "app.login", "success": 1, "error": -4, "error_note": 'Nevozmozhno poluchit balans zapreshen'};
});

window.fakedSocket.register("registration", function (input) {
  return {
    "method"    : 'registration',
    "error"     : 0,
    "error_note": '',
    "success"   : 1
  }
});

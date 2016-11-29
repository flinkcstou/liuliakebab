window.fakedSocket.register("device.register.request", function (input) {
  console.log("Input of REGISTER REQUEST ", input);
  return {"confirm_needed": true, "device_id": "9989094641336AC091D93CD5E", "language": "UZ"};
});

window.fakedSocket.register("device.register.confirm", function (input) {
  console.log("SMS_CODE ", input.parameters.sms_code);
  if (input.parameters.sms_code == '12345')
    return {"method": "device.register.confirm", "success": 1, "error": 0, "error_note": ""};
  return {"method": "device.register.confirm", "success": 1, "error": -4, "error_note": 'Neverniy sms'};
});

window.fakedSocket.register("sms.resend", function (input) {
  return {"method": "device.register.confirm", "success": 1, "error": 0, "error_note": "sms pereotpravleno"};
});

window.fakedSocket.register("app.login", function (input) {
  if (localStorage.getItem("pinForStand") != "11111") {
    return {"method": "app.login", "success": 1, "error": -4, "error_note": 'Neverniy PIN CODE'};
  }
  else
    return {"method": "device.register.confirm", "success": 1, "error": 0, "error_note": "",
      "session_key"    : "987654321", "language": "UZ", "default_account": "123456789",
      "visibility"     : "", "help_status": "", "firstname": "test", "lastname": "testov",
      "gender"         : "male", "profile_image_url": "", "update_categories": "",
      "update_services": "", "update_faq": "", "update_terms": "", "p2p_comission": ""
    };
});

window.fakedSocket.register("get.accounts", function (input) {
  if(localStorage.getItem("token"))
  return {
    "accno"        : "", "description": "", "branch": "",
    "bank_name"    : "", "currency": "", "currency_code": "", "currency_name": "",
    "acc_abs"      : "", "access": "", "short_name": "",
    "card_num"     : "", "expire_date": "", "image_url": "", "card_num_crypted": "",
    "card_num_hash": "", "ls_uzcard": ""
  };
  return {"method": "app.login", "success": 1, "error": -4, "error_note": 'Dostup zapreshen'};
});

window.fakedSocket.register("get.balance", function (input) {
  if(localStorage.getItem("token"))
  return {"method": "device.register.confirm", "success": 1, "error": 0, "error_note": "", "balance": 6000};
  return {"method": "app.login", "success": 1, "error": -4, "error_note": 'Nevozmozhno poluchit balans zapreshen'};
});

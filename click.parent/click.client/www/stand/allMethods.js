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
      "session_key"      : "99890988081996E4e71383c9ed9b1a3fb05fb0002499744",
      "language"         : "RU",
      "default_account"  : "3487271",
      "visibility"       : false,
      "help_status"      : false,
      "firstname"        : "Test",
      "lastname"         : "Testov",
      "gender"           : "F",
      "profile_image_url": null,
      "update_categories": false,
      "update_services"  : true,
      "update_faq"       : false,
      "update_terms"     : true,
      "p2p_comission"    : 2
    };
});

window.fakedSocket.register("get.accounts", function (input) {
  if (localStorage.getItem("click_client_token"))
    return {
      "accno"           : "",
      "description"     : "Карта UZCARD-Online",
      "branch"          : "00000",
      "bank_name"       : "UZCARD",
      "currency"        : "000",
      "currency_code"   : "UZS",
      "currency_name"   : "Сум (для междунар.расчетов код 860)",
      "acc_abs"         : "SMARTV",
      "access"          : 2,
      "short_name"      : null,
      "card_num"        : "8600***5865",
      "expire_date"     : "1806",
      "image_url"       : "https://merchant.click.uz/static/merchant/bank/aloq.png",
      "card_num_crypted": "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw= ",
      "card_num_hash"   : "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      "ls_uzcard"       : 1
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

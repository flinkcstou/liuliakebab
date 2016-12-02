window.fakedSocket.register("device.register.request", function (input) {
  console.log("Input of REGISTER REQUEST ", input);

  return [
    {"method": input.method, "success": 1, "error": 0, "error_note": ""},
    {
      "confirm_needed": true,
      "device_id"     : "9989094641336AC091D93CD5E",
      "language"      : "UZ"
    }
  ];
});

window.fakedSocket.register("device.register.confirm", function (input) {

  console.log("SMS_CODE ", input.parameters.sms_code);
  if (input.parameters.sms_code == '12345')
    return [
      {
        "method"    : input.method,
        "success"   : 1,
        "error"     : 0,
        "error_note": ""
      }
    ];
  return [
    {
      "method"    : input.method,
      "success"   : 1,
      "error"     : -4,
      "error_note": 'Neverniy sms'
    }
  ];
});

window.fakedSocket.register("sms.resend", function (input) {
  return [
    {
      "method"    : input.method,
      "success"   : 1,
      "error"     : 0,
      "error_note": "sms pereotpravleno"
    }
  ];
});

window.fakedSocket.register("app.login", function (input) {

  if (localStorage.getItem("pinForStand") != "11111")
    return [
      {
        "method"    : input.method,
        "success"   : 1,
        "error"     : -4,
        "error_note": 'Neverniy PIN CODE'
      }
    ];

  return [
    {"method": input.method, "success": 1, "error": 0, "error_note": ""},
    {
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
    }];
});

window.fakedSocket.register("get.accounts", function (input) {

  var array = [];
  array.push({method: input.method, success: 1, error: 0, error_note: ""});
  array.push({
      accno           : "",
      description     : "Карта UZCARD-Online",
      branch          : "00000",
      bank_name       : "UZCARD",
      currency        : "000",
      currency_code   : "UZS",
      currency_name   : "Сум (для междунар.расчетов код 860)",
      acc_abs         : "SMARTV",
      access          : 2,
      short_name      : null,
      card_num        : "8600***5865",
      expire_date     : "1806",
      image_url       : "https://merchant.click.uz/static/merchant/bank/aloq.png",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw= ",
      card_num_hash   : "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      ls_uzcard       : 1
    },
    {
      accno           : "",
      description     : "Онлайн карта Сбербанка",
      branch          : "00000",
      bank_name       : "Сбербанк",
      currency        : "000",
      currency_code   : "RUB",
      currency_name   : "Руб (для междунар.расчетов код 860)",
      acc_abs         : "SMARTV",
      access          : 2,
      short_name      : null,
      card_num        : "2631***7777",
      expire_date     : "1906",
      image_url       : "https://merchant.click.uz/static/merchant/bank/aloq.png",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw= ",
      card_num_hash   : "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      ls_uzcard       : 1
    },
    {
      accno           : "",
      description     : "Онлайн карта KAZKOM",
      branch          : "00000",
      bank_name       : "KAZKOM",
      currency        : "000",
      currency_code   : "TNG",
      currency_name   : "тенге (для междунар.расчетов код 860)",
      acc_abs         : "SMARTV",
      access          : 2,
      short_name      : null,
      card_num        : "8888***1111",
      expire_date     : "2006",
      image_url       : "https://merchant.click.uz/static/merchant/bank/aloq.png",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw= ",
      card_num_hash   : "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      ls_uzcard       : 1
    });

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("get.balance", function (input) {

  if (localStorage.getItem("click_client_token"))
    return [
      {"method": input.method, "success": 1, "error": 0, "error_note": ""},
      {
        "balance": 6000
      }
    ];
  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Nevozmozhno poluchit balans zapreshen'}];
});

window.fakedSocket.register("get.payments.by.account", function (input) {

  if (localStorage.getItem("click_client_token"))
    return [
      {"method": input.method, "success": 1, "error": 0, "error_note": ""},
      [{
        "payment_id"       : 277019456,
        "amount"           : 1000,
        "cntrg_info_param2": "974647747",
        "cntrg_info_param3": null,
        "cntrg_info_param4": null,
        "cntrg_info_param5": null,
        "status_note"      : "Успешно проведен",
        "state"            : 0,
        "paydoc_state"     : 2,
        "service_name"     : "UMS (97 4647747)",
        "created"          : "2016-11-30T13:26:01.596Z",
        "created_timestamp": 1480512361,
        "abs_type"         : "SMARTV    ",
        "description"      : '',
        "account_id"       : 3487271,
        "service_id"       : 2,
        "is_invoice"       : 0,
        "comission_amount" : 0
      },
        {
          "payment_id"       : 123456789,
          "amount"           : 1580,
          "cntrg_info_param2": "974647747",
          "cntrg_info_param3": null,
          "cntrg_info_param4": null,
          "cntrg_info_param5": null,
          "status_note"      : "Успешно проведен",
          "state"            : 0,
          "paydoc_state"     : 2,
          "service_name"     : "UMS (97 4647747)",
          "created"          : "2016-11-30T13:26:01.596Z",
          "created_timestamp": 1480512361,
          "abs_type"         : "SMARTV    ",
          "description"      : '',
          "account_id"       : 2484171,
          "service_id"       : 2,
          "is_invoice"       : 0,
          "comission_amount" : 0
        }]
    ];
  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'error '}];
});

window.fakedSocket.register("registration", function (input) {

  return [{
    "method"    : input.method,
    "error"     : 0,
    "error_note": '',
    "success"   : 1
  }]
});

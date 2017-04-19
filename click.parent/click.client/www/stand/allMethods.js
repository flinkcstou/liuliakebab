window.fakedSocket.register("registration", function (input) {
  window.standCheckRegistration = true;

  return [[{"method": input.method, "success": 1, "error": 0, "error_note": ""}]];
});

window.fakedSocket.register("device.register.request", function (input) {


  return [
    [{"method": input.method, "success": 1, "error": 0, "error_note": ""}],
    [{
      "confirm_needed": true,
      "device_id": "9989094641336AC091D93CD5E",
      "language": "UZ"
    }]
  ];
});

window.fakedSocket.register("device.register.confirm", function (input) {

  if (input.parameters.sms_code == '12345') {
    if (!window.standCheckRegistration)
      return [
        [{
          "client_exists": 0,
          "method": input.method,
          "success": 1,
          "error": 0,
          "error_note": ""
        }]
      ];
    else
      return [
        [{
          "client_exists": 1,
          "method": input.method,
          "success": 1,
          "error": 0,
          "error_note": ""
        }]
      ];
  }
  else
    return [
      {
        "method": input.method,
        "success": 1,
        "error": -4,
        "error_note": 'Neverniy sms'
      }
    ];
});

window.fakedSocket.register("sms.resend", function (input) {
  return [
    {
      "method": input.method,
      "success": 1,
      "error": 0,
      "error_note": "sms pereotpravleno"
    }
  ];
});

window.fakedSocket.register("app.login", function (input) {

  if (localStorage.getItem("pinForStand") != "11111")
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": -31,
        "error_note": 'Neverniy PIN CODE'
      }]
    ];

  return [
    [{"method": input.method, "success": 1, "error": 0, "error_note": ""}],
    [{
      "session_key": "99890988081996E4e71383c9ed9b1a3fb05fb0002499744",
      "language": "RU",
      "default_account": "3487271",
      "my_service_id": "3",
      "visibility": false,
      "help_status": false,
      "firstname": "Test",
      "lastname": "Testov",
      "gender": "F",
      "profile_image_url": null,
      "update_categories": false,
      "update_services": true,
      "update_faq": false,
      "update_terms": true,
      "p2p_comission": 2
    }]];
});

window.fakedSocket.register("get.accounts", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([
    {
      acc_abs: "DUET    ",
      access: 2,
      accno: "1234 **** **** 5678",
      background_url: "https://my.click.uz/static/content/app/card/aab.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "1234 **** **** 5678",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      background_color_bottom: "255,141,101",
      background_color_top: "192,62,108",
      font_color: "255,255,255",
      card_background_url: 'https://merchant.click.uz/static/content/app/card/1.png',
      currency_code: "UZS",
      currency_name: "тенге                                               ",
      description: "Карта KAZKOM-Online Kazakhstan Halyk Bank Group",
      expire_date: "1806",
      id: 2484171,
      image_url: "https://my.click.uz/static/content/app/bank/aab.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    },
    {
      acc_abs: "SMARTV    ",
      access: 2,
      accno: "8600 **** **** 5865",
      background_url: "https://my.click.uz/static/content/app/card/aab.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "2300 **** **** 1111",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      background_color_bottom: "255,33,101",
      background_color_top: "6,62,12",
      font_color: "255,255,255",
      card_background_url: 'https://my.click.uz/static/content/app/card/aab.png',
      currency_code: "UZS",
      currency_name: "сум                                               ",
      description: "СБЕРБАНК",
      expire_date: "1806",
      id: 7487271,
      image_url: "https://my.click.uz/static/content/app/bank/aab.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    },

    {
      acc_abs: "SMARTV    ",
      access: 1,
      accno: "8600 **** **** 5865",
      background_url: "https://my.click.uz/static/content/app/card/aab.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "8600 **** **** 5865",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      currency_code: "UZS",
      background_color_bottom: "12,141,44",
      background_color_top: "3,55,22",
      font_color: "255,255,255",
      card_background_url: 'https://my.click.uz/static/content/app/card/aab.png',
      currency_name: "сум                                               ",
      description: "Карта UZCARD-Online",
      expire_date: "1806",
      id: 3487271,
      image_url: "https://my.click.uz/static/content/app/bank/aab.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    },

    {
      acc_abs: "SMARTV    ",
      access: 2,
      accno: "3333 **** **** 2222",
      background_url: "https://my.click.uz/static/content/app/card/aab.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "3333 **** **** 2222",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      background_color_bottom: "155,141,22",
      background_color_top: "192,33,4",
      font_color: "255,255,255",
      card_background_url: 'https://my.click.uz/static/content/app/card/aab.png',
      currency_code: "UZS",
      currency_name: "сум                                               ",
      description: "СБЕРБАНК",
      expire_date: "1806",
      id: 1287271,
      image_url: "https://my.click.uz/static/content/app/card/aab.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    },

    {
      acc_abs: "SMARTV    ",
      access: 2,
      accno: "8600 **** **** 5865",
      background_url: "https://my.click.uz/static/content/app/card/aab.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "8600 **** **** 5865",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      background_color_bottom: "132,141,101",
      background_color_top: "4,62,23",
      font_color: "255,255,255",
      card_background_url: 'https://my.click.uz/static/content/app/card/aab.png',
      currency_code: "UZS",
      currency_name: "сум                                               ",
      description: "Карта UZCARD-Online",
      expire_date: "1806",
      id: 5487271,
      image_url: "https://my.click.uz/static/content/app/card/aab.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    }
  ]);

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("get.balance", function (input) {

  if (localStorage.getItem("click_client_token")) {

    if (input.parameters.account_id == 3487271) {
      return [
        [{"method": 'get.balance', "success": 1, "error": 0, "error_note": ""}],
        [{
          "account_id": input.parameters.account_id,
          "balance": 6000
        }]
      ];
    }

    if (input.parameters.account_id == 1287271) {
      return [
        [{"method": 'get.balance', "success": 1, "error": 0, "error_note": ""}],
        [{
          "account_id": input.parameters.account_id,
          "balance": 433552122
        }]
      ];
    }

    if (input.parameters.account_id == 2484171) {
      return [
        [{"method": 'get.balance', "success": 1, "error": 0, "error_note": ""}],
        [{
          "account_id": input.parameters.account_id,
          "balance": 123432110
        }]
      ];
    }

    if (input.parameters.account_id == 5487271) {
      return [
        [{"method": 'get.balance', "success": 1, "error": 0, "error_note": ""}],
        [{
          "account_id": input.parameters.account_id,
          "balance": 0
        }]
      ];
    }

    if (input.parameters.account_id == 7487271) {
      return [
        [{"method": 'get.balance', "success": 1, "error": 0, "error_note": ""}],
        [{
          "account_id": input.parameters.account_id,
          "balance": 52300
        }]
      ];
    }
  }
  else
    return [{
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'Nevozmozhno poluchit balans zapreshen'
    }];
});

window.fakedSocket.register("get.payments.by.account", function (input) {


  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([{
    "payment_id": 277019456,
    "amount": 22543,
    "cntrg_info_param2": "974647747",
    "cntrg_info_param3": null,
    "cntrg_info_param4": null,
    "cntrg_info_param5": null,
    "status_note": "Успешно проведен",
    "state": 0,
    "paydoc_state": 2,
    image: "https://m.click.uz/static/merchant/logo/logo_2.png",
    "service_name": "UMS (97 4647747)",
    "created": "2016-11-30T12:56:01.596Z",
    "created_timestamp": 1480512361,
    "abs_type": "SMARTV    ",
    "description": '',
    "account_id": 3487271,
    "service_id": 2,
    "is_invoice": 0,
    "comission_amount": 0
  },
    {
      "payment_id": 277019456,
      "amount": 345,
      "cntrg_info_param2": "111111111",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T13:26:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 3487271,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    },
    {
      "payment_id": 277019456,
      "amount": 345655,
      "cntrg_info_param2": "222222222",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T13:26:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 3487271,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    },
    {
      "payment_id": 123456789,
      "amount": 1580,
      "cntrg_info_param2": "974647747",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T14:20:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 2484171,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    },
    {
      "payment_id": 123456789,
      "amount": 3456556,
      "cntrg_info_param2": "974647747",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T13:26:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 5487271,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    }]);
  if (localStorage.getItem("click_client_token"))
    return array;

  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'error '}];
});

window.fakedSocket.register("get.payment.list", function (input) {


  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([{
    "payment_id": 277019456,
    "amount": '22543AAA ',
    "cntrg_info_param2": "974647747",
    "cntrg_info_param3": null,
    "cntrg_info_param4": null,
    "cntrg_info_param5": null,
    "status_note": "Успешно проведен",
    "state": 0,
    image: "https://m.click.uz/static/merchant/logo/logo_2.png",
    "paydoc_state": 2,
    "service_name": "UMS (97 4647747)",
    "created": "2016-11-30T12:56:01.596Z",
    "created_timestamp": 1480512361,
    "abs_type": "SMARTV    ",
    "description": '',
    "account_id": 3487271,
    "service_id": 2,
    "is_invoice": 0,
    "comission_amount": 0
  },
    {
      "payment_id": 277019456,
      "amount": 345,
      "cntrg_info_param2": "111111111",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      image: "https://m.click.uz/static/merchant/logo/logo_2.png",
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T13:26:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 3487271,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    },
    {
      "payment_id": 277019456,
      "amount": 345655,
      "cntrg_info_param2": "222222222",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      image: "https://m.click.uz/static/merchant/logo/logo_2.png",
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T13:26:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 3487271,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    },
    {
      "payment_id": 123456789,
      "amount": 1580,
      "cntrg_info_param2": "974647747",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      image: "https://m.click.uz/static/merchant/logo/logo_2.png",
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T14:20:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 2484171,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    },
    {
      "payment_id": 123456789,
      "amount": 3456556,
      "cntrg_info_param2": "974647747",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
      image: "https://m.click.uz/static/merchant/logo/logo_2.png",
      "paydoc_state": 2,
      "service_name": "UMS (97 4647747)",
      "created": "2016-11-30T13:26:01.596Z",
      "created_timestamp": 1480512361,
      "abs_type": "SMARTV    ",
      "description": '',
      "account_id": 5487271,
      "service_id": 2,
      "is_invoice": 0,
      "comission_amount": 0
    }]);
  if (localStorage.getItem("click_client_token"))
    return array;

  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'error '}];
});


window.fakedSocket.register("get.service.category.list", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([{
      color_hex: "#e7b949",
      color_rgb: "231-185-73",
      icon: "https://my.click.uz/static/content/app/categories/1.png",
      id: 1,
      name: "Мобильные операторы",
      parent: 0,
      priority: 0,
      status: true
    },
      {
        color_hex: "#87c965",
        color_rgb: "135-201-101",
        icon: "https://my.click.uz/static/content/app/categories/2.png",
        id: 2,
        name: "Интернет провайдеры",
        parent: 0,
        priority: 10,
        status: true
      },
      {
        color_hex: "#e45e55",
        color_rgb: "228-94-85",
        icon: "https://my.click.uz/static/content/app/categories/6.png",
        id: 6,
        name: "Интернет сервисы",
        parent: 0,
        priority: 20,
        status: true
      },
      {
        color_hex: "#77acde",
        color_rgb: "119-172-222",
        icon: "https://my.click.uz/static/content/app/categories/8.png",
        id: 8,
        name: "Коммунальные платежи",
        parent: 0,
        priority: 35,
        status: true
      },
      {
        color_hex: "#6e9a8f",
        color_rgb: "110-154-143",
        icon: "https://my.click.uz/static/content/app/categories/10.png",
        id: 10,
        name: "Налоги",
        parent: 0,
        priority: 36,
        status: true
      },
      {
        color_hex: "#be2e1f",
        color_rgb: "190-46-31",
        icon: "https://my.click.uz/static/content/app/categories/11.png",
        id: 11,
        name: "Интернет пакеты",
        parent: 0,
        priority: 3,
        status: true
      },
      {
        color_hex: "#ee9344",
        color_rgb: "238-147-68",
        icon: "https://my.click.uz/static/content/app/categories/7.png",
        id: 7,
        name: "Телефония",
        parent: 0,
        priority: 5,
        status: true
      },
      {
        color_hex: "#52a450",
        color_rgb: "82-164-80",
        icon: "https://my.click.uz/static/content/app/categories/3.png",
        id: 3,
        name: "Телевидение",
        parent: 0,
        priority: 15,
        status: true
      },
      {
        color_hex: "#f3aab5",
        color_rgb: "243-170-181",
        icon: "https://my.click.uz/static/content/app/categories/5.png",
        id: 5,
        name: "Хостинг и домены",
        parent: 0,
        priority: 25,
        status: true
      }
    ]
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("get.service.list", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([

      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 6,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 12,
        image: "https://m.click.uz/static/merchant/logo/logo_12.png",
        is_communal: 0,
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 500000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 500000,
        min_pay_limit: 1000,
        name: "OLX.UZ",
        priority: 0,
        service_parameters: "4",
        service_short_name: "OLX.UZ",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 3,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 28,
        image: "https://m.click.uz/static/merchant/logo/logo_28.png",
        is_communal: 0,
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "UZDIGITAL TV",
        priority: 0,
        service_parameters: "4",
        service_short_name: "UZDTV",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 8,
        cost: 1,
        form_type: 3,
        is_visible: 1,
        id: 39,
        image: "https://m.click.uz/static/merchant/logo/logo_39.png",
        is_communal: 1,
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Mahsustrans",
        priority: 0,
        service_parameters: "16",
        service_short_name: "MAXSUSTRANS",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 5,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 45,
        image: "https://m.click.uz/static/merchant/logo/logo_45.png",
        is_communal: 0,
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Regname.uz",
        priority: 0,
        service_parameters: "4",
        service_short_name: "REGNAME",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: "^(95)(\d{7})$",
        category_id: 1,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 6,
        image: "https://m.click.uz/static/merchant/logo/logo_6.png",
        is_mobile: 1,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 600000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 600000,
        min_pay_limit: 1000,
        name: "UZMOBILE",
        priority: 20,
        service_parameters: "1",
        service_short_name: "UZMOBILE",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 1,
        autopay_available_amounts: [
          "5000.0000",
          "10000.0000",
          "15000.0000",
          "20000.0000",
          "50000.0000"
        ],
        autopay_available_steps: [{step_title: "0.1$", step_value: "2"}, {
          step_title: "1$",
          step_value: "1"
        }, {step_title: "1$", step_value: "1"}, {step_title: "1$", step_value: "1"}, {
          step_title: "1$",
          step_value: "1"
        }, {step_title: "1$", step_value: "1"}, {step_title: "1$", step_value: "1"}],
        validation: "^(93|94)(\d{7})$",
        category_id: 1,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 5,
        image: "https://m.click.uz/static/merchant/logo/logo_5.png",
        is_mobile: 1,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Ucell",
        priority: 10,
        service_parameters: "1",
        service_short_name: "UCELL",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 1,
        autopay_available_amounts: [
          "5000.0000",
          "10000.0000",
          "15000.0000",
          "20000.0000",
          "50000.0000"
        ],
        autopay_available_steps: [{step_title: "1$", step_value: "1"}],
        validation: "^(90|91)(\d{7})$",
        category_id: 1,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 3,
        image: "https://m.click.uz/static/merchant/logo/logo_3.png",
        is_mobile: 1,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Билайн",
        priority: 5,
        service_parameters: "1",
        service_short_name: "BEELINE",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: "^(99)(\d{7})$",
        category_id: 1,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 148,
        image: "https://m.click.uz/static/merchant/logo/logo_148.png",
        is_mobile: 1,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 150000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 150000,
        min_pay_limit: 1000,
        name: "Uztelecom",
        priority: 30,
        service_parameters: "1",
        service_short_name: "UzmobileGSM",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: "^(97)(\d{7})$",
        category_id: 1,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 2,
        image: "https://m.click.uz/static/merchant/logo/logo_2.png",
        is_mobile: 1,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1500000.00 сум",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1500000,
        min_pay_limit: 1000,
        name: "UMS",
        priority: 25,
        service_parameters: "1",
        service_short_name: "UMS",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 7,
        cost: 1,
        form_type: 2,
        is_visible: 1,
        id: 44,
        image: "https://m.click.uz/static/merchant/logo/logo_44.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 500000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 3000.00 сум",
        max_pay_limit: 500000,
        min_pay_limit: 3000,
        name: "Карты междунар.связи UzTelecom/Централ.Телеграф",
        priority: 10,
        service_parameters: "32768",
        service_short_name: "TELEGRAF",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 7,
        cost: 1,
        form_type: 2,
        is_visible: 1,
        id: 83,
        image: "https://m.click.uz/static/merchant/logo/logo_83.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Telekarta.uz",
        priority: 20,
        service_parameters: "32768",
        service_short_name: "Telekarta",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 6,
        cost: 1,
        form_type: 2,
        is_visible: 1,
        id: 95,
        image: "https://m.click.uz/static/merchant/logo/logo_95.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Dastur.uz",
        priority: 0,
        service_parameters: "32768",
        service_short_name: "Dastur.uz",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 7,
        cost: 1,
        form_type: 2,
        is_visible: 1,
        id: 139,
        image: "https://m.click.uz/static/merchant/logo/logo_139.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Oxygen Networks",
        priority: 30,
        service_parameters: "32768",
        service_short_name: "Oxygen Networks",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 2,
        cost: 1,
        form_type: 2,
        is_visible: 1,
        id: 1133,
        image: "https://m.click.uz/static/merchant/logo/logo_1133.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "SONET PINCARD",
        priority: 0,
        service_parameters: "32768",
        service_short_name: "SONET.UZ PINCARD",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 2,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 7,
        image: "https://m.click.uz/static/merchant/logo/logo_7.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Sharq Telekom",
        priority: 5,
        service_parameters: "134",
        service_short_name: "SHARQTELEKOM",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 2,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 15,
        image: "https://m.click.uz/static/merchant/logo/logo_15.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Sarkor Telekom",
        priority: 7,
        service_parameters: "10",
        service_short_name: "SARKORTELEKOM",
        lang_amount_currency: "сум",
        status: 1
      }
      ,
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 2,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 10,
        image: "https://m.click.uz/static/merchant/logo/logo_10.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Skyline",
        priority: 10,
        service_parameters: "18",
        service_short_name: "SKYLINE",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 2,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 35,
        image: "https://m.click.uz/static/merchant/logo/logo_35.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "Platinum Connect",
        priority: 20,
        service_parameters: "6148",
        service_short_name: "PLATINUM",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 7,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 128,
        image: "https://m.click.uz/static/merchant/logo/logo_128.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "East Telekom",
        priority: 35,
        service_parameters: "19",
        service_short_name: "east_telekom",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 2,
        cost: 1,
        form_type: 1,
        is_visible: 1,
        id: 183,
        image: "https://m.click.uz/static/merchant/logo/logo_183.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1000000,
        min_pay_limit: 1000,
        name: "EVO LTE",
        priority: 35,
        service_parameters: "16777232",
        service_short_name: "EVOLTE",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 8,
        cost: 1,
        form_type: 3,
        is_visible: 1,
        id: 198,
        image: "https://m.click.uz/static/merchant/logo/logo_198.png",
        is_mobile: 0,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 5000000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 5000000,
        min_pay_limit: 1000,
        name: "Gaz",
        priority: 0,
        service_parameters: "16",
        service_short_name: "gaz",
        lang_amount_currency: "сум",
        status: 1
      },
      {
        autopay_available: 0,
        autopay_available_amounts: null,
        autopay_available_steps: null,
        validation: null,
        category_id: 11,
        cost: 1,
        form_type: 4,
        id: 4422,
        image: "https://m.click.uz/static/merchant/logo/logo_4422.png",
        is_mobile: 0,
        is_visible: 1,
        lang_amount_hint: null,
        lang_amount_placeholder: "Введите сумму оплаты",
        lang_amount_title: "Сумма",
        lang_max_amount: "Максимальная сумма для оплаты 1500000.00 сум ",
        lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
        max_pay_limit: 1500000,
        min_pay_limit: 1000,
        name: "UMS Internet Paketi",
        priority: 25,
        service_parameters: "1",
        service_short_name: "UMS Internet Paketi",
        lang_amount_currency: "сум",
        status: 1
      }

    ]
  )
  ;

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});


window.fakedSocket.register("get.service.parameters.list", function (input) {


  var array = [];
  var arrayOne = {};
  var arrayTwo = {};
  var arrayThree = {};
  var arrayMethod = ([{method: input.method, success: 1, error: 0, error_note: ""}]);

  array.push(arrayMethod);
  array.push([{
    error_message: "Номер телефона введен неправильно",
    input_type: 1,
    max_len: "999999999",
    min_len: "0",
    parameter_id: "1",
    placeholder: "Введите номер телефона без 998",
    service_id: 3,
    title: "Номер телефона",
    ussd_query: "*880*0199999*{param}*{amount}#"
  },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "1",
      placeholder: "Введите номер телефона без 998",
      service_id: 2,
      title: "Номер телефона",
      ussd_query: "*880*0199999*{param}*{amount}#"
    },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "1",
      placeholder: "Введите номер телефона без 998",
      service_id: -2,
      title: "Номер телефона",
      ussd_query: null
    },
    {
      error_message: "Логин введен неправильно",
      input_type: 2,
      max_len: "50",
      min_len: "3",
      parameter_id: "2",
      placeholder: "Введите логин ",
      service_id: -2,
      title: "Логин",
      ussd_query: null
    },
    {
      error_message: "Выберите счет, на который нужно перевести деньги",
      input_type: 0,
      max_len: "99999999999",
      min_len: "1",
      parameter_id: "8192",
      placeholder: "Выберите счет, на который нужно перевести средства",
      service_id: -1,
      title: "На счет",
      ussd_query: null
    },
    {
      error_message: "Выбирите счет, с которого будут переведены средства",
      input_type: 0,
      max_len: "99999999999",
      min_len: "1",
      parameter_id: "16384",
      placeholder: "Выбирите счет, с которого будут переведены средства",
      service_id: -1,
      title: "Списать со счета",
      ussd_query: null
    },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "1",
      placeholder: "Введите номер телефона без 998",
      service_id: 5,
      title: "Номер телефона",
      ussd_query: "*880*0199999*{param}*{amount}#"
    },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "1",
      placeholder: "Введите номер телефона без 998",
      service_id: 6,
      title: "Номер телефона",
      ussd_query: "*880*0199999*{param}*{amount}#"
    },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "1",
      placeholder: "Введите номер телефона без 998",
      service_id: 148,
      title: "Номер телефона",
      ussd_query: "*880*0199999*{param}*{amount}#"
    },
    {
      error_message: "Логин введен неправильно",
      input_type: 2,
      max_len: "50",
      min_len: "3",
      parameter_id: "2",
      placeholder: "Введите логин ",
      service_id: 7,
      title: "Логин",
      ussd_query: "*880*0799999*{option}*{param}*{amount}#"
    },
    {
      error_message: "Неверный ID абонента",
      input_type: 1,
      max_len: "999999999999999",
      min_len: "0",
      parameter_id: "4",
      placeholder: "Введите ID абонента",
      service_id: 7,
      title: "ID абонента",
      ussd_query: null
    },
    {
      error_message: "Неверно введен кроссированный номер",
      input_type: 1,
      max_len: "998999999999",
      min_len: "0",
      parameter_id: "128",
      placeholder: "Введите кроссированный номер",
      service_id: 7,
      title: "Кроссированный номер",
      ussd_query: null
    },
    {
      error_message: "Логин введен неправильно",
      input_type: 2,
      max_len: "50",
      min_len: "3",
      parameter_id: "2",
      placeholder: "Введите логин ",
      service_id: 10,
      title: "Логин",
      ussd_query: "*880*01099999*1*{param}*{amount}#"
    },
    {
      error_message: "Неверно набран лицевой счет",
      input_type: 2,
      max_len: "50",
      min_len: "0",
      parameter_id: "16",
      placeholder: "Введите лицевой счет абонента",
      service_id: 10,
      title: "Лицевой счет абонента",
      ussd_query: "*880*01099999*2*{param}*{amount}#"
    },
    {
      error_message: "Неверно набран лицевой счет",
      input_type: 2,
      max_len: "50",
      min_len: "0",
      parameter_id: "16",
      placeholder: "Введите лицевой счет абонента",
      service_id: 183,
      title: "Лицевой счет абонента",
      ussd_query: "*880*018399999*2*{option}*{param}*{amount}#"
    },
    {
      error_message: "Номер контракта введен неверно",
      input_type: 2,
      max_len: "50",
      min_len: "1",
      parameter_id: "16777216",
      placeholder: "Введите номер контракта",
      service_id: 183,
      title: "Номер контракта",
      ussd_query: "*880*018399999*1*{option}*{param}*{amount}#"
    },
    {
      error_message: "Неверно набран лицевой счет",
      input_type: 2,
      max_len: "50",
      min_len: "0",
      parameter_id: "16",
      placeholder: "Введите лицевой счет абонента",
      service_id: 198,
      title: "Лицевой счет абонента",
      ussd_query: "*880*019899999*{communal_param}*{param}*{amount}#"
    },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "65536",
      placeholder: "Введите номер телефона с кодом города (г.Ташкент(71), Таш. Обл.(70), Каракалпакстан(61), Сырдарья(67))",
      service_id: 9,
      title: "Номер телефона",
      ussd_query: "*880*0999999*{communal_param}*{param}*{amount}#"
    },
    {
      error_message: "Неверно набран лицевой счет",
      input_type: 2,
      max_len: "50",
      min_len: "0",
      parameter_id: "16",
      placeholder: "Введите лицевой счет абонента",
      service_id: 39,
      title: "Лицевой счет абонента",
      ussd_query: "*880*03999999*{communal_param}*{param}*{amount}#"
    },
    {
      error_message: "ИНН введен не верно",
      input_type: 1,
      max_len: "999999999",
      min_len: "1",
      parameter_id: "8388608",
      placeholder: "Введите ИНН",
      service_id: 107,
      title: "ИНН",
      ussd_query: "*880*010799999*{communal_param}*{param}*{amount}#"
    },
    {
      error_message: "Номер телефона введен неправильно",
      input_type: 1,
      max_len: "999999999",
      min_len: "0",
      parameter_id: "1",
      placeholder: "Введите номер телефона без 998",
      service_id: 4422,
      title: "Номер телефона",
      ussd_query: "*880*0199999*{param}*{amount}#"
    }
  ]);

  array.push([
    {
      code: -1,
      id: 2,
      name: "Мирабадский район",
      offline_code: "-1",
      parent: 0,
      service_id: 39
    },
    {
      code: -1,
      id: 4,
      name: "Мирзо-Улугбекский район",
      offline_code: "-1",
      parent: 0,
      service_id: 39
    },
    {
      code: -1,
      id: 5,
      name: "Хамзинский район",
      offline_code: "-1",
      parent: 0,
      service_id: 39
    },
    {
      code: -1,
      id: 6,
      name: "Шайхантахурский район",
      offline_code: "-1",
      parent: 0,
      service_id: 39
    },
    {
      code: -1,
      id: 7,
      name: "Яккасарайский район",
      offline_code: "-1",
      parent: 0,
      service_id: 39
    },
    {
      code: 1,
      id: 1,
      name: "Ташкент",
      offline_code: "1",
      parent: 0,
      service_id: 198
    },
    {
      code: 3,
      id: 3,
      name: "Бухара",
      offline_code: "3",
      parent: 0,
      service_id: 198
    },
    {
      code: 3,
      id: 3,
      name: "Миробод тумани",
      offline_code: "003",
      parent: 1,
      service_id: 198
    },
    {
      code: 4,
      id: 4,
      name: "М. Улугбек тумани",
      offline_code: "004",
      parent: 1,
      service_id: 198
    },
    {
      code: 5,
      id: 5,
      name: "Яккасарой тумани",
      offline_code: "005",
      parent: 1,
      service_id: 198
    },
    {
      code: 172,
      id: 172,
      name: "Бухоро шахар",
      offline_code: "172",
      parent: 3,
      service_id: 198
    },
    {
      code: 174,
      id: 174,
      name: "Ромитан тумани",
      offline_code: "174",
      parent: 3,
      service_id: 198
    },
    {
      code: 175,
      id: 175,
      name: "Когон тумани",
      offline_code: "175",
      parent: 3,
      service_id: 198
    },
    {
      code: 176,
      id: 176,
      name: "Гиждувон тумани",
      offline_code: "176",
      parent: 3,
      service_id: 198
    },
    {
      code: 1,
      id: 1,
      name: "WiMAX",
      offline_code: "1",
      parent: 0,
      service_id: 183
    },
    {
      code: 2,
      id: 2,
      name: "LTE",
      offline_code: "2",
      parent: 0,
      service_id: 183
    },
    {
      code: 2,
      id: 2,
      name: "Таш. Обл.",
      offline_code: "2",
      parent: 0,
      service_id: 198
    }
  ]);


  array.push([{
      card_type: "STK",
      card_type_desc: "Central Telegraf",
      card_type_id: 1,
      duration: null,
      name: "Центральный Телеграф",
      nominal: 5000,
      service_id: 44,
    },
      {
        card_type: "STK",
        card_type_desc: "Central Telegraf",
        card_type_id: 1,
        duration: null,
        name: "Центральный Телеграф",
        nominal: 10000,
        service_id: 44,
      },
      {
        card_type: "STK",
        card_type_desc: "Central Telegraf",
        card_type_id: 1,
        duration: null,
        name: "Центральный Телеграф",
        nominal: 20000,
        service_id: 44,
      },
      {
        card_type: "UzT",
        card_type_desc: "UzTelecom",
        card_type_id: 3,
        duration: null,
        name: "UzTelecom",
        nominal: 100000,
        service_id: 44
      },
      {
        card_type: "UzT",
        card_type_desc: "UzTelecom",
        card_type_id: 3,
        duration: null,
        name: "UzTelecom",
        nominal: 50000,
        service_id: 44,
      },
      {
        card_type: "RUS-KAZ",
        card_type_desc: "Russia,Kazahstan",
        card_type_id: 2,
        duration: 30,
        name: "Россия, Казахстан",
        nominal: 6600,
        service_id: 44
      },
      {
        card_type: "RUS-KAZ",
        card_type_desc: "Russia,Kazahstan",
        card_type_id: 2,
        duration: 20,
        name: "Россия, Казахстан",
        nominal: 4500,
        service_id: 44
      },
      {
        card_type: "SONET",
        card_type_desc: "SONET",
        card_type_id: 7,
        duration: null,
        name: "SONET",
        nominal: 5000,
        service_id: 78
      },
      {
        card_type: "SONET",
        card_type_desc: "SONET",
        card_type_id: 7,
        duration: null,
        name: "SONET",
        nominal: 10000,
        service_id: 78
      },
      {
        card_type: "TELEKARTA",
        card_type_desc: "TELEKARTA",
        card_type_id: 6,
        duration: null,
        name: "TELEKARTA",
        nominal: 3000,
        service_id: 83
      }]
  );

  array.push([
    {
      name: "30 dney",
      service_id: 4422,
      type: 1
    },
    {
      name: "sutochnie",
      service_id: 4422,
      type: 2
    },
    {
      name: "nochnie",
      service_id: 4422,
      type: 3
    },
    {
      name: "nochnoy DRIVE",
      service_id: 4422,
      type: 4
    }
  ]);

  array.push([
    {
      code: "MB300M1",
      name: "Интернет-пакет 300 Mb",
      priority: 1,
      service_id: 4422,
      status: 1,
      sum_cost: 16785,
      type: 1,
      usd_cost: 5
    },
    {
      code: "MB500M",
      name: "Интернет-пакет 500 Mb",
      priority: 2,
      service_id: 4422,
      status: 1,
      sum_cost: 23499,
      type: 1,
      usd_cost: 7
    },
    {
      code: "MB1000M1",
      name: "Интернет-пакет 1000 Mb",
      priority: 3,
      service_id: 4422,
      status: 1,
      sum_cost: 33569,
      type: 1,
      usd_cost: 10
    },
    {
      code: "FRGPRS50DAY",
      name: "Суточный интернет-пакет 50 Mb",
      priority: 1,
      service_id: 4422,
      status: 1,
      sum_cost: 5036,
      type: 2,
      usd_cost: 1.5,
    },
    {
      code: "MB1000MNIGHT",
      name: "Ночной интернет-пакет 1000 Mb",
      priority: 1,
      service_id: 4422,
      status: 1,
      sum_cost: 6714,
      type: 3,
      usd_cost: 2
    },
    {
      code: "NIGHTDRIVE1",
      name: "Ночной DRIVE 1",
      priority: 1,
      service_id: 4422,
      status: 1,
      sum_cost: 10071,
      type: 4,
      usd_cost: 3
    }
  ]);


  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Some error'}];
});

window.fakedSocket.register("app.payment", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [{
        "invoice_id": 555,
        "payment_id": "xzsa"
      }]
    ];
  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("p2p.card.info", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [{
        "invoice_id": null,
        "payment_id": "xzsa"
      }]
    ];
  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("p2p.payment", function (input) {

  if (input) {
    console.log(input)
    var random = Math.random() * 1000;
    if (random.length == 2) {
      random + Math.random() * 10;
    }
    if (random.length == 1) {
      random + Math.random() * 10 + Math.random() * 10
    }

    if (random.length == 0) {
      random + Math.random() * 10 + Math.random() * 10 + Math.random() * 10
    }
    if (input.parameters.type == 2) {
      //if (input.parameters.receiver_data == '998222222222')
      return [
        [{
          "method": input.method,
          "success": 1,
          "error": 0,
          "error_note": "qweqw eqw eqweqweqeqweq we wqeqweqweqwe qwe qweqweqwe qw eqwe qwe qweqwe qwe qweqwe"
        }],
        [{
          "secret_code": random.toFixed(0),
        }]
      ];
      //else
      //  return [
      //    [{
      //      "method": input.method,
      //      "success": 1,
      //      "error": 1,
      //      "error_note": ""
      //    }],
      //  ];
    }
    else {
      //if (input.parameters.receiver_data == '1111222233334444')
      return [
        [{
          "method": input.method,
          "success": 1,
          "error": 0,
          "error_note": ""
        }],
        [{
          "secret_code": 0,
        }]
      ];
      //else
      //  return [
      //    [{
      //      "method": input.method,
      //      "success": 1,
      //      "error": 1,
      //      "error_note": ""
      //    }],
      //  ];

    }
  }
});


window.fakedSocket.register("settings.account.name", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }]
    ];
  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("settings.change.default.account", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [{
        "default_account_id": 1287271
      }]
    ];
  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("get.popular.services", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
      is_visible: 1,
      id: 6,
      image: "https://m.click.uz/static/merchant/logo/logo_6.png",
      is_mobile: 1,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 600000.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
      max_pay_limit: 600000,
      min_pay_limit: 1000,
      name: "UZMOBILE",
      priority: 20,
      service_parameters: "1",
      service_short_name: "UZMOBILE",
      lang_amount_currency: "сум",
      status: 1
    },
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
      is_visible: 1,
      id: 5,
      image: "https://m.click.uz/static/merchant/logo/logo_5.png",
      is_mobile: 1,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
      max_pay_limit: 1000000,
      min_pay_limit: 1000,
      name: "Ucell",
      priority: 10,
      service_parameters: "1",
      service_short_name: "UCELL",
      lang_amount_currency: "сум",
      status: 1
    },
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
      is_visible: 1,
      id: 3,
      image: "https://m.click.uz/static/merchant/logo/logo_3.png",
      is_mobile: 1,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум",
      lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
      max_pay_limit: 1000000,
      min_pay_limit: 1000,
      name: "Билайн",
      priority: 5,
      service_parameters: "1",
      service_short_name: "BEELINE",
      lang_amount_currency: "сум",
      status: 1
    }]
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("p2p.bank.list", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([
    {
      code: "020",
      image: "https://merchant.click.uz/static/merchant/bank/utb.png",
      bank_name: "UT банк",
      p2p_min_limit: 5000,
      p2p_max_limit: 5000000,
      p2p_percent: 2
    },
    {
      code: "004",
      image: "https://merchant.click.uz/static/merchant/bank/agro.png",
      bank_name: "Агробанк",
      p2p_min_limit: 5000,
      p2p_max_limit: 5000000,
      p2p_percent: 1.5
    },
    {
      code: "055",
      image: "https://merchant.click.uz/static/merchant/bank/aab.png",
      bank_name: "Азия Альянс Банк",
      p2p_min_limit: 5000,
      p2p_max_limit: 5000000,
      p2p_percent: 2
    },
    {
      code: "031",
      image: "https://merchant.click.uz/static/merchant/bank/aloq.png",
      bank_name: "Алокабанк",
      p2p_min_limit: 5000,
      p2p_max_limit: 5000000,
      p2p_percent: 1.5
    },
    {
      code: "013",
      image: "https://merchant.click.uz/static/merchant/bank/asaka.png",
      bank_name: "Асака Банк",
      p2p_min_limit: 5000,
      p2p_max_limit: 5000000,
      p2p_percent: 1.5
    },
    {
      code: "051",
      image: "https://merchant.click.uz/static/merchant/bank/davr.png",
      bank_name: "Давр Банк",
      p2p_min_limit: 5000,
      p2p_max_limit: 5000000,
      p2p_percent: 0.7
    }]
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("settings.change.pin", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("history.chart.data", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);
  array.push([
    {
      category_id: 1,
      category_name: "Мобильные операторы",
      amount: "81 600",
      percent: 34.42,
      image: "https://merchant.click.uz/static/merchant/categories/1.png",
    },
    {
      category_id: 4,
      category_name: "Перевод средств",
      amount: "105 199",
      percent: 44.38,
      image: "https://merchant.click.uz/static/merchant/categories/4.png",
    },
    {
      category_id: 6,
      category_name: "Интернет-сервисы",
      amount: "8 500",
      percent: 3.59,
      image: "https://merchant.click.uz/static/merchant/categories/6.png",
    },
    {
      category_id: 11,
      category_name: "Интернет пакеты",
      amount: "41 763",
      percent: 17.62,
      image: "https://merchant.click.uz/static/merchant/categories/11.png",
    }]
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("account.remove", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);


  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("settings.change.profile.data", function (input) {

  var array = [];
  array.push([{method: input.method, success: 1, error: 0, error_note: ""}]);


  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});


window.fakedSocket.register("pin.reset", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [{
        "text1": "Все Ваши карты отключены от системы CLICK",
        "text2": "Для установки нового CLICK-PIN необходимо заново пройти регистрацию"
      }]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("settings.change.pin", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("settings.change.visibility", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("invoice.list", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [
        {
          amount: 695326,
          datetime: "2017-03-24T10:41:15.760Z",
          "date": "24.03.2017",
          "time": "10:41",
          datetime_timestamp: 1490352075,
          description: "Перевод от 998974647747",
          invoice_id: 4063838,
          is_p2p: 1,
          merchant_phone: "998974647747",
          parameter: "998974647747",
          service_id: -4,
          service_name: "PAYME"
        },
        {
          amount: 100,
          datetime: "2017-03-24T10:40:31.876Z",
          "date": "24.03.2017",
          "time": "10:40",
          datetime_timestamp: 1490352031,
          description: "Счет от YTT MUXAMEDOVA SH. R.",
          invoice_id: 4063823,
          is_p2p: 0,
          merchant_phone: "998974647747",
          parameter: "04703",
          service_id: 4703,
          service_name: "YTT MUXAMEDOVA SH. R.",
        },
        {
          amount: 5326,
          datetime: "2017-03-24T10:40:57.856Z",
          "date": "24.03.2017",
          "time": "10:40",
          datetime_timestamp: 1490352057,
          description: "Перевод от 998974647747",
          invoice_id: 4063829,
          is_p2p: 1,
          merchant_phone: "998974647747",
          parameter: "998974647747",
          service_id: -4,
          service_name: "PAYME"
        },
        {
          amount: 1000,
          datetime: "2017-03-24T10:40:10.320Z",
          "date": "24.03.2017",
          "time": "10:40",
          datetime_timestamp: 1490352010,
          description: "Помощь другу 998974647747",
          invoice_id: 4063819,
          is_p2p: 0,
          merchant_phone: "998974647747",
          parameter: "909037856",
          service_id: 3,
          service_name: "BEELINE"
        },
        {
          amount: 1000,
          datetime: "2017-03-24T10:39:55.656Z",
          "date": "24.03.2017",
          "time": "10:39",
          datetime_timestamp: 1490351995,
          description: "Помощь другу 998974647747",
          invoice_id: 4063812,
          is_p2p: 0,
          merchant_phone: "998974647747",
          parameter: "974647747",
          service_id: 2,
          service_name: "UMS"
        },
        {
          "invoice_id": 4164639,
          "merchant_phone": "998974647747",
          "amount": "5 000",
          "service_name": "PAYME",
          "parameter": "998974647747",
          "datetime": "2017-03-31T11:51:48.783Z",
          "datetime_timestamp": 1490961108,
          "date": "31.03.2017",
          "time": "14:47",
          "description": "Перевод от 998974647747",
          "service_id": -4,
          "is_p2p": 1
        }, {
        "invoice_id": 4155469,
        "merchant_phone": "998974647747",
        "amount": "5 000",
        "service_name": "PAYME",
        "parameter": "998974647747",
        "datetime": "2017-03-30T16:58:15.796Z",
        "datetime_timestamp": 1490893095,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Перевод от 998974647747",
        "service_id": -4,
        "is_p2p": 1
      }, {
        "invoice_id": 4152055,
        "merchant_phone": null,
        "amount": "1 000",
        "service_name": "TELEGRAF (TELEGRAMMI)",
        "parameter": "",
        "datetime": "2017-03-30T12:54:12.680Z",
        "datetime_timestamp": 1490878452,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Счет от TELEGRAF (TELEGRAMMI)",
        "service_id": 60,
        "is_p2p": 0
      }, {
        "invoice_id": 4139323,
        "merchant_phone": null,
        "amount": "5 500",
        "service_name": "OLX.UZ",
        "parameter": "1936851",
        "datetime": "2017-03-29T15:48:57.310Z",
        "datetime_timestamp": 1490802537,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Счет от OLX.UZ",
        "service_id": 12,
        "is_p2p": 0
      }, {
        "invoice_id": 4132270,
        "merchant_phone": "998974647747",
        "amount": "5 500",
        "service_name": "PAYME",
        "parameter": "998974647747",
        "datetime": "2017-03-29T08:13:24.190Z",
        "datetime_timestamp": 1490775204,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Перевод от 998974647747",
        "service_id": -4,
        "is_p2p": 1
      }, {
        "invoice_id": 4132264,
        "merchant_phone": "998974647747",
        "amount": "53 222",
        "service_name": "UMS INTERNET PAKETI",
        "parameter": "977031581",
        "datetime": "2017-03-29T08:13:07.803Z",
        "datetime_timestamp": 1490775187,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Помощь другу 998974647747",
        "service_id": 4422,
        "is_p2p": 0
      }, {
        "invoice_id": 4132257,
        "merchant_phone": "998974647747",
        "amount": "356 294",
        "service_name": "UZMOBILE (CDMA)",
        "parameter": "996532679",
        "datetime": "2017-03-29T08:12:51.756Z",
        "datetime_timestamp": 1490775171,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Помощь другу 998974647747",
        "service_id": 6,
        "is_p2p": 0
      }, {
        "invoice_id": 4132252,
        "merchant_phone": "998974647747",
        "amount": "563 298",
        "service_name": "PAYME",
        "parameter": "998974647747",
        "datetime": "2017-03-29T08:12:31.906Z",
        "datetime_timestamp": 1490775151,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Перевод от 998974647747",
        "service_id": -4,
        "is_p2p": 1
      }, {
        "invoice_id": 4132248,
        "merchant_phone": "998974647747",
        "amount": "1 000",
        "service_name": "UMS",
        "parameter": "974647747",
        "datetime": "2017-03-29T08:12:16.240Z",
        "datetime_timestamp": 1490775136,
        "date": "31.03.2017",
        "time": "14:47",
        "description": "Помощь другу 998974647747",
        "service_id": 2,
        "is_p2p": 0
      }
      ]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("invoice.history", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [
        {
          "invoice_id": 4164639,
          "amount": "5 000",
          "cntrg_info_param2": "998974647747",
          "cntrg_info_param3": "998974647747",
          "cntrg_info_param4": "755",
          "cntrg_info_param5": "1819885",
          "status_note": "Ожидание",
          "date": "31.03.2017",
          "time": "14:47",
          "state": 1,
          "paydoc_state": null,
          "service_name": "Perevod P2P (998974647747)",
          "created": "2017-03-31T11:51:48.783Z",
          "created_time": 1490961108,
          "account_id": "4717680",
          "error": null,
          "service_id": -4,
          "param_name": "Номер телефона",
          "is_p2p": 1,
          "p2p_secret_code": 755,
          "p2p_comission_amount": 75
        }, {
        "invoice_id": 4155469,
        "amount": "5 000",
        "cntrg_info_param2": "998974647747",
        "cntrg_info_param3": "998974647747",
        "cntrg_info_param4": "751",
        "cntrg_info_param5": "1819885",
        "status_note": "Ожидание",
        "date": "31.03.2017",
        "time": "14:47",
        "state": 1,
        "paydoc_state": null,
        "service_name": "Perevod P2P (998974647747)",
        "created": "2017-03-30T16:58:15.796Z",
        "created_time": 1490893095,
        "account_id": "4717680",
        "error": null,
        "service_id": -4,
        "param_name": "Номер телефона",
        "is_p2p": 1,
        "p2p_secret_code": 751,
        "p2p_comission_amount": 75
      }, {
        "invoice_id": 4132270,
        "amount": "5 500",
        "cntrg_info_param2": "998974647747",
        "cntrg_info_param3": "998974647747",
        "cntrg_info_param4": "557",
        "cntrg_info_param5": "1819885",
        "status_note": "Ожидание",
        "state": 1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "Perevod P2P (998974647747)",
        "created": "2017-03-29T08:13:24.190Z",
        "created_time": 1490775204,
        "account_id": "4698124",
        "error": null,
        "service_id": -4,
        "param_name": "Номер телефона",
        "is_p2p": 1,
        "p2p_secret_code": 557,
        "p2p_comission_amount": 82.5
      }, {
        "invoice_id": 4132264,
        "amount": "53 222",
        "cntrg_info_param2": "977031581",
        "cntrg_info_param3": null,
        "cntrg_info_param4": null,
        "cntrg_info_param5": "NIGHTDRIVE7",
        "status_note": "Ожидание",
        "state": 1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "UMS Internet Paketi (977031581)",
        "created": "2017-03-29T08:13:07.803Z",
        "created_time": 1490775187,
        "account_id": null,
        "error": null,
        "service_id": 4422,
        "param_name": "Номер телефона",
        "is_p2p": 0,
        "p2p_secret_code": 0,
        "p2p_comission_amount": 0
      }, {
        "invoice_id": 4132257,
        "amount": "356 294",
        "cntrg_info_param2": "996532679",
        "cntrg_info_param3": null,
        "cntrg_info_param4": null,
        "cntrg_info_param5": null,
        "status_note": "Ожидание",
        "state": 1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "UZMOBILE (99 6532679)",
        "created": "2017-03-29T08:12:51.756Z",
        "created_time": 1490775171,
        "account_id": null,
        "error": null,
        "service_id": 6,
        "param_name": "Номер телефона",
        "is_p2p": 0,
        "p2p_secret_code": 0,
        "p2p_comission_amount": 0
      }, {
        "invoice_id": 4132252,
        "amount": "563 298",
        "cntrg_info_param2": "998974647747",
        "cntrg_info_param3": "998974647747",
        "cntrg_info_param4": "489",
        "cntrg_info_param5": "1819885",
        "status_note": "Ожидание",
        "state": 1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "Perevod P2P (998974647747)",
        "created": "2017-03-29T08:12:31.906Z",
        "created_time": 1490775151,
        "account_id": "4698124",
        "error": null,
        "service_id": -4,
        "param_name": "Номер телефона",
        "is_p2p": 1,
        "p2p_secret_code": 489,
        "p2p_comission_amount": 8449.47
      }, {
        "invoice_id": 4132248,
        "amount": "1 000",
        "cntrg_info_param2": "974647747",
        "cntrg_info_param3": null,
        "cntrg_info_param4": null,
        "cntrg_info_param5": null,
        "status_note": "Ожидание",
        "state": 1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "UMS (97 4647747)",
        "created": "2017-03-29T08:12:16.240Z",
        "created_time": 1490775136,
        "account_id": null,
        "error": null,
        "service_id": 2,
        "param_name": "Номер телефона",
        "is_p2p": 0,
        "p2p_secret_code": 0,
        "p2p_comission_amount": 0
      }, {
        "invoice_id": 4122980,
        "amount": "5 000",
        "cntrg_info_param2": "998974647747",
        "cntrg_info_param3": "998974647747",
        "cntrg_info_param4": "340",
        "cntrg_info_param5": "1819885",
        "status_note": "Удален",
        "state": -1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "Perevod P2P (998974647747)",
        "created": "2017-03-28T14:14:08.103Z",
        "created_time": 1490710448,
        "account_id": "4698124",
        "error": null,
        "service_id": -4,
        "param_name": "Номер телефона",
        "is_p2p": 1,
        "p2p_secret_code": 340,
        "p2p_comission_amount": 75
      }, {
        "invoice_id": 4122879,
        "amount": "5 000",
        "cntrg_info_param2": "998974647747",
        "cntrg_info_param3": "998974647747",
        "cntrg_info_param4": "565",
        "cntrg_info_param5": "1819885",
        "status_note": "Удален",
        "state": -1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "Perevod P2P (998974647747)",
        "created": "2017-03-28T14:09:12.103Z",
        "created_time": 1490710152,
        "account_id": "4698124",
        "error": null,
        "service_id": -4,
        "param_name": "Номер телефона",
        "is_p2p": 1,
        "p2p_secret_code": 565,
        "p2p_comission_amount": 75
      }, {
        "invoice_id": 4107563,
        "amount": "500 649",
        "cntrg_info_param2": "998974647747",
        "cntrg_info_param3": "998974647747",
        "cntrg_info_param4": "989",
        "cntrg_info_param5": "1819885",
        "status_note": "Удален",
        "state": -1,
        "date": "31.03.2017",
        "time": "14:47",
        "paydoc_state": null,
        "service_name": "Perevod P2P (998974647747)",
        "created": "2017-03-27T14:50:46.203Z",
        "created_time": 1490626246,
        "account_id": "4678219",
        "error": null,
        "service_id": -4,
        "param_name": "Номер телефона",
        "is_p2p": 1,
        "p2p_secret_code": 989,
        "p2p_comission_amount": 7509.735
      }
      ]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("rate.convert", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [{
        "amount": 1,
        "converted_amount": 3596,
        "current_rate": 3595.02
      }]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("invoice.action", function (input) {

  console.log("Input for invoice.action", input);

  if (input)

    if (input.parameters.action == invoiceActions.DECLINE) {
      return [
        [{
          "method": input.method,
          "success": 1,
          "error": 0,
          "error_note": "",
          "invoice_id": input.parameters.invoice_id
        }]
      ];
    } else if (input.parameters.action == invoiceActions.ACCEPT) {

      return [
        [{
          "method": input.method,
          "success": 1,
          "error": 0,
          "error_note": ""
        }],
        [{
          invoice_id: input.parameters.invoice_id,
          payment_id: "352814752"
        }]
      ]
    }

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("settings.get.trusted.devices", function (input) {

  console.log("Input for settings.get.trusted.devices", input);

  if (input) {

    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": "",
        "invoice_id": input.parameters.invoice_id
      }],
      [
        {
          "device_id": "9989746477470CC3A9585B6A6B97AB5D46DB85763875",
          "device_type": 2,
          "device_type_name": "iOS",
          "device_name": "iPhone4,1"
        },
        {
          "device_id": "998974647747142C972F4502E63D488A7B62B77BCFA3",
          "device_type": 2,
          "device_type_name": "iOS",
          "device_name": "iPhone4,1"
        },
        {
          "device_id": "9989746477472095613FF74967916AFFFF555F99B057",
          "device_type": 1,
          "device_type_name": "Android",
          "device_name": "A0001"
        },
        {
          "device_id": "99897464774728B7617EBD1AF6C43ABD93F8725CCF3A",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/54.0.2840.98"
        },
        {
          "device_id": "9989746477472C1EB1D7DB60A6595E3C7B3982B5CAA2",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Edge/13.10586"
        },
        {
          "device_id": "9989746477473724CF524CE46CD3376F6AEBB4C04837",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/55.0.2883.87"
        },
        {
          "device_id": "9989746477473A179042B5D9D18726343F8EFDF53113",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/54.0.2840.99"
        },
        {
          "device_id": "9989746477473CA01AE0B46EF283221DAA593B69AC12",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Safari/7.0.6"
        },
        {
          "device_id": "9989746477475A7B04FA8072A7AE7CBD077BEDE33FCB",
          "device_type": 2,
          "device_type_name": "iOS",
          "device_name": "iPhone4,1"
        },
        {
          "device_id": "998974647747671B162845329D46A67F4AB3F8F2CB44",
          "device_type": 2,
          "device_type_name": "iOS",
          "device_name": "iPhone4,1"
        },
        {
          "device_id": "9989746477476B160798E60348CAE0816755E53B1189",
          "device_type": 1,
          "device_type_name": "Android",
          "device_name": "SM-J710F"
        },
        {
          "device_id": "998974647747754CDCC1E6416D7A56262CF3D275472D",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/56.0.2924.87"
        },
        {
          "device_id": "9989746477477FBB3DA0DD1D829E2AA03F69D88F328C",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/54.0.2840.71"
        },
        {
          "device_id": "9989746477478032A000BC4252966F1F555E5D61A114",
          "device_type": 1,
          "device_type_name": "Android",
          "device_name": "Nexus 6"
        },
        {
          "device_id": "998974647747844F7AE4D251B2E6E152FDD13EF479F6",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/55.0.2883.87"
        },
        {
          "device_id": "9989746477479BC134E93CA434CC48BB120CDC5E1606",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "macintel"
        },
        {
          "device_id": "998974647747A133AD1BB88CE05F84349C60A02F596E",
          "device_type": 2,
          "device_type_name": "iOS",
          "device_name": "iPhone4,1"
        },
        {
          "device_id": "998974647747A1E958CDA927804447A0414C5BF8AA27",
          "device_type": 1,
          "device_type_name": "Android",
          "device_name": "Nexus 6"
        },
        {
          "device_id": "998974647747A3C460B60964F772829A2045CF28F868",
          "device_type": 2,
          "device_type_name": "iOS",
          "device_name": "iPhone4,1"
        },
        {
          "device_id": "998974647747BBE17F0A746D1D92D88F5944FC82BF7F",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/54.0.2840.99"
        },
        {
          "device_id": "998974647747C2A9916B51290A90D3EFCF0161892C25",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/54.0.2840.85"
        },
        {
          "device_id": "998974647747FDFE46DA4E0CFCBC728DB30D4233EC17",
          "device_type": 3,
          "device_type_name": "Web браузер",
          "device_name": "Chrome/54.0.2840.71"
        }
      ]
    ];
  }

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("get.indoor.service", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [
        {
          "address": "г.Ташкент, ул. Езгулик Езгулик Езгулик Езгулик Езгулик Езгулик Езгулик Езгулик Езгулик Езгулик Езгулик, дом 15",
          "category_id": 6,
          "cost": 1,
          "form_type": 1,
          "id": 4705,
          "image": "https://m.click.uz/static/merchant/logo/logo_4705.png",
          "is_mobile": 0,
          "is_visible": 0,
          "lang_amount_currency": "сум",
          "lang_amount_hint": null,
          "lang_amount_placeholder": "Введите сумму оплаты",
          "lang_amount_title": "Сумма",
          "lang_max_amount": "Максимальная сумма для оплаты 10000000.00 сум ",
          "lang_min_amount": "Минимальная сумма для оплаты 100.00 сум ",
          "max_pay_limit": 10000000,
          "min_pay_limit": 100,
          "name": "CafeQQB",
          "priority": 0,
          "service_parameters": "0",
          "service_short_name": "CafeQQB",
          "status": 0
        }
      ]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("settings.device.revoke.trust", function (input) {

  if (input) {
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }]
    ];
  }

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});


window.fakedSocket.register("get.terms", function (input) {

  if (input) {
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }]
    ];
  }

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("get.news", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [
        {
          "news_title": "Переводы с карты на карту через CLICK теперь на 25% дешевле!",
          "news_content_short": "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что в системе CLICK запущены переводы с карты на карту СО СНИЖЕННОЙ СТОИМОСТЬЮ! Теперь стоимость услуги перевода с карты на карту составляет 1,5% от суммы перевода (ранее было 2%).На текущий момент услуга доступна для держателей карт 6 банков и их число растет ПОСТОЯННО Список банков можно проверить в приложении CLICK Uzbekistan или в USSD-меню.Следите за нашими новостями!",
          "news_content": "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что в системе CLICK запущены переводы с карты на карту СО СНИЖЕННОЙ СТОИМОСТЬЮ! Теперь стоимость услуги перевода с карты на карту составляет 1,5% от суммы перевода (ранее было 2%).На текущий момент услуга доступна для держателей карт 6 банков и их число растет ПОСТОЯННО!Список банков можно проверить в приложении CLICK Uzbekistan или в USSD-меню.Следите за нашими новостями!",
          "url": null,
          "news_id": 2,
          "image": "https://m.click.uz/static/content/news/2.png",
          "datetime": "2017-04-11",
        },

        {
          "news_title": "Переводы с карты на карту через CLICK теперь на 1000% дешевле!",
          "news_content_short": "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что в системе CLICK запущены переводы с карты на карту СО СНИЖЕННОЙ СТОИМОСТЬЮ! Теперь стоимость услуги перевода с карты на карту составляет 1,5% от суммы перевода (ранее было 2%).На текущий момент услуга доступна для держателей карт 6 банков и их число растет ПОСТОЯННО Список банков можно проверить в приложении CLICK Uzbekistan или в USSD-меню.Следите за нашими новостями!",
          "news_content": "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что в системе CLICK запущены переводы с карты на карту СО СНИЖЕННОЙ СТОИМОСТЬЮ! Теперь стоимость услуги перевода с карты на карту составляет 1,5% от суммы перевода (ранее было 2%).На текущий момент услуга доступна для держателей карт 6 банков и их число растет ПОСТОЯННО!Список банков можно проверить в приложении CLICK Uzbekistan или в USSD-меню.Следите за нашими новостями!",
          "url": null,
          "news_id": 3,
          "image": null,
          "datetime": "2017-04-11",
        },

        {
          "news_title": "Переводы с карты на карту через CLICK теперь на 9999% дешевле!",
          "news_content_short": "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что в системе CLICK запущены переводы с карты на карту СО СНИЖЕННОЙ СТОИМОСТЬЮ! Теперь стоимость услуги перевода с карты на карту составляет 1,5% от суммы перевода (ранее было 2%).На текущий момент услуга доступна для держателей карт 6 банков и их число растет ПОСТОЯННО Список банков можно проверить в приложении CLICK Uzbekistan или в USSD-меню.Следите за нашими новостями!",
          "news_content": "Приятная новость в преддверии праздника Навруз для всех пользователей системы CLICK! С огромной радостью сообщаем, что в системе CLICK запущены переводы с карты на карту СО СНИЖЕННОЙ СТОИМОСТЬЮ! Теперь стоимость услуги перевода с карты на карту составляет 1,5% от суммы перевода (ранее было 2%).На текущий момент услуга доступна для держателей карт 6 банков и их число растет ПОСТОЯННО!Список банков можно проверить в приложении CLICK Uzbekistan или в USSD-меню.Следите за нашими новостями!",
          "url": null,
          "news_id": 4,
          "image": "https://m.click.uz/static/content/news/2.png",
          "datetime": "2017-04-11",
        }
      ]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.fakedSocket.register("autopay.list", function (input) {

  if (input)
    return [
      [{
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }],
      [
        {
          account_id: 4834489,
          amount: "1 500",
          autopay_type: 1,
          cntrg_param1: null,
          cntrg_param2: "974647747",
          cntrg_param3: null,
          cntrg_param4: null,
          cntrg_param5: null,
          cntrg_param_id: 1,
          created: "2017-04-17T13:56:33.086Z",
          id: 49317,
          month_day: 24,
          paytime: "1970-01-01T19:00:00.000Z",
          service_id: 2,
          service_name: null,
          status: 1,
          step: 0,
          title: "Автоплатёж &#039;UMS - 1500&#039;",
          type: 3,
          week_day: null
        },

        {
          account_id: 4834489,
          amount: "1 500",
          autopay_type: 1,
          cntrg_param1: null,
          cntrg_param2: "974647747",
          cntrg_param3: null,
          cntrg_param4: null,
          cntrg_param5: null,
          cntrg_param_id: 1,
          created: "2017-04-17T13:54:52.830Z",
          id: 49316,
          month_day: 27,
          paytime: "1970-01-01T02:43:00.000Z",
          service_id: 148,
          service_name: null,
          status: 1,
          step: 0,
          title: "Автоплатёж &#039;Uzmobile (GSM) - 1500&#039;",
          type: 3,
          week_day: null
        },

        {
          account_id: 4834489,
          amount: "1 000",
          autopay_type: 1,
          cntrg_param1: null,
          cntrg_param2: "x541",
          cntrg_param3: null,
          cntrg_param4: null,
          cntrg_param5: null,
          cntrg_param_id: 2,
          created: "2017-04-17T13:54:23.396Z",
          id: 49315,
          month_day: null,
          paytime: "1970-01-01T00:00:00.000Z",
          service_id: 3,
          service_name: null,
          status: 1,
          step: 0,
          title: "Автоплатёж &#039;ISTV - 1000&#039;",
          type: 4,
          week_day: null
        },

        {
          account_id: 4834489,
          amount: "5 000",
          autopay_type: 2,
          cntrg_param1: null,
          cntrg_param2: "998933974546",
          cntrg_param3: null,
          cntrg_param4: null,
          cntrg_param5: null,
          cntrg_param_id: null,
          created: "2017-04-17T13:53:48.550Z",
          id: 404373,
          month_day: null,
          paytime: null,
          service_id: 5,
          service_name: "UCELL",
          status: 1,
          step: 2,
          title: "Автоплатёж &#039;Ucell - 5000&#039;",
          type: null,
          week_day: null
        },

        {
          account_id: 4834489,
          amount: "1 000",
          autopay_type: 1,
          cntrg_param1: null,
          cntrg_param2: "974647747",
          cntrg_param3: null,
          cntrg_param4: null,
          cntrg_param5: null,
          cntrg_param_id: 1,
          created: "2017-04-17T13:53:16.940Z",
          id: 49314,
          month_day: null,
          paytime: "1970-01-01T22:56:00.000Z",
          service_id: 2,
          service_name: null,
          status: 1,
          step: 0,
          title: "Автоплатёжtgjj &#039;UMS - 1000&#039;",
          type: 2,
          week_day: 3
        }
      ]
    ];

  return [
    {
      "method": input.method,
      "success": 1,
      "error": -4,
      "error_note": 'wrong'
    }
  ];
});

window.notificationInvoice = {

  action: "invoice",
  body: "Abonent +998909464133 prosit Vas oplatit' 1000 sum na +998909464133(BEELINE)↵Naberite *880# dlya oplati ili otkaza",
  notify_id: "4503973",
  tap: false
};

window.notificationCardAdd = {

  action: "card.add",
  body: "Karta 8600***8946 uspeshno dobavlena. Pojaluysta ustanovite kartu dlya oplat po umolchaniyu v razdele 4)Nastroyki-4)Upravleniye kartami",
  notify_id: "8600330432558946",
  tap: false
};

window.notificationCardAddBack = {
  action: "card.add",
  collapse_key: "com.ios.xp",
  from: "206647793311",
  "google.message_id": "0:1492141725817086%37cfad8637cfad86",
  "google.sent_time": 1492141725644,
  "notify_id": "8600330432558946",
  "tap": true
};
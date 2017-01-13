window.fakedSocket.register("registration", function (input) {
  console.log("Input of REGISTER REQUEST ", input);
  return [{"method": input.method, "success": 1, "error": 0, "error_note": ""}];
});

window.fakedSocket.register("device.register.request", function (input) {
  console.log("Input of REGISTER REQUEST ", input);

  return [
    {"method": input.method, "success": 1, "error": 0, "error_note": ""},
    {
      "confirm_needed": true,
      "device_id": "9989094641336AC091D93CD5E",
      "language": "UZ"
    }
  ];
});

window.fakedSocket.register("device.register.confirm", function (input) {

  console.log("SMS_CODE ", input.parameters.sms_code);
  if (input.parameters.sms_code == '12345')
    return [
      {
        "method": input.method,
        "success": 1,
        "error": 0,
        "error_note": ""
      }
    ];
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
      {
        "method": input.method,
        "success": 1,
        "error": -4,
        "error_note": 'Neverniy PIN CODE'
      }
    ];

  return [
    {"method": input.method, "success": 1, "error": 0, "error_note": ""},
    {
      "session_key": "99890988081996E4e71383c9ed9b1a3fb05fb0002499744",
      "language": "RU",
      "default_account": "3487271",
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
    }];
});

window.fakedSocket.register("get.accounts", function (input) {

  var array = [];
  array.push({method: input.method, success: 1, error: 0, error_note: ""});
  array.push({
      acc_abs: "SMARTV    ",
      access: 2,
      accno: "8600 **** **** 5865",
      background_url: "resources/icons/cards/card1.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "8600 **** **** 5865",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      currency_code: "UZS",
      currency_name: "сум                                               ",
      description: "Карта UZCARD-Online",
      expire_date: "1806",
      id: 3487271,
      image_url: "https://merchant.click.uz/static/content/app/bank/aloq.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    },

    {
      acc_abs: "DUET    ",
      access: 2,
      accno: "1234 **** **** 5678",
      background_url: "resources/icons/cards/card2.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "1234 **** **** 5678",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      currency_code: "UZS",
      currency_name: "тенге                                               ",
      description: "Карта KAZKOM-Online",
      expire_date: "1806",
      id: 2484171,
      image_url: "https://merchant.click.uz/static/content/app/bank/ofb.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    },
    {
      acc_abs: "SMARTV    ",
      access: 2,
      accno: "8600 **** **** 5865",
      background_url: "resources/icons/cards/card1.png",
      bank_name: "UZCARD",
      branch: "00000",
      card_num: "8600 **** **** 5865",
      card_num_crypted: "lOsf9WfWjE0SkLmL/vo7BZaXMoJzK7kko4NdN66GDH+AYhDbjw7vzSKi7HcX0XZgLF+KKa8DMlt3Y2Gd4hynoGo46t9ue/unPvX6KHO4TFKeEFrdo/BI5FcwF9gY3703MoVidiu1a1tdAotUXXB+sSlDFJkZghcg8+BQX3r9Zzw=",
      card_num_hash: "06F93764713760A6DEA80ABFADE34B17029CE010C391674798CCB7DEB77A34FC",
      currency: "000",
      currency_code: "UZS",
      currency_name: "сум                                               ",
      description: "Карта UZCARD-Online",
      expire_date: "1806",
      id: 5487271,
      image_url: "https://merchant.click.uz/static/content/app/bank/aloq.png",
      is_uzcard: 1,
      removable: 1,
      short_name: "aloq"
    });

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("get.balance", function (input) {

  if (localStorage.getItem("click_client_token")) {
    console.log(' account ID  AAA ', input.parameters.account_id)
    if (input.parameters.account_id == 3487271) {
      return [
        {"method": 'get.balance', "success": 1, "error": 0, "error_note": ""},
        {
          "account_id": input.parameters.account_id,
          "balance": 6000
        }
      ];
    }

    if (input.parameters.account_id == 2484171) {
      return [
        {"method": 'get.balance', "success": 1, "error": 0, "error_note": ""},
        {
          "account_id": input.parameters.account_id,
          "balance": 1234321
        }
      ];
    }

    if (input.parameters.account_id == 5487271) {
      return [
        {"method": 'get.balance', "success": 1, "error": 0, "error_note": ""},
        {
          "account_id": input.parameters.account_id,
          "balance": 430
        }
      ];
    }
  }
  else
    return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Nevozmozhno poluchit balans zapreshen'}];
});

window.fakedSocket.register("get.payments.by.account", function (input) {


  var array = [];
  array.push({method: input.method, success: 1, error: 0, error_note: ""});
  array.push({
      "payment_id": 277019456,
      "amount": 1000,
      "cntrg_info_param2": "974647747",
      "cntrg_info_param3": null,
      "cntrg_info_param4": null,
      "cntrg_info_param5": null,
      "status_note": "Успешно проведен",
      "state": 0,
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
      "amount": 125,
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
      "amount": 5580,
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
    });
  if (localStorage.getItem("click_client_token"))
    return array;

  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'error '}];
});


window.fakedSocket.register("get.service.category.list", function (input) {

  var array = [];
  array.push({method: input.method, success: 1, error: 0, error_note: ""});
  array.push({
      color_hex: "#e7b949",
      color_rgb: "231-185-73",
      icon: "https://m.click.uz/static/merchant/categories/1.png",
      id: 1,
      name: "Мобильные операторы",
      parent: 0,
      priority: 0,
      status: true
    },
    {
      color_hex: "#87c965",
      color_rgb: "135-201-101",
      icon: "https://m.click.uz/static/merchant/categories/2.png",
      id: 2,
      name: "Интернет провайдеры",
      parent: 0,
      priority: 10,
      status: true
    },
    {
      color_hex: "#e45e55",
      color_rgb: "228-94-85",
      icon: "https://m.click.uz/static/merchant/categories/6.png",
      id: 6,
      name: "Интернет сервисы",
      parent: 0,
      priority: 20,
      status: true
    },
    {
      color_hex: "#77acde",
      color_rgb: "119-172-222",
      icon: "https://m.click.uz/static/merchant/categories/8.png",
      id: 8,
      name: "Коммунальные платежи",
      parent: 0,
      priority: 35,
      status: true
    },
    {
      color_hex: "#6e9a8f",
      color_rgb: "110-154-143",
      icon: "https://m.click.uz/static/merchant/categories/10.png",
      id: 10,
      name: "Налоги",
      parent: 0,
      priority: 36,
      status: true
    },
    {
      color_hex: "#be2e1f",
      color_rgb: "190-46-31",
      icon: "https://m.click.uz/static/merchant/categories/11.png",
      id: 11,
      name: "Интернет пакеты",
      parent: 0,
      priority: 3,
      status: true
    },
    {
      color_hex: "#ee9344",
      color_rgb: "238-147-68",
      icon: "https://m.click.uz/static/merchant/categories/7.png",
      id: 7,
      name: "Телефония",
      parent: 0,
      priority: 5,
      status: true
    },

    {
      color_hex: "#52a450",
      color_rgb: "82-164-80",
      icon: "https://m.click.uz/static/merchant/categories/3.png",
      id: 3,
      name: "Телевидение",
      parent: 0,
      priority: 15,
      status: true
    },

    {
      color_hex: "#f3aab5",
      color_rgb: "243-170-181",
      icon: "https://m.click.uz/static/merchant/categories/5.png",
      id: 5,
      name: "Хостинг и домены",
      parent: 0,
      priority: 25,
      status: true
    },
    {
      color_hex: "#B58D74",
      color_rgb: "181-141-116",
      icon: "https://m.click.uz/static/merchant/categories/9.png",
      id: 9,
      name: "Такси",
      parent: 0,
      priority: 37,
      status: false
    },
    {
      color_hex: "#aeaced",
      color_rgb: "174-172-237",
      icon: "https://m.click.uz/static/merchant/categories/4.png",
      id: 4,
      name: "Перевод средств",
      parent: 0,
      priority: 40,
      status: true
    }
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});

window.fakedSocket.register("get.service.list", function (input) {

  var array = [];
  array.push({method: input.method, success: 1, error: 0, error_note: ""});
  array.push({
      category_id: 4,
      cost: 1,
      form_type: 1,
      id: -4,
      image: "https://m.click.uz/static/merchant/logo/logo_-4.png",
      is_communal: 0,
      is_mobile: 0,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму перевода",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 5000000.00 сум",
      lang_min_amount: "Минимальная сумма для оплаты 5000.00 сум",
      max_pay_limit: 5000000,
      min_pay_limit: 5000,
      name: "Payme",
      priority: 0,
      service_parameters: "0",
      service_short_name: "Perevod P2P",
      status: 0
    },
    {
      category_id: 4,
      cost: 1,
      form_type: 1,
      id: -2,
      image: "https://m.click.uz/static/merchant/logo/logo_-2.png",
      is_communal: 0,
      is_mobile: 0,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 50000.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 100.00 сум",
      max_pay_limit: 50000,
      min_pay_limit: 100,
      name: "Переводы Click",
      priority: 0,
      service_parameters: "3",
      service_short_name: "TRANSFER",
      status: 1
    },
    {
      category_id: 4,
      cost: 1,
      form_type: 1,
      id: -1,
      image: "https://m.click.uz/static/merchant/logo/logo_-1.png",
      is_communal: 0,
      is_mobile: 0,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 999999999.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 0.00 сум",
      max_pay_limit: 999999999,
      min_pay_limit: 0,
      name: "Переброс между счетами",
      priority: 0,
      service_parameters: "24576",
      service_short_name: "PEREBROS",
      status: 1
    },
    {
      category_id: 6,
      cost: 1,
      form_type: 1,
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
      status: 1
    },
    {
      category_id: 3,
      cost: 1,
      form_type: 1,
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
      status: 1
    },
    {
      category_id: 8,
      cost: 1,
      form_type: 3,
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
      status: 1
    },
    {
      category_id: 5,
      cost: 1,
      form_type: 1,
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
      status: 1
    },
    {
      category_id: 9,
      cost: 1,
      form_type: 1,
      id: 48,
      image: "https://m.click.uz/static/merchant/logo/logo_48.png",
      is_communal: 0,
      is_mobile: 0,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
      max_pay_limit: 1000000,
      min_pay_limit: 1000,
      name: "Taxi Aist",
      priority: 0,
      service_parameters: "0",
      service_short_name: "AIST_TAXI",
      status: 0
    },
    {
      category_id: 6,
      cost: 1,
      form_type: 1,
      id: 51,
      image: "https://m.click.uz/static/merchant/logo/logo_51.png",
      is_mobile: 0,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 1000000.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 100.00 сум",
      max_pay_limit: 1000000,
      min_pay_limit: 100,
      name: "Matbuot Tarkatuvchi",
      priority: 0,
      service_parameters: "0",
      service_short_name: "mt",
      status: 0
    },
    {
      category_id: 6,
      cost: 1,
      form_type: 1,
      id: 184,
      image: "https://m.click.uz/static/merchant/logo/logo_184.png",
      is_mobile: 0,
      lang_amount_hint: null,
      lang_amount_placeholder: "Введите сумму оплаты",
      lang_amount_title: "Сумма",
      lang_max_amount: "Максимальная сумма для оплаты 500000.00 сум ",
      lang_min_amount: "Минимальная сумма для оплаты 1000.00 сум",
      max_pay_limit: 500000,
      min_pay_limit: 1000,
      name: "Arba.uz",
      priority: 0,
      service_parameters: "0",
      service_short_name: "arba.uz",
      status: 0
    },
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
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
      name: "Мой номер",
      priority: 20,
      service_parameters: "1",
      service_short_name: "UZMOBILE",
      status: 1
    },
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
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
      status: 1
    },
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
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
      status: 1
    },
    {
      category_id: 1,
      cost: 1,
      form_type: 1,
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
      status: 1
    },
    {

      category_id: 1,
      cost: 1,
      form_type: 1,
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
      status: 1
    }
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Dostup zapreshen'}];
});


window.fakedSocket.register("get.service.parameters.list", function (input) {
  console.log("Input of REGISTER REQUEST ", input);

  var array = [];
  array.push({method: input.method, success: 1, error: 0, error_note: ""});
  array.push({
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
    }
  );
  array.push({
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
    }
  );

  if (localStorage.getItem("click_client_token"))
    return array;


  return [{"method": input.method, "success": 1, "error": -4, "error_note": 'Some error'}];
});

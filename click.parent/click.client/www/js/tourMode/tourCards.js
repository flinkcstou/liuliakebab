window.tourCards = {};

tourCards.registration =
  [{
    counter: 1, image: "resources/icons/ComponentTour/registration/1.png", title: "ШАГ 1",
    text: "Подключите услугу SMS-информирования в любом инфокиоске",
    back_color: "transparent", title_color: "#8b8b8b",
    icon_size: 68, icon_y: 100, check: "resources/1.png"
  }, {
    counter: 2,
    image: "resources/icons/ComponentTour/registration/2.png",
    title: "ШАГ 2",
    text: "Введите полный номер Вашего телефона",
    back_color: "transparent", title_color: "#8b8b8b",
    icon_size: 68, icon_y: 100, check: "resources/2.png"
  }, {
    counter: 3,
    image: "resources/icons/ComponentTour/registration/3.png",
    title: "ШАГ 3",
    text: "Для подтверждения устройства введите код, полученный по SMS",
    back_color: "transparent", title_color: "#8b8b8b",
    icon_size: 68, icon_y: 100, check: "resources/3.png"
  }, {
    counter: 4,
    image: "resources/icons/ComponentTour/registration/4.png",
    title: "ШАГ 4",
    text: "Введите 16-тизначный номер карты и срок её действия",
    back_color: "transparent", title_color: "#8b8b8b",
    icon_size: 75, icon_y: 86, check: "resources/4.png"
  },
    {
      counter: 5,
      image: "resources/icons/ComponentTour/registration/5.png",
      title: "ШАГ 5",
      text: "Установите CLICK-PIN из 5 цифр для подтверждения операций в системе CLICK",
      back_color: "transparent", title_color: "#8b8b8b",
      icon_size: 66, icon_y: 110, check: "resources/5.png"
    }
  ];

tourCards.mainpage = [{
  counter: 1, image: "resources/icons/ComponentTour/mainpage/total_balance.png",
  title: "ОБЩИЙ БАЛАНС",
  text: "Информация об общем балансе всех Ваших карт и история платежей",
  back_color: "	#0091EA", title_color: "white",
  icon_size: 28, icon_y: 49,
  check: "resources/total-balance1.png"
}, {
  counter: 2,
  image: "resources/icons/ComponentTour/mainpage/my_cards.png",
  title: "ОПЕРАЦИИ С КАРТАМИ",
  text: "Список подключенных карт и возможность добавления новых",
  back_color: "#0091EA", title_color: "white",
  icon_size: 71, icon_y: 47, check: "resources/my-cards1.png"
}];

tourCards.transfer = [{
  counter: 1, image: "resources/icons/ComponentTour/transfer/banks.png",
  title: "ДОСТУПНЫЕ БАНКИ",
  text: "Список банков, чьи карты доступны для переводов",
  back_color: "#0091EA", title_color: "white",
  icon_size: 28, icon_y: 46, check: "resources/banks1.png"
}, {
  counter: 2,
  image: "resources/icons/ComponentTour/transfer/card.png",
  title: "ПЕРЕВОД ПО НОМЕРУ КАРТЫ",
  text: "Возможность перевода средств по номеру банковской карты UzCARD",
  back_color: "transparent", title_color: "#8b8b8b",
  icon_size: 51, icon_y: 47, check: "resources/card1.png"
}, {
  counter: 3,
  image: "resources/icons/ComponentTour/transfer/contact.png",
  title: "ПЕРЕВОД ПО НОМЕРУ ТЕЛЕФОНА",
  text: "Возможность перевода средств по номеру телефона пользователя CLICK ",
  back_color: "transparent", title_color: "#8b8b8b",
  icon_size: 59, icon_y: 47, check: "resources/contact1.png"
}];

tourCards.invoice = [{
  counter: 1, image: "resources/icons/ComponentTour/invoice/invoice.png",
  title: "ВХОДЯЩИЕ СЧЕТА",
  text: "Список полученных счетов от друзей, поставщиков и входящие переводы по номеру телефона",
  back_color: "#e7e7e7", title_color: "#8b8b8b",
  icon_size: 30, icon_y: 47, check: "resources/invoice1.png"
}, {
  counter: 2,
  image: "resources/icons/ComponentTour/invoice/invoice-2.png",
  title: "ИСХОДЯЩИЕ СЧЕТА",
  text: "Список отправленных вами счетов друзьям и отправленные переводы по номеру телефона",
  back_color: "#e7e7e7", title_color: "#8b8b8b",
  icon_size: 30, icon_y: 47, check: "resources/invoice-21.png"
}];

tourCards.autopaymethod = [{
  counter: 1, image: "resources/icons/ComponentTour/autopaymethod/event.png",
  title: "АВТОПЛАТЕЖ ПО СОБЫТИЮ",
  text: "Возможность пополнять баланс автоматически, указав номер и сумму. Пока доступно для абонентов Beeline и Ucell",
  back_color: "#e7e7e7", title_color: "#8b8b8b",
  icon_size: 34, icon_y: 46, check: "resources/event1.png"
}, {
  counter: 2,
  image: "resources/icons/ComponentTour/autopaymethod/schedule.png",
  title: "АВТОПЛАТЕЖ ПО РАСПИСАНИЮ",
  text: "Удобный способ автоматизировать периодические платежи",
  back_color: "#e7e7e7", title_color: "#8b8b8b",
  icon_size: 34, icon_y: 46, check: "resources/schedule1.png"
}];

tourCards.calculator = [{
  counter: 1, image: "resources/icons/ComponentTour/calculator.png",
  title: "КАЛЬКУЛЯТОР ВАЛЮТ",
  text: "Удобный калькулятор для расчета суммы из $ в UZS по текущему курсу ЦБ РУ",
  back_color: "#e7e7e7", title_color: "#8b8b8b",
  icon_size: 30, icon_y: 46, check: "resources/calculator1.png"
}];

tourCards.friendhelp = [{
  counter: 1, image: "resources/icons/ComponentTour/friendhelp.png",
  title: "ПОМОЩЬ ДРУГА",
  text: "Возможность указать номер телефона Вашего друга и близкого для оплаты счета за Вас. Для добавления в список нажмите значок “+”",
  back_color: "#e7e7e7", title_color: "#8b8b8b",
  icon_size: 35, icon_y: 46, check: "resources/friend-help1.png"
}];
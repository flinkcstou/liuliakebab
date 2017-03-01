window.languages = {};

localStorage.setItem('settings_language', 'ru');

var RU_LANGUAGES =
{
  "CodeOfCountry": "998",

  "ComponentBankOperationsPay": "ОПЛАТА",

  "ComponentBankOperationsTransfer": "ПЕРЕВОДЫ",

  "ComponentBankOperationsAutoPay": "АВТОПЛАТЁЖ",

  "BankOperationsAutoPay": "МОИ КАРТЫ",

  "ComponentPopularServicesTitle": "Популярные сервисы",

  "ComponentFavoritePaymentsTitle": "Избранные платежи",

  "ComponentFooterContactsLabel": "КОНТАКТЫ",

  "ViewRegistrationTextField": "Введите номер телефона",
  "ViewRegistrationDeviceRememberLabel": "Запомнить устройство",
  "ViewRegistrationDeviceButtonEnterLabel": "Далее",
  "ViewRegistrationDeviceButtonHelp": "Помощь",
  "ViewRegistrationDeviceButtonOffline": "Офлайн режим",
  "ViewRegistrationDeviceButtonDemoVersion": "Демо версия",

  "ViewSmsFieldOne": "Введите код активации",
  "ViewSmsButtonHelp": "Помощь",
  "ViewSmsCodeActivationText": "Код активации выслан на номер:",
  "ViewSmsMessageTitle": "Мы позвоним вам через минуту,",
  "ViewSmsMessageTitleTwo": "чтобы сообщить код активации на номер:",
  "ViewSmsResendText": "Смс переотправлено на номер: ",

  "ViewAuthorizationClickPinLabel": "Введите CLICK-PIN",
  "ViewAuthorizationForgetPinLabel": "Забыли Click-Pin?",
  "ViewAuthorizationResetLocalStorageLabel": "Очистить данные",
  "ViewAuthorizationOfflineModeLabel": "Офлайн режим",

  "ViewInfoBalanceTitle": "Общий баланс",

  "ViewInfoMyFinanceTitle": "Мои финансы",
  "ViewInfoReportsTitle": "Отчёты",
  "ViewInfoLastOperations": "Последние операции",

  "ViewMyCardTransfer": "Переводы с карты на карту",
  "ViewMyCardTitleName": "ЗАРПЛАТНАЯ КАРТА",
  "ViewMyCardPay": "Оплата с карты",
  "ViewMyCardReports": "Отчеты по карте",
  "ViewMyCardBlock": "Заблокировать карту",
  "ViewMyCardLastOperations": "Последние операции",

  "ViewServicePageEnterLabel": "ДАЛЕЕ",
  "ViewServicePageAmountTextLabel": "Сумма оплаты:",

  "ViewMyCardListTitleName": "МОИ КАРТЫ",

  "ViewPayTitleName": "ОПЛАТА",

  "ComponentCategorySearchTitle": "ВЫБОР КАТЕГОРИИ",

  "ComponentContactSearchTitle": "ВЫБОР КОНТАКТА",

  "ViewServicePinCardPayFromField": "Оплатить с:",
  "ViewServicePinCardHelpText": "Помощь друга",
  "ViewServicePinCardButtonEnterLabel": "ОПЛАТИТЬ",

  "ViewPayConformEnterPhone": "Номер телефона:",
  "ViewPayConfirmAmountOfPay": "Сумма платежа:",
  "ViewPayConfirmCategory": "Категория:",
  "ViewPayConfirmMobileConnection": "Мобильная связь",
  "ViewPayConfirmPayFromCard": "Оплата с карты:",
  "ViewPayConfirmAddToFavorites": "Добавить в избранные",
  "ViewPayConfirmRemoveFromFavorites": "Удалить из избранных",
  "ViewPayConfirmAddToAutoPay": "Добавить в автоплатеж",
  "ViewPayConfirmPay": "ОПЛАТИТЬ",

  "ViewPayTransferMenuNameContact": "КОНТАКТ",
  "ViewPayTransferMenuNameCard": "КАРТА",
  "ViewPayTransferContactTextField": "Укажите номер телефона получателя:",
  "ViewPayTransferCardTextField": "Укажите номер карты получателя:",
  "ViewPayTransferNext": "ДАЛЕЕ",
  "ViewPayTransferTitle": "ПЕРЕВОДЫ",


  "ViewTransferTwoTax": "Комиссия: ",
  "ViewTransferTwoNext": "ДАЛЕЕ",
  "ViewTransferTwoTitle": "ПЕРЕВОД НА",
  "ViewTransferTwoSum": "СУММА",

  "ViewTransferThreeTitle": "ПЕРЕВОД НА",
  "ViewTransferThreeMenuTitle": "ПЕРЕВЕСТИ С КАРТЫ",

  "ViewTransferFourTitle": "ПЕРЕВОД НА",
  "ViewTransferFourEnterPhone": "Номер телефона получателя:",
  "ViewTransferFourEnterCard": "Номер карты получателя:",
  "ViewTransferFourAmountOfPay": "Сумма платежа:",
  "ViewTransferFourOwner": "Владелец:",
  "ViewTransferFourCategory": "Категория:",
  "ViewTransferFourMobileConnection": "Мобильная связь",
  "ViewTransferFourPayFromCard": "Перевод с карты:",
  "ViewTransferFourAddToFavouritePartOne": "Добавить",
  "ViewTransferFourAddToFavouritePartTwo": "в избранные",
  "ViewTransferFourAddToAutoPay": "Добавить в автоплатеж",
  "ViewTransferFourPay": "ПЕРЕВЕСТИ",
  "ViewTransferFourTax": "Комиссия: ",
  "ViewTransferFourTransferInformation": "Перевод с карты: ",

  "ComponentCodeConfirmTitle": "ЗАЩИТНЫЙ КОД",

  "ComponentSuccessMessage": "Перевод прошел успешно!",
  "ComponentSuccessMessageForPay": "Оплата проведена успешно!",
  "ComponentSuccessNext": "OK",

  "ComponentUnsuccessMessagePart1": 'Извините,',
  "ComponentUnsuccessMessagePart2": 'что-то пошло не так.',
  "ComponentUnsuccessMessagePart3": "Проверьте правильность введенных данных или попробуйте повторить перевод позже",

  "ComponentUnsuccessMessagePart3ForPay": "Проверьте правильность введенных данных или попробуйте повторить оплату позже",
  "ComponentUnsuccessNext": "OK",

  "ViewPinCodeClickPinLabel": "Установите CLICK-PIN",
  "ViewPinCodeConfirmClickPinLabel": "Подтвердите CLICK-PIN",

  "ViewCardEditTitleName": "НАСТРОЙКИ КАРТЫ",

  "ComponentPinResetTextOne": "При смене CLICK-PIN все Ваши карты будут отключены от системы CLICK",
  "ComponentPinResetTextTwo": "Продолжить?",
  "ComponentPinResetTextThree": "Все Ваши карты отключены от системы CLICK",
  "ComponentPinResetTextFour": "Для установки нового CLICK-PIN необходимо заново пройти регистрацию",
  "ComponentPinResetYesButtonLabel": "ДА",
  "ComponentPinResetNoButtonLabel": "НЕТ",
  "ComponentPinResetRegistrationButtonLabel": "РЕГИСТРАЦИЯ",

  "ComponentMenuOnlineMode": "Активен он-лайн режим",
  "ComponentMenuOfflineMode": "Активен USSD режим",
  "ComponentMenuBillings": "Активен USSD режим",


};

window.languages = RU_LANGUAGES;
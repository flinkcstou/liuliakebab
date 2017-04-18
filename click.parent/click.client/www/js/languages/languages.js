window.languages = {};

localStorage.setItem('settings_language', 'ru');

var RU_LANGUAGES =
{
  "CodeOfCountry": "998",
  "Currency": "сум",

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
  "ViewMyCardTitleName": "ДЕЙСТВИЯ С КАРТОЙ",
  "ViewMyCardPay": "Оплата с карты",
  "ViewMyCardReports": "Отчеты по карте",
  "ViewMyCardBlock": "Удалить карту",
  "ViewMyCardLastOperations": "Последние операции",

  "ViewServicePageEnterLabel": "Далее",
  //"ViewServicePageChooseRegion": "ВЫБЕРИТЕ РАЙОН",
  //"ViewServicePageChooseCity": "ВЫБЕРИТЕ ГОРОД",
  "ViewServicePageSaveLabel": "Сохранить",
  "ViewServicePageAmountTextLabel": "Сумма оплаты:",

//{(secondLevelArray && secondLevelArray[0])?(secondLevelArray[0].name):("")}
//{service.options_title}

  "ComponentReportFilterTitle": "Фильтры",
  "ComponentReportFilterDate": "Выбрать даты для фильтра",
  "ComponentReportFilterDateToday": "За сегодня",
  "ComponentReportFilterDateYesterday": "За вчера",
  "ComponentReportFilterDateWeek": "За текущую неделю",
  "ComponentReportFilterDatePastWeek": "За прошлую неделю",
  "ComponentReportFilterDateCurrentMonth": "За текущий месяц",
  "ComponentReportFilterDatePastMonth": "За прошлый месяц",

  "ComponentReportFilterAccount": "Выбрать карту для фильтра",

  "ComponentReportFilterByDate": "По дате",
  "ComponentReportFilterByAccount": "По карте",

  "ComponentReportFilterByDateFrom": "C",
  "ComponentReportFilterByDateTo": "По",

  "ComponentReportFilterReadyButton": "готово",

  "ComponentReportFilterTodayText": "сегодня",
  "ComponentReportFilterYesterdayText": "вчера",

  "ViewAmountCalculatorNameTitle": "КАЛЬКУЛЯТОР ВАЛЮТ",
  "ViewAmountCalculatorTextOne": "Введите сумму в USD",
  "ViewAmountCalculatorTextTwo": "Текущий курс: 1$=",
  "ViewAmountCalculatorTextThree": "Сумма в национальной валюте (сум)",
  "ViewAmountCalculatorCancelText": "Отменить",
  "ViewAmountCalculatorAcceptText": "Принять",

  "ViewMyCardListTitleName": "МОИ КАРТЫ",

  "ViewPayTitleName": "ОПЛАТА",

  "ComponentCategorySearchTitle": "ВЫБОР КАТЕГОРИИ",

  "ComponentContactSearchTitle": "ВЫБОР КОНТАКТА",

  "ViewServicePinCardPayFromField": "Оплатить с:",
  "ViewServicePinCardHelpText": "Помощь друга",
  "ViewServicePinCardButtonEnterLabel": "Оплатить",

  "ViewPayConformEnterPhone": "Номер телефона:",
  "ViewPayConfirmAmountOfPay": "Сумма платежа:",
  "ViewPayConfirmCategory": "Категория:",
  "ViewPayConfirmMobileConnection": "Мобильная связь",
  "ViewPayConfirmPayFromCard": "Оплата с карты:",
  "ViewPayConfirmFriendHelp": "Помощь друга:",
  "ViewPayConfirmAddToFavorites": "Добавить в избранные",
  "ViewPayConfirmAvailable": "Доступно",
  "ViewPayConfirmRemoveFromFavorites": "Удалить из избранных",
  "ViewPayConfirmAddToAutoPay": "Добавить в автоплатеж",
  "ViewPayConfirmPay": "Оплатить",

  "ViewPayTransferMenuNameContact": "КОНТАКТ",
  "ViewPayTransferMenuNameCard": "КАРТА",
  "ViewPayTransferContactTextField": "Укажите номер телефона получателя:",
  "ViewPayTransferCardTextField": "Укажите номер карты получателя:",
  "ViewPayTransferNext": "Далее",
  "ViewPayTransferTitle": "ПЕРЕВОДЫ",
  "ViewPayTransferCardOwnerTitle": "Владелец:",


  "ViewTransferTwoTax": "Комиссия: ",
  "ViewTransferTwoNext": "Далее",
  "ViewTransferTwoTitle": "ПЕРЕВОД НА",
  "ViewTransferTwoSum": "СУММА",

  "ViewTransferThreeTitle": "ПЕРЕВОД НА",
  "ViewTransferThreeMenuTitle": "ПЕРЕВЕСТИ С КАРТЫ",
  "ViewTransferThreeNext": "Далее",

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
  "ViewTransferFourPay": "Перевести",
  "ViewTransferFourTax": "Комиссия: ",
  "ViewTransferFourTransferInformation": "Перевод с карты: ",

  "ComponentCodeConfirmTitle": "ЗАЩИТНЫЙ КОД",

  "ComponentSuccessMessage": "Перевод прошел успешно!",
  "ComponentSuccessMessageForPay": "Оплата проведена успешно!",
  "ComponentSuccessMessageForPayFriendHelp": "Запрос передан в обработку",
  "ComponentSuccessNext": "OK",

  "ComponentSuccessMessageForAddingToFavorites": "Платёж успешно добавлен в избранные",

  "ComponentInProcessingPartOne": "Перевод передан на обработку.",
  "ComponentInProcessingPartTwo": "Ждите СМС с результатом!",

  "ComponentUnsuccessMessagePart1": 'Извините,',
  "ComponentUnsuccessMessagePart2": 'что-то пошло не так.',
  "ComponentUnsuccessMessagePart3": "Проверьте правильность введенных данных или попробуйте повторить перевод позже",

  "ComponentUnsuccessMessagePart3ForPay": "Проверьте правильность введенных данных или попробуйте повторить оплату позже",
  "ComponentUnsuccessNext": "OK",

  "ComponentDeleteText": "Вы действительно хотите удалить карту из приложения?",
  "ComponentDeleteTextYes": "ДА",
  "ComponentDeleteTextNo": "НЕТ",

  "ViewPinCodeClickPinLabel": "Установите CLICK-PIN",
  "ViewPinCodeConfirmClickPinLabel": "Подтвердите CLICK-PIN",

  "ViewCardEditTitleName": "НАСТРОЙКИ КАРТЫ",
  "ViewCardEditCardNameText": "Название карты",
  "ViewCardEditMakeMainText": "Сделать основной",

  "ViewInvoiceListTitle": "ВЫСТАВЛЕННЫЕ СЧЕТА",
  "ViewInvoiceListToUser": "пользователю",
  "ViewInvoiceListFromUser": "пользователем",
  "ViewInvoiceListInvoiceIsP2PToUser": "Получен перевод от:",
  "ViewInvoiceListInvoiceIsP2PFromUser": "Отправлен перевод на:",
  "ViewInvoiceListInvoiceIsNot2P2": "Вам выставлен счет:",

  "ViewInvoiceHistoryDetailTransferTitle": "ДЕТАЛИ ПЕРЕВОДА",
  "ViewInvoiceHistoryDetailTransferToNumberLabel": "Перевод на номер",
  "ViewInvoiceHistoryDetailTransferAmountLabel": "Cумма перевода:",
  "ViewInvoiceHistoryDetailTransferCommissionLabel": "Комиссия:",
  "ViewInvoiceHistoryDetailTransferCodeLabel": "Код перевода:",
  "ViewInvoiceHistoryDetailTransferNumberLabel": "Номер перевода:",
  "ViewInvoiceHistoryDetailTransferDateLabel": "Дата перевода:",
  "ViewInvoiceHistoryDetailTransferStatusLabel": "Статус:",

  "ViewInvoiceHistoryDetailPaymentTitle": "ДЕТАЛИ СЧЕТА",
  "ViewInvoiceHistoryDetailPaymentToNumberLabel": "Счет на оплату",
  "ViewInvoiceHistoryDetailPaymentAmountLabel": "Cумма оплаты:",
  "ViewInvoiceHistoryDetailPaymentNumberLabel": "Номер счета:",
  "ViewInvoiceHistoryDetailPaymentDateLabel": "Дата перевода:",
  "ViewInvoiceHistoryDetailPaymentStatusLabel": "Статус:",

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

  "ViewSettingsTitleName": "Настройки",
  "ViewSettingsTitleNameTwo": "НАСТРОЙКИ",
  "ViewMainSettingsTitle": "Персональные данные",
  "ViewMainSettingsTitleTwo": "ПЕРСОНАЛЬНЫЕ ДАННЫЕ",
  "ViewSecuritySettingsTitle": "Безопасность",
  "ViewFriendHelpSettingsTitle": "Помощь друга",
  "ViewSecuritySettingsFriendHelpTitle": "ПОМОЩЬ ДРУГА",
  "ViewInviteFriendSettingsTitle": "Пригласить друга",
  "ViewAboutSettingsTitle": "О программе",
  "ViewSupportSettingsTitle": "Служба поддержки",
  "ViewCallCenterSettingsTitle": "Позвонить в Контактный центр",

  "ViewSecuritySettingsTrustedDevicesTitle": "Доверенные устройства",
  "ViewSecuritySettingsPinChangeTitle": "Сменить CLICK-PIN",
  "ViewSecuritySettingsTouchScanUseTitle": "Использовать сканнер отпечатка пальца",
  "ViewSecuritySettingsBlockTitle": "Блокировка",
  "ViewSecuritySettingsBlockText": "Запрашивать CLICK-PIN после каждого сворачивания приложения",
  "ViewSecuritySettingsMyNumberHideTitle": "Скрыть мой номер",

  "ViewFriendHelpSettingsAddFriendText": "Добавить друга",
  "ViewFriendHelpSettingsFriendNameText": "Имя друга",
  "ViewFriendHelpSettingsAddText": "Добавить",
  "ViewFriendHelpSettingsAddFromContactsText": "Выбрать из контактов",
  "ViewFriendHelpSettingsCancelText": "Отменить",

  "ViewAboutSettingsAgreementTitle": "Пользовательское соглашение",
  "ViewAboutSettingsRateUsTitle": "Оцените нас в Google Play",

  "ViewSettingsAboutProgramTitleName": "О ПРОГРАММЕ",
  "ViewSettingsAboutProgramVersionTitleNamePartOne": "Версия 1.0 BETA",
  "ViewSettingsAboutProgramVersionTitleNamePartTwo": "5 марта, 2017",
  "ViewSettingsAboutProgramUserAgreementTitleName": "Пользовательское соглашение",
  "ViewSettingsAboutProgramRankTitleName": "Оцените нас в Google Play",

  "ViewSettingsAddFriendTitleName": "ДОБАВИТЬ ДРУГА",
  "ViewSettingsAddFriendPhoneNumberTitle": "Номер телефона",
  "ViewSettingsAddFriendNameTitle": "Имя друга",

  "ViewSettingsGeneralDownloadPhotoTitle": "Загрузить фото",
  "ViewSettingsGeneralDeletePhotoTitle": "Удалить фото",
  "ViewSettingsGeneralGenderMaleTitle": "Муж",
  "ViewSettingsGeneralGenderFemaleTitle": "Жен",

  "ViewSettingsUserAgreementTitle": "ПОЛЬЗОВАТЕЛЬСКОЕ СОГЛАШЕНИЕ",

  "ViewTransferDetailTitle": "ДЕТАЛИ ПЕРЕВОДА",
  "ViewTransferDetailTransferIconTitleOne": "Получен перевод",
  "ViewTransferDetailTransferIconTitleTwo": "от пользователя CLICK",
  "ViewTransferDetailTitleSum": "Сумма перевода:",
  "ViewTransferDetailTitleNumber": "Номер перевода:",
  "ViewTransferDetailTitleDate": "Дата перевода:",
  "ViewTransferDetailTitleStatus": "Статус:",
  "ViewTransferDetailTitleAccept": "Принять",
  "ViewTransferDetailTitleDecline": "Отклонить",

  "ViewTransferDetailConfirmEnterCodeLabel": "Введите секретный код для получения перевода:",
  "ViewTransferDetailConfirmShouldSendCodeLabelFirstPart": "Пользователь",
  "ViewTransferDetailConfirmShouldSendCodeLabelSecondPart": "должен сообщить вам секретный код",

  "ViewTransferOnCardTitleTextPartOne": "Зачислить средства в размере",
  "ViewTransferOnCardTitleTextPartTwo": "на карту:",
  "ViewTransferOnCardAcceptButtonText": "принять",

  "ViewAccountDetailTransferIconTitleOne": "Получен счет",
  "ViewAccountDetailTransferIconTitleTwo": "от пользователя CLICK",
  "ViewAccountDetailTitleSum": "Сумма платежа:",
  "ViewAccountDetailTitlePayFor": "Оплата за:",
  "ViewAccountDetailTitlePayFrom": "Оплата с:",
  "ViewAccountDetailTitle": "ДЕТАЛИ СЧЕТА",
  "ViewAccountDetailTitlePay": "Оплатить",
  "ViewAccountDetailTitleDecline": "Отказать",

  "ViewPaymentDetailTitleOne": "Получен счет",
  "ViewPaymentDetailTitleTwo": "от пользователя CLICK",
  "ViewPaymentDetailTitleTwoIfNotFriendsHelp": "от",
  "ViewPaymentDetailTitle": "ДЕТАЛИ СЧЕТА #",
  "ViewPaymentDetailTitleSum": "Сумма платежа:",
  "ViewPaymentDetailTitlePayFor": "Оплата за",
  "ViewPaymentDetailTitlePayFrom": "Оплатить с:",

  "ViewTrustedDevicesTitle": "доверенные устройства",

  "ViewReportMonthsArray": [{"name": "Январь", "count": 1}, {"name": "Февраль", "count": 2}, {
    "name": "Март",
    "count": 3
  }, {"name": "Апрель", "count": 4},
    {"name": "Май", "count": 5}, {"name": "Июнь", "count": 6}, {"name": "Июль", "count": 7}, {
      "name": "Август",
      "count": 8
    }, {"name": "Сентябрь", "count": 9},
    {"name": "Октябрь", "count": 10}, {"name": "Ноябрь", "count": 11}, {"name": "Декабрь", "count": 12}],

  "ViewReportMonthsArrayTwo": ["января", "февраля", "марта", "апреля", "мая", "июня", "июля", "августа", "сентября", "октября", "ноября", "декабря"],

  "ViewReportServiceAddToFavorites": "Добавить в избранные",
  "ViewReportServiceAddToAutoPayment": "Добавить в автоплатеж",
  "ViewReportServiceGetSupportHelp": "Получить помощь поддержки",
  "ViewReportServiceRepeatButtonLabel": "повторить",

  "ViewBankListTitleName": "ДОСТУПНЫЕ БАНКИ",
  "ViewBankListLimitForMonthText": "сум в месяц",
  "ViewBankListTransferLimitText": "Лимит на передачу:",
  "ViewBankListReceiveLimitText": "Лимит на прием:",

  "ViewAddCardTitle": "ДОБАВИТЬ КАРТУ",
  "ViewAddCardNameTitle": "Введите название карты",
  "ViewAddCardNumberTitle": "Номер карты",
  "ViewAddCardDateTitle": "Дата окончания",
  "ViewAddCardPinTitle": "Код банка",
  "ViewAddCardDoMainTitle": "Сделать основной",

  "ViewContactTitle": "КОНТАКТ",
  "ViewContactPay": "Оплатить за мобильный",
  "ViewContactTransfer": "Перевод по номеру телефона",
  "ViewContactChooseNumber": "ВЫБЕРИТЕ НОМЕР",

  "ComponentAlertClickPinErrorTextOne": 'CLICK-PIN набран неверно',
  "ComponentAlertClickPinErrorTextTwo": 'более 3 раз',
  "ComponentAlertClickPinErrorTextThree": 'и Ваш профиль заблокирован на 15 минут',
  "ComponentAlertOk": 'OK',


  "ViewQrTitle": "ОПЛАТА ТОВАРОВ И УСЛУГ",
  "ViewQrTitleAccept": "Далее",
  "ViewQrTitleCancel": "Отменить",

  "ViewReportServiceAmountOfPay": "Сумма платежа:",
  "ViewReportServicePayWithCard": "Оплата с карты:",
  "ViewReportServiceStatus": "Статус:",
  "ViewReportServicePaymentNumber": "Номер платежа:",
  "ViewReportServicePaymentDate": "Дата:",

  "ViewReportsFilterAllAccountsText": "Все карты и счета",

  "ViewReportsFilterMonthNotStartedYet": "ещё не наступил",

  "VewSettingsSupportMessage": "Если вы обнаружили ошибку, хотите получить помощь или внести предложение,пожалуйста, сообщите нам об этом",
  "VewSettingsSupportTheme": "ВЫБЕРИТЕ ТЕМУ ДЛЯ ОБРАЩЕНИЯ",
  "VewSettingsSupportRegistration": "РЕГИСТРАЦИЯ",
  "VewSettingsSupportPay": "ОПЛАТА",
  "VewSettingsSupportBalance": "БАЛАНС",
  "VewSettingsSupportOther": "ДРУГОЕ",

  "VewSettingsSupportPartTwoTheme": "ОБРАЩЕНИЕ НА ТЕМУ",
  "VewSettingsSupportPartTwoSend": "ОТПРАВИТЬ",

  "ViewHelpTitle": "ПОМОЩЬ",

  "ConnectionSocket": "Устанавливаем соединение...",
  "Downloading": "Загрузка...",

  "AuthorizationInProgress": "Выполняется вход...",

  "ViewAutoPayTitleName": "АВТОПЛАТЕЖ",
  "ViewAutoPayMethodChooseText": "Выберите тип автоплатежа:",
  "ViewAutoPayMethodEventText": "По событию",
  "ViewAutoPayMethodSchedulerText": "По расписанию",
};

window.languages = RU_LANGUAGES;
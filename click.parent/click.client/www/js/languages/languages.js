window.languages = {};

localStorage.setItem('settings_language', 'ru');

var RU_LANGUAGES =
  {
    "CodeOfCountry": "998",
    "PhoneNumberLength": 9,
    "Currency": "сум",
    "Back": "Назад",
    "Close": "Закрыть",
    "Add": "Добавить",
    "Save": "Сохранить",


    "PublicOfferConfirm": "Оплачивая Вы соглашаетесь с условиями",
    "PublicOffer": "публичной оферты",
    "ServiceUnavailableText": "Сервис временно не доступен",

    "ChooseFromContacts": "Выбрать контакт из телефонной книги",

    "ComponentBankOperationsPay": "ОПЛАТА",

    "ComponentBankOperationsTransfer": "ПЕРЕВОДЫ",

    "ComponentBankOperationsAutoPay": "АВТОПЛАТЁЖ",
    "ComponentBankOperationsQr": "СКАНЕР QR",
    "ComponentBankOperationsInPlacePay": "ОПЛАТА НА МЕСТАХ",

    "BankOperationsAutoPay": "МОИ КАРТЫ",

    "ComponentPopularServicesTitle": "Популярные сервисы",

    "ComponentFavoritePaymentsTitle": "Избранные платежи",

    "ComponentFooterContactsLabel": "КОНТАКТЫ",

    "ViewRegistrationTextField": "Введите номер телефона",
    "ViewRegistrationDeviceRememberLabel": "Запомнить устройство",
    "ViewRegistrationDeviceButtonEnterLabel": "ДАЛЕЕ",
    "ViewRegistrationDeviceButtonHelp": "Помощь",
    "ViewRegistrationDeviceButtonOffline": "Офлайн режим",
    "ViewRegistrationDeviceButtonDemoVersion": "Демо версия",

    "ViewSmsAriaLabelResendSms": "Отправить заново смс код",
    "ViewSmsFieldOne": "Введите код активации",
    "ViewSmsButtonHelp": "Помощь",
    "ViewSmsCodeActivationText": "Код активации выслан на номер:",
    "ViewSmsMessageTitle": "Мы позвоним вам через минуту,",
    "ViewSmsMessageTitleTwo": "чтобы сообщить код активации на номер:",
    "ViewSmsResendText": "Смс переотправлено на номер: ",
    "ViewSmsButtonEnterLabel": "Указать другой номер",
    "ViewSmsContinue": "ПРОДОЛЖИТЬ",

    "ViewAuthorizationFirstEnterAriaLabelShowPass": "Показать введённый пароль",
    "ViewAuthorizationClickPinLabel": "Введите CLICK-PIN",
    "ViewAuthorizationForgetPinLabel": "Забыли CLICK-PIN?",
    "ViewAuthorizationFirstEnterLabel": "ВОЙТИ",
    "ViewAuthorizationResetLocalStorageLabel": "Сбросить данные",
    "ViewAuthorizationOfflineModeLabel": "Офлайн режим",
    "ViewAuthorizationClickScanLabel": "CLICK PASS",

    "ViewAuthFingerprintModeButtonLabel": "ВОЙТИ ИСПОЛЬЗУЯ CLICK-PIN",
    "ViewAuthFingerprintBodyText": "Приложите палец к сканеру отпечатка для входа в приложение",
    "ViewAuthFingerprintErrorText": "Отпечаток пальца не распознан",

    "ViewInfoBalanceTitle": "Общий баланс",

    "ViewInfoAriaLabelReloadAmount": "Обновить баланс",

    "ViewInfoMyFinanceTitle": "Мои финансы",
    "ViewInfoReportsTitle": "Отчёты",
    "ViewInfoLastOperations": "Последние операции",

    "ViewMonitoringReportNoTokenTitle": "ОТЧЁТЫ",
    "ViewMonitoringReportYesTokenTitle": "МОНИТОРИНГ ЗА ",
    "ViewMonitoringReportTurnOnTextOne": "Включите сервис \"Мониторинг платежей\"",
    "ViewMonitoringReportTurnOnTextTwo": "и следите за передвижением Ваших средств",
    "ViewMonitoringReportTurnOnTurnOn": "ВКЛЮЧИТЬ СЕРВИС",
    "ViewMonitoringReportIncomeTypeTitle": "Поступление",
    "ViewMonitoringReportOutgoTypeTitle": "Расход",

    "ViewReportFilterTitle": "ФИЛЬТРЫ",
    "ViewReportFilterSaveButton": "СОХРАНИТЬ",
    "ViewReportFilterApplyButton": "ПРИМЕНИТЬ",
    "ViewReportFilterByDateTitle": "Фильтр по дате",
    "ViewReportFilterByCardTitle": "Фильтр по карте",
    "ViewReportFilterDatePageTitle": "ПО ДАТЕ",
    "ViewReportFilterDateCustomText": "За определенный период",
    "ViewReportFilterDateCustomFrom": "с",
    "ViewReportFilterDateCustomTo": "по",
    "ViewReportFilterDateRangeToday": "За сегодня",
    "ViewReportFilterDateRangeYesterday": "За вчера",
    "ViewReportFilterDateRangeCurrentWeek": "За текущую неделю",
    "ViewReportFilterDateRangeLastWeek": "За прошлую неделю",

    "ViewReportFilterCardPageTitle": "ПО КАРТЕ",
    "ViewReportFilterCardChooseCardText": "Выберите карту",

    "ViewMyCardAriaLabelCardSettings": "Настройки карты",
    "ViewMyCardTransfer": "Переводы с карты на карту",
    "ViewMyCardTitleName": "ДЕЙСТВИЯ С КАРТОЙ",
    "ViewMyCardPay": "Оплата с карты",
    "ViewMyCardReports": "Отчеты по карте",
    "ViewMyCardBlock": "Удалить карту",
    "ViewMyCardLastOperations": "Последние операции",
    "ViewMyCardSuccessDelete": "Карта успешно удалена",
    "ViewMyCardTransferDeniedAccess": "Извининте, вы не можете произвести перевод с этой карты",
    "ViewMyCardTransferDeniedP2p": "Первод средств с данной карты недоступен",

    "ViewServicePageEnterLabel": "ПРОДОЛЖИТЬ",
    "ViewServicePageChooseCityLabel": "Выберите город",
    "ViewServicePageChooseDistrictLabel": "Выберите район",
    //"ViewServicePageChooseRegion": "ВЫБЕРИТЕ РАЙОН",
    //"ViewServicePageChooseCity": "ВЫБЕРИТЕ ГОРОД",
    "ViewServicePageSaveLabel": "СОХРАНИТЬ",
    "ViewServicePagePayLabel": "ОПЛАТИТЬ",
    "ViewServicePageVoiceOverOpenCalculator": "Открыть калькулятор",
    "ViewServicePageAmountTextLabel": "Сумма оплаты:",
    "PlusCommission": "Плюс комиссия - ",
    "Commission": "Комиссия - ",
    "CommissionAndNds": "Комиссия (в т.ч. НДС) - ",
    "Nds": "НДС - ",
    "PlusNds": "Плюс НДС - ",
    "PlusCommissionAndNds": "Плюс комиссия (в т.ч. НДС) - ",
    "ViewServiceToEnrollment": "Будет зачислено:",
    "ViewTrustedDevicesDeleteOtherDevice": "Вы действительно хотите удалить устройство из списка доверенных?",
    "ViewTrustedDevicesDeleteSelfDevice": "Вы действительно хотите удалить своё устройство из списка доверенных? (Потребуется повторная авторизация)",


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

  "ComponentReportFilterByDateFrom": "C:",
  "ComponentReportFilterByDateTo": "По:",

  "ComponentReportFilterReadyButton": "готово",

  "ComponentReportFilterTodayText": "сегодня",
  "ComponentReportFilterYesterdayText": "вчера",

  "ComponentReportFilterDoneButtonLabel": "Готово",
  "ComponentReportFilterCancelButtonLabel": "Отменить",

  "ComponentResultPleaseWait": "Пожалуйста подождите...",
  "ComponentResultOk": "Закрыть",
  "ComponentResultClose": "Закрыть",
  "ComponentResultQRScanSuccess": "Оплата по QR-коду прошла успешно",
  "ComponentResultQRFormSuccess": "Успешно проведено",

  "ViewAmountCalculatorNameTitle": "КАЛЬКУЛЯТОР ВАЛЮТ",
  "ViewAmountCalculatorTextOne": "Введите сумму в USD",
  "ViewAmountCalculatorTextTwo": "Текущий курс: 1$=",
  "ViewAmountCalculatorTextThree": "Сумма в национальной валюте (сум)",
  "ViewAmountCalculatorCancelText": "Отменить",
  "ViewAmountCalculatorAcceptText": "Принять",

  "ViewMyCardListTitleName": "МОИ КАРТЫ",
  "ViewMyCardListVoiceOverAddCard": "Добавить карту",

  "ViewPayTitleName": "ОПЛАТА",

  "ViewPayVoiceOverSearch": "Поиск сервисов",

  "ComponentCategorySearchTitle": "ВЫБОР КАТЕГОРИИ",

  "ComponentContactSearchTitle": "ВЫБОР КОНТАКТА",

  "ViewServicePinCardPayFromField": "Оплатить с:",
  "ViewServicePinCardHelpText": "Помощь друга",
  "ViewServicePinCardButtonEnterLabel": "Оплатить",

  "ViewPayConformEnterPhone": "Номер телефона:",
  "ViewPayConfirmAmountOfPay": "Сумма платежа:",
  "ViewPayConfirmCategory": "Категория:",
  "ViewPayConfirmServiceId": "ID Сервиса:",
  "ViewPayConfirmMobileConnection": "Мобильная связь",
  "ViewPayConfirmPayFromCard": "Оплата с карты:",
  "ViewPayConfirmFriendHelp": "Помощь друга:",
  "ViewPayConfirmAddToFavorites": "Добавить в избранные",
  "ViewPayConfirmAvailable": "Доступно",
  "ViewPayConfirmRemoveFromFavorites": "Удалить из избранных",
  "ViewPayConfirmAddToAutoPay": "Добавить в автоплатеж",
  "ViewPayConfirmPay": "ОПЛАТИТЬ",

  "ViewPayTransferMenuNameContact": "КОНТАКТ",
  "ViewPayTransferMenuNameCard": "КАРТА",
  "ViewPayTransferContactTextField": "Укажите номер телефона получателя:",
  "ViewPayTransferCardTextField": "Укажите номер карты получателя:",
  "ViewPayTransferNext": "ПРОДОЛЖИТЬ",
  "ViewPayTransferTitle": "ПЕРЕВОДЫ",
  "ViewPayTransferCardOwnerTitle": "Владелец:",
  "ViewPayTransferAccessToContacts": "Для быстрого поиска в адресной книге, необходимо разрешить приложению доступ к контактам на Вашем устройстве",
  "ViewPayTransferAccessToContactsSettings": "Перейти в настройки",
  "ViewPayTransferByCardNumber": "ПО НОМЕРУ КАРТЫ",
  "ViewPayTransferByPhoneNumber": "ПО НОМЕРУ ТЕЛЕФОНА",
  "ViewPayTransferBetweenCards": "МЕЖДУ СВОИМИ КАРТАМИ",
  "ViewPayTransferBetweenCardsTitle": "ПЕРЕВОД МЕЖДУ КАРТАМИ",
  "ViewPayTransferBetweenCardsFrom": "Карта списания:",
  "ViewPayTransferBetweenCardsTo": "Карта пополнения:",
  "ViewPayTransferHistory": "ИСТОРИЯ ПЕРЕВОДОВ",
  "ViewPayTransferByCardNumberTitle": "ПЕРЕВОД НА КАРТУ",
  "ViewPayTransferByPhoneNumberTitle": "ПЕРЕВОД НА НОМЕР",
  "ViewPayTransferHistoryTitle": "ИСТОРИЯ ПЕРЕВОДОВ",
  "ViewPayTransferNewCardTextField": "Введите номер карты получателя:",
  "ViewPayTransferNewContactName": "Пользователю CLICK",
  "ViewPayTransferNewCardName": "На карту друга",
  "ViewPayTransferNewBetweenName": "Между моими картами",
  "ViewPayTransferNewTitle": "ПЕРЕВОД СРЕДСТВ",
  "ViewPayTransferNewContactTextField": "Номер телефона друга:",
  "ViewPayTransferNewContinue": "ПРОДОЛЖИТЬ",
  "ViewPayTransferNewSubmitTransfer": "ПОДТВЕРДИТЬ ПЕРЕВОД",
  "ViewPayTransferNewCardOwnerTitle": "ФИО:",
  "ViewPayTransferNewSubmitRecieverLabel": "Получатель:",
  "ViewPayTransferNewSubmitTitle": "ПОДТВЕРЖДЕНИЕ ПЕРЕВОДА",


  "ViewTransferTwoTax": "Комиссия: ",
  "ViewTransferTwoNext": "ПРОДОЛЖИТЬ",
  "ViewTransferTwoTitle": "ПЕРЕВОД НА",
  "ViewTransferTwoSum": "Введите сумму",

  "ViewTransferThreeTitle": "ПЕРЕВОД НА",
  "ViewTransferThreeMenuTitle": "ПЕРЕВЕСТИ С КАРТЫ",
  "ViewTransferThreeNext": "ПРОДОЛЖИТЬ",
  "ViewTransferSubmitNoCards": "Нет карт доступных для переводов",

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
  "ComponentCodeConfirmMessageText": "Передайте код получателю для завершения перевода",
  "ComponentCodeConfirmOk": "OK",

  "ComponentSuccessMessage": "Перевод прошел успешно!",
  "ComponentSuccessMessageForPay": "Оплата проведена успешно!",
  "ComponentSuccessMessageForPayFriendHelp": "Запрос передан в обработку",
  "ComponentSuccessNext": "Закрыть",

  "ComponentSuccessMessageForAddingToFavorites": "Платёж успешно добавлен в избранные",
  "ComponentSuccessMessageForRemovingFromFavorites": "Платёж успешно удален из избранных",

  "ComponentInProcessingPartOne": "Перевод передан на обработку.",
  "ComponentInProcessingPartOneWithoutDot": "Перевод передан на обработку",
  "ComponentInProcessingPartOneForTransfer": "Перевод отправлен",
  "ComponentInProcessingPartTwoForTransfer": "и ожидает подтверждения получателя",
  "ComponentInProcessingForTransfer": "Перевод отправлен и ожидает подтверждения получателя",

  "ComponentInProcessingPartOneForPay": "Оплата передана на обработку.",
  "ComponentInProcessingPartTwo": "Ждите СМС с результатом!",
  "ComponentInProcessingPayment": "Оплата передана на обработку. Ждите СМС с результатом!",

  "ComponentUnsuccessMessagePart1": 'Извините,',
  "ComponentUnsuccessMessagePart2": 'что-то пошло не так.',
  "ComponentUnsuccessMessagePart3": "Проверьте правильность введенных данных или попробуйте повторить перевод позже",

  "ComponentUnsuccessMessagePart3ForPay": "Проверьте правильность введенных данных или попробуйте повторить оплату позже",
  "ComponentUnsuccessNext": "Закрыть",

  "ComponentDeleteText": "Вы действительно хотите удалить карту из приложения?",
  "ComponentDeleteTextYes": "Да",
  "ComponentDeleteTextNo": "Нет",

  "ViewPinCodeClickPinLabel": "Установите CLICK-PIN",
  "ViewPinCodeNowClickPinLabel": "Текущий CLICK-PIN",
  "ViewPinCodeConfirmClickPinLabel": "Подтвердите CLICK-PIN",
  "ViewPinCodeConfirmPayTransferLabel": "Введите CLICK-PIN для подтверждения",
  "ViewPinCodeConfirmPayTransferErrorAlertText": "Неверно набран CLICK-PIN, пожалуйста повторите ввод",
  "ViewPinCodeConfirmPayTransferThirdErrorAlertText": "CLICK-PIN набран неверно более 3 раз",

  "ViewCardEditTitleName": "НАСТРОЙКИ КАРТЫ",
  "ViewCardEditCardNameText": "Название карты",
  "ViewCardEditMakeMainText": "Сделать основной",

  "ViewInvoiceListTitle": "ВЫСТАВЛЕННЫЕ СЧЕТА",
  "ViewInvoiceListToUser": "ВХОДЯЩИЕ",
  "ViewInvoiceListFromUser": "ИСХОДЯЩИЕ",
  "ViewInvoiceListInvoiceIsP2PToUser": "Получен перевод от:",
  "ViewInvoiceListInvoiceIsP2PFromUser": "Отправлен перевод на:",
  "ViewInvoiceListInvoiceIsNot2P2ToUser": "Вам выставлен счет:",
  "ViewInvoiceListInvoiceIsNot2P2FromUser": "Отправлен счет:",

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
  "ComponentPinResetTextTwo": "ПРОДОЛЖИТЬ?",
  "ComponentPinResetTextThree": "Все Ваши карты отключены от системы CLICK",
  "ComponentPinResetTextFour": "Для установки нового CLICK-PIN необходимо заново пройти регистрацию",
  "ComponentPinResetYesButtonLabel": "ДА",
  "ComponentPinResetNoButtonLabel": "НЕТ",
  "ComponentPinResetRegistrationButtonLabel": "РЕГИСТРАЦИЯ",

  "ComponentMenuAriaLabelPersonalInfo": "Персональные данные",
  "ComponentMenuOnlineMode": "Активен онлайн режим",
  "ComponentMenuOnlineModeHint": "Ваш телефон подключен к интернету",
  "ComponentMenuOfflineMode": "Активен USSD режим",
  "ComponentMenuOfflineModeHint": "Ваш телефон отключен от интернета",
  "ComponentMenuBillings": "Активен USSD режим",

  "ViewSettingsTitleName": "Настройки",
  "ViewSettingsTitleNameTwo": "НАСТРОЙКИ",
  "ViewMainSettingsTitle": "Персональные данные",
  "ViewMainSettingsTitleTwo": "ПЕРСОНАЛЬНЫЕ ДАННЫЕ",
  "ViewSecuritySettingsTitle": "Безопасность",
  "ViewFriendHelpSettingsTitle": "Помощь друга",
  "ViewFriendHelpSettingsVoiceOverAddFriend": "Добавить друга",
  "ViewFriendHelpSettingsVoiceOverDeleteFriend": "Удалить друга",
  "ViewSecuritySettingsFriendHelpTitle": "ПОМОЩЬ ДРУГА",
  "ViewInviteFriendSettingsTitle": "Пригласить друга",
  "ViewAboutSettingsTitle": "О программе",
  "ViewSupportSettingsTitle": "Служба поддержки",
  "ViewSupportSettingsPageTitle": "СЛУЖБА ПОДДЕРЖКИ",
  "ViewCallCenterSettingsTitle": "Позвонить в Контактный центр",
  "ClearLocalStorage": "Очистить данные",

  "ViewSecuritySettingsTrustedDevicesTitle": "Доверенные устройства",
  "ViewSecuritySettingsPinChangeTitle": "Сменить CLICK-PIN",
  "ViewSecuritySettingsTouchScanUseTitle": "Использовать сканер отпечатка пальца",
  "ViewSecuritySettingsBlockTitle": "Блокировка приложения",
  "ViewSecuritySettingsBlockText": "Запрашивать CLICK-PIN после каждого сворачивания приложения",
  "ViewSecuritySettingsBlockPayTitle": "Блокировка платежей",
  "ViewSecuritySettingsBlockPayText": "Запрашивать CLICK-PIN при каждой транзакции",
  "ViewSecuritySettingsMyNumberHideTitle": "Скрыть мой номер",

  "ViewFriendHelpSettingsAddFriendText": "Добавить друга",
  "ViewFriendHelpSettingsFriendNameText": "Имя друга",
  "ViewFriendHelpSettingsAddText": "Добавить",
  "ViewFriendHelpSettingsAddFromContactsText": "Выбрать из контактов",
  "ViewFriendHelpSettingsCancelText": "Отменить",

  "ViewAboutSettingsAgreementTitle": "Пользовательское соглашение",
  "ViewAboutSettingsRateUsTitle": "Оцените нас в Google Play",

  "ViewSettingsAboutProgramTitleName": "О ПРОГРАММЕ",
  "ViewSettingsAboutProgramVersionTitleNamePartOne": "Версия 5.3.9",
  "ViewSettingsAboutProgramVersionTitleNamePartOneClick": "CLICK Uzbekistan",
  "ViewSettingsAboutProgramVersionTitleNamePartTwo": "21 сентября, 2018",
  "ViewSettingsAboutProgramUserAgreementTitleName": "Пользовательское соглашение",
  "ViewSettingsAboutProgramRankTitleName": "Оцените нас в Google Play",

  "ViewSettingsAboutProgramIOSRankTitleName": "Оцените нас в Apple Store",

  "ViewSettingsAddFriendTitleName": "ДОБАВИТЬ ДРУГА",
  "ViewSettingsAddFriendPhoneNumberTitle": "Номер телефона",
  "ViewSettingsAddFriendNameTitle": "Имя друга",

  "ViewSettingsGeneralVoiceOverEditName": "Изменить Имя",
  "ViewSettingsGeneralDownloadPhotoTitle": "Загрузить фото",
  "ViewSettingsGeneralDeletePhotoTitle": "Удалить фото",
  "ViewSettingsGeneralGenderMaleTitle": "Муж",
  "ViewSettingsGeneralGenderFemaleTitle": "Жен",
  "ViewSettingsGeneralSuccessSave": "Изменения сохранены",
  "ViewSettingsGeneralConfirmPhotoDelete": "Подтвердите удаление фото",
  "ViewSettingsGeneralLanguageRussian": "Русский",

  "ViewSettingsUserAgreementTitle": "ПОЛЬЗОВАТЕЛЬСКОЕ СОГЛАШЕНИЕ",

  "ViewPaymentMonitorTitle": "МОНИТОРИНГ ПЛАТЕЖЕЙ",
  "ViewPaymentMonitorAbout": "Данный сервис позволяет отслеживать полную историю расходов и поступлений по вашей карте",
  "ViewPaymentMonitorCostFirstPart": "Стоимость услуги ",
  "ViewPaymentMonitorCostSecondPart": " сум за каждую карту",
  "ViewPaymentMonitorOffer": "Публичная оферта",
  "ViewPaymentMonitorSuccessTurningOn": "Публичная оферта",

  "ViewTransferDetailTitle": "ДЕТАЛИ ПЕРЕВОДА",
  "ViewTransferDetailTransferIconTitleOne": "Получен перевод",
  "ViewTransferDetailTransferIconTitleTwo": "от пользователя CLICK",
  "ViewTransferDetailTitleSum": "Сумма перевода:",
  "ViewTransferDetailTitleNumber": "Номер перевода:",
  "ViewTransferDetailTitleDate": "Дата перевода:",
  "ViewTransferDetailTitleStatus": "Статус:",
  "ViewTransferDetailTitleAccept": "Принять",
  "ViewTransferDetailTitleDecline": "Отклонить",

  "ViewTransferDetailCodeNotEntered": "Введите секретный код",

  "ViewTransferDetailConfirmEnterCodeLabel": "Введите секретный код для получения перевода:",
  "ViewTransferDetailConfirmShouldSendCodeLabelFirstPart": "Пользователь",
  "ViewTransferDetailConfirmShouldSendCodeLabelSecondPart": "должен сообщить вам секретный код",

  "ViewTransferOnCardTitleTextPartOne": "Зачислить средства в размере",
  "ViewTransferOnCardTitleTextPartTwo": "на карту:",
  "ViewTransferOnCardAcceptButtonText": "ПРИНЯТЬ",
  "ViewTransferOnCardCardNotChosen": "Выберите карту",

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

  "ViewPaymentDetailTitleFriendHelpOne": "Помощь другу",
  "ViewPaymentDetailTitleFriendHelpTwo": "CLICK",
  "ViewPaymentDetailTitleTwoIfNotFriendsHelp": "от",
  "ViewPaymentDetailTitle": "ДЕТАЛИ СЧЕТА #",
  "ViewPaymentDetailTitleSum": "Сумма платежа:",
  "ViewPaymentDetailTitlePayFor": "Оплата за",
  "ViewPaymentDetailTitlePayFrom": "Оплатить с:",
  "ViewPaymentDetailCardNotChosen": "Выберите карты",

  "ViewTrustedDevicesTitle": "Доверенные устройства",
  "ViewTrustedDevicesVoiceOverRemove": "Удалить доверенное устройство",

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

  "ViewReportAriaLabelToggleGraphic": "Показать/Скрыть график",
  "ViewReportServiceAddToFavorites": "Добавить в избранные",
  "ViewReportServiceRemoveFromFavorites": "Удалить из избранных",
  "ViewReportServiceAddToAutoPayment": "Добавить в автоплатеж",
  "ViewReportServiceGetSupportHelp": "Получить помощь поддержки",
  "ViewReportServiceRepeatButtonLabel": "ПОВТОРИТЬ",
  "ViewReportServiceShowQrButtonLabel": "Показать QR-Код",

  "ViewBankListTitleName": "ЛИМИТЫ НА ПЕРЕВОДЫ",
  "ViewBankListLimitForMonthText": "сум",
  "ViewBankListTransferLimitText": "передача в месяц",
  "ViewBankListReceiveLimitText": "прием в месяц",
  "ViewBankListPublicOfferText": "ПУБЛИЧНАЯ ОФЕРТА",

  "ViewAddCardTitle": "ДОБАВИТЬ КАРТУ",
  //"ViewAddCardNameTitle": "Введите название карты",
  "ViewAddCardNameTitle": "Введите 16-тизначный номер карты и срок её действия",
  "ViewAddCardNumberTitle": "Номер карты",
  "ViewAddCardDateTitle": "Срок действия",
  "ViewAddCardPinTitle": "Код банка",
  "ViewAddCardDoMainTitle": "Сделать основной",
  "ViewAddCardAddBtnText": "ДОБАВИТЬ",

  "ViewContactTitle": "КОНТАКТ",
  "ViewContactPay": "Оплатить за мобильный",
  "ViewContactTransfer": "Перевод по номеру телефона",
  "ViewContactChooseNumber": "ВЫБЕРИТЕ НОМЕР",
  "ViewContactDeleteNumber": "Удалить контакт",

  "ComponentAlertClickPinErrorTextOne": 'CLICK-PIN набран неверно',
  "ComponentAlertClickPinErrorTextTwo": 'более 3 раз',
  "ComponentAlertClickPinErrorTextThree": 'и Ваш профиль заблокирован на 15 минут',
  "ComponentAlertOk": 'OK',
  "ComponentAlertRegister": 'Регистрация',


  "ViewQrTitle": "ОПЛАТА ТОВАРОВ И УСЛУГ",
  "ViewQrTitleAccept": "ПРОДОЛЖИТЬ",
  "ViewQrTitleCancel": "Отменить",
  "ViewQrLabelOnScanner": "Наведите камеру на QR код",

  "ViewQrInfoTitleAccept": "ОПЛАТИТЬ",

  "ViewClickPassTitle": "CLICK PASS",
  "ViewClickPassHelpFirst": "КАК РАБОТАЕТ",
  "ViewClickPassHelpSecond": "CLICK PASS",
  "ViewClickPassHelpFirstStep": "Выберите карту для оплаты",
  "ViewClickPassHelpSecondStep": "Позвольте продавцу отсканировать Ваш QR",
  "ViewClickPassHelpThirdStep": "Нужная сумма автоматически спишется с выбранной карты",
  "ViewClickPassChoseCard": "Выберите карту",
  "ViewClickPassShowToSeller": "Покажите QR код продавцу",

  "ViewReportServiceAmountOfPay": "Сумма платежа:",
  "ViewReportServicePayWithCard": "Оплата с карты:",
  "ViewReportServiceStatus": "Статус:",
  "ViewReportServicePaymentNumber": "Номер платежа:",
  "ViewReportServicePaymentDate": "Дата:",
  "ViewReportServiceCommissionCurrency": "сум",

  "ViewReportsFilterAllAccountsText": "Все карты и счета",

  "ViewReportsFilterMonthNotStartedYet": "ещё не наступил",

  "VewSettingsSupportMessage": "Если вы обнаружили ошибку, хотите получить помощь или внести предложение, пожалуйста, сообщите нам об этом",
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

  "ViewAutoPayVoiceOverAdd": "Добавить автоплатеж",

  "ViewAutoPayEveryMonthLastDayText": "Ежемесячно в последний день ",
  "ViewAutoPayEveryMonthLastDayTextTwo": "Конец месяца",
  "ViewAutoPayEveryMonthText": "Ежемесячно ",
  "ViewAutoPayAtText": " в ",
  "ViewAutoPayEveryWeekText": "Еженедельно ",

  "ViewAutoPayAfterMinimumBalansText": "При балансе меньше ",

  "ViewAutoPayMethodChooseText": "Выберите тип автоплатежа:",
  "ViewAutoPayMethodEventText": "По событию",
  "ViewAutoPayMethodSchedulerText": "По расписанию",

  "ViewAutoPayMethodEventPhoneNumber": "Номер абонента",
  "ViewAutoPayMethodEventPutBalansText": "Пополнить баланс, если на счету меньше",
  "ViewAutoPayMethodEventPayAmountText": "Сумма оплаты",
  "ViewAutoPayMethodEventAmountCanBeText": "Сумма может быть:",

  "ViewAutoPayMethodScheduleHowOftenText": "Как часто активировать автоплатеж:",
  "ViewAutoPayMethodScheduleEveryMonth": "Ежемесячно",
  "ViewAutoPayMethodScheduleEveryWeek": "Еженедельно",
  "ViewAutoPayMethodScheduleLastDay": "в последний день",
  "ViewAutoPayMethodScheduleChosenDay": "в указанный день",
  "ViewAutoPayMethodScheduleChoseDate": "Выберите дату",
  "ViewAutoPayMethodScheduleChoseTime": "Выберите время",
  "ViewAutoPayMethodScheduleHourText": "час",
  "ViewAutoPayMethodScheduleMinutesText": "мин",
  "ViewAutoPayMethodScheduleHMColonText": ":",
  "ViewAutoPayMethodScheduleChoseWeekDay": "Выберите день недели",
  "ViewAutoPayMethodScheduleChoseButtonLabel": "ВЫБРАТЬ",

  "ViewAutoPayMethodScheduleDaysArray": [{"k": -3, "v": '28'}, {"k": -2, "v": '29'}, {"k": -1, "v": '30'},
    {"k": 0, "v": '31'}, {"k": 1, "v": '01'}, {"k": 2, "v": '02'}, {"k": 3, "v": '03'},
    {"k": 4, "v": '04'}, {"k": 5, "v": '05'}, {"k": 6, "v": '06'}, {"k": 7, "v": '07'},
    {"k": 8, "v": '08'}, {"k": 9, "v": '09'}, {"k": 10, "v": '10'}, {"k": 11, "v": '11'}, {"k": 12, "v": '12'},
    {"k": 13, "v": '13'}, {"k": 14, "v": '14'}, {"k": 15, "v": '15'}, {"k": 16, "v": '16'},
    {"k": 17, "v": '17'}, {"k": 18, "v": '18'}, {"k": 19, "v": '19'}, {"k": 20, "v": '20'}, {"k": 21, "v": '21'},
    {"k": 22, "v": '22'}, {"k": 23, "v": '23'}, {"k": 24, "v": '24'}, {"k": 25, "v": '25'}, {"k": 26, "v": '26'},
    {"k": 27, "v": '27'}, {"k": 28, "v": '28'}, {"k": 29, "v": '29'}, {"k": 30, "v": '30'},
    {"k": 31, "v": '31'}, {"k": 32, "v": '01'}, {"k": 33, "v": '02'}, {"k": 34, "v": '03'}, {"k": 35, "v": '04'}],

  "ViewAutoPayMethodScheduleWeekDaysArray": [{"k": -13, "v": "ПОНЕДЕЛЬНИК"},
    {"k": -12, "v": "ВТОРНИК"}, {"k": -11, "v": "СРЕДА"},
    {"k": -10, "v": "ЧЕТВЕРГ"}, {"k": -9, "v": "ПЯТНИЦА"},
    {"k": -8, "v": "СУББОТА"}, {"k": -7, "v": "ВОСКРЕСЕНЬЕ"}, {"k": -6, "v": "ПОНЕДЕЛЬНИК"},
    {"k": -5, "v": "ВТОРНИК"}, {"k": -4, "v": "СРЕДА"},
    {"k": -3, "v": "ЧЕТВЕРГ"}, {"k": -2, "v": "ПЯТНИЦА"},
    {"k": -1, "v": "СУББОТА"}, {"k": 0, "v": "ВОСКРЕСЕНЬЕ"},
    {"k": 1, "v": "ПОНЕДЕЛЬНИК"},
    {"k": 2, "v": "ВТОРНИК"}, {"k": 3, "v": "СРЕДА"},
    {"k": 4, "v": "ЧЕТВЕРГ"}, {"k": 5, "v": "ПЯТНИЦА"},
    {"k": 6, "v": "СУББОТА"}, {"k": 7, "v": "ВОСКРЕСЕНЬЕ"},
    {"k": 8, "v": "ПОНЕДЕЛЬНИК"}, {"k": 9, "v": "ВТОРНИК"},
    {"k": 10, "v": "СРЕДА"}, {"k": 11, "v": "ЧЕТВЕРГ"},
    {"k": 12, "v": "ПЯТНИЦА"}, {"k": 13, "v": "СУББОТА"}, {"k": 14, "v": "ВОСКРЕСЕНЬЕ"}, {"k": 15, "v": "ПОНЕДЕЛЬНИК"},
    {"k": 16, "v": "ВТОРНИК"}, {"k": 17, "v": "СРЕДА"},
    {"k": 18, "v": "ЧЕТВЕРГ"}, {"k": 19, "v": "ПЯТНИЦА"},
    {"k": 20, "v": "СУББОТА"}, {"k": 21, "v": "ВОСКРЕСЕНЬЕ"}],

  "ViewAutoPayMethodScheduleHoursArray": [{"k": -5, "v": '19'}, {"k": -4, "v": '20'}, {"k": -3, "v": '21'},
    {"k": -2, "v": '22'}, {"k": -1, "v": '23'}, {"k": 0, "v": '00'}, {"k": 1, "v": '01'},
    {"k": 2, "v": '02'}, {"k": 3, "v": '03'},
    {"k": 4, "v": '04'}, {"k": 5, "v": '05'}, {"k": 6, "v": '06'}, {"k": 7, "v": '07'},
    {"k": 8, "v": '08'}, {"k": 9, "v": '09'}, {"k": 10, "v": '10'}, {"k": 11, "v": '11'}, {"k": 12, "v": '12'},
    {"k": 13, "v": '13'}, {"k": 14, "v": '14'}, {"k": 15, "v": '15'}, {"k": 16, "v": '16'},
    {"k": 17, "v": '17'}, {"k": 18, "v": '18'}, {"k": 19, "v": '19'}, {"k": 20, "v": '20'}, {"k": 21, "v": '21'},
    {"k": 22, "v": '22'}, {"k": 23, "v": '23'}, {"k": 24, "v": '00'}, {"k": 25, "v": '01'}, {"k": 26, "v": '02'},
    {"k": 27, "v": '03'}, {"k": 28, "v": '04'}, {"k": 29, "v": '05'}, {"k": 30, "v": '06'}],

  "ViewAutoPayMethodScheduleMinutesArray": [{"k": -5, "v": '55'}, {"k": -4, "v": '56'},
    {"k": -3, "v": '57'}, {"k": -2, "v": '58'}, {"k": -1, "v": '59'}, {"k": 0, "v": '00'},
    {"k": 1, "v": '01'}, {"k": 2, "v": '02'}, {"k": 3, "v": '03'},
    {"k": 4, "v": '04'}, {"k": 5, "v": '05'}, {"k": 6, "v": '06'}, {"k": 7, "v": '07'},
    {"k": 8, "v": '08'}, {"k": 9, "v": '09'}, {"k": 10, "v": '10'}, {"k": 11, "v": '11'}, {"k": 12, "v": '12'},
    {"k": 13, "v": '13'}, {"k": 14, "v": '14'}, {"k": 15, "v": '15'}, {"k": 16, "v": '16'},
    {"k": 17, "v": '17'}, {"k": 18, "v": '18'}, {"k": 19, "v": '19'}, {"k": 20, "v": '20'}, {"k": 21, "v": '21'},
    {"k": 22, "v": '22'}, {"k": 23, "v": '23'}, {"k": 24, "v": '24'}, {"k": 25, "v": '25'}, {"k": 26, "v": '26'},
    {"k": 27, "v": '27'}, {"k": 28, "v": '28'}, {"k": 29, "v": '29'}, {"k": 30, "v": '30'},
    {"k": 31, "v": '31'}, {"k": 32, "v": '32'}, {"k": 33, "v": '33'}, {"k": 34, "v": '34'}, {"k": 35, "v": '35'},
    {"k": 36, "v": '36'}, {"k": 37, "v": '37'}, {"k": 38, "v": '38'}, {"k": 39, "v": '39'}, {"k": 40, "v": '40'},
    {"k": 41, "v": '41'}, {"k": 42, "v": '42'}, {"k": 43, "v": '43'}, {"k": 44, "v": '44'},
    {"k": 45, "v": '45'}, {"k": 46, "v": '46'}, {"k": 47, "v": '47'}, {"k": 48, "v": '48'},
    {"k": 49, "v": '49'}, {"k": 50, "v": '50'}, {"k": 51, "v": '51'}, {"k": 52, "v": '52'},
    {"k": 53, "v": '53'}, {"k": 54, "v": '54'}, {"k": 55, "v": '55'}, {"k": 56, "v": '56'},
    {"k": 57, "v": '57'}, {"k": 58, "v": '58'}, {"k": 59, "v": '59'}, {"k": 60, "v": '00'}, {"k": 61, "v": '01'},
    {"k": 62, "v": '02'}, {"k": 63, "v": '03'}, {"k": 64, "v": '04'}, {"k": 65, "v": '05'}, {"k": 66, "v": '06'}],

  "ComponentConfirmOk": "Ок",
  "ComponentConfirmCancel": "Отмена",
  "ComponentConfirmNoInternetConnection": "Интернет соединение отсутствует. Перейти в офлайн режим?",

  "ViewAutoPayNameFieldText": "Название автоплатежа",
  "ViewAutoPayConditionFieldText": "Условие",
  "ViewAutoPayCreateButtonText": "СОЗДАТЬ",
  "ViewAutoPayDeleteButtonText": "УДАЛИТЬ",
  "ViewAutoPayCreatedSuccessTextOne": "Автоплатеж ",
  "ViewAutoPayCreatedSuccessTextTwo": " успешно создан!",
  "ViewAutoPayDeletedSuccessText": "Автоплатеж успешно удален!",

  "ViewServiceInfoButtonNextText": "ПРОДОЛЖИТЬ",
  "ViewServiceInfoButtonGoToPaymentText": "ПЕРЕЙТИ К ОПЛАТЕ",

  "ComponentToolbarAriaLabelOpenSideMenu": "Открыть боковое меню",
  "ComponentToolbarAriaLabelOpenBalanceInfo": "Информация об общем балансе всех Ваших карт и история платежей",
  "ComponentToolbarAriaLabelOpenNews": "Открыть новости",
  "ComponentToolbarTitle": "ОТЧЕТЫ",

  "ComponentKeyboardAriaLabelDeleteSym": "Удалить последний символ",

  "ComponentTourRegistrationTitleText": "Помощь в регистрации",
  "ComponentTourMainPageTitleText": "Тур по приложению",
  "ComponentTourNextButtonText": "Далее",
  "ComponentTourCloseButtonText": "Закрыть",
  "ComponentTourCloseButtonTextIn": "Понятно",
  "ComponentTourRegistrationButtonText": "Понятно",


  "ViewAutoPayEmptyTitleText": "СПИСОК АВТОПЛАТЕЖЕЙ ПУСТ",
  "ViewAutoPayEmptyBodyText": "Нажмите на \"+\" для создания автоплатежа",
  "ViewFavoriteAriaLabelAddOperation": "Добавить операцию",
  "ViewFavoriteAriaLabelEditOperation": "Редактировать операцию",
  "ViewFavoriteAriaLabelRemoveOperation": "Удалить операцию",
  "ViewFavoriteEmptyTitleText": "ВЫ ЕЩЕ НЕ ДОБАВИЛИ НИ ОДНОГО ИЗБРАННОГО ПЛАТЕЖА",
  "ViewFavoriteEmptyBodyText": "Нажмите на \"+\" для добавления платежа в избранные",
  "ViewFavoriteBodyTitleText": "ИЗБРАННЫЕ ПЛАТЕЖИ",
  "ViewInvoiceInEmptyTitleText": "",
  "ViewInvoiceInEmptyBodyText": "ПОКА ВАМ НИКТО НЕ ВЫСТАВЛЯЛ СЧЕТ",
  "ViewInvoiceOutEmptyTitleText": "",
  "ViewInvoiceOutEmptyBodyText": "ПОКА ВЫ НИКОМУ НЕ ВЫСТАВЛЯЛИ СЧЕТ",

  "ViewServicePageFavoriteNameField": "Название",
  "ViewServicePageFavoriteNamePlaceholder": "Введите название избранного",

  "ComponentGeneratedQrUpperInfoText": "Ваш  электронный билет (QR-код):",


  "ComponentCardCarouselAddFirstCardtext": "Добавьте свою первую карту в CLICK",
  "ComponentCardCarouselBalanceError": "Ошибка баланса",

  "ViewNewsDetails": "Подробнее",
  "ViewNewsFollowLink": "ПЕРЕЙТИ",

  "WaitingTimeExpiredText": "Время ожидания истекло",

  "ViewDefaultAccountTitle": "ОСНОВНАЯ КАРТА",
  "ViewDefaultAccountSubTitle": "Выберите основную карту",
  "ViewDefaultAccountChooseButtonText": "ВЫБРАТЬ",


  "ViewDefaultAccountSuccessText": "Основная карта установлена успешно",

  "DemoModeConstraintText": "Внимание! Для совершения данного действия необходимо авторизоваться!",


  "ViewInPlacePayTitle": "ОПЛАТА НА МЕСТАХ",
  "InPlaceSearchPlaceHolderText": "Поиск",
  "InPlaceSearchNoMatchText": "Нет совпадений",
  "InPlacePayGpsErrorText": "Пожалуйста, откройте настройки и разрешите CLICK Uzbekistan использовать ваше местонахождение и убедитесь что у вас включены геоданные",
  "QrJowiOfflineConstraintText": "Оплата за данного поставщика доступна только в онлайн режиме",
  "QrOnlyStartQrText": "Запустите QR сканер и отсканируйте QR-код в предоставленном чеке",
  "QrOnlyQrText": "QR сканер",
  "QrScanerText": "QR сканер",

  "ViewSettingsFriendHelpEmptyMessage": "ДОБАВЬТЕ КОНТАКТНЫЙ НОМЕР ИЗ АДРЕСНОЙ КНИГИ ТЕЛЕФОНА"
};

window.languages = RU_LANGUAGES;
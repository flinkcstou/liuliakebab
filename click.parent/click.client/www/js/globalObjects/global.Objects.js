window.viewMainPage = {};
viewMainPage.myCards = false;


window.viewMyCards = {};
viewMyCards.check = false;


window.viewAuthorization = {};
viewAuthorization.check = false;


window.viewRegistrationDevice = {};


window.viewSms = {};
viewSms.check = false;
viewSms.time = '';


window.history = {};
history.arrayOfHistory = [];
sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


window.viewRegistrationClient = {};
viewRegistrationClient.check = false;
viewRegistrationClient.cardNumber = '';
viewRegistrationClient.cardNumberCheck = false;
viewRegistrationClient.cardDateCheck = false;
viewRegistrationClient.cardPinCheck = false;


window.componentKeyboard = {};


window.viewMainPage = {};
viewMainPage.myCards = false;
window.viewMyCards = {};
viewMyCards.check = false;

window.viewAuthorization = {};
viewAuthorization.check = false;


window.viewRegistration = {};


window.viewSms = {};
viewSms.check = false;
viewSms.time = '';

window.history = {};
history.arrayOfHistory = [];
sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));

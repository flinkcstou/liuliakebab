window.viewMainPage = {};
viewMainPage.myCards = false;


window.viewMyCards = {};
viewMyCards.check = false;
viewMyCards.chosenCardId = '';


window.viewAuthorization = {};
viewAuthorization.check = false;


window.viewRegistrationDevice = {};

window.viewSms = {};


window.history = {};
history.arrayOfHistory = [];
sessionStorage.setItem('history', JSON.stringify(history.arrayOfHistory));


window.viewRegistrationClient = {};


window.componentKeyboard = {};

window.firstMount = {};

window.viewPay = {};
viewPay.getSampleFile();
viewPay.onErrorLoadFs();
viewPay.convertFileToDataURLviaFileReader();
viewPay.b64toBlob();
viewPay.savebase64AsImageFile();

window.viewServicePage = {};

window.viewServicePinCards = {};

window.viewMyCardList = {};

viewMyCardList.myCardListBoolean = false;

window.viewTransfer = {};
viewTransfer.phoneNumber = '';
viewTransfer.cardNumber = '';
viewTransfer.type = 2;

window.viewTransferStepTwo = {};
viewTransferStepTwo.sum = '';
viewTransferStepTwo.sumWithoutSpace = '';

window.viewTransferStepThree = {};
window.viewTransferStepFour = {};

window.viewTransferThree = {};
viewTransferThree.check = false;


window.SMS_FAKE = {};

setTimeout(function () {
  if (!window.SMS) {
    window.SMS = window.SMS_FAKE;
  }
}, 0);
  
window.SMS_FAKE.send = function (message) {
  console.log("Sended sms with message: " + message)
};

window.SMS_FAKE = {};

setTimeout(function () {
  if (!window.SMS) {
    window.SMS = window.SMS_FAKE;
  }
}, 0);
  
window.SMS_FAKE.send = function (message) {
  console.log("Sended sms with message: " + message)
  if(message == '12345')
    window.SMS_FAKE.result(true);
   window.SMS_FAKE.result(false);
};

window.SMS_FAKE.result = function(check){
  console.log(check)
  if(check)
    return true;
  return false;

}

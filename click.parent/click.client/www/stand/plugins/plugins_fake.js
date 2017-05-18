window.device_fake = {};
window.device_fake.model = 'Phone4';
window.device_fake.uuid = 'F93CF2F8-C2E3-408F-B3AE-32BA7050271F';
window.device_fake.platform = 'BrowserStand';
window.device_fake.info = 'Apple 9.3.5 iPhone4,1';
window.device_fake.check = false;

console.log("FAKE PLUGIN")
window.Keyboard_fake = {};
window.Keyboard_fake.hide = function (){
  //alert('keyboard is hidden')
};

window.exitApp = function (){
  //alert('keyboard is hidden')
};

if(!window.Keyboard){
  window.Keyboard = window.Keyboard_fake;
}

window.contact_fake = {};

contact_fake.ContactFindOptions = function () {
}


if (!window.ContactFindOptions) {
  window.ContactFindOptions = contact_fake.ContactFindOptions();
}

if (!window.device) {
  window.device = window.device_fake;
}


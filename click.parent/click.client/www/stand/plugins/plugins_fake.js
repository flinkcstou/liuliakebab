window.device_fake = {};
window.device_fake.model = 'Phone4,1';
window.device_fake.uuid = 'F93CF2F8-C2E3-408F-B3AE-32BA7050271F';
window.device_fake.platform = 'Android';
window.device_fake.info = 'Apple 9.3.5 iPhone4,1';
window.device_fake.check = false;


if (!window.device) {
  window.device = window.device_fake;
}

window.contact_fake = {};

contact_fake.ContactFindOptions = function () {
}


if (!window.ContactFindOptions) {
  window.ContactFindOptions = contact_fake.ContactFindOptions();
}


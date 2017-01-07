window.device_fake = {};
window.device_fake.model = 'iPhone 9';
window.device_fake.uuid = '2323232323253';
window.device_fake.platform = 'iOS';
window.device_fake.info = 'iPhone OS 9_3_5 Version/9.0 232323232323';
window.device_fake.check = false;


if (!window.device) {
  window.device = window.device_fake;
}

window.contact_fake = {};

contact_fake.ContactFindOptions = function () {}


if (!window.ContactFindOptions) {
  window.ContactFindOptions = contact_fake.ContactFindOptions();
}


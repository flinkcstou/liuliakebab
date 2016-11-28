window.device_fake = {};
window.device_fake.name = 'iPhone 9';
window.device_fake.uuid = '232323232323';
window.device_fake.platform = 'IOS';
window.device_fake.info =  'iPhone OS 9_3_5 Version/9.0 232323232323';

setTimeout(function () {
  if (!window.device) {
    window.device = window.device_fake;
  }
}, 0);

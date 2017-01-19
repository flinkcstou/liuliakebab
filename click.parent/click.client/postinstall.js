const fs = require('fs-extra');

if (!fs.existsSync("www/lib")) {
  fs.mkdirSync("www/lib");
}

fs.copySync("node_modules/riot/riot.js", "www/lib/js/riot.js");

//fs.copySync("cordova/AndroidManifest.xml", "cordova/platforms/android/AndroidManifest.xml")

const riot = require('riot-cli');

riot.make({
  from: 'www/app/',
  to  : 'www/lib/js/all.js'
});

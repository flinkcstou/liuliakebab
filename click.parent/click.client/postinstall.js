var fs = require('fs-extra');

if (!fs.existsSync("www/lib")) {
  fs.mkdirSync("www/lib");
}

fs.copySync("node_modules/riot/riot.js", "www/lib/riot/riot.js");


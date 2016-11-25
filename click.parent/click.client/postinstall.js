var fs = require('fs-extra');

if (!fs.existsSync("www2/lib")) {
  fs.mkdirSync("www2/lib");
}

fs.copySync("node_modules/riot/riot.js", "www2/lib/riot/riot.js");


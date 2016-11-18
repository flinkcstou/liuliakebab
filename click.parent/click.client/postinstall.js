var fs = require('fs-extra');

if (!fs.existsSync("www2/lib")) {
  fs.mkdirSync("www2/lib");
}

fs.copySync("node_modules/riot/riot+compiler.js", "www2/lib/riot/riot+compiler.js");



var devConfig = require("../config/uu5-environment-dev.json");
var config = require("./../src/uu5-environment.json");
if (devConfig) for (var k in devConfig) config[k] = devConfig[k];
window.UU5 = { Environment: config };

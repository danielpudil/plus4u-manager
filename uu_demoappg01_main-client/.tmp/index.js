var mod=require("module");
  var uri = ((mod ? mod.uri : (document.currentScript || Array.prototype.slice.call(document.getElementsByTagName("script"), -1)[0] || {}).src) || "").toString();
  __webpack_public_path__=uri.split(/\//).slice(0, -1).join("/") + "/"; // runtime publicPath configuration required for proper linking of styles, background images, ...
  module.exports = require("__project__/index.js");
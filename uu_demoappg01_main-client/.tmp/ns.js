export default {
    namespace: 'UU.Plus4UManager',
    cssPrefix: 'uu-plus4umanager',
    tag: function(component) {return this.namespace + '.' + component;},
    css: function(component) {return this.cssPrefix + '-' + component;},
  };
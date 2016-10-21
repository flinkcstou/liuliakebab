Ext.define('Click.controller.Main', {
  extend: 'Click.controller.Base',

  launch: function () {
    window.interaction = {};

    Ext.fly('appLoadingIndicator').destroy();

    this.showView('ViewMain');
  },

});

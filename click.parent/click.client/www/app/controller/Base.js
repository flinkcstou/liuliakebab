Ext.define('Click.controller.Base', {
  extend: 'Ext.app.Controller',

  showView: function (viewClass) {
    Ext.Viewport.removeAll(true, true);
    Ext.Viewport.add(Ext.create('Click.view.' + viewClass));
  },

});

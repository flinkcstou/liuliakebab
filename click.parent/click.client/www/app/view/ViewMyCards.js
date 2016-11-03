Ext.define('Click.view.ViewMyCards', {
  extend: 'Ext.Panel',
  xtype: 'viewMyCards',

  config: {
    title: 'cards',
    items: [{

      xtype: 'toolbar',
      items: [{
        xtype: 'button',
        text: '<--',
        action: 'back'
      }, {
        xtype: 'spacer'
      }, {
        xtype: 'label',
        name: 'title',
        html: 'Мои карты'
      }, {
        xtype: 'spacer'
      }]
    }]
  },

});

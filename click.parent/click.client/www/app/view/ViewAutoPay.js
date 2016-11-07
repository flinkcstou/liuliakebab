Ext.define('Click.view.ViewAutoPay', {
  extend: 'Ext.Panel',
  xtype: 'viewAutoPay',

  config: {
    title: 'cards',
    style: 'background: #007EE4',
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
        html: 'АВТОПЛАТЕЖ'
      }, {
        xtype: 'spacer'
      }]
    }]
  }

});

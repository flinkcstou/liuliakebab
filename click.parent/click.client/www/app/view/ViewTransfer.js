Ext.define('Click.view.ViewTransfer', {
  extend: 'Ext.Panel',
  xtype: 'viewTransfer',


  config: {
    html: 'Here will be my transfer information',
    title: 'pay',
    items: [
      {
        xtype: 'toolbar',
        items: [
          {
            xtype: 'button',
            text: '<--',
            action: 'back'
          },
          {
            xtype: 'spacer'
          },
          {
            xtype: 'label',
            name: 'title',
            html: 'Переводы'
          },
          {
            xtype: 'spacer'
          }
        ]
      }]
  }

});



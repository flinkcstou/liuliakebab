Ext.define('Click.view.ViewMyPayment',{
  extend: 'Ext.Panel',
  xtype: 'viewMyPayment',


  config: {
    html: 'Here will be my payments information',
    title:'pay',
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
          xtype:'label',
          name: 'title',
          html: 'Мои оплаты'
        },
        {
          xtype: 'spacer'
        }
      ]
    }]
  }
});

Ext.define('Click.view.ViewReport',{
  extend: 'Ext.Panel',
  xtype: 'viewReport',


  config: {
    html: 'Here will be my report information',
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
            html: 'Отчёты'
          },
          {
            xtype: 'spacer'
          }
        ]
      }]
  }
});

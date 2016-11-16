Ext.define('Click.view.ViewAuthorization', {
  extend: 'Ext.Panel',
  xtype : 'viewAuthorization',

  config: {
    items: [{
      xtype: 'textfield',
      name : 'authorizationField',
      label: 'авторизация',
    },
      {
        xtype : 'button',
        text  : 'далее',
        action: 'authorization'
      },
      {
        xtype : 'button',
        text  : 'удалить все номера',
        action: 'delete',
        docked: 'bottom'
      }
    ]
  }
});
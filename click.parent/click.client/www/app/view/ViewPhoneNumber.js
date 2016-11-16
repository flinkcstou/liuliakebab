Ext.define('Click.view.ViewPhoneNumber', {
  extend: 'Ext.Panel',
  xtype : 'viewPhoneNumber',

  config: {

    xtype: 'fieldset',
    items: [{
      xtype    : 'textfield',
      maxlength: 12,
      label    : 'Введите номер телефона',
      name     : 'phoneNumberID',
    },
      {
        xtype : 'button',
        text  : 'далее',
        action: 'next',
      },
      {
        xtype : 'button',
        text  : 'удалить все номера',
        action: 'delete',
        docked: 'bottom'
      },
      {
        xtype    : 'textfield',
        maxlength: 6,
        label    : 'Введите код из СМС',
        name     : 'smsField'
      },
      {
        xtype : 'button',
        text  : 'Подтвердить',
        action: 'confirmSms'
      },
      {
        xtype : 'button',
        text  : 'Повторить отправку СМС',
        action: 'resendSms'
      },
      {
        xtype  : 'checkboxfield',
        name   : 'smsChecker',
        label  : 'Запомнить устройство',
        checked: false
      }]
  }
});
Ext.define('Click.view.ViewPhoneNumber', {
  extend: 'Ext.Panel',
  xtype : 'viewPhoneNumber',

  config: {

    xtype:'fieldset',
    items: [{
      xtype    : 'textfield',
      maxlength: 12,
      label    : 'Phone number',
      name:'phoneNumberID',
      component: {
        type: 'tel'
      }
    },
      {
        xtype:'button',
        text:'далее',
        action: 'next'
      }]
  }
});
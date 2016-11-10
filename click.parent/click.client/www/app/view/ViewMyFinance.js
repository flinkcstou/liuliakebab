Ext.define('Click.view.ViewMyFinance', {
  extend: 'Ext.Panel',
  xtype : 'viewMyFinance',

  config: {
    title: 'finance',
    items: [{
      xtype: 'toolbar',
      items: [{
        xtype : 'button',
        text  : '<--',
        action: 'back'
      }, {
        xtype: 'spacer'
      }, {
        xtype: 'label',
        name : 'title',
        html : 'Мои финансы'
      }, {
        xtype: 'spacer'
      }]
    }, {
      xtype: 'label',
      html : 'Привет мир Hi world <b>жирный</b>',
      style: "font-family: 'Neuron';",
    }]
  }

});
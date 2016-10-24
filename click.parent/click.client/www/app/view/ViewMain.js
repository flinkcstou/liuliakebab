Ext.define('Click.view.ViewMain', {
  extend: 'Ext.Panel',
  xtype : 'main',

  requires: [
    'Ext.carousel.Carousel'
  ],

  config: {
    cls   : 'cards',
    layout: {
      type : 'vbox',
      align: 'stretch'
    },

    items: [{
      xtype : 'container',
      layout: 'hbox',
      flex  : 17,

      items: [{
        xtype: 'label',
        html : 'ssssssss',
      }],
    }, {
      xtype    : 'carousel',
      direction: 'horizontal',
      flex     : 29,

      items: [{
        html : 'hi 1',
        cls  : 'card',
        style: 'background-color: #5E99CC'
      }, {
        html : 'hi 2',
        cls  : 'card',
        style: 'background-color: #759E60'
      }, {
        html : 'Card #3',
        cls  : 'card',
        style: 'background-color: red'
      }]
    }, {
      xtype   : 'container',
      layout  : 'hbox',
      flex    : 18,
      padding : '0 0.5em 0 0',
      defaults: {
        flex     : 1,
        margin   : '0.5em 0 0 0.5em',
        xtype    : 'button',
        ui       : 'normal',
        iconAlign: 'top',
        iconMask : true,
      },

      items: [{
        text: 'Оплата',
        icon: 'resources/icons/32x32/main/Icon32x32_Payment.png',
      }, {
        text: 'Мои карты',
        icon: 'resources/icons/32x32/main/Icon32x32_MyCards.png',
      }, {
        text: 'Мои финансы',
        icon: 'resources/icons/32x32/main/Icon32x32_MyFinances.png',
      }],
    }, {
      xtype   : 'container',
      layout  : 'hbox',
      flex    : 18,
      padding : '0 0.5em 0 0',
      defaults: {
        flex     : 1,
        margin   : '0.5em 0 0 0.5em',
        xtype    : 'button',
        ui       : 'normal',
        iconAlign: 'top',
      },

      items: [{
        text: 'Переводы',
        icon: 'resources/icons/32x32/main/Icon32x32_Transactions.png',
      }, {
        text: 'Отчёты',
        icon: 'resources/icons/32x32/main/Icon32x32_Reports.png',
      }],
    }, {
      xtype   : 'container',
      layout  : 'hbox',
      flex    : 20,
      padding : '0 0.5em 0 0',
      defaults: {
        flex  : 1,
        margin: '0.5em 0 0 0.5em',
        xtype : 'button',
        ui    : 'normal',
      },

      items: [{
        icon: 'resources/icons/32x32/logos/Icon32x32_logo1.png',
      }, {
        icon: 'resources/icons/32x32/logos/Icon32x32_logo2.png',
      }, {
        icon: 'resources/icons/32x32/logos/Icon32x32_logo3.png',
      }, {
        icon: 'resources/icons/32x32/logos/Icon32x32_logo1.png',
      }, {
        icon: 'resources/icons/32x32/logos/Icon32x32_logo2.png',
      }, {
        icon: 'resources/icons/32x32/logos/Icon32x32_logo3.png',
      }],
    }, {
      xtype   : 'container',
      layout  : 'hbox',
      flex    : 5,
      defaults: {
        flex  : 1,
        margin: '0.5em',
        xtype : 'label',
      },

      items: [{
        html: 'asd 111',
      }],
    }],
  },
});

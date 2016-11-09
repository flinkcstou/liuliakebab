Ext.define('Click.view.ViewMainPage', {
  extend: 'Ext.Container',
  xtype : 'viewMain',

  requires: [
    'Ext.Panel',
    'Ext.Carousel',
    'Click.component.CarouselElement',
    'Ext.Menu',
    'Ext.Toolbar'
  ],

  config    : {
    cls   : 'cards',
    layout: {
      type : 'vbox',
      align: 'stretch'
    },

    items    : [{

      xtype : 'toolbar',
      docked: 'top',
      items : [{
        xtype : 'button',
        ui    : 'toolbar-left',
        icon  : 'resources/icons/32x32/menu.png',
        docked: 'left',

        //dlya Experimenta ne udalyat'
        handler: function () {
          if (Ext.Viewport.getMenus().left.isHidden()) {
            Ext.Viewport.showMenu('left');
          } else {
            Ext.Viewport.hideMenu('left');

          }
        }
      },
        {
          xtype : 'button',
          icon  : 'resources/icons/32x32/bell.png',
          action: 'openFooter',
          docked: 'right',
          ui    : 'toolbar-right',
        }]
    },
      {
        xtype : 'container',
        layout: 'hbox',
        flex  : 17,

        items: [{
          xtype: 'label',
          style: 'font-family: Neuron-Bold',
          html : 'HELLO IT IS NEURON'


        }]
      }, {
        xtype    : 'carousel',
        direction: 'horizontal',
        flex     : 29,
        defaults : {
          xtype: 'carouselElement'
        },

        items: [{
          sum   : '234000.99',
          number: '432145432656365',
        }, {
          sum: '1700000.23'
        }, {
          sum: '100000.99'
        }, {
          sum: '1111'
        }]
      },
      {

        xtype   : 'container',
        layout  : 'hbox',
        flex    : 14,
        padding : '0 0.5em 0 0',
        defaults: {
          flex     : 1,
          margin   : '0.5em 0 0 0.5em',
          xtype    : 'button',
          ui       : 'big-icon',
          iconAlign: 'top',
          iconMask : true
        },
        items   : [{
          style : 'font-family: Neuron',
          text  : 'ОПЛАТА',
          icon  : 'resources/icons/32x32/main/Icon32x32_Payment.png',
          action: 'myPay'
        }, {
          text  : 'ПЕРЕВОДЫ',
          icon  : 'resources/icons/32x32/main/Icon32x32_Transactions.png',
          action: 'transfer'

        }, {
          text  : 'АВТОПЛАТЕЖ',
          icon  : 'resources/icons/32x32/main/Icon32x32_MyCards.png',
          action: 'autoPay'
        }]
      }, {
        xtype   : 'container',
        layout  : 'hbox',
        flex    : 14,
        padding : '0 0.5em 0 0',
        defaults: {
          style    : 'font-family: Neuron',
          margin: '0.5em 0 0 0.5em',
          xtype : 'button',
          ui    : 'big-icon',
          iconAlign: 'top'
        },

        items: [{
          text  : 'МОИ ФИНАНСЫ',
          icon: 'resources/icons/32x32/main/Icon32x32_MyFinances.png',
          action: 'myFinance'

        }, {
          text  : 'ОТЧЁТЫ',
          icon: 'resources/icons/32x32/main/Icon32x32_Reports.png',
          action: 'report'
        }]
      }, {
        xtype   : 'container',
        layout: 'hbox',
        flex  : 20,
        padding: '0 0.5em 0 0',
        defaults: {
          flex     : 1,
          margin: '0.5em 0 0 0.5em',
          xtype : 'button',
          ui    : 'big-icon',
          iconAlign: 'top'
        }
      }, {
        xtype   : 'container',
        layout: 'hbox',
        flex  : 5,
        defaults: {
          flex  : 1,
          margin: '0.5em',
          xtype : 'label'
        }
      },
      {
        xtype : 'toolbar',
        docked: 'bottom',
        title : 'Контакты ^',

      }],
    listeners: {
      initialize: function () {
        Ext.Viewport.setMenu(this.createMenu(), {
          side  : 'left',
          reveal: true
        });
      }
    }
  },
//Sliding menu Here
  createMenu: function () {
    var items = [
      {
        xtype  : 'button',
        text : 'button1',
        iconCls: 'user',
        class  : 'menu-button'
      }
    ];
    return Ext.create('Ext.Menu', {
      style     : 'padding: 0',
      id   : 'menu',
      width: 300,
      scrollable: 'vertical',
      items     : items
    });
  }
});

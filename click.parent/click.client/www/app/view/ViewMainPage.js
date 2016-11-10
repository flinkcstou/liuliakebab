Ext.define('Click.view.ViewMainPage', {
  extend: 'Ext.Container',
  xtype : 'viewMain',

  requires: [
    'Ext.Panel',
    'Ext.Carousel',
    'Click.component.CarouselElement',
    'Ext.Menu',
    'Ext.Toolbar',
    'Click.component.BottomCarouselElement'
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
        icon  : 'resources/icons/32x32/toolbar/menu.png',
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
          icon  : 'resources/icons/32x32/toolbar/bell.png',
          action: 'openFooter',
          docked: 'right',
          ui    : 'toolbar-right',
        }]
    },
      {
        xtype : 'container',
        layout: 'hbox',
        flex  : 10,
        items : [{
          html: 'Общий баланс',

        }]
      }, {

        xtype    : 'carousel',
        name     : 'main',
        direction: 'horizontal',
        flex     : 29,
        defaults : {
          xtype: 'carouselElement',
          style: 'color: black',
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
        defaults: {
          xtype    : 'button',
          iconAlign: 'top',

        },
        items   : [{
          ui    : 'payment',
          text  : 'ОПЛАТА',
          icon  : 'resources/icons/32x32/main/payments.png',
          action: 'myPay'
        }, {
          ui    : 'transfer',
          text  : 'ПЕРЕВОДЫ',
          icon  : 'resources/icons/32x32/main/transfer.png',
          action: 'transfer'

        }, {
          ui    : 'autopay',
          text  : 'АВТОПЛАТЕЖ',
          icon  : 'resources/icons/32x32/main/autopay.png',
          action: 'autoPay'
        }]
      }, {
        xtype   : 'container',
        layout  : 'hbox',
        flex    : 14,
        defaults: {
          xtype    : 'button',
          iconAlign: 'top'
        },

        items: [{
          ui    : 'finance',
          text: 'МОИ ФИНАНСЫ',
          icon: 'resources/icons/32x32/main/myfinance.png',
          action: 'myFinance'

        }, {
          ui    : 'report',
          text: 'ОТЧЁТЫ',
          icon: 'resources/icons/32x32/main/reports.png',
          action: 'report'
        }]
      }, {
        xtype    : 'carousel',
        direction: 'horizontal',
        flex     : 20,
        default  : {
          style:"margin-top:10px;"
        },
        items    : [{
          style:"background-color: white;",
          items:[{
            html:'Популярные сервисы',
            style:"color: black;"
          }]
        },
          {
            style:"background-color: grey;"
          }]
      },
      {
        xtype : 'toolbar',
        docked: 'bottom',
        title : 'КОНТАКТЫ ^',
        //style: "font-family: 'Neuron';"

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

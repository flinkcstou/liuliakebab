Ext.define('Click.view.ViewMain', {
  extend: 'Ext.Container',
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
      defaults: {
        flex: 1,
        margin: '0.5em',
      },

      items: [{
        xtype: 'button',
        ui   : 'action',
        text : 'asd',
      }, {
        xtype: 'label',
        html : 'dsa',
      }, {
        xtype: 'label',
        html : 'dsa',
      }],
    }, {
      xtype   : 'container',
      layout  : 'hbox',
      flex    : 18,
      defaults: {
        flex: 1,
      },

      items: [{
        xtype: 'label',
        html : 'asd',
      }, {
        xtype: 'label',
        html : 'dsa',
      }],
    }, {
      xtype   : 'container',
      layout  : 'hbox',
      flex    : 25,
      defaults: {
        flex: 1,
      },

      items: [{
        xtype: 'label',
        html : 'asd 111',
      }, {
        xtype: 'label',
        html : 'dsa 222',
      }],
    }],
  },
});

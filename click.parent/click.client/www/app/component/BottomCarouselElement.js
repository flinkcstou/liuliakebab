Ext.define('Click.component.BottomCarouselElement', {
  extend: 'Ext.Component',
  xtype : 'bottomCarouselElement',

  config  : {

    baseCls: 'bottom-carousel-element',

    //backIcon: 'resources/images/card_bg.jpg'
    btn: null,
  },
  template: [{
    tag      : 'div',
    className: 'bottom-carousel-element',
    reference: 'serviceElement',
    children : [{
      tag      : 'button',
      className: 'bottom-button-beeline',
      style     : "background-image: url(resources/icons/32x32/services/beeline.png)",
      reference: 'buttonBeeline'
    },
      {
        tag      : 'button',
        reference: 'buttonUcell'
      },
      {
        tag      : 'button',
        reference: 'buttonUms'
      }]
  }],
});
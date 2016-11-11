Ext.define('Click.component.BottomCarouselElement', {
  extend: 'Ext.Component',
  xtype : 'bottomCarouselElement',

  config  : {

    baseCls: 'bottom-carousel-element',
    //backIcon: 'resources/images/card_bg.jpg'
    clr    : null,
  },
  template: [{
    tag      : 'div',
    reference: 'serviceElement',
    children : [{
      tag      : 'span',
      reference: 'colorElement'
    }]
  }],




    updateClr    : function (clr) {
    this.colorElement.setStyle('background-color', clr);
  }

});
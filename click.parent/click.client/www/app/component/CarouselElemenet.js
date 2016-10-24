Ext.define('Click.component.CarouselElement', {
  extend: 'Ext.Component',
  xtype : 'carouselElement',

  config: {
    baseCls: 'my-carousel-element',

    backIcon: 'resources/images/card_bg.jpg',
  },

  template: [
    {
      tag      : 'div',
      reference: 'cardElement',
      className: 'my-carousel-card',
      children : [{
        tag      : 'span',
        className: 'wow',
        reference: 'iconElement'
      }]
    },
  ],

  updateBackIcon: function (backIcon) {
    var element = this.cardElement;

    if (backIcon) {
      element.setStyle('background-image', 'url(' + backIcon + ')');
    } else {
      element.setStyle('background-image', null);
    }
  },

});

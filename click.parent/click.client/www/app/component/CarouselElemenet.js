Ext.define('Click.component.CarouselElement', {
  extend: 'Ext.Component',
  xtype : 'carouselElement',

  config: {
    baseCls: 'my-carousel-element',

    backIcon: 'resources/images/card_bg.jpg',

    sum: null,
  },

  template: [
    {
      tag      : 'div',
      reference: 'cardElement',
      className: 'my-carousel-card',
      children : [{
        tag      : 'span',
        className: 'my-carousel-card-sum',
        reference: 'sumElement',
      }, {
        tag      : 'span',
        className: 'my-carousel-card-title',
        reference: 'titleElement',
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

  updateSum: function (sum) {
    var element = this.sumElement;

    element.setHtml(sum);
  },

});

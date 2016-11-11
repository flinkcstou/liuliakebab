Ext.define('Click.component.BottomCarouselElement', {
  extend: 'Ext.Container',
  xtype : 'bottomCarouselElement',

  config: {
    xtype : 'container',
    layout: 'hbox',

    items: [
      {

        //НЕ ТРОГАТЬ ПРОВЕРКА
        html:'Популярные сервисы',
        style:'color:grey;' +
        'font-size:22px;' +
        'position:absolute;' +
        'left:25%;' +
        'top:18%;'
      },
      {
      xtype: 'button',
      icon : 'resources/icons/32x32/services/beeline.png',
      ui   : 'button-beeline',
    },
      {
        xtype:'button',
        ui  : 'button-ucell',
        icon: 'resources/icons/32x32/services/ucell.png'
      },
      {
        xtype:'button',
        ui  : 'button-ums',
        icon: 'resources/icons/32x32/services/ums.png'
      }]
  }
});
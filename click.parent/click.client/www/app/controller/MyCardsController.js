Ext.define('Click.controller.MyCardsController', {
  extend: 'Click.controller.Base',


  config: {
    refs: {
      view: 'viewMyCards',

      backButton: 'viewMyCards button[action=back]',
    },

    control: {
      view: {
        show: 'onShow',
      },
      backButton: {
        tap: 'backButtonTap',
      }
    }
  },

  onShow: function () {

  },

  backButtonTap: function () {
    this.showView('ViewMainPage');
  },

});
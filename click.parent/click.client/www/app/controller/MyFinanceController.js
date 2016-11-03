Ext.define('Click.controller.MyFinanceController', {
  extend: 'Click.controller.Base',

  config:{
    refs:{
      view: 'viewMyFinance',

      backButton: 'viewMyFinance button[action = back]',
    },

    control:{
      backButton: {
        tap: 'backButtonTap',
      }
    }

  },

  backButtonTap: function(){
    this.showView('ViewMainPage');
  }
});
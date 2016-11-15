Ext.define('Click.store.UserStore', {
  extend: 'Ext.data.Store',
  alias : 'store.UserStore',

  requires: ['Click.model.UserModel'],

  config: {
    model: 'Click.model.UserModel',
    proxy: {
      type: 'localstorage',
      id  : 'phoneNumber'
    }
  }
});
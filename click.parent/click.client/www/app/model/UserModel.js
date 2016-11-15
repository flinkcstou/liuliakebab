Ext.define('Click.model.UserModel', {
  extend: 'Ext.data.Model',
  xtype : 'userModel',

  config: {
    fields: [{
      name: 'phoneNumber',
      type: 'string'
    }],
  }
});
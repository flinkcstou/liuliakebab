Ext.define('Click.controller.TransferController', {
  extend: 'Click.controller.Base',


  config: {
    refs: {
      view: 'viewTransfer',

      backButton: 'viewTransfer button[action=back]',
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

      alert(true);
      /*if (Ext.os.deviceType == 'Phone'){
        var contactsConfig = {
          success: function( contacts){
            Ext.Msg.alert('Contacts?', contacts.length, Ext.emptyFn);
            console.log(navigator.contacts.fieldType.displayName);
          },

          failure: function(context){
            Ext.Msg.alert('Failure', 'It did not work.', Ext.emptyFn);
          },
          scope: this,
          includeImages: false
        };
        Ext.device.Contacts.getContacts(contactsConfig);
      }*/

  },

  backButtonTap: function () {
    this.showView('ViewMainPage');
  },

});
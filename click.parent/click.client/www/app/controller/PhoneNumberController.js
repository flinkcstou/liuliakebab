Ext.define('Click.controller.PhoneNumberController', {
  extend: 'Click.controller.Base',

  requires: ['Click.store.Api'],

  config: {
    refs: {
      view: 'viewPhoneNumber',

      nextButton : 'viewPhoneNumber button[action = next]',
      phoneNumber: 'viewPhoneNumber textfield[name = phoneNumberID]'
    },

    control: {
      view       : {
        show: 'onShow'
      },
      phoneNumber: {
        keyup: 'onPhoneNumberKeyUp'
      },
      nextButton : {
        tap: 'nextButtonTap'
      }
    },
  },

  onPhoneNumberKeyUp: function () {
    console.log(this.getPhoneNumber().getValue());
    if (this.getPhoneNumber().getValue().length > 12) {
      alert("Phone number is incorrect");
      this.getPhoneNumber().setValue('+7');
      this.getNextButton().setDisabled(true);
    }
    if(this.getPhoneNumber().getValue().length == 12){
      this.getNextButton().setDisabled(false);
    }
  },
  onShow: function () {
    this.getPhoneNumber().setValue('+7');
    this.getNextButton().setDisabled(true);

    var UserStore = Ext.getStore('UserStore');
    UserStore.load();

    var modelRecord = UserStore.getAt(0).get('phoneNumber');
    var modelRecord2 = UserStore.getAt(1).get('phoneNumber');
    console.log("MODEL RECORD " + modelRecord);
    console.log("MODEL RECORD 2 " + modelRecord2);

    var modelData = UserStore.getData();
    var length = UserStore.getData().length;

    console.log("Length of data " + length);
    console.log("MODEL DATA " + modelData);
  },

  nextButtonTap: function () {

    var UserStore = Ext.getStore('UserStore');
    UserStore.load();
    UserStore.add({
      phoneNumber: this.getPhoneNumber().getValue()
    });
    UserStore.sync();

    console.log(this.getPhoneNumber().getValue());

  }
});
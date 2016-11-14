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
  },

  nextButtonTap: function () {
    console.log(this.getPhoneNumber());
    console.log(this.getPhoneNumber().getValue());

  }
});
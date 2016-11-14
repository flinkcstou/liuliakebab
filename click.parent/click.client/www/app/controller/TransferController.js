Ext.define('Click.controller.TransferController', {
  extend: 'Click.controller.Base',


  config: {
    refs: {
      view: 'viewTransfer',

      backButton: 'viewTransfer button[action=back]'
    },

    control: {
      view: {
        show: 'onShow'
      },
      backButton: {
        tap: 'backButtonTap'
      }
    }
  },

  onShow: function () {


    var options = new ContactFindOptions();
    options.filter = "";
    options.multiple = true;
    filter = ["name"];
    navigator.contacts.find(filter, onSuccess, onError, options);


  function onSuccess(contacts){

  ///alert(JSON.stringify(contacts));
   alert(contacts[0].displayName);
    alert(contacts.length);

  for(var i = 0; i < contacts.length; i++){

      alert(contacts[i].displayName + ': ' + contacts[i].phoneNumbers[0].value);

     //alert(contacts[i].displayName + ' ' + contacts[i].phoneNumbers[0].value + ' '
       //  + contacts[i].emails[0].value + ' ' + contacts[i].organizations[0].name);

    /*if(contacts[i].organizations[0].name == "Greetgo"){
     alert(contacts[i].displayName);
     alert(contacts[i].phoneNumbers[0].value);
     alert(contacts[i].emails[0].value);
     alert(contacts[i].organizations[0].name);
     }*/


  }
}

function onError(){
  alert("Error");
}


/*var contactsConfig = {

  success: function( contacts){
    //Ext.Msg.alert(contacts.find());
    Ext.Msg.alert(JSON.stringify(contacts[0]));

    for(var i = 0; i < contacts.length; i++){
      //console.log(contacts[i].first + ' ' + contacts[i].last + ' ' + contacts[i].emails.work);
      //alert('Name:  ' + contacts[i].displayName + '\n' + 'Phone ' +
          //contacts[i].phoneNumbers[0].value + '\n' + 'email:  ' + contacts[i].emails[0].value
         // + '\n' + 'organization:  ' + contacts[i].organizations[0].name);
    }
  },

  failure: function(context){
    Ext.Msg.alert('Failure', 'It did not work.', Ext.emptyFn);
  },
  scope: this,
  includeImages: true
};
Ext.device.Contacts.getContacts(contactsConfig);*/
  },

  backButtonTap: function () {
    this.showView('ViewMainPage');
  }

});
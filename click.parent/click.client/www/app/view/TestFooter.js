Ext.define('Click.view.TestFooter', {
    extend: 'Ext.Panel',
    xtype:'footer',

requires:['Ext.DataView', ],
    config: {

    items:[{
        xtype: 'toolbar',
        docked: 'bottom',
        items: [
            {
                xtype: 'spacer'
            },
            {
            xtype: 'button',
            text: 'Контакты+',
            handler: function () {
                Ext.select('#listId').show();
            }
            },

            {
                xtype: 'spacer'
            }
        ]},
        {
        xtype:'dataview',
        hidden: true,
        docked: 'bottom',
        id: 'listId',
        scrollable: 'horizontal',
        store: {
            onItemDisclosure: true,
            fields: ['contacts'],
            data: [
                {contacts: '8-707-476-4737'},
                {contacts: '8-707-826-11-07'},
                {contacts: '8-707-833-11-11'}
            ]
        },
        itemTpl: '{contacts}'


    }
        ]
    }


});
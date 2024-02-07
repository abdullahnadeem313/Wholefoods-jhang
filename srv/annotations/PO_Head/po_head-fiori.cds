using WholefoodsService as service from '../../wholefoods-service';
using from '../PO_Items/po_items-fiori';

annotate service.PO_Head {
    EBELN   @(title: '{i18n>purchaseOrderNumber}');
    PARTNER @(title: '{i18n>businessPartnerID}',
                Common: {
            ValueListWithFixedValues,
            ValueList: {
                $Type         : 'Common.ValueListType',
                CollectionPath: 'POVendor',
                Parameters    : [
                    {
                        $Type            : 'Common.ValueListParameterOut',
                        LocalDataProperty: PARTNER_PARTNER,
                        ValueListProperty: 'PARTNER_PARTNER',
                    },
                    {
                        $Type            : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'NAME',
                    },
                ],
            },
            Text : {
                $value: PARTNER.NAME,
                ![@UI.TextArrangement] : #TextFirst,
            },
        },
        Common.FieldControl:#Mandatory
    );
}



annotate service.PO_Head with @(
    // UI.SelectionFields: [EBELN],
    UI.LineItem: [
    {
        $Type                : 'UI.DataField',
        Value                : EBELN,
        ![@HTML5.CssDefaults]: {
            $Type: 'HTML5.CssDefaultsType',
            width: '50%'
        },
    },
    {
        $Type                : 'UI.DataField',
        Value                : PARTNER_PARTNER,
        ![@HTML5.CssDefaults]: {
            $Type: 'HTML5.CssDefaultsType',
            width: '50%'
        },
    },
]);
annotate service.PO_Head with @(UI:{
    HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : '{i18n>purchaseOrder}',
        TypeNamePlural : '{i18n>purchaseOrders}',
        Title:{Value:EBELN}
    },
});
annotate service.PO_Head with @(
    
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: EBELN,
            },
            {
                $Type: 'UI.DataField',
                Value: PARTNER_PARTNER,
            },
        ],
    },
    UI.Facets                     : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup1',
    },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Items',
            ID : 'POItemstable',
            Target : 'items/@UI.LineItem#POItemstable',
        }, ]
);






annotate service.PO_Head with {
    EBELN @Common.FieldControl : #ReadOnly
};


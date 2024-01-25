using WholefoodsService as service from '../../wholefoods-service';
using from '../../annotations/Materials/materials-fiori';
using from '../PO_Items/po_items-fiori';

annotate service.PO_Head {
    EBELN   @(title: '{i18n>purchaseOrderNumber}');
    PARTNER @(title: '{i18n>businessPartnerID}',
                Common: {
            ValueListWithFixedValues,
            ValueList: {
                $Type         : 'Common.ValueListType',
                CollectionPath: 'BPGeneral',
                Parameters    : [
                    {
                        $Type            : 'Common.ValueListParameterOut',
                        LocalDataProperty: PARTNER_PARTNER,
                        ValueListProperty: 'PARTNER',
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



annotate service.Materials with {
    MAKTX @(Common.Text : {
                $value : MATNR,
                ![@UI.TextArrangement] : #TextFirst,
            }
)};

annotate service.Plants with {
    WERKS @Common.Text : {
        $value : NAME1,
        ![@UI.TextArrangement] : #TextLast,
    }
};

annotate service.Plants with {
    NAME1 @Common.FieldControl : #ReadOnly
};


annotate service.PO_Head with {
    EBELN @Common.FieldControl : #ReadOnly
};

annotate service.Materials with {
    MATNR @Common.Text : {
        $value : MAKTX,
        ![@UI.TextArrangement] : #TextLast,
    }
};


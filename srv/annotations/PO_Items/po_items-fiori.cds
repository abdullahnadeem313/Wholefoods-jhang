using WholefoodsService as service from '../../wholefoods-service';

annotate service.PO_Item with @(
    UI.LineItem #POItemstable : [
        {
            $Type : 'UI.DataField',
            Value : EBELP,
        },{
            $Type : 'UI.DataField',
            Value : MATNR_MATNR,
        },
        {
            $Type : 'UI.DataField',
            Value : MATNR.MAKTX,
        },{
            $Type : 'UI.DataField',
            Value : MENGE,
        },{
            $Type : 'UI.DataField',
            Value : UOM,
            ![@UI.Importance] : #High,
        },{
            $Type : 'UI.DataField',
            Value : WERKS_WERKS,
        },
        {
            $Type : 'UI.DataField',
            Value : WERKS.NAME1,
        },]
);
annotate service.PO_Item with {
    EBELP @Common.FieldControl : #ReadOnly
};
annotate service.PO_Item with {
    MATNR @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Materials',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : MATNR_MATNR,
                    ValueListProperty : 'MATNR',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.PO_Item with {
    WERKS @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Plants',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : WERKS_WERKS,
                    ValueListProperty : 'WERKS',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.PO_Item with @(UI:{
HeaderInfo  : {
    $Type : 'UI.HeaderInfoType',
    TypeName : '{i18n>purchaseOrderItem}',
    TypeNamePlural : '{i18n>purchaseOrderItems}',
    Title:{Value:EBELP}
},
});
annotate service.PO_Item with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Information',
            ID : 'PurchaseOrderInformation',
            Target : '@UI.Identification',
        },
    ],
    UI.Identification : [
        {
            $Type : 'UI.DataField',
            Value : EBELN.EBELN,
        },{
            $Type : 'UI.DataField',
            Value : EBELP,
        },{
            $Type : 'UI.DataField',
            Value : WERKS_WERKS,
        },{
            $Type : 'UI.DataField',
            Value : UOM,
        },{
            $Type : 'UI.DataField',
            Value : MENGE,
        },{
            $Type : 'UI.DataField',
            Value : MATNR_MATNR,
        },{
            $Type : 'UI.DataField',
            Value : EBELN.EBELN,
        },{
            $Type : 'UI.DataField',
            Value : EBELN.PARTNER_PARTNER,
        },]
);

annotate service.Materials with {
    MAKTX @Common.FieldControl : #ReadOnly
};
annotate service.PO_Item with {
    UOM @Common.Text : {
            $value : MATNR.UOM,
            ![@UI.TextArrangement] : #TextLast,
        }
};
annotate service.PO_Item with {
    UOM @UI.MultiLineText : false
};
annotate service.PO_Item with {
    UOM @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Materials',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : UOM,
                    ValueListProperty : 'UOM',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
)};

annotate service.PO_Item with {
    UOM @Common.FieldControl : #ReadOnly
};

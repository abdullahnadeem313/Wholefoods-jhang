using WholefoodsService as service from '../../wholefoods-service';
using from '../../annotations/Materials/materials-fiori';

annotate service.PO_Item {
    ID         @(title: '{i18n>poItemsID}');
    EBELN      @(title: '{i18n>purchaseOrderNumber}');
    EBELP      @(title: '{i18n>itemNumber}');
    WERKS      @(
        title              : '{i18n>plantID}',
        Common.FieldControl: #Mandatory
    );
    MATNR      @(
        title              : '{i18n>materialID}',
        Common.FieldControl: #Mandatory
    );
    MENGE      @(
        title              : '{i18n>poQuantity}',
        Common.FieldControl: #Mandatory
    );
    UOM        @(title: '{i18n>unitOfMeasure}');
    // MATNR_NAME @(title: '{i18n>materialName}');
}
// SideEffects
annotate service.PO_Item @(Common : {
    SideEffects #MATNR : {
        $Type : 'Common.SideEffectsType',
        SourceProperties : ['MATNR_MATNR'],  //feilds on the basis of which we want to get value
        TargetEntities   : ['MATNR'] //feilds on which we want to get value
    }
});

annotate service.PO_Item @(Common : {
    SideEffects #WERKS : {
        $Type : 'Common.SideEffectsType',
        SourceProperties : ['WERKS_WERKS'],  //feilds on the basis of which we want to get value
        TargetEntities   : ['WERKS'] //feilds on which we want to get value
    }
});

annotate service.PO_Item with @(UI.LineItem #POItemstable: [
    {
        $Type                : 'UI.DataField',
        Value                : EBELP,
        ![@HTML5.CssDefaults]: {width: 'auto'},

    },
    {
        $Type                : 'UI.DataField',
        Value                : MATNR_MATNR,
        ![@HTML5.CssDefaults]: {width: 'auto'},

    },
    {
        $Type                : 'UI.DataField',
        Value                : MATNR.MAKTX,
        ![@HTML5.CssDefaults]: {width: 'auto'},

    },
    // {
    //     $Type                : 'UI.DataField',
    //     Value                : MATNR_NAME,
    //     ![@HTML5.CssDefaults]: {width: 'auto'},
    // },
    {
        $Type                : 'UI.DataField',
        Value                : MENGE,
        ![@HTML5.CssDefaults]: {width: 'auto'},

    },
    {
        $Type                : 'UI.DataField',
        Value                : MATNR.UOM,
        ![@HTML5.CssDefaults]: {width: 'auto'},
    },
    {
        $Type                : 'UI.DataField',
        Value                : WERKS_WERKS,
        ![@HTML5.CssDefaults]: {width: 'auto'},

    },
    {
        $Type                : 'UI.DataField',
        Value                : WERKS.NAME1,
        ![@HTML5.CssDefaults]: {width: 'auto'},

    },
]);

annotate service.PO_Item with {
    EBELP @Common.FieldControl: #ReadOnly
};

annotate service.PO_Item with {
    MATNR @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'rawMaterials',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: MATNR_MATNR,
                ValueListProperty: 'MATNR',
            }, ],
        },
        Common.ValueListWithFixedValues: true
    )
};

annotate service.PO_Item with {
    WERKS @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Plants',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: WERKS_WERKS,
                ValueListProperty: 'WERKS',
            }, ],
        },
        Common.ValueListWithFixedValues: true
    )
};

annotate service.PO_Item with @(UI: {HeaderInfo: {
    $Type         : 'UI.HeaderInfoType',
    TypeName      : '{i18n>purchaseOrderItem}',
    TypeNamePlural: '{i18n>purchaseOrderItems}',
    Title         : {Value: EBELP}
}, });

annotate service.PO_Item with @(
    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'Purchase Order Information',
        ID    : 'PurchaseOrderInformation',
        Target: '@UI.Identification',
    }, ],
    UI.Identification: [
        {
            $Type                : 'UI.DataField',
            Value                : EBELN.EBELN,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : EBELP,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : WERKS_WERKS,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : UOM,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : MENGE,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            $Type                : 'UI.DataField',
            Value                : MATNR_MATNR,
            ![@HTML5.CssDefaults]: {width: 'auto'},
        },
        {
            $Type: 'UI.DataField',
            Value: EBELN.EBELN,

        },
        {
            $Type: 'UI.DataField',
            Value: EBELN.PARTNER_PARTNER,
        },
    ]
);

// annotate service.rawMaterials with {
//     MAKTX @Common.FieldControl : #ReadOnly
// };
annotate service.Materials with {
    MATNR @Common.Text : {
        $value : MAKTX,
        ![@UI.TextArrangement] : #TextLast,
    }
};

annotate service.Materials with {
    MAKTX @Common.FieldControl: #ReadOnly
};
annotate service.Materials with {
    MAKTX @(Common.Text : {
                $value : MATNR,
                ![@UI.TextArrangement] : #TextFirst,
            }
)};
annotate service.Materials with {
    UOM @Common.FieldControl: #ReadOnly
};


annotate service.PO_Item with {
    UOM @Common.FieldControl: #ReadOnly
};



annotate service.Plants with {
    WERKS @Common.Text : {
        $value : NAME1,
        ![@UI.TextArrangement] : #TextLast,
    }
};

annotate service.Plants with {
    NAME1 @Common.FieldControl : #ReadOnly
};



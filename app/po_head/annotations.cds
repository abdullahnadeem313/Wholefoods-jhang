using WholefoodsService as service from '../../srv/wholefoods-service';

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


annotate service.PO_Head with @(UI.LineItem: [
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
    }, ]
);

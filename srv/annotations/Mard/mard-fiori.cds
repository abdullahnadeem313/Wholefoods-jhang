using WholefoodsService as service from '../../wholefoods-service';

annotate service.Mard with {
    MATNR @( //Material ID
    title: '{i18n>materialID}', 
    Common: {
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Materials',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : MATNR_MATNR,
                    ValueListProperty : 'MATNR',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'MAKTX',
                },
            ],
        },
        Text : {
            $value: MATNR.MAKTX,
            ![@UI.TextArrangement] : #TextFirst,
        },
    }
    );
    WERKS @( //Plant ID
    title: '{i18n>plantID}', 
    Common: {
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Plants',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : WERKS_WERKS,
                    ValueListProperty : 'WERKS',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'NAME1',
                },
            ],
        },
        Text : {
            $value: WERKS.NAME1,
            ![@UI.TextArrangement] : #TextFirst,
        },
    }
    );
    LABST @( //Unrestricted Stock
    title: '{i18n>unrestrictedStock}', );
    UOM   @( //Unit of Measure
    title: '{i18n>unitOfMeasure}', );
};

/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.Mard with @(UI: {
    SelectionFields    : [
        MATNR_MATNR,
        WERKS_WERKS
    ],
    LineItem           : [
        {
            $Type                : 'UI.DataField',
            Value                : MATNR_MATNR,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '25%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : WERKS_WERKS,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '25%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : LABST,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '25%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : UOM,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '25%',
            },
        },
    ],
    PresentationVariant: {
        $Type    : 'UI.PresentationVariantType',
        SortOrder: [{
            $Type     : 'Common.SortOrderType',
            Property  : createdAt,
            Descending: false,
        }, ],
    },

});


annotate service.Mard with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>mard}',
        TypeNamePlural: '{i18n>mards}',
        Title         : {Value: WERKS_WERKS},
        Description   : {Value: MATNR_MATNR},
        TypeImageUrl  : 'sap-icon://company-view',
    },
    /**
     **
    *
    * Object page Facets
    *
    */
    Facets                        : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>basicInfo}',
            Target: '@UI.FieldGroup#BasicInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>administrativeData}',
            Target: '@UI.FieldGroup#AdministrativeData'
        }
    ],
    FieldGroup #BasicInfo         : {Data: [
        {Value: MATNR_MATNR},
        {Value: WERKS_WERKS},
        {Value: LABST},
        {Value: UOM},

    ]},

    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

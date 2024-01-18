using WholefoodsService as service from '../../wholefoods-service';


annotate service.Plants with {
    WERKS  @(title: '{i18n>plantID}');
    NAME1  @(title: '{i18n>plantName}');
    STRAS  @(title: '{i18n>address}');
    PSTLZ  @(title: '{i18n>postalCode}');
    ORT01  @(title: '{i18n>city}');
    LANDX  @(title: '{i18n>country}');
    CNTACT @(title: '{i18n>phoneNumber}');
};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.Plants with @(UI: {
    SelectionFields    : [
        WERKS,
        NAME1
    ],
    LineItem           : {$value: [
        {
            $Type: 'UI.DataField',
            Value: WERKS,
        },
        {
            $Type                : 'UI.DataField',
            Value                : NAME1,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : STRAS,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },
        }
    ]},
    PresentationVariant: {
        SortOrder     : [{
            $Type     : 'Common.SortOrderType',
            Property  : createdAt,
            Descending: false
        }],
        Visualizations: ['@UI.LineItem']
    }
});


annotate service.Plants with @(UI:{
        /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>plant}',
        TypeNamePlural: '{i18n>plants}',
        Title         : {Value: NAME1},
        Description   : {Value: STRAS},
        TypeImageUrl  : 'sap-icon://company-view',
    },
});


annotate service.Plants with @(UI: {

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
        {Value: NAME1},
        {Value: PSTLZ},
        {Value: ORT01},
        {Value: STRAS},
        {Value: LANDX},
        {Value: CNTACT},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

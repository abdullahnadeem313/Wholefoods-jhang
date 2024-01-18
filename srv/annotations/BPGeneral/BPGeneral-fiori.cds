using WholefoodsService as service from '../../wholefoods-service';


annotate service.BPGeneral with {
    PARTNER @(title: '{i18n>businessPartnerID}');
    BPTYPE  @(title: '{i18n>bpCategory}');
    NAME    @(title: '{i18n>bpName}');
    STRAS   @(title: '{i18n>address}');
    PSTLZ   @(title: '{i18n>postalCode}');
    ORT01   @(title: '{i18n>city}');
    LANDX   @(title: '{i18n>country}');
    CNTACT  @(title: '{i18n>phoneNumber}');
};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.BPGeneral with @(UI: {
    SelectionFields    : [
        // BPTYPE,
        // NAME
    ],
    LineItem           : {$value: [
        {
            $Type: 'UI.DataField',
            Value: PARTNER,
            ![@HTML5.CssDefaults] : {width:'20%'}
        },
        {
            $Type: 'UI.DataField',
            Value: BPTYPE,
            ![@HTML5.CssDefaults] : {width:'20%'}
        },
        {
            $Type: 'UI.DataField',
            Value: NAME,
            ![@HTML5.CssDefaults] : {width:'20%'}

        },
        {
            $Type: 'UI.DataField',
            Value: STRAS,
            ![@HTML5.CssDefaults] : {width:'20%'}
        },
        {
            $Type: 'UI.DataField',
            Value: LANDX,
            ![@HTML5.CssDefaults] : {width:'20%'}
        },
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


annotate service.BPGeneral with @(UI: {
                                       /**
                                    **
                                   *
                                   * Object Page Header
                                   *
                                   **
                                   */
                                      HeaderInfo: {
    TypeName      : '{i18n>bpGeneral}',
    TypeNamePlural: '{i18n>bpGenerals}',
    Title         : {Value: NAME},
    Description   : {Value: STRAS},
    TypeImageUrl  : 'sap-icon://company-view',
}, });


annotate service.BPGeneral with @(UI: {

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
        {Value: PARTNER},
        {Value: BPTYPE},
        {Value: NAME},
        {Value: STRAS},
        {Value: PSTLZ},
        {Value: ORT01},
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



// annotate service.BPGeneral with {
//     BPTYPE  @{
//         common:{
//             valuelist:{

//             }
//         }
//     }
//     // NAME    
    
//     }
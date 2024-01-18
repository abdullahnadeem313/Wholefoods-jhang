using WholefoodsService as service from '../../wholefoods-service';


annotate service.MaterialGroups with  {
    MATKL   @(title: '{i18n>id}');
    MATKLTX @(title: '{i18n>description}');

};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.MaterialGroups with @(UI: {
    SelectionFields    : [MATKL
                               // MATKLTX
                         ],
    LineItem           : {$value: [
        {
            $Type                : 'UI.DataField',
            Value                : MATKL,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : MATKLTX,
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


annotate service.MaterialGroups with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>matGroup}',
        TypeNamePlural: '{i18n>matGroups}',
        Title         : {Value: MATKL},
        Description   : {Value: MATKLTX},
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
        {Value: MATKL},
        {Value: MATKLTX},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

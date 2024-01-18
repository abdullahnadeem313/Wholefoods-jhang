using WholefoodsService as service from '../../wholefoods-service';


annotate service.Roles with  {
    ROLE   @(title: '{i18n>roleId}');
    DESC @(title: '{i18n>roleDescription}');

};

/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.Roles with @(UI: {
    SelectionFields    : [DESC
                               // MATKLTX
                         ],
    LineItem           : {$value: [
        {
            $Type                : 'UI.DataField',
            Value                : ROLE,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : DESC,
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


annotate service.Roles with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>role}',
        TypeNamePlural: '{i18n>roles}',
        Title         : {Value: ROLE},
        Description   : {Value: DESC},
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
        {Value: ROLE},
        {Value: DESC},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});
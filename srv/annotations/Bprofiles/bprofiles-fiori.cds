using WholefoodsService as service from '../../wholefoods-service';


annotate service.Bprofiles with  {
    PARTNER   @(title: '{i18n>bpId}'
    , Common : { 
        ValueListWithFixedValues,
        ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Bprofiles',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterOut',
                LocalDataProperty : ROLE_ROLE,
                ValueListProperty : 'ROLE_ROLE',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'PARTNER_PARTNER',
            },
        ],
    }, },);
    ROLE @(title: '{i18n>bpRoleId}'
    , Common : { 
        ValueListWithFixedValues,
        ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Bprofiles',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterOut',
                LocalDataProperty : ROLE_ROLE,
                ValueListProperty : 'PARTNER_PARTNER',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'ROLE_ROLE',
            },
        ],
    }, },);

};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.Bprofiles with @(UI: {
    SelectionFields    : [
                               PARTNER_PARTNER,
                               ROLE_ROLE
                         ],
    LineItem           : {$value: [
        {
            $Type                : 'UI.DataField',
            Value                : PARTNER_PARTNER,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : ROLE_ROLE,
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


annotate service.Bprofiles with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>bprofile}',
        TypeNamePlural: '{i18n>bprofiles}',
        Title         : {Value: PARTNER_PARTNER},
        Description   : {Value: ROLE_ROLE},
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
        {Value: PARTNER_PARTNER},
        {Value: ROLE_ROLE},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

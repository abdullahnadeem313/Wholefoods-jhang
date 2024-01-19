using WholefoodsService as service from '../../wholefoods-service';


annotate service.Bprofiles with {
    PARTNER @(
        title : '{i18n>bpId}',
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
        },
    );
    ROLE    @(
        title : '{i18n>bpRoleId}',
        Common: {
            ValueListWithFixedValues,
            ValueList: {
                $Type         : 'Common.ValueListType',
                CollectionPath: 'Roles',
                Parameters    : [
                    {
                        $Type            : 'Common.ValueListParameterOut',
                        LocalDataProperty: ROLE_ROLE,
                        ValueListProperty: 'ROLE',
                    },
                    {
                        $Type            : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'DESC',
                    },
                ],
            },
        },
    );
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
                width: '20%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : ROLE_ROLE,
            // ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : PARTNER.NAME,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : PARTNER.ORT01,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : PARTNER.LANDX,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },
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


annotate service.Bprofiles with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>bpprofile}',
        TypeNamePlural: '{i18n>bpprofiles}',
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
        // {
        //     $Type : 'UI.ReferenceFacet',
        //     Label : '{i18n>businessPartnerRole',
        //     Target: '@UI.FieldGroup#BusinessPartnerRole'
        // },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>administrativeData}',
            Target: '@UI.FieldGroup#AdministrativeData'
        }
    ],
    FieldGroup #BasicInfo         : {Data: [
        {Value: PARTNER_PARTNER},
        {Value: ROLE_ROLE},
        {Value: PARTNER.STRAS},
        // {Value: ROLE.DESC },
        {Value: PARTNER.ORT01},
        {Value: PARTNER.LANDX},
        {Value: PARTNER.NAME},
        // {Value: PARTNER.BPTYPE},
        {Value: PARTNER.CNTACT},

    ]},
    // FieldGroup #BusinessPartnerRole: {Data: [
    //     {Value: },
    //     ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

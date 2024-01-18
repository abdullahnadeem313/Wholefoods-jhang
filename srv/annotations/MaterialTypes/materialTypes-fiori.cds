using WholefoodsService as service from '../../wholefoods-service';


annotate service.MaterialTypes with {
    MTART   @(title: '{i18n>id}');
    MTARTTX @(title: '{i18n>description}');

};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.MaterialTypes with @(UI: {
    SelectionFields    : [

    ],
    LineItem           : {$value: [
        {
            $Type                : 'UI.DataField',
            Value                : MTART,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },

        },
        {
            $Type                : 'UI.DataField',
            Value                : MTARTTX,
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


annotate service.MaterialTypes with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>matType}',
        TypeNamePlural: '{i18n>matTypes}',
        Title         : {Value: MTART},
        Description   : {Value: MTARTTX},
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
        {Value: MTART},
        {Value: MTARTTX},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

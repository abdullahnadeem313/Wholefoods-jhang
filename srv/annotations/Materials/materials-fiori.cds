using WholefoodsService as service from '../../wholefoods-service';
using from '@sap/cds/common';



annotate service.Materials with{
    MATNR @(title: '{i18n>materialID}');
    MTART @(title: '{i18n>materialType}');// , Common.ValueListWithFixedValues); this method also workable by annotating entities
    MATKL @(title: '{i18n>materialGroup}');//, Common.ValueListWithFixedValues);
    MAKTX @(title: '{i18n>materialDescription}');
    UOM   @(title: '{i18n>unitOfMeasure}');
};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.Materials with @(UI: {
    SelectionFields    : [
        MATKL_MATKL,
        MTART_MTART
    ],
    LineItem           : {$value: [
        {
            $Type                : 'UI.DataField',
            Value                : MATNR,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },
        },
        {
            $Type                : 'UI.DataField',
            Value                : MTART_MTART,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },

        },
        {
            $Type                : 'UI.DataField',
            Value                : MATKL_MATKL,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },

        },
        {
            $Type                : 'UI.DataField',
            Value                : MAKTX,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '20%',
            },

        },
        {
            $Type                : 'UI.DataField',
            Value                : UOM,
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


annotate service.Materials with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>material}',
        TypeNamePlural: '{i18n>materials}',
        Title         : {Value: MATNR},
        Description   : {Value: MTART_MTART},
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
        {Value: MATNR},
        {Value: MTART_MTART},
        {Value: MATKL_MATKL},
        {Value: MAKTX},
        {Value: UOM},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});



annotate service.Materials with{
    MTART       @Common.ValueListWithFixedValues; //Instead of dialog box, the value help is a dropdown
    MTART @(Common : {
        // ValueListWithFixedValues: true,
        ValueList       : {
            // Label          : '{i18n>criticality}',
            CollectionPath : 'MaterialTypes',
            Parameters     : [
                // {
                //     $Type : 'Common.ValueListParameterOut',
                //     LocalDataProperty : MTART_MTART,
                //     ValueListProperty : 'MTART',
                // },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : MTART_MTART,
                    ValueListProperty : 'MTART',
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'MTARTTX',
                },
                
            ]
        }
    });

    MATKL @(Common : {
        ValueListWithFixedValues: true,
        ValueList       : {
            // Label          : '{i18n>criticality}',
            CollectionPath : 'MaterialGroups',
            Parameters     : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : MATKL_MATKL,
                    ValueListProperty : 'MATKL',
                },
                {
                    $Type               : 'Common.ValueListParameterDisplayOnly', //Displays additional information from the entity set of the value help 
                    ValueListProperty   : 'MATKLTX',
                },
                
            ]
        }
    });
}
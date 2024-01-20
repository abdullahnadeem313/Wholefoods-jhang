using WholefoodsService as service from '../../wholefoods-service';

annotate service.BPTpyes with {
    BPTYPE     @(title: '{i18n>bpTypeID}', 
    Common: {        
        ValueListWithFixedValues,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BPTpyes',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : BPTYPE,
                    ValueListProperty : 'BPTYPE',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'BPTYPEDESC',
                },
            ],
        },
        // Text : {
        //     $value: BPTYPE.BPTYPEDESC,
        //     ![@UI.TextArrangement] : #TextFirst,
        // },
    }
    
    );
    BPTYPEDESC @(title: '{i18n>bpTypeDescription}',
        Common: {        
        ValueListWithFixedValues,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BPTpyes',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : BPTYPEDESC,
                    ValueListProperty : 'BPTYPEDESC',
                },
                // {
                //     $Type : 'Common.ValueListParameterDisplayOnly',
                //     ValueListProperty : 'BPTYPEDESC',
                // },
            ],
}
}

);
};


/*
 *
 *
 ListReport page
 *
 *
 */

annotate service.BPTpyes with @(UI: {
    SelectionFields    : [
        BPTYPE,BPTYPEDESC
    ],
    LineItem           : {$value: [
        {
            $Type                : 'UI.DataField',
            Value                : BPTYPE,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },

        },
        {
            $Type                : 'UI.DataField',
            Value                : BPTYPEDESC,
            ![@UI.Importance]    : #High,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '40%',
            },
        }
    ]}
    ,
    PresentationVariant: {
        SortOrder     : [{
            $Type     : 'Common.SortOrderType',
            Property  : createdAt,
            Descending: false
        }],
        Visualizations: ['@UI.LineItem']
    }
});


annotate service.BPTpyes with @(UI: {
    /**
     **
    *
    * Object Page Header
    *
    **
    */
    HeaderInfo                    : {
        TypeName      : '{i18n>bpType}',
        TypeNamePlural: '{i18n>bpTypes}',
        Title         : {Value: BPTYPE},
        Description   : {Value: BPTYPEDESC},
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
        {Value: BPTYPE},
        {Value: BPTYPEDESC},
    ]},
    FieldGroup #AdministrativeData: {Data: [
        {Value: createdBy},
        {Value: createdAt},
        {Value: modifiedBy},
        {Value: modifiedAt}
    ]}
});

using WholefoodsService as service from '../../wholefoods-service';
using from '../Recipe_Item/recipe_item-fiori';
// using from '../../annotations/Materials/materials-fiori';

annotate service.Recipe_Head {
    RECIPE      @(title: '{i18n>recipeNumber}');
    MATNR       @(
        title              : '{i18n>materialID}',
        Common.FieldControl: #Mandatory,
    );
    RECIPE_QTY  @(title: '{i18n>recipeQuantity}');
    UOM         @(title: '{i18n>unitOfMeasure}');
    recipe_Item @(title: '{i18n>recipeItem}');
}

annotate service.Materials with {
    UOM @(title: '{i18n>unitOfMeasure}')
};

annotate service.Recipe_Head with {
    RECIPE @Common.FieldControl: #ReadOnly
};

annotate service.Recipe_Head with {
    RECIPE_QTY @Common.FieldControl: #ReadOnly
};

annotate service.Recipe_Head with {
    UOM @Common.FieldControl: #ReadOnly
};

// SideEffects
annotate service.Recipe_Head @(Common: {SideEffects: {
    $Type           : 'Common.SideEffectsType',
    SourceProperties: ['MATNR_MATNR'], //feilds on the basis of which we want to get value
    TargetEntities  : ['MATNR'] //feilds on which we want to get value
}});


annotate service.Recipe_Head with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: RECIPE,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR_MATNR,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: RECIPE_QTY,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR.UOM,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
]);


annotate service.Recipe_Head with @(UI: {HeaderInfo: {
    $Type         : 'UI.HeaderInfoType',
    TypeName      : '{i18n>recipe}',
    TypeNamePlural: '{i18n>recipes}',
    Title         : {Value: RECIPE}
}, });

annotate service.Recipe_Head with {
    MATNR @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'finishedMaterials',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: MATNR_MATNR,
                ValueListProperty: 'MATNR',
            },
            // {
            //     $Type            : 'Common.ValueListParameterDisplayOnly',
            //     ValueListProperty: 'MTART_MTART',
            // },
            // {
            //     $Type            : 'Common.ValueListParameterDisplayOnly',
            //     ValueListProperty: 'UOM',
            // },
        ],
        
    }
};

annotate service.Recipe_Head with @(
    UI.FieldGroup #GeneratedGroup1: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: RECIPE,
                ![@HTML5.CssDefaults]: {width: 'auto'}
            },
            {
                $Type: 'UI.DataField',
                Value: MATNR_MATNR,
                ![@HTML5.CssDefaults]: {width: 'auto'}
            },
            {
                $Type: 'UI.DataField',
                Value: RECIPE_QTY,
                ![@HTML5.CssDefaults]: {width: 'auto'}
            },
            {
                $Type: 'UI.DataField',
                Value: MATNR.UOM,
                ![@HTML5.CssDefaults]: {width: 'auto'}
            },
        ],
    },
    UI.Facets                     : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'General Information',
            Target: '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Recipe Items Information',
            ID    : 'RecipeItemsInformation',
            Target: 'recipe_Item/@UI.LineItem#RecipeItemsInformation',
        },
    ]
);

using WholefoodsService as service from '../../wholefoods-service';
using from '../../annotations/Materials/materials-fiori';

annotate service.Recipe_Item{
    RECIPE @(title: '{i18n>recipeNumber}');
    RECIPE_ITM @(title: '{i18n>itemNumber}');
    MATNR @(title: '{i18n>rawMaterialID}');
    RAW_QTY @(title: '{i18n>rawMaterialQuantity}');
    UOM @(title: '{i18n>unitOfMeasure}');
}

annotate service.Recipe_Item with {
    RAW_QTY @Common.FieldControl : #ReadOnly
};
annotate service.Recipe_Item with {
    RECIPE_ITM @Common.FieldControl : #ReadOnly
};


annotate service.Recipe_Item with {
    MATNR @(
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'rawMaterials',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: MATNR_MATNR,
                ValueListProperty: 'MATNR',
            }, ],
        },
        Common.ValueListWithFixedValues: true
    )
};
// SideEffects
annotate service.Recipe_Item @(Common : {
    SideEffects #MATNR : {
        $Type : 'Common.SideEffectsType',
        SourceProperties : ['MATNR_MATNR'],  //feilds on the basis of which we want to get value
        TargetEntities   : ['MATNR'] //feilds on which we want to get value
    }
});

annotate service.Recipe_Item with @(
    UI.LineItem #RecipeItemsInformation: [
    {
        $Type: 'UI.DataField',
        Value: RECIPE_ITM,
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR_MATNR,
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR.MAKTX,
    },
    {
        $Type: 'UI.DataField',
        Value: RAW_QTY,
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR.UOM,
    },
]);

annotate service.Recipe_Item with @(UI: {
        HeaderInfo: {
            $Type         : 'UI.HeaderInfoType',
            TypeName      : '{i18n>recipeItem}',
            TypeNamePlural: '{i18n>recipeItems}',
            Title         : {Value:RECIPE_ITM}
        }, 
    });
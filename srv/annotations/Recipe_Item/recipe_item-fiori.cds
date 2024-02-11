using WholefoodsService as service from '../../wholefoods-service';
using from '../../annotations/Materials/materials-fiori';

annotate service.Recipe_Item{
    RECIPE @(title: '{i18n>recipeNumber}');
    RECIPE_ITM @(title: '{i18n>itemNumber}');
    MATNR @(title: '{i18n>rawMaterialID}');
    RAW_QTY @(
        title: '{i18n>rawMaterialQuantity}',
        // Common.FieldControl: #Mandatory
        );
    UOM @(title: '{i18n>unitOfMeasure}');
}



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
    SideEffects : {
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
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR_MATNR,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR.MAKTX,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: RAW_QTY,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
    {
        $Type: 'UI.DataField',
        Value: MATNR.UOM,
        ![@HTML5.CssDefaults]: {width: 'auto'}
    },
]);

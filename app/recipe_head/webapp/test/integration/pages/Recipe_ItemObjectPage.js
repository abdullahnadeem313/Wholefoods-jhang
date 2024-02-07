sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns.recipehead',
            componentId: 'Recipe_ItemObjectPage',
            contextPath: '/Recipe_Head/recipe_Item'
        },
        CustomPageDefinitions
    );
});
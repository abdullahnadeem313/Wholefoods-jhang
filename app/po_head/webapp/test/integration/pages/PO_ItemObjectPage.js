sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns.pohead',
            componentId: 'PO_ItemObjectPage',
            contextPath: '/PO_Head/items'
        },
        CustomPageDefinitions
    );
});
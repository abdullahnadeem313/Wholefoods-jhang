sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'ns.recipehead',
            componentId: 'Recipe_HeadList',
            contextPath: '/Recipe_Head'
        },
        CustomPageDefinitions
    );
});
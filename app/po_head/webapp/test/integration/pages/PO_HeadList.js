sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'ns.pohead',
            componentId: 'PO_HeadList',
            contextPath: '/PO_Head'
        },
        CustomPageDefinitions
    );
});
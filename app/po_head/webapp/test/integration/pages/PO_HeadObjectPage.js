sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'ns.pohead',
            componentId: 'PO_HeadObjectPage',
            contextPath: '/PO_Head'
        },
        CustomPageDefinitions
    );
});
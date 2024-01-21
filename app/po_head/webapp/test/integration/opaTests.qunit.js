sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/pohead/test/integration/FirstJourney',
		'ns/pohead/test/integration/pages/PO_HeadList',
		'ns/pohead/test/integration/pages/PO_HeadObjectPage',
		'ns/pohead/test/integration/pages/PO_ItemObjectPage'
    ],
    function(JourneyRunner, opaJourney, PO_HeadList, PO_HeadObjectPage, PO_ItemObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/pohead') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePO_HeadList: PO_HeadList,
					onThePO_HeadObjectPage: PO_HeadObjectPage,
					onThePO_ItemObjectPage: PO_ItemObjectPage
                }
            },
            opaJourney.run
        );
    }
);
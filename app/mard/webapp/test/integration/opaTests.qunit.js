sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/mard/test/integration/FirstJourney',
		'ns/mard/test/integration/pages/MardList',
		'ns/mard/test/integration/pages/MardObjectPage'
    ],
    function(JourneyRunner, opaJourney, MardList, MardObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/mard') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheMardList: MardList,
					onTheMardObjectPage: MardObjectPage
                }
            },
            opaJourney.run
        );
    }
);
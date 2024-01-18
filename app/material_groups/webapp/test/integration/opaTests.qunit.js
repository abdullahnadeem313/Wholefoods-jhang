sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/materialgroups/test/integration/FirstJourney',
		'ns/materialgroups/test/integration/pages/MaterialGroupsList',
		'ns/materialgroups/test/integration/pages/MaterialGroupsObjectPage'
    ],
    function(JourneyRunner, opaJourney, MaterialGroupsList, MaterialGroupsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/materialgroups') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheMaterialGroupsList: MaterialGroupsList,
					onTheMaterialGroupsObjectPage: MaterialGroupsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
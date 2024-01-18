sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/bprofiles/test/integration/FirstJourney',
		'ns/bprofiles/test/integration/pages/BprofilesList',
		'ns/bprofiles/test/integration/pages/BprofilesObjectPage'
    ],
    function(JourneyRunner, opaJourney, BprofilesList, BprofilesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/bprofiles') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBprofilesList: BprofilesList,
					onTheBprofilesObjectPage: BprofilesObjectPage
                }
            },
            opaJourney.run
        );
    }
);
sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/materialtypes/test/integration/FirstJourney',
		'ns/materialtypes/test/integration/pages/MaterialTypesList',
		'ns/materialtypes/test/integration/pages/MaterialTypesObjectPage'
    ],
    function(JourneyRunner, opaJourney, MaterialTypesList, MaterialTypesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/materialtypes') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheMaterialTypesList: MaterialTypesList,
					onTheMaterialTypesObjectPage: MaterialTypesObjectPage
                }
            },
            opaJourney.run
        );
    }
);
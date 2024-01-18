sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/plants/test/integration/FirstJourney',
		'ns/plants/test/integration/pages/PlantsList',
		'ns/plants/test/integration/pages/PlantsObjectPage'
    ],
    function(JourneyRunner, opaJourney, PlantsList, PlantsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/plants') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePlantsList: PlantsList,
					onThePlantsObjectPage: PlantsObjectPage
                }
            },
            opaJourney.run
        );
    }
);
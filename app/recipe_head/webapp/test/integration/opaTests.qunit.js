sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/recipehead/test/integration/FirstJourney',
		'ns/recipehead/test/integration/pages/Recipe_HeadList',
		'ns/recipehead/test/integration/pages/Recipe_HeadObjectPage',
		'ns/recipehead/test/integration/pages/Recipe_ItemObjectPage'
    ],
    function(JourneyRunner, opaJourney, Recipe_HeadList, Recipe_HeadObjectPage, Recipe_ItemObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/recipehead') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheRecipe_HeadList: Recipe_HeadList,
					onTheRecipe_HeadObjectPage: Recipe_HeadObjectPage,
					onTheRecipe_ItemObjectPage: Recipe_ItemObjectPage
                }
            },
            opaJourney.run
        );
    }
);
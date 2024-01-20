sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/bptypes/test/integration/FirstJourney',
		'ns/bptypes/test/integration/pages/BPTpyesList',
		'ns/bptypes/test/integration/pages/BPTpyesObjectPage'
    ],
    function(JourneyRunner, opaJourney, BPTpyesList, BPTpyesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/bptypes') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBPTpyesList: BPTpyesList,
					onTheBPTpyesObjectPage: BPTpyesObjectPage
                }
            },
            opaJourney.run
        );
    }
);
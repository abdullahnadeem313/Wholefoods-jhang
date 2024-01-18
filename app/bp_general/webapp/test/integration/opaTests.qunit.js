sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/bpgeneral/test/integration/FirstJourney',
		'ns/bpgeneral/test/integration/pages/BPGeneralList',
		'ns/bpgeneral/test/integration/pages/BPGeneralObjectPage'
    ],
    function(JourneyRunner, opaJourney, BPGeneralList, BPGeneralObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/bpgeneral') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheBPGeneralList: BPGeneralList,
					onTheBPGeneralObjectPage: BPGeneralObjectPage
                }
            },
            opaJourney.run
        );
    }
);
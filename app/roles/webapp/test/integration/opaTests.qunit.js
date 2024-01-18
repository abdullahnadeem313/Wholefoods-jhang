sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/roles/test/integration/FirstJourney',
		'ns/roles/test/integration/pages/RolesList',
		'ns/roles/test/integration/pages/RolesObjectPage'
    ],
    function(JourneyRunner, opaJourney, RolesList, RolesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/roles') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheRolesList: RolesList,
					onTheRolesObjectPage: RolesObjectPage
                }
            },
            opaJourney.run
        );
    }
);
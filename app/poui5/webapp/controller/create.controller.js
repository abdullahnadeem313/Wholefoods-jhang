sap.ui.define([
    "sap/ui/core/mvc/Controller",
    "sap/ui/core/UIComponent",
    "sap/m/MessageToast"
    // "sap/ui/model/resource/ResourceModel"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("ns.poui5.controller.create", {
            onInit: function () {

            },

            onNavBack() {
                const oHistory = sap.ui.core.routing.History.getInstance();
                const sPreviousHash = oHistory.getPreviousHash();

                if (sPreviousHash !== undefined) {
                    window.history.go(-1);
                } else {
                    const oRouter = this.getOwnerComponent().getRouter();
                    oRouter.navTo("TargetpoListReport", {}, true);
                }
            },
            onPressClickMe() {
                let objHeader = this.byId("headerTitle");
                objHeader.setTitle('items')
            },
            onAddItems : function (oEvent) {
                var oItem = new sap.m.ColumnListItem({
                    cells: [
                        new sap.m.Input(),
                        new sap.m.Select({
                            items: {
                                path: "/Plants",
                                template: new sap.ui.core.ListItem({
                                    key: '{WERKS}',
                                    text: '{NAME1}'
                                })
                            }
                        }),
                        new sap.m.Select({
                            items: {
                                path: "/rawMaterials",
                                template: new sap.ui.core.ListItem({
                                    key: '{MATNR}',
                                    text: '{MAKTX}'
                                })
                            }
                        }),
                        new sap.m.Input(),
                    ]
                });
                var oTable = this.byId("poItemTable");
                           oTable.addItem(oItem);
            }
           
        });
    });

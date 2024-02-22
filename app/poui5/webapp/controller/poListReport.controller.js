sap.ui.define([
    "sap/ui/core/mvc/Controller",
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";

        return Controller.extend("ns.poui5.controller.poListReport", {
            onInit: function () {
            },

            onNavToDetails: function (oEvent) {
                var oItem = oEvent.getSource();

                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("TargetpoObjectPage", { poHead: oItem.getBindingContext().getPath().substring("/PO_Head".length) });
                
            }
        });
    });
    





    // Given binding path
    // var bindingPath = oItem.getBindingContext().getPath()

    // Extracting ID using regular expression
    // var idMatch = bindingPath.match(/ID=([^,]+)/);
    // var id = idMatch ? idMatch[1] : null;

    // Log the extracted ID
    //     console.log("Extracted ID: ###", id);
    //    oRouter.navTo("TargetpoObjectPage", {POItemVar: id});
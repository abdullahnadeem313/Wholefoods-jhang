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

        return Controller.extend("ns.poui5.controller.poObjectPage", {
            onInit: function () {

                // var oRouter = UIComponent.getRouterFor(this)
                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.getRoute("TargetpoObjectPage").attachPatternMatched(this.onRouteMachedFunc, this)
            },

            onRouteMachedFunc: function (oEvent) {
                var data = oEvent.getParameter("arguments").poHead;

                this.getView().bindElement("/PO_Head" + data);

                // MessageToast.show(data)
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
            formatQuantity: function (value) {
                if (value || value === 0) {
                    return parseFloat(value).toFixed(2);
                }
                return value;
            }
        });
    });

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
                oRouter.getRoute("TargetpoObjectPage").attachPatternMatched(this.onRouteMachedFunc, this);

                this.oActiveContext = null;
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
            onEdit : function () {
                
                this.toggleDraft("draftEdit");
            },
            onSave : function () {

                this.toggleDraft("draftActivate");
                // .then(function (oDraftContext) {
                //     oDraftContext.delete(null);
                // });
            },
            onCancel : function () {
                var oDraftContext = this.getView().getBindingContext(),
                    that = this;
                var oRouter = this.getOwnerComponent().getRouter();
    
                function gotoActiveContext(oActiveContext) {
                    that.oActiveContext = null; // not needed anymore
                    oDraftContext.delete("$auto", true);
                    // that.navTo(oActiveContext);

                    var oPath = oActiveContext.sPath 
                    oRouter.navTo("TargetpoObjectPage", { poHead: oPath.substring("/".length) });
                }
    
                if (this.oActiveContext) {
                    // oDraftContext.replaceWith(this.oActiveContext);
                    gotoActiveContext(this.oActiveContext);
                } 
                else {
                    oDraftContext.getModel().bindContext("PO_Item(...)", oDraftContext,
                            {$$inheritExpandSelect : true})
                        .execute("$auto", false, null).then(gotoActiveContext);
                }
            },
            addItem : function () {
                oNewItemContext = this.byId("poItemTable").getBinding("items").create();
            },
            deleteItem : function () {
                this.byId("poItemTable").getSelectedItem().getBindingContext().delete();
            },
            toggleDraft: function (sAction) {
                var oObject = this.getView();
                var oContext = oObject.getBindingContext();
                var that = this;
                var oRouter = this.getOwnerComponent().getRouter();
                oContext.getModel().bindContext("WholefoodsService."+sAction+"(...)",
                oContext, {$$inheritExpandSelect : true})
                    .execute("$auto", false, null)
                    .then(function (oDraftContext) {
                        that.oActiveContext
						= oDraftContext.getProperty("IsActiveEntity") ? null : oContext; 
                        
                        let oPath = oDraftContext.sPath
                        console.log(oPath);
                        oRouter.navTo('TargetpoObjectPage',{poHead: oPath.substring("/PO_Head".length)})
                        // that.getView().getModel().refresh()
                    });
            }
            // formatQuantity: function (value) {
            //     if (value || value === 0) {
            //         return parseFloat(value).toFixed(2);
            //     }
            //     return value;
            // }
        });
    });

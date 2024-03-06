sap.ui.define([
    "sap/ui/core/mvc/Controller",
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller) {
        "use strict";
        var oPOtable
        return Controller.extend("ns.poui5.controller.poListReport", {
            onInit: function () {

            },

            onNavToDetails: function (oEvent) {
                var oItem = oEvent.getSource();

                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("TargetpoObjectPage", { poHead: oItem.getBindingContext().getPath().substring("/PO_Head".length) });
                
            },

            onCreateOrder : function (oEvent) {
                // var oItem = oEvent.getSource();
                var oView = this.getView();
                oPOtable = oView.byId("PurchaseOrderListID").getBinding("items");
                console.log("oPOtable$$$", oPOtable);

                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("Targetcreate");


                
                // .getItems();

                
            },
            /**
             * 
             * Create View code
             * 
             */
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
            onAddItems: function (oEvent) {


                // item number
                var itemNumber = '0';
                itemNumber = parseInt(itemNumber);
                itemNumber = itemNumber + 10;
                var PO_ITEM_EBELP = String(itemNumber).padStart(4, "0");
                // Fields addition
                var oItem = new sap.m.ColumnListItem({
                    cells: [
                        new sap.m.Input({ width: 'auto' }),
                        // new sap.m.Text({ width: 'auto', text: PO_ITEM_EBELP }),
                        new sap.m.Select({
                            items: {
                                path: "/Plants",
                                template: new sap.ui.core.ListItem({
                                    key: '{WERKS}',
                                    text: '{NAME1}'
                                })
                            },
                            width: 'auto',
                        }),
                        new sap.m.Select({
                            items: {
                                path: "/rawMaterials",
                                template: new sap.ui.core.ListItem({
                                    key: '{MATNR}',
                                    text: '{MAKTX}'
                                })
                            },
                            width: 'auto',
                            change: function (oEvent) {
                                var oContext = oEvent.getParameters().selectedItem.getBindingContext();
                                console.log("oContext ###",oContext);
                                // var oView = this.getView().byId('stepInputID');
                                // console.log("oView ###",oView);
                            //    oView.setBindingContext(oContext)
                            },
                        }),
                        // new sap.m.Input({ width: 'auto' }),

                        new sap.m.StepInput({ 
                        id:'stepInputID',
                        width: 'auto', 
                        min: 1, 
                        max: 1000, 
                        step: 1, 
                        description: '{UOM}', 
                        enabled: true, 
                        editable: true, 
                        displayValuePrecision: 2 }),
                    ]
                });
                var oTable = this.byId("poItemTable");
                oTable.addItem(oItem);
            },
            onPressSaveBtn: function (oEvent) {
                var oView = this.getView();
                // var oModel = oView.getModel();

                /**
                 * 
                 * 
                 * Purchase Order Number
                 * 
                 * 
                 */
                // left

                var sPurchaseDocumentID = this.byId("poid").getValue();

                var sBusinessPartnerID = this.byId("bpid").getSelectedItem().getKey();

                // console.log('sBusinessPartnerID ###', sBusinessPartnerID);

                var aItems = [];

                var oTable = oView.byId("poItemTable");
                var aTableItems = oTable.getItems();

                for (let x = 0; x < aTableItems.length; x++) {
                    let dataObj = {
                        EBELP: aTableItems[x].getCells()[0].getValue(),
                        WERKS_WERKS: aTableItems[x].getCells()[1].getSelectedItem().mProperties.key              ,
                        MATNR_MATNR: aTableItems[x].getCells()[2].getSelectedItem().mProperties.key,
                        MENGE: parseInt(aTableItems[x].getCells()[3].getValue())

                        // WERKS_WERKS: aTableItems[x].getCells()[1].getSelectedItem().getKey(),
                        // MATNR_MATNR: aTableItems[x].getCells()[2].getSelectedItem().getKey(),
                        // MENGE: parseFloat(aTableItems[x].getCells()[3].getValue()).toFixed(2).toString()
                    }

                    aItems.push(dataObj);
                    // console.log('aItems ###', aItems);
                }

                let oPurchaseOrder = {
                    EBELN: sPurchaseDocumentID,
                    PARTNER_PARTNER: sBusinessPartnerID,
                    items: aItems
                }
                // console.log('oPurchaseOrder ###',oPurchaseOrder);
                oPOtable.create(oPurchaseOrder, {
                    success: function (oData) {
                        // sales order successfully created
                        MessageToast.show("Purchase Order created successfully");
                    },
                    error: function (oError) {
                        // handle rejection of entity creation
                        MessageToast.show("Error occurred while creating Purchase Order");
                    }
                });

                const oHistory = sap.ui.core.routing.History.getInstance();
                const sPreviousHash = oHistory.getPreviousHash();

                if (sPreviousHash !== undefined) {
                    window.history.go(-1);
                } else {
                    const oRouter = this.getOwnerComponent().getRouter();
                    oRouter.navTo("TargetpoListReport", {}, true);
                }

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
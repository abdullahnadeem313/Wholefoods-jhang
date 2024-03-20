sap.ui.define([
    "sap/ui/core/mvc/Controller",
	"sap/ui/model/Filter",
    "sap/m/MessageToast",
	"sap/ui/model/FilterOperator"
],
    /**
     * @param {typeof sap.ui.core.mvc.Controller} Controller
     */
    function (Controller,Filter,FilterOperator,MessageToast) {
        "use strict";
        var oPOtable;
        var oPOtableView;
        return Controller.extend("ns.poui5.controller.poListReport", {
            onInit: function () {


            },

            onNavToDetails: function (oEvent) {
                var oItem = oEvent.getSource();

                var oRouter = this.getOwnerComponent().getRouter();
                oRouter.navTo("TargetpoObjectPage", { poHead: oItem.getBindingContext().getPath().substring("/PO_Head".length) });
                
            },

            onCreateOrder : function (oEvent) {

                var oContext= this.byId("PurchaseOrderListID").getBinding("items").create({EBELN: ''});
                var oModel =this.getView().getModel();
                var that = this;
                var oRouter = that.getOwnerComponent().getRouter();
                oModel.submitBatch("poTableGroup").then({
                    function () {
                        oPOtable = that.byId("PurchaseOrderListID")
                        // var oBinding = oPOtable.getBinding("items");
                        
                        var oItem= oPOtable.getItems()[0].getBindingContext();
                        console.log("oItem $$$", oItem);
                        oRouter.navTo("TargetpoObjectPage", { poHead: oItem.sPath.substring("/PO_Head".length) });
                    }
                })
                
                
                // var oRouter = this.getOwnerComponent().getRouter();
                
                // oContext.created().then(function () {
                //     console.log("Sales Order created: " + oContext.getProperty("ID"));
                //     // oContext.setKeepAlive(true, undefined, /*bRequestMessages*/ true);
                //     if (oContext.isTransient()) {
                //         this.getView().getModel("ui").setProperty("/oContext", oContext);
                //         // oRouter.navTo("TargetpoObjectPage", {poHead : oContext.sPath.substring("/PO_Head".length)});
                //         oRouter.navTo("TargetpoObjectPage", {poHead : oContext.getProperty("ID")});
                //     } 
                // }, function () {
                //     // creation canceled
                //     oRouter.navTo("TargetpoObjectPage",{poHead : oContext.getProperty("ID")});
                // });
                
                
            },
            onFilterProducts(oEvent) {
                // build filter array
                var comFil = new sap.ui.model.Filter([new Filter("PARTNER/NAME", FilterOperator.Contains, sQuery),
                    new Filter("PARTNER_PARTNER", FilterOperator.Contains, sQuery),
                    new Filter("EBELN", FilterOperator.Contains, sQuery)]);
                // filter binding
                const oList = this.byId("PurchaseOrderListID");
                const oBinding = oList.getBinding("items");
                oBinding.filter(comFil);
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
                let aTableLength = this.byId("poItemTable").getItems().length;
                let itemNumber = String( aTableLength * 10 + 10);
                let PO_ITEM_EBELP = itemNumber.padStart(4, "0");
                // Fields addition
                let oItem = new sap.m.ColumnListItem({
                    cells: [
                        // new sap.m.Input({ width: 'auto' }),
                        new sap.m.Text({ width: 'auto', text: PO_ITEM_EBELP }),
                        new sap.m.ComboBox({
                            items: {
                                path: "/Plants",
                                template: new sap.ui.core.ListItem({
                                    key: '{WERKS}',
                                    text: '{WERKS} ({NAME1})'
                                })
                            },
                            width: 'auto',
                        }),
                        new sap.m.ComboBox({
                            items: {
                                path: "/rawMaterials",
                                template: new sap.ui.core.Item({
                                    key: '{MATNR}',
                                    text: '{MATNR} ({MAKTX})'
                                })
                            },
                            width: 'auto',
                            selectionChange: function (oEvent) {
                                var oContext = oEvent.getParameters().selectedItem.getBindingContext();
                                // console.log("oContext ###",oContext);
                                let row = oEvent.getSource().sId.replace('__box','')
                                // let row = oEvent.getSource().sId.replace('__select','')
                                row = Math.floor(row/2)-1;
                                // console.log("row ###",row);
                                let quantityID = '__input'+ row
                                // console.log("quantityID ###",quantityID);
                                sap.ui.core.Element.getElementById(quantityID).setBindingContext(oContext);

                            },
                        }),
                        // new sap.m.Input({ width: 'auto' }),
                        new sap.m.StepInput({ 
                            min: 1, 
                            max: 1000, 
                            step: 1, 
                            description: ' {UOM}', 
                            enabled: true, 
                            editable: true, 
                            displayValuePrecision: 2 }),
                    ]
                });
                var oTable = this.byId("poItemTable");
                oTable.addItem(oItem);
            },
            onDeleteOrder : function () {
                let oView = this.getView()
                oPOtableView = oView.byId("PurchaseOrderListID");
                let oPOtableContext = oPOtableView.getSelectedItem().getBindingContext();
                console.log('oPOtableContext ###',oPOtableContext);
                
                oPOtableContext.delete("$auto").then(function () {
                        // Purchase Order successfully deleted
                        // MessageToast.show("Purchase Order deleted successfully");
                   }, function (oError) {
                        // do error handling
                        // MessageToast.show("Error occurred while deleting Purchase Order");
                   });
            },
            toggleDraft: function (sAction) {
                var oObject = this.getView();
                var oContext = oObject.getBindingContext();
                
                oContext.bindContext("WholefoodsService."+sAction+"(...)",
                oContext, {$$inheritExpandSelect : true})
                    .execute("$auto", false, null)
            },
            /**
             * 
             * Before draft create code
             *  
             */
            /* 
            onCreatePOBtn: function (oEvent) {
                var oView = this.getView();
                // var oModel = oView.getModel();

                var sBusinessPartnerID = this.byId("bpid").getSelectedItem().getKey();

                // console.log('sBusinessPartnerID ###', sBusinessPartnerID);

                var aItems = [];

                var oTable = oView.byId("poItemTable");
                var aTableItems = oTable.getItems();

                for (let x = 0; x < aTableItems.length; x++) {
                    let dataObj = {
                        EBELP: aTableItems[x].getCells()[0].getText(),
                        WERKS_WERKS: aTableItems[x].getCells()[1].getSelectedItem().mProperties.key              ,
                        MATNR_MATNR: aTableItems[x].getCells()[2].getSelectedItem().mProperties.key,
                        MENGE: parseInt(aTableItems[x].getCells()[3].getValue()),
                        
                        // UOM: parseInt(aTableItems[x].getCells()[3].getDescription())
                        // EBELP: aTableItems[x].getCells()[0].getValue(),
                        // WERKS_WERKS: aTableItems[x].getCells()[1].getSelectedItem().getKey(),
                        // MATNR_MATNR: aTableItems[x].getCells()[2].getSelectedItem().getKey(),
                        // MENGE: parseFloat(aTableItems[x].getCells()[3].getValue()).toFixed(2).toString()
                    }

                    aItems.push(dataObj);
                    console.log('aItems ###', aItems);
                }

                let oPurchaseOrder = {
                    EBELN: '',
                    PARTNER_PARTNER: sBusinessPartnerID,
                    items: aItems
                }
                console.log('oPurchaseOrder ###',oPurchaseOrder);
                oPOtable.create(oPurchaseOrder,false,true);
                
                const oHistory = sap.ui.core.routing.History.getInstance();
                const sPreviousHash = oHistory.getPreviousHash();

                if (sPreviousHash !== undefined) {
                    window.history.go(-1);
                } else {
                    const oRouter = this.getOwnerComponent().getRouter();
                    oRouter.navTo("TargetpoListReport", {}, true);
                }

            },
             */
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
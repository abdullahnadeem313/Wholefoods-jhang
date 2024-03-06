// sap.ui.define([
//     "sap/ui/core/mvc/Controller",
//     "sap/ui/core/UIComponent",
//     "sap/m/MessageToast",
//     "sap/ui/model/resource/ResourceModel"
// ],
//     /**
//      * @param {typeof sap.ui.core.mvc.Controller} Controller
//      */
//     function (Controller, MessageToast, ResourceModel) {
//         "use strict";

//         return Controller.extend("ns.poui5.controller.create", {
//             onInit: function () {

//             },

//             onNavBack() {
//                 const oHistory = sap.ui.core.routing.History.getInstance();
//                 const sPreviousHash = oHistory.getPreviousHash();

//                 if (sPreviousHash !== undefined) {
//                     window.history.go(-1);
//                 } else {
//                     const oRouter = this.getOwnerComponent().getRouter();
//                     oRouter.navTo("TargetpoListReport", {}, true);
//                 }
//             },
//             onPressClickMe() {
//                 let objHeader = this.byId("headerTitle");
//                 objHeader.setTitle('items')
//             },
//             onAddItems: function (oEvent) {


//                 // item number
//                 var itemNumber = '0';
//                 itemNumber = parseInt(itemNumber);
//                 itemNumber = itemNumber + 10;
//                 var PO_ITEM_EBELP = String(itemNumber).padStart(4, "0");
//                 // Fields addition
//                 var oItem = new sap.m.ColumnListItem({
//                     cells: [
//                         new sap.m.Input({ width: 'auto' }),
//                         // new sap.m.Text({ width: 'auto', text: PO_ITEM_EBELP }),
//                         new sap.m.Select({
//                             items: {
//                                 path: "/Plants",
//                                 template: new sap.ui.core.ListItem({
//                                     key: '{WERKS}',
//                                     text: '{NAME1}'
//                                 })
//                             },
//                             width: 'auto',
//                         }),
//                         new sap.m.Select({
//                             items: {
//                                 path: "/rawMaterials",
//                                 template: new sap.ui.core.ListItem({
//                                     key: '{MATNR}',
//                                     text: '{MAKTX}'
//                                 })
//                             },
//                             width: 'auto',
//                             change: "onChangeMaterials",
//                         }),
//                         // new sap.m.Input({ width: 'auto' }),

//                         new sap.m.StepInput({ 
//                         id:'stepInputID',
//                         width: 'auto', 
//                         min: 1, 
//                         max: 1000, 
//                         step: 1, 
//                         description: '{UOM}', 
//                         enabled: true, 
//                         editable: true, 
//                         displayValuePrecision: 2 }),
//                     ]
//                 });
//                 var oTable = this.byId("poItemTable");
//                 oTable.addItem(oItem);
//             },
//             onChangeMaterials:function (oEvent) {
//             //     var oView = this.getView();
//             //     var oContext = oEvent.getParameters().selectedItem.getBindingContext();
//             //     console.log("oContext ###",oContext);
//             //    oView.byId('stepInputID').setBindingContext(oContext)
//             },
//             onPressSaveBtn: function (oEvent) {
//                 var oView = this.getView();
//                 // var oModel = oView.getModel();

//                 /**
//                  * 
//                  * 
//                  * Purchase Order Number
//                  * 
//                  * 
//                  */
//                 // left

//                 var sPurchaseDocumentID = this.byId("poid").getValue();

//                 var sBusinessPartnerID = this.byId("bpid").getSelectedItem().getKey();

//                 // console.log('sPurchaseDocumentID ###', sPurchaseDocumentID);

//                 var aItems = [];

//                 var oTable = oView.byId("poItemTable");
//                 var aTableItems = oTable.getItems();

//                 for (let x = 0; x < aTableItems.length; x++) {
//                     let dataObj = {
//                         EBELP: aTableItems[x].getCells()[0].getValue(),
//                         WERKS_WERKS: aTableItems[x].getCells()[1].getSelectedItem().getKey(),
//                         MATNR_MATNR: aTableItems[x].getCells()[2].getSelectedItem().getKey(),
//                         MENGE: parseFloat(aTableItems[x].getCells()[3].getValue()).toFixed(2)
//                         // MENGE: parseInt(aTableItems[x].getCells()[3].getValue())
//                     }

//                     aItems.push(dataObj);
//                     console.log('aItems ###', aItems);
//                 }

//                 let oPurchaseOrder = {
//                     EBELN: sPurchaseDocumentID,
//                     PARTNER_PARTNER: sBusinessPartnerID,
//                     items: aItems
//                 }
//                 var oModel = sap.ui.getCore().byId("PurchaseOrderListID").getBinding("items");
//                 // .getItems();


//                 console.log("oModel$$$", oModel);

//                 // oModel.create(oPurchaseOrder)
//                 // oModel.create("/PO_Head", oPurchaseOrder, {
//                 //     success: function (oData) {
//                 //         // sales order successfully created
//                 //         MessageToast.show("Purchase Order created successfully");
//                 //     },
//                 //     error: function (oError) {
//                 //         // handle rejection of entity creation
//                 //         MessageToast.show("Error occurred while creating Purchase Order");
//                 //     }
//                 // });

//             }

//         });
//     });

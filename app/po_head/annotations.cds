using WholefoodsService as service from '../../srv/wholefoods-service';
// using from '../../srv/annotations/Materials/materials-fiori';

// annotate service.PO_Head {
//     EBELN   @(title: '{i18n>purchaseOrderNumber}');
//     PARTNER @(title: '{i18n>businessPartnerID}',
//                 Common: {
//             ValueListWithFixedValues,
//             ValueList: {
//                 $Type         : 'Common.ValueListType',
//                 CollectionPath: 'BPGeneral',
//                 Parameters    : [
//                     {
//                         $Type            : 'Common.ValueListParameterOut',
//                         LocalDataProperty: PARTNER_PARTNER,
//                         ValueListProperty: 'PARTNER',
//                     },
//                     {
//                         $Type            : 'Common.ValueListParameterDisplayOnly',
//                         ValueListProperty: 'NAME',
//                     },
//                 ],
//             },
//             Text : {
//                 $value: PARTNER.NAME,
//                 ![@UI.TextArrangement] : #TextFirst,
//             },
//         },
//     );
// }


// annotate service.PO_Item {
//     ID  @(title: '{i18n>poItemsID}');
//     EBELN @(title: '{i18n>purchaseOrderNumber}');
//     EBELP @(title: '{i18n>itemNumber}');
//     WERKS @(title: '{i18n>plantID}');
//     MATNR @(title: '{i18n>materialID}');
//     MENGE @(title: '{i18n>poQuantity}');
//     UOM @(title: '{i18n>unitOfMeasure}');
// }

// annotate service.PO_Head with @(
//     UI.LineItem: [
//     {
//         $Type                : 'UI.DataField',
//         Value                : EBELN,
//         ![@HTML5.CssDefaults]: {
//             $Type: 'HTML5.CssDefaultsType',
//             width: '50%'
//         },
//     },
//     {
//         $Type                : 'UI.DataField',
//         Value                : PARTNER_PARTNER,
//         ![@HTML5.CssDefaults]: {
//             $Type: 'HTML5.CssDefaultsType',
//             width: '50%'
//         },
//     },
// ]);
// annotate service.PO_Head with @(UI:{
//     HeaderInfo  : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : '{i18n>purchaseOrder}',
//         TypeNamePlural : '{i18n>purchaseOrders}',
//         Title:{Value:EBELN}
//     },
// });
// annotate service.PO_Head with @(
    
//     UI.FieldGroup #GeneratedGroup1: {
//         $Type: 'UI.FieldGroupType',
//         Data : [
//             {
//                 $Type: 'UI.DataField',
//                 Value: EBELN,
//             },
//             {
//                 $Type: 'UI.DataField',
//                 Value: PARTNER_PARTNER,
//             },
//         ],
//     },
//     UI.Facets                     : [{
//         $Type : 'UI.ReferenceFacet',
//         ID    : 'GeneratedFacet1',
//         Label : 'General Information',
//         Target: '@UI.FieldGroup#GeneratedGroup1',
//     },
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'Purchase Order Items',
//             ID : 'POItemstable',
//             Target : 'items/@UI.LineItem#POItemstable',
//         }, ]
// );


// annotate service.PO_Item with @(
//     UI.LineItem #POItemstable : [
//         {
//             $Type : 'UI.DataField',
//             Value : EBELP,
//         },{
//             $Type : 'UI.DataField',
//             Value : MATNR_MATNR,
//         },
//         {
//             $Type : 'UI.DataField',
//             Value : MATNR.MAKTX,
//         },{
//             $Type : 'UI.DataField',
//             Value : MENGE,
//         },{
//             $Type : 'UI.DataField',
//             Value : UOM,
//             ![@UI.Importance] : #High,
//         },{
//             $Type : 'UI.DataField',
//             Value : WERKS_WERKS,
//         },
//         {
//             $Type : 'UI.DataField',
//             Value : WERKS.NAME1,
//         },]
// );
// // annotate service.PO_Item with {
// //     EBELP @Common.FieldControl : #ReadOnly
// // };
// annotate service.PO_Item with {
//     MATNR @(Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Materials',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : MATNR_MATNR,
//                     ValueListProperty : 'MATNR',
//                 },
//             ],
//         },
//         Common.ValueListWithFixedValues : true
// )};
// annotate service.Materials with {
//     MATNR @Common.Text : {
//         $value : MAKTX,
//         ![@UI.TextArrangement] : #TextLast,
//     }
// };


// annotate service.Materials with {
//     MAKTX @(Common.Text : {
//                 $value : MATNR,
//                 ![@UI.TextArrangement] : #TextFirst,
//             }
// )};
// annotate service.PO_Item with {
//     WERKS @(Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Plants',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : WERKS_WERKS,
//                     ValueListProperty : 'WERKS',
//                 },
//             ],
//         },
//         Common.ValueListWithFixedValues : true
// )};
// annotate service.Plants with {
//     WERKS @Common.Text : {
//         $value : NAME1,
//         ![@UI.TextArrangement] : #TextLast,
//     }
// };
// annotate service.Materials with {
//     MAKTX @Common.FieldControl : #ReadOnly
// };
// annotate service.PO_Item with {
//     UOM @Common.Text : {
//             $value : MATNR.UOM,
//             ![@UI.TextArrangement] : #TextLast,
//         }
// };
// annotate service.Plants with {
//     NAME1 @Common.FieldControl : #ReadOnly
// };
// annotate service.PO_Item with {
//     UOM @UI.MultiLineText : false
// };
// annotate service.PO_Item with {
//     UOM @(Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Materials',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : UOM,
//                     ValueListProperty : 'UOM',
//                 },
//             ],
//         },
//         Common.ValueListWithFixedValues : true
// )};
// annotate service.PO_Item with {
//     UOM @Common.FieldControl : #ReadOnly
// };
// annotate service.PO_Item with @(UI:{
// HeaderInfo  : {
//     $Type : 'UI.HeaderInfoType',
//     TypeName : '{i18n>purchaseOrderItem}',
//     TypeNamePlural : '{i18n>purchaseOrderItems}',
//     Title:{Value:EBELP}
// },
// });
// annotate service.PO_Item with @(
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             Label : 'Purchase Order Information',
//             ID : 'PurchaseOrderInformation',
//             Target : '@UI.Identification',
//         },
//     ],
//     UI.Identification : [
//         {
//             $Type : 'UI.DataField',
//             Value : EBELN.EBELN,
//         },{
//             $Type : 'UI.DataField',
//             Value : EBELP,
//         },{
//             $Type : 'UI.DataField',
//             Value : WERKS_WERKS,
//         },{
//             $Type : 'UI.DataField',
//             Value : UOM,
//         },{
//             $Type : 'UI.DataField',
//             Value : MENGE,
//         },{
//             $Type : 'UI.DataField',
//             Value : MATNR_MATNR,
//         },{
//             $Type : 'UI.DataField',
//             Value : EBELN.EBELN,
//         },{
//             $Type : 'UI.DataField',
//             Value : EBELN.PARTNER_PARTNER,
//         },]
// );
// annotate service.PO_Head with {
//     EBELN @Common.FieldControl : #ReadOnly
// };

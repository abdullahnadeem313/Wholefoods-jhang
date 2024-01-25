const cds = require("@sap/cds");
const { Console } = require("console");

module.exports = async function (srv) {
  const zeroPad = (num, places) => String(num).padStart(places, "0");

  const { PO_Head, PO_Item, Mard } = this.entities();

  let PO_HEADER_EBELN = "0";
  // let PO_ITEM_EBELP = '0';
  let PO_ITEM_EBELP = "0";
  let ITEMID = "0";

  this.before("CREATE", "PO_Head", async (req) => {
    PO_HEADER_EBELN = parseInt(PO_HEADER_EBELN);

    PO_HEADER_EBELN += 1;

    req.data.EBELN = zeroPad(PO_HEADER_EBELN, 10);

    // console.log("EBELN ###"+ req.data.EBELN);
  });

  this.before("CREATE", "PO_Item.drafts", (req) => {
    console.log("adding materials @@@ ");
    ITEMID = parseInt(ITEMID);
    ITEMID = ITEMID + 10;
    let temp = String(ITEMID).padStart(4, "0");
    req.data.EBELP = temp;
  });

  this.before("UPDATE", "PO_Item.drafts", (req) => {
    if (req.data) {
      if (req.data.MENGE) {
        if (req.data.MENGE < 1) {
          return req.error(409, `Quantity entered should be greater than zero`);
        } else if (req.data.MENGE > 1000) {
          return req.error(409, `Quantity entered should be less than 1000`);
        }
      }
    }
  });

  // this.on('READ', 'Mard', req=>{
  //     let poitems = SELECT.from `PO_Item` .columns (b => {b.ID , b.EBELN , b.EBELP , b.WERKS,b.MATNR, b.MENGE,b.UOM})
  //     console.log(JSON.stringify(poitems));
  // });

  // this.before('NEW', '', async (req)=> {

  // let po_items_Data= JSON.stringify(req.ID)
  // // let po_items_Data= req.ID

  // console.log('adding materials @@@ '+ JSON.stringify(req.ID));

  // PO_ITEM_EBELP = parseInt(PO_ITEM_EBELP);

  // PO_ITEM_EBELP += 10

  // let itemData = zeroPad(PO_ITEM_EBELP,4);
  // req.data.items[0].EBELP = itemData;
  // console.log('EBELP !!',req.data.items[0].EBELP);

  // });
};

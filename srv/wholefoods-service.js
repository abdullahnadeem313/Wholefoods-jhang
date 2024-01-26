const cds = require("@sap/cds");
const { Console } = require("console");

module.exports = async function (srv) {
  const zeroPad = (num, places) => String(num).padStart(places, "0");

  const { PO_Head, PO_Item, Mard } = this.entities();

  let PO_HEADER_EBELN = "0";
  // let PO_ITEM_EBELP = '0';
  let ITEMID = "0";
  let PO_ITEM_EBELP = "0";

  this.before('*',async req=>{
    if (req.target){
      let entityName = req.target.name;
      console.log("calling entity name:  " + entityName);
    }
    if (req.event) {
      let methodName = req.event;
      console.log("calling method name: " + methodName);
    }
  })

  
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
      PO_ITEM_EBELP = String(ITEMID).padStart(4, "0");
  
      req.data.EBELP = PO_ITEM_EBELP;


    
  });


  this.before("UPDATE", "PO_Item.drafts", (req) => {
    const { data } = req;

  // Check MENGE is present in the request data
  if (data.MENGE !== undefined) {
    const MENGEValue = data.MENGE;


    if (MENGEValue == 0) {
      req.error({
        message: "Quantity value should be greater than zero.",
        target: "MENGE"
      });
    }
    else if (MENGEValue < 0) {
      req.error({
        message: "Negative numbers are not allowed.",
        target: "MENGE"
      });
    }
    else if (MENGEValue > 1000) {
      req.error({
        message: "Quantity value should not exceed 1000.",
        target: "MENGE"
      });
    }
  }
  });


  this.on('error',async (err) =>{
        console.log("err ***",err);
    if (err.element === 'EBELP') {
        return err.message = (`Error in ${err.value} item: Only 10 items are allowed in one purchase order`);
    }
  });

    // if(err.element === 'MENGE'){
    //   if(err.value === 0){
    //     return err.message = (err,`zero is not allowed!`);
    //   }else if(err.value > 1000){
    //     return err.message = (`Quantity greater than 1000 is not allowed!`);
    //   }else{
    //     return err.message = (`Negative nuumbers are not allowed!`);
    //   }
    // }



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

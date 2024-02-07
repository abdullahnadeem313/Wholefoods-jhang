const cds = require("@sap/cds");

module.exports = async function (srv) {
  const zeroPad = (num, places) => String(num).padStart(places, "0");

  const { PO_Head, PO_Item, Mard, Materials } = this.entities();

  let ITEMID = "0";
  let PO_ITEM_EBELP = "0";
  let PO_HEADER_EBELN;

  // checking the details of request
  this.before("*", async (req) => {
    if (req.target) {
      let entityName = req.target.name;
      console.log("calling entity name:  " + entityName);
    }
    if (req.event) {
      let methodName = req.event;
      console.log("calling method name: " + methodName);
    }
  });
  // Adding Delete functionality
//   this.before('DELETE', "PO_Head", async (req) => {
//     let PO_ID = req.data.ID;

//     console.log("PO_ID =", req.data.ID);
//     const poItem = await SELECT.from('WholefoodsService.PO_Item').columns('MATNR_MATNR', 'WERKS_WERKS', 'MENGE', 'UOM').where({ EBELN_ID: PO_ID });
//     console.log('poItem', poItem);
//     for (let i = 0; i < poItem.length; i++) {
//         const item = poItem[i];

//         let mardTable = await SELECT.from('WholefoodsService.Mard').where({ MATNR_MATNR: item.MATNR_MATNR, WERKS_WERKS: item.WERKS_WERKS }).columns('MATNR_MATNR', 'WERKS_WERKS', 'LABST', 'UOM');
//         console.log('mardTable', mardTable);

//         if (mardTable[0].LABST === poItem[i].MENGE) {
//             await DELETE.from('WholefoodsService.Mard').where({ WERKS_WERKS: mardTable[0].WERKS_WERKS, MATNR_MATNR: mardTable[0].MATNR_MATNR });
//         } else {
//             await UPDATE('WholefoodsService.Mard').set({ LABST: { '-=': poItem[i].MENGE } }).where({ MATNR_MATNR: mardTable[0].MATNR_MATNR, WERKS_WERKS: mardTable[0].WERKS_WERKS });
//         }
//     }
// });

  this.before("CREATE", "PO_Head", async (req) => {
    let purNum = await SELECT.from(PO_Head).columns("EBELN");
    console.log("purNum: ", purNum);
    if (purNum.length > 0) {
      purNum.sort(function (a, b) {
        a.EBELN - b.EBELN;
      });
      PO_HEADER_EBELN = purNum[purNum.length - 1].EBELN;
      PO_HEADER_EBELN = parseInt(PO_HEADER_EBELN);
      PO_HEADER_EBELN += 1;
      req.data.EBELN = zeroPad(PO_HEADER_EBELN, 10);
    } else {
      PO_HEADER_EBELN = "0";
      PO_HEADER_EBELN = parseInt(PO_HEADER_EBELN);
      
      PO_HEADER_EBELN += 1;
      
      req.data.EBELN = zeroPad(PO_HEADER_EBELN, 10);
    }
    
    // console.log("EBELN ###"+ req.data.EBELN);
  });

  this.before("CREATE", "PO_Item.drafts", async (req) => {
    
    let req_ID = req.data.EBELN_ID;
    let itemNum = await SELECT.from("WholefoodsService.PO_Item.drafts")
    .columns("EBELP")
    .where({ EBELN_ID: req_ID });
    // console.log("item $$$$",itemNum);
    if (itemNum.length > 0) {
      itemNum.sort(function (a, b) {
        a.EBELP - b.EBELP;
      });
      ITEMID = itemNum[itemNum.length - 1].EBELP;
      // console.log("last Item id after sort &&& ",ITEMID);

      ITEMID = parseInt(ITEMID);
      ITEMID = ITEMID + 10;
      PO_ITEM_EBELP = String(ITEMID).padStart(4, "0");

      req.data.EBELP = PO_ITEM_EBELP;
    } else {
      ITEMID = "0";
      ITEMID = parseInt(ITEMID);
      ITEMID = ITEMID + 10;
      PO_ITEM_EBELP = String(ITEMID).padStart(4, "0");
      
      req.data.EBELP = PO_ITEM_EBELP;
    }
  });
  
  this.before("UPDATE", "PO_Item.drafts",async (req) => {
    const { data } = req;
    
    // Check MENGE validations
    
    if (data.MENGE !== undefined) {
      const MENGEValue = data.MENGE;
      
      if (MENGEValue == 0) {
        req.error({
          message: "Quantity value should be greater than zero.",
          target: "MENGE",
        });
      } else if (MENGEValue < 0) {
        req.error({
          message: "Negative numbers are not allowed.",
          target: "MENGE",
        });
      } else if (MENGEValue > 1000) {
        req.error({
          message: "Quantity value should not exceed 1000.",
          target: "MENGE",
        });
      }
    }
    
    
  });


  this.on("error", async (err, req) => {
    // console.log("req++",req);
    // console.log("err ***", err);
    //check for limiting 10 items
    if (err.element === "EBELP") {
      return (err.message = `Error in ${err.value} item: Only 10 items are allowed in one purchase order`);
    }
    
    //Business Partner should not be null
    if (
      err.element === "PARTNER_PARTNER" &&  err.message === "ASSERT_NOT_NULL"
      ) {
        // console.log("PARTNER_PARTNER ERROR +++", err.message);

        return (err.message = `Error: Business Partner should not be null`,err.target.name );
      }
      
      // not null PO Quantity
      if (err.element === "MENGE" && err.message === "ASSERT_NOT_NULL") {
        // console.log("MENGE ERROR ###", err.message);
        
        const columnName = "PO Quantity";
        err.message = (`Error: cannot insert NULL or update to NULL to ${columnName}`);       
      }
      
      // not null Plant ID
      if (err.element === "WERKS_WERKS" && err.message === "ASSERT_NOT_NULL") {
        // console.log("WERKS_WERKS ERROR @@@", err.message);
        
        const columnName = "Plant ID";
        
        const errorMessage = `Error: cannot insert NULL or update to NULL to ${columnName}.`;
        
        err.message = errorMessage;
      }
      
      // not null Material ID
      if (err.element === "MATNR_MATNR" && err.message === "ASSERT_NOT_NULL") {
        // console.log("MATNR_MATNR ERROR $$$", err.message);
        
        const columnName = "Material ID";
        
        const errorMessage = `Error: cannot insert NULL or update to NULL to ${columnName}.`;
        
        err.message = errorMessage;
      }
    }); 
    //EDIT part
  // this.before('UPDATE', PO_Head, async req=>{
  
  //   let POItemJSON = JSON.stringify(req.data.items);
  //   let updatedPOItems = req.data.items;
  //   console.log(">>>## after Edit "+ POItemJSON);

  //   // const po_ItemNoEdit = await SELECT.from(PO_Item);
  //   // console.log(">>>## before Edit"+JSON.stringify(po_ItemNoEdit));


  //   for (const item of updatedPOItems) {
  //     const { ID, EBELP, WERKS_WERKS, MATNR_MATNR, MENGE, UOM } = item;
    
  //     // Check if MATNR_MATNR field needs to be updated
  //     const poItem = await SELECT.from(PO_Item).where({ ID: ID, EBELP: EBELP });
  //     if (poItem.MATNR_MATNR === MATNR_MATNR) {
  //       // Check if MATNR_MATNR field needs to be updated
  //       const existingMard = await SELECT.from(Mard).where({ MATNR_MATNR: MATNR_MATNR }).one();
  //       if (existingMard) {

  //         let updatedMenge = poItem.MENGE;
  //         if (MENGE > poItem.MENGE) {
  //           updatedMenge += MENGE - poItem.MENGE; // increment MENGE
  //         } else if (MENGE < poItem.MENGE) {
  //           updatedMenge -= poItem.MENGE - MENGE; // decrement MENGE
  //         }

  //         await UPDATE(Mard)
  //           .set({
  //             LABST: updatedMenge,
  //             WERKS_WERKS:WERKS_WERKS
  //           })
  //           .where({ MATNR_MATNR: MATNR_MATNR });
  //       } else {
  //         await INSERT.into(Mard)
  //           .columns('MATNR_MATNR', 'WERKS_WERKS' , 'LABST', 'UOM')
  //           .values(MATNR_MATNR, WERKS_WERKS , MENGE, UOM);
  //       }
  //     }
  //   }

  // });


  // this.after('EDIT',PO_Head,async req=>{

  //   console.log(">>>## "+JSON.stringify(req));
  // });


  // Adding Data to Mard
  this.after('CREATE', 'PO_Head', async (req) => {
    let poItems = await SELECT.from(PO_Item).columns('MATNR_MATNR', 'WERKS_WERKS','UOM')
    //   console.log("Adding DATA to MARD !!! \n",poItems);
    
    for (let i = 0; i < poItems.length; ++i) {
      // console.log("\n !!!!!: " + JSON.stringify(poItems[i]))
      // console.log("Inserting Plants and Material ID !!! \n"+ element);
      await UPSERT(poItems[i]).into(Mard)
    }

    
    poItems = await SELECT.from(PO_Item).columns('MATNR_MATNR', 'WERKS_WERKS', 'MENGE')
    await UPDATE(Mard).with({ LABST: 0})
    
    for (let i = 0; i < poItems.length; ++i) {
      // console.log("\n @@@@@: " + JSON.stringify(poItems[i]) + "\n")
      // console.log("updating Quantity and UOM !!! \n"+ element);
      await UPDATE(Mard)
      .with({
        LABST: { '+=': poItems[i].MENGE },
        // UOM: poItems[i].UOM
      })
      .where({ MATNR_MATNR: poItems[i].MATNR_MATNR, WERKS_WERKS: poItems[i].WERKS_WERKS })
    }
  
  });
  // Updating UOM
  this.after("UPDATE", PO_Item.drafts,async (req)=>{
    const {data} = req;
    // console.log('MATr data ',data);
    if (req.MATNR_MATNR !== undefined) {
      let material = await SELECT.one.from(Materials).columns('UOM').where({MATNR:req.MATNR_MATNR});
      console.log('MATr'+JSON.stringify(material));
      await UPDATE `WHOLEFOODSSERVICE_PO_ITEM_DRAFTS` .set `UOM = ${material.UOM}` .where `ID=${req.ID}` ;   
    }
  });
  
  
};



















// this.before("READ", "PO_Item", (req) => {
  //   const { data } = req;
  //   // not null Plant ID
  //   if (data.WERKS === undefined || data.WERKS === '' || data.WERKS === null) {
    //     req.error({
      //       message: "Plant ID should not be null.",
      //       target: "WERKS",
      //     });
      //   }
      
      //   if (data.MENGE === undefined || data.MENGE === '' || data.MENGE === null) {
        //     req.error({
          //       message: "PO Quantity should  not be null.",
          //       target: "MENGE",
          //     });
          //   }
          
          //  });
          
          // this.on('READ', 'Mard', req=>{
            //     let poitems = SELECT.from `PO_Item` .columns (b => {b.ID , b.EBELN , b.EBELP , b.WERKS,b.MATNR, b.MENGE,b.UOM})
            //     console.log(JSON.stringify(poitems));
            // });

// this.before('NEW', 'PO_Head', async (req)=> {

// let po_items_Data= JSON.stringify(req.ID)
// // let po_items_Data= req.ID

// console.log('adding materials @@@ '+ JSON.stringify(req.ID));

// PO_ITEM_EBELP = parseInt(PO_ITEM_EBELP);

// PO_ITEM_EBELP += 10

// let itemData = zeroPad(PO_ITEM_EBELP,4);
// req.data.items[0].EBELP = itemData;
// console.log('EBELP !!',req.data.items[0].EBELP);

// });

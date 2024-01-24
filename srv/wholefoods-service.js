const cds = require('@sap/cds');

module.exports = async function (srv) {
    const zeroPad = (num, places) => String(num).padStart(places, '0')
    
    const {PO_Head,PO_Item} = this.entities();

    let PO_HEADER_EBELN = '0';
    // let PO_ITEM_EBELP = '0';
    let PO_ITEM_EBELP = '0';

    this.before('CREATE','PO_Head', async (req)=>{
        PO_HEADER_EBELN = parseInt(PO_HEADER_EBELN);

        PO_HEADER_EBELN += 1

        req.data.EBELN = zeroPad(PO_HEADER_EBELN,10);

        // console.log("EBELN ###"+ req.data.EBELN);
    });




    this.after('NEW', 'PO_Item', async (req)=> {

    // let po_items_Data= JSON.stringify(req.ID) 
    // let po_items_Data= req.ID

    console.log('adding materials @@@ '+ JSON.stringify(req.ID));

    
    PO_ITEM_EBELP = parseInt(PO_ITEM_EBELP);
    
    PO_ITEM_EBELP += 10
    
    let itemData = zeroPad(PO_ITEM_EBELP,4);
    req.data.items[0].EBELP = itemData;
    console.log('EBELP !!',req.data.items[0].EBELP);

    });
    
    
}
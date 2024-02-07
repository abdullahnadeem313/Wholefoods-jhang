using {managed} from '@sap/cds/common';

namespace wholefoods;

context Wholefoods {

    entity Plants : managed {
        key WERKS  : String(4);  //Plant ID => WERKS
            NAME1  : String(30); //Name => NAME1
            STRAS  : String(30); //House No. & Street => STRAS
            PSTLZ  : String(10); //Postal/zip code => PSTLZ
            ORT01  : String(25); //City => ORT01
            LANDX  : String(15); //Country => LANDX
            CNTACT : String(20); //Phone number => CNTACT
    }

    // @cds.odata.valuelist
    entity Materials : managed {
        key MATNR : String(18); //Material ID => MATNR
            MTART : Association to one MaterialTypes; //Material Type => MTART
            MATKL : Association to one MaterialGroups; //Material Group => MATKL
            MAKTX : String(40); //Material Description => MAKTX
            UOM   : String(2); //Unit of Measure => UOM
    }

    // @cds.odata.valuelist
    entity MaterialTypes : managed {
        key MTART   : String(9);  //Material Type
            MTARTTX : String(40); //Material Type Description
    }

    // @cds.odata.valuelist
    entity MaterialGroups : managed {
        key MATKL   : String(9);  // Material Group
            MATKLTX : String(40); // Material Group Description
    }

    // @cds.odata.valuelist
    entity BPGeneral : managed {
        key PARTNER : String(10); //Business Partner ID
        BPTYPE  : Association to one BPTpyes;  //BP Category
        NAME    : String(50); //BP Name
        STRAS   : String(30); //House No. & Street
        PSTLZ   : String(10); //Postal/zip code
        ORT01   : String(25); //City
        LANDX   : String(15); //Country
        CNTACT  : String(20); //Phone number
    }

    // @cds.odata.valuelist
    entity Roles : managed {
        key ROLE :String(4); //BP Role ID
        DESC: String(30);    //Role Description
    }

    // @cds.odata.valuelist
    entity Bprofiles : managed {
        key PARTNER : Association to one BPGeneral; //BP ID
        key ROLE :Association to one Roles; //BP Role ID
        // partnerNAME    : String(50);//BP name
    }

    entity BPTpyes : managed {
        Key BPTYPE : String(1);
        BPTYPEDESC : String(12);
    }
// Stock
    entity Mard : managed {
        Key MATNR : Association to one Materials; //Material ID
        key WERKS : Association to one Plants; //Plant ID
        LABST : Integer; //Unrestricted Stock
        UOM : String(2); //Unit of Measure
    }

    entity PO_Head : managed {
        Key ID : UUID @Core.Computed:true; 
        EBELN : String(10); //Purchasing Document Number
        PARTNER : Association to one BPGeneral; // @mandatory; //Business Partner ID
        items : Composition of many wholefoods.Wholefoods.PO_Item on items.EBELN = $self;
    }

    entity PO_Item : managed {
        key ID: UUID @Core.Computed:true;
        EBELN : Association to PO_Head; //Purchasing Document Number
        EBELP : String(10) @assert.range:['0010','0100']; //Item Number
        WERKS : Association to one Plants; // @mandatory; //Plant ID
        MATNR : Association to one Materials; // @mandatory; //raw Material ID
        MENGE : Integer; // @mandatory;// @assert.range:[1,1000];  // PO Quantity
        UOM : String(2); // Unit of Measure
        virtual MATNR_NAME: String;
    }

    entity POVendor : managed {
        key PARTNER : Association to one BPGeneral; //BP ID
        key ROLE : Association to one Roles; //BP Role ID
        }

    entity rawMaterials : managed {
        key MATNR : String(18); //Material ID => MATNR
            MTART : Association to one MaterialTypes; //Material Type => MTART
            MATKL : Association to one MaterialGroups; //Material Group => MATKL
            MAKTX : String(40); //Material Description => MAKTX
            UOM   : String(2); //Unit of Measure => UOM
    }

    entity Recipe_Head : managed {
        key ID: UUID @Core.Computed:true;
        RECIPE: String(10); //Recipe Number
        MATNR: Association to finishedMaterials; //Material ID
        RECIPE_QTY: Integer; //Quantity
        UOM: String(2); //UOM
        recipe_Item:Composition of many Recipe_Item on recipe_Item.RECIPE = $self;
    }

    entity Recipe_Item : managed {
        key ID: UUID @Core.Computed:true;
        RECIPE: Association to Recipe_Head; //Recipe Number
        RECIPE_ITM: String(4); //Item Number
        MATNR:Association to Materials; //Raw Material
        RAW_QTY: Decimal; //Raw material Quantity
        UOM: String(2); //UOM
    }
    entity finishedMaterials : managed {
        key MATNR : String(18); //Material ID => MATNR
            MTART : Association to one MaterialTypes; //Material Type => MTART
            MATKL : Association to one MaterialGroups; //Material Group => MATKL
            MAKTX : String(40); //Material Description => MAKTX
            UOM   : String(2); //Unit of Measure => UOM
    }
}

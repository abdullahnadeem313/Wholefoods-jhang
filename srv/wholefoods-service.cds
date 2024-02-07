using wholefoods from '../db/data-model';

service WholefoodsService {
    
    @odata.draft.enabled:true
    entity Plants as projection on wholefoods.Wholefoods.Plants;
    @odata.draft.enabled:true
    entity Materials as projection on wholefoods.Wholefoods.Materials;
    @odata.draft.enabled:true
    entity MaterialGroups as projection on wholefoods.Wholefoods.MaterialGroups;
    @odata.draft.enabled:true
    entity MaterialTypes as projection on wholefoods.Wholefoods.MaterialTypes;
    @odata.draft.enabled:true
    entity BPGeneral as projection on wholefoods.Wholefoods.BPGeneral;
    @odata.draft.enabled:true
    entity Roles as projection on wholefoods.Wholefoods.Roles;
    @odata.draft.enabled:true
    entity Bprofiles as projection on wholefoods.Wholefoods.Bprofiles;
    @odata.draft.enabled:true
    entity BPTpyes as projection on  wholefoods.Wholefoods.BPTpyes;
    
    entity Mard as projection on wholefoods.Wholefoods.Mard;
    @odata.draft.enabled:true
    entity PO_Head as projection on wholefoods.Wholefoods.PO_Head;

    entity PO_Item as projection on wholefoods.Wholefoods.PO_Item;
    
    entity POVendor as select from Bprofiles{PARTNER,ROLE,PARTNER.NAME}  where ROLE.ROLE = 'VEND';

    entity rawMaterials as select from Materials where MTART.MTART = 'ROH';

    @odata.draft.enabled:true
    entity Recipe_Head as projection on wholefoods.Wholefoods.Recipe_Head;

    entity Recipe_Item as projection on wholefoods.Wholefoods.Recipe_Item;

    entity finishedMaterials as select from Materials where MTART.MTART = 'FERT';
}


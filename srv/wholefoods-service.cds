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
    // @odata.draft.enabled:true
    entity Mard as projection on wholefoods.Wholefoods.Mard;
    @odata.draft.enabled:true
    entity PO_Head as projection on wholefoods.Wholefoods.PO_Head;
    // @odata.draft.enabled:true  //due to composition we have no need to add this
    entity PO_Item as projection on wholefoods.Wholefoods.PO_Item;
}

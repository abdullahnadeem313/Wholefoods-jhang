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
}


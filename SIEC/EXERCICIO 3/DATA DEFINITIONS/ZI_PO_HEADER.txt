@AbapCatalog.sqlViewName: 'ZIPO30'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pedidos'

define root view ZI_PO_HEADER 
    as select from ekko 
    
    composition[0..*] of ZI_PO_ITEM as _Items
    
    association[0..1] to I_Supplier as _Supplier on $projection.Supplier = _Supplier.Supplier
    
{
    key ebeln as PONumber,
    bukrs as CompanyCode,
    aedat as CreationDate,
    bsart as POType,
    lifnr as Supplier,
    @Semantics.amount.currencyCode: 'Currency'
    rlwrt as Amount,
    @Semantics.currencyCode: true
    waers as Currency,
    
    _Items,
    _Supplier
    
}
 where bstyp = 'F'

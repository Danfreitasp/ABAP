@AbapCatalog.sqlViewName: 'ZIPOIT30'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pedidos - itens'

define view ZI_PO_ITEM 
    as select from ekpo
    
    association to parent ZI_PO_HEADER as _Header on $projection.PONumber = _Header.PONumber
    
{
    key ebeln as PONumber,
    key ebelp as POItem,
    matnr as Material,
    werks as Plant,
    lgort as StorageLocation,
    @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
    menge as Quantity,
    @Semantics.unitOfMeasure: true    
    meins as QuantityUnit,
    @Semantics.amount.currencyCode: 'Currency'
    netwr as Amount,
    @Semantics.currencyCode: true
    _Header.Currency,
    
    _Header
}

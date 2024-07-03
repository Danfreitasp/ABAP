@EndUserText.label: 'Pedidos - itens'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@OData.entityType.name: 'PurchaseOrderItem'
@OData.entitySet.name: 'PurchaseOrderItemSet'

define view entity ZC_PO_ITEM 
    as projection on ZI_PO_ITEM
    
{
    @UI.lineItem: [{ position: 10, importance: #HIGH }]
    key PONumber,
    @UI.lineItem: [{ position: 20, importance: #HIGH }]
    key POItem,
    @UI.lineItem: [{ position: 30 }]
    Material,
    @UI.lineItem: [{ position: 40 }]
    Plant,
    @UI.lineItem: [{ position: 50 }]
    StorageLocation,
    @UI.lineItem: [{ position: 60 }]
    Quantity,
    QuantityUnit,
    @UI.lineItem: [{ position: 70 }]
    @Aggregation.default: #SUM
    Amount,
    Currency,
    /* Associations */
    _Header: redirected to parent ZC_PO_HEADER
}

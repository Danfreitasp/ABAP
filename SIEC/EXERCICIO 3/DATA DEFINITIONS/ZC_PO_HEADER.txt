@EndUserText.label: 'Pedidos'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@OData.entityType.name: 'PurchaseOrder'
@OData.entitySet.name: 'PurchaseOrderSet'
@OData.publish: true

@UI.headerInfo.typeName: 'Pedido'
@UI.headerInfo.typeNamePlural: 'Pedidos'
@UI.headerInfo.title.value: 'PONumber'
@UI.headerInfo.description.value: 'POType'

define root view entity ZC_PO_HEADER 
  as projection on ZI_PO_HEADER
{

    @UI.facet: [
        { purpose: #HEADER, type: #FIELDGROUP_REFERENCE, targetQualifier: 'header', position: 10 },
        
        { purpose: #STANDARD, type: #COLLECTION, label: 'Dados básicos', position: 10, id: 'basic'},        
        { purpose: #STANDARD, type: #FIELDGROUP_REFERENCE, parentId: 'basic', targetQualifier: 'info', position: 10, label: 'Informações'},
        { purpose: #STANDARD, type: #FIELDGROUP_REFERENCE, parentId: 'basic', targetQualifier: 'supplier', position: 20, label: 'Fornecedor'},
        
        { purpose: #STANDARD, type: #COLLECTION, label: 'Itens', position: 20, id: 'item'},
        { purpose: #STANDARD, type: #LINEITEM_REFERENCE, parentId: 'item', targetElement: '_Items'}
    ]
    
    @UI.lineItem: [{ position: 10, importance: #HIGH }]
    @UI.selectionField: [{ position: 10 }]
    @Consumption.semanticObject: 'PurchaseOrder'
    key PONumber,
    @UI.fieldGroup: [{ qualifier: 'header', position: 10 },{ qualifier: 'info', position: 30 }]
    CompanyCode,
    @UI.lineItem: [{ position: 20 }]
    @UI.selectionField: [{ position: 20 }]
    @Consumption.filter.selectionType: #RANGE
    @Consumption.filter.multipleSelections: false
    @UI.fieldGroup: [{ qualifier: 'info', position: 10 }]
    CreationDate,
    @UI.fieldGroup: [{ qualifier: 'info', position: 10 }]
    POType,
    @UI.lineItem: [{ position: 30, importance: #MEDIUM }]    
    @UI.selectionField: [{ position: 30 }]
    @ObjectModel.text.element: [ 'SupplierName' ]
    @UI.textArrangement: #TEXT_FIRST
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_Supplier_VH', element: 'Supplier' } }]
    @UI.fieldGroup: [{ qualifier: 'supplier', position: 10 }]
    Supplier,
    _Supplier.SupplierName,
    @UI.fieldGroup: [{ qualifier: 'supplier', position: 20 }]
    _Supplier.CityName,
    @UI.fieldGroup: [{ qualifier: 'supplier', position: 30 }]
    _Supplier.TaxNumber1,
    @UI.lineItem: [{ position: 40 }]
    @Aggregation.default: #SUM
    @UI.fieldGroup: [{ qualifier: 'header', position: 20 }, { qualifier: 'info', position: 40 }]
    Amount,
    @Consumption.valueHelpDefinition: [{ entity:{ name: 'I_CurrencyStdVH', element: 'Currency' } }]
    Currency,
    
    /* Associations */
    _Items: redirected to composition child ZC_PO_ITEM,
    _Supplier
}

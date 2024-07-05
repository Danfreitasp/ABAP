@AbapCatalog.sqlViewName: 'ZSQL_SALES_001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS para consulta de vendas'

define view ZSALES_001
  as select from ekpo as item
  association [0..1] to ekko as _header on item.ebeln = _header.ebeln

{
  key _header.ebeln as OrderNum,
      item.netwr    as TotalCost,
      item.netpr    as UnitCost,
      item.bukrs    as CompanyCode,
      @Semantics.currencyCode: true
      _header.waers as Currency,
      _header.aedat as Data
}

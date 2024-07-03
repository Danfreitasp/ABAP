@AbapCatalog.sqlViewName: 'ZIDOCI30'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Doc. contábil - itens'

define view ZI_DOC_ITEM 
  as select from bseg
  
    association to parent ZI_DOC_HEADER as _Header on $projection.companyCode = _Header.companyCode
                                                  and $projection.documentNumber = _Header.documentNumber
                                                  and $projection.fiscalYear = _Header.fiscalYear

{
   key bukrs as companyCode,
   key belnr as documentNumber,
   key gjahr as fiscalYear,
   key buzei as docItem,
   bschl as postingKey,
   hkont as accountNumber,
@Semantics.amount.currencyCode: 'currency'
   dmbtr as amount,
   sgtxt as itemText,
   rfccur as currency,
   
   _Header
    
}

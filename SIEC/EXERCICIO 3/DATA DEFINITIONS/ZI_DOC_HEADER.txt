@AbapCatalog.sqlViewName: 'ZIDOCH30'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Doc. contábil'

define root view ZI_DOC_HEADER 
  as select from bkpf

    composition[0..*] of ZI_DOC_ITEM as _Items
    
{
   key bukrs as companyCode,
   key belnr as documentNumber,
   key gjahr as fiscalYear,
   bldat as docDate,
   usnam as createdBy,
   xblnr as reference,
   waers as currency,
   
   _Items
}

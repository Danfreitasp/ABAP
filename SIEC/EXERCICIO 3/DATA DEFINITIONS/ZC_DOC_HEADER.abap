@EndUserText.label: 'Doc. contábil'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZC_DOC_HEADER 
    as projection on ZI_DOC_HEADER
{
    key companyCode,
    key documentNumber,
    key fiscalYear,
    docDate,
    createdBy,
    reference,
    currency,
    
    /* Associations */
    _Items: redirected to composition child ZC_DOC_ITEM
}

@EndUserText.label: 'Doc. contábil - itens'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_DOC_ITEM 
    as projection on ZI_DOC_ITEM
{
    key companyCode,
    key documentNumber,
    key fiscalYear,
    key docItem,
    postingKey,
    accountNumber,
    amount,
    itemText,
    currency,
    /* Associations */
    _Header: redirected to parent ZC_DOC_HEADER
}

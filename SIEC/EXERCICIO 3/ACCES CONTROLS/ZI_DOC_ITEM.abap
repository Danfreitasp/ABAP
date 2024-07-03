@EndUserText.label: 'Access control ZI_DOC_ITEM'
@MappingRole: true
define role ZI_DOC_ITEM {
    grant 
        select
            on
                ZI_DOC_ITEM
                    where
                        (companyCode) = aspect pfcg_auth('BUKRS COMP', bukrs, actvt = '03');
                        
}
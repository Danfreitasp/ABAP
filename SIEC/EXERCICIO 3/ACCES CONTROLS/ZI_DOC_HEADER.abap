@EndUserText.label: 'Access control ZI_DOC_HEADER'
@MappingRole: true
define role ZI_DOC_HEADER {
    grant 
        select
            on
                ZI_DOC_HEADER
                    where
                        (companyCode) = aspect pfcg_auth('BUKRS COMP', bukrs, actvt = '03');
                        
}

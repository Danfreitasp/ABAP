*&---------------------------------------------------------------------*
*& Report ZDLFAJRRP_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDLFAJRRP_002.
" Utilizando uma estrutura do dicionário de dados.
DATA: ls_status TYPE zdlfajres_001.


ls_status-status = 'A'.
WRITE: / ls_status-status.

" Utilizando uma estrutura declarada localmente
TYPES: BEGIN OF ty_status,
        status TYPE zdlfajrel_001,
        description TYPE c LENGTH 40,
       END OF ty_status.
DATA: ls_status_local TYPE ty_status.

ls_status_local-status = 'A'.
WRITE: / ls_status_local-status.
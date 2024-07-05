*&---------------------------------------------------------------------*
*& Report ZDLPMJRRP_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

REPORT ZDLFAJRRP_003.

*A - Em Aberto
*V - Validado
*S - Em Separação de Estoque
*R - Em Rota
*F - Finalizado

" Utilizando uma estrutura do dicionário de dados.
DATA: ls_status TYPE zdlfajres_001,
      lt_status TYPE zdlfajrtt_001.

ls_status-status      = 'A'.
ls_status-description = 'Em Aberto'.
APPEND ls_status TO lt_status.

ls_status-status      = 'V'.
ls_status-description = 'Validado'.
APPEND ls_status TO lt_status.

ls_status-status      = 'S'.
ls_status-description = 'Em Separação de estoque'.
APPEND ls_status TO lt_status.

ls_status-status      = 'R'.
ls_status-description = 'Em Rota'.
APPEND ls_status TO lt_status.

ls_status-status      = 'F'.
ls_status-description = 'Finalizado'.
APPEND ls_status TO lt_status.

LOOP AT lt_status INTO ls_status.
  WRITE: / ls_status-status, ' - ', ls_status-description.
ENDLOOP.

*Forma de declarar atualizada
DATA(lt_status_inline) = VALUE zdlfajrtt_001(
  ( status = 'A' description = 'Em aberto' )
  ( status = 'V' description = 'Validado' )
  ( status = 'S' description = 'Em Separação de estoque' )
  ( status = 'R' description = 'Em Rota' )
  ( status = 'F' description = 'Finalizado' )
).

LOOP AT lt_status_inline INTO ls_status.
  WRITE: / ls_status-status, ' - ', ls_status-description.
ENDLOOP.

*Forma de solicitar um input e apresentar o resultado

*PARAMETERS: p_status TYPE zdlfajrel_001.
*
*IF
*p_status = 'A'.
*WRITE: / lt_status[ 1 ]-status, ' - ', lt_status[ 1 ]-description.
*
*ELSEIF
*p_status = 'V'.
*WRITE: / lt_status[ 2 ]-status, ' - ', lt_status[ 2 ]-description.
*
*ELSEIF
*p_status = 'S'.
*WRITE: / lt_status[ 3 ]-status, ' - ', lt_status[ 3 ]-description.
*
*ELSEIF
*p_status = 'R'.
*WRITE: / lt_status[ 4 ]-status, ' - ', lt_status[ 4 ]-description.
*
*ELSEIF
*p_status = 'F'.
*WRITE: / lt_status[ 5 ]-status, ' - ', lt_status[ 5 ]-description.
*
*ENDIF.
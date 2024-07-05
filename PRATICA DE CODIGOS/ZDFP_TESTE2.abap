REPORT zdfp_teste2.

TYPES: BEGIN OF ls_dados,
         nome       TYPE char30,
         idade      TYPE i,
         sexo       TYPE c,
         nascimento TYPE dats,
       END OF ls_dados.

DATA: lt_dados TYPE TABLE OF ls_dados.

PARAMETERS:
  p_nome  TYPE char30,
  p_idade TYPE i,
  p_sexo  TYPE c,
  p_nasc  TYPE dats.

START-OF-SELECTION.
  DATA(ls_dados) = VALUE ls_dados(
                     nome       = p_nome
                     idade      = p_idade
                     sexo       = p_sexo
                     nascimento = p_nasc
                   ).

  APPEND ls_dados TO lt_dados.

  " Criar objeto de ALV
  DATA: lo_alv TYPE REF TO cl_salv_table.
  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_dados ).
    CATCH cx_salv_msg.
  ENDTRY.

  " Adicionar nomes das colunas
  DATA: lo_column TYPE REF TO cl_salv_column.
  lo_alv->get_columns( )->set_optimize( 'X' ).
  lo_column = lo_alv->get_columns( )->get_column( 'NOME' ).
  lo_column->set_short_text( 'Nome' ).
  lo_column = lo_alv->get_columns( )->get_column( 'IDADE' ).
  lo_column->set_short_text( 'Idade' ).
  lo_column = lo_alv->get_columns( )->get_column( 'SEXO' ).
  lo_column->set_short_text( 'Sexo' ).
  lo_column = lo_alv->get_columns( )->get_column( 'NASCIMENTO' ).
  lo_column->set_short_text( 'Nascimento' ).

  " Exibir ALV
  IF lo_alv IS BOUND.
    lo_alv->display( ).
  ENDIF.

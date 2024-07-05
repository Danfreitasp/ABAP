*&---------------------------------------------------------------------*
*& Report ZDLFAJR_010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdlfajr_010.
TABLES: sflight.

* Relatorio
* - Colocar os filtros na tela de selecao
* - Selecionar dados do banco
* - Montar os dados
* - Exibicao dos dados

* Voos -                       SFLIGHT
* Horario dos voos -           SPFLI
* Marcacao de voo individual - SBOOK

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_carrid TYPE s_carr_id OBLIGATORY.
  SELECT-OPTIONS: s_connid FOR sflight-connid,
                  s_fldate FOR sflight-fldate.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_voos DEFINITION.

  PUBLIC SECTION.
    DATA: lt_voos TYPE TABLE OF sflight.

    METHODS: run,
             get_voos,
             display_alv,
             display_message IMPORTING VALUE(iv_msg) TYPE string.

ENDCLASS.

CLASS lcl_voos IMPLEMENTATION.

   METHOD run.
     get_voos( ).
     display_alv( ).
   ENDMETHOD.

   METHOD get_voos.

  SELECT *
    FROM sflight
    INTO TABLE lt_voos
    WHERE carrid EQ p_carrid
      AND connid IN s_connid
      AND fldate IN s_fldate.

   IF lt_voos[] IS INITIAL.
    display_message( 'Não foram encontrados dados!' ).
   ENDIF.

   ENDMETHOD.

   METHOD display_alv.

      cl_salv_table=>factory(
      IMPORTING
       r_salv_table = DATA(lo_alv)
      CHANGING
       t_table      = lt_voos
      ).

*   Ativar a toolbar do ALV

   DATA(lo_functions) = lo_alv->get_functions( ).
   lo_functions->set_all( ).

   lo_alv->display( ).

   ENDMETHOD.

   METHOD display_message.

     MESSAGE iv_msg TYPE 'E'.

   ENDMETHOD.

ENDCLASS.

INITIALIZATION.
  DATA(lo_voos) = NEW lcl_voos( ).

START-OF-SELECTION.
  lo_voos->run( ).
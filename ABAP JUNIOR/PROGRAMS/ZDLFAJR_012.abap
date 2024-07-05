*&---------------------------------------------------------------------*
*& Report ZDLFAJR_012
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zdlfajr_012.

* Relatorio Multi Visão
* - Colocar os filtros na tela de selecao
* - 2 Selecionar dados do banco
* - 2 Montar os dados
* - 2 Exibicao dos dados

* Voos -                       SFLIGHT
* Horario dos voos -           SPFLI
* Marcacao de voo individual - SBOOK

"Analitica - dados globais
"Sintetica - resumos

TABLES: sflight.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_carrid TYPE s_carr_id OBLIGATORY.
  SELECT-OPTIONS: s_connid FOR sflight-connid,
                  s_fldate FOR sflight-fldate.
  SELECTION-SCREEN SKIP 1.
  PARAMETERS: rb_anli RADIOBUTTON GROUP rbg1,
              rb_sint RADIOBUTTON GROUP rbg1.
SELECTION-SCREEN END OF BLOCK b1.

INCLUDE: zdlfajr_012_analitico,
         zdlfajr_012_sintetico.

INITIALIZATION.
  DATA(lo_voos_analitica) = NEW lcl_voos_analitica( ).
  DATA(lo_voos_sintetica) = NEW lcl_voos_sintetica( ).

START-OF-SELECTION.
  IF rb_anli = 'X'.
    lo_voos_analitica->get_voos( ).
  ELSE.
    lo_voos_sintetica->get_voos( ).
  ENDIF.

END-OF-SELECTION.
  IF rb_anli = 'X'.
    lo_voos_analitica->display_alv( ).
  ELSE.
    lo_voos_sintetica->display_alv( ).
  ENDIF.
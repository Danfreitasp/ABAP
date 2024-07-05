*&---------------------------------------------------------------------*
*& Report ZDLFAJR_009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDLFAJR_009.

TABLES: bkpf, sscrfields.

*Parameters - Parametros
*Filtros Unicos quando se quer filtrar algo específico
PARAMETERS: p_belnr  TYPE bkpf-belnr.
PARAMETERS: p_belnr2 TYPE belnr_d.

*Options - Ranges
SELECT-OPTIONS: s_blart FOR bkpf-blart.

*Checkbox - True or False
PARAMETERS: cx_bloq AS CHECKBOX.

SELECTION-SCREEN SKIP 1.

*Radiobutton - Uma das opções
PARAMETERS: rb_cred RADIOBUTTON GROUP rbg1,
            rb_debt RADIOBUTTON GROUP rbg1.

*Quebra de Linha
SELECTION-SCREEN SKIP 1.

*ListBox - Lista de seleção
PARAMETERS: lb_typ AS LISTBOX VISIBLE LENGTH 30 MODIF ID typ.

*Quebra de Linha
SELECTION-SCREEN SKIP 1.

*Blocos de seleção
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  PARAMETERS: p_block TYPE belnr_d.
SELECTION-SCREEN END OF BLOCK b1.

*Button - Screen
SELECTION-SCREEN PUSHBUTTON /1(20) p_but1 USER-COMMAND but1.

*Button - Toolbar
SELECTION-SCREEN FUNCTION KEY 1.

INITIALIZATION.
  p_but1 = '@01@ Carrega Aqui'.
  sscrfields-functxt_01 = '@03@ Carrega Aqui'.

AT SELECTION-SCREEN.
  IF sscrfields-ucomm = 'BUT1'.
    MESSAGE 'Clicou no botão da screen' TYPE 'I'.
  ELSEIF sscrfields-ucomm = 'FC01'.
    MESSAGE 'Clicou no botão da toolbar' TYPE 'S'.
  ENDIF.

AT SELECTION-SCREEN OUTPUT.

  DATA(lt_values) = VALUE vrm_values(
  ( KEY = '1' text = 'PDF' )
  ( KEY = '2' text = 'Texto' )
  ( KEY = '3' text = 'Power Point' )
  ( KEY = '4' text = 'Word' )
  ).
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id                    = 'LB_TYP'
      values                = lt_values
   EXCEPTIONS
     ID_ILLEGAL_NAME       = 1
     OTHERS                = 2
            .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
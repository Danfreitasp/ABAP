*&---------------------------------------------------------------------*
*& Report zfii001_25
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsiec004_25.
TABLES bkpf.

TYPES:BEGIN OF ty_bancos,
        banks TYPE bnka-banks,
        bankl TYPE bnka-bankl,
        banka TYPE bnka-banka,
        provz TYPE bnka-provz,
        stras TYPE bnka-stras,
        ort01 TYPE bnka-ort01,
        brnch TYPE bnka-brnch,
      END OF ty_bancos.

TYPES: BEGIN OF y_bdc.
         INCLUDE TYPE bdcdata.
TYPES: END OF y_bdc.

TYPES: BEGIN OF y_msg.
         INCLUDE TYPE bdcmsgcoll.
TYPES: END OF y_msg.

TYPES truxs_t_text_data(4096) TYPE c.

DATA: tg_bancos  TYPE TABLE OF ty_bancos,
      ls_bancos  TYPE ty_bancos,
      tg_txtfile TYPE TABLE OF truxs_t_text_data,
      ls_txtfile LIKE LINE OF tg_txtfile,
      t_bdc      TYPE  TABLE OF y_bdc,
      t_msg      TYPE  TABLE OF y_msg,
      s_bdc      TYPE  y_bdc,
      s_msg      TYPE  y_msg,
      g_color    TYPE char1,
      g_ind      TYPE char1.

DATA: v_file TYPE string.

**********************************************************************
* Parâmetros de seleção
**********************************************************************
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_file TYPE rlgrap-filename OBLIGATORY.

SELECTION-SCREEN: END OF BLOCK b1.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'
    IMPORTING
      file_name = p_file.

START-OF-SELECTION.

  v_file = p_file.

  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename                = v_file
      filetype                = 'ASC'
    TABLES
      data_tab                = tg_txtfile
    EXCEPTIONS
      file_open_error         = 1
      file_read_error         = 2
      no_batch                = 3
      gui_refuse_filetransfer = 4
      invalid_type            = 5
      no_authority            = 6
      unknown_error           = 7
      bad_data_format         = 8
      header_not_allowed      = 9
      separator_not_allowed   = 10
      header_too_long         = 11
      unknown_dp_error        = 12
      access_denied           = 13
      dp_out_of_memory        = 14
      disk_full               = 15
      dp_timeout              = 16
      OTHERS                  = 17.
  IF sy-subrc IS INITIAL.

    PERFORM f_processar_arquivo.

    IF tg_bancos IS NOT INITIAL .
      PERFORM executa_FI01.
    ENDIF.


  ELSE.
    "Erro ao ler arquivor
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE TO LIST-PROCESSING.
  ENDIF.
*&---------------------------------------------------------------------*
*& Form f_processar_arquivo
*&---------------------------------------------------------------------*
FORM f_processar_arquivo .
  LOOP AT tg_txtfile INTO ls_txtfile.

    SPLIT ls_txtfile AT ';' INTO ls_bancos-banks ls_bancos-bankl ls_bancos-banka ls_bancos-provz ls_bancos-stras ls_bancos-ort01 ls_bancos-brnch.
    APPEND ls_bancos TO tg_bancos.
    CLEAR ls_bancos.

  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form executa_FI01
*&---------------------------------------------------------------------*
FORM executa_FI01 .
  DATA: s_opt  TYPE  ctu_params.

  LOOP AT tg_bancos INTO ls_bancos.

    IF ls_bancos-bankl IS NOT INITIAL.

      REFRESH: t_msg, t_bdc.

      PERFORM z_preenche_bdc USING:
        'X'     'SAPMF02B'         '0100'         ,
        ' '     'BDC_OKCODE'       '/00'          ,
        ' '     'BNKA-BANKS'       ls_bancos-banks,
        ' '     'BNKA-BANKL'       ls_bancos-bankl.

      PERFORM z_preenche_bdc USING:
        'X'     'SAPMF02B'         '0110'         ,
        ' '     'BDC_OKCODE'       '=UPDA'        ,
        ' '     'BNKA-BANKA'       ls_bancos-banka,
        ' '     'BNKA-PROVZ'       ls_bancos-provz,
        ' '     'BNKA-STRAS'       ls_bancos-stras,
        ' '     'BNKA-ORT01'       ls_bancos-ort01,
        ' '     'BNKA-BRNCH'       ls_bancos-brnch.

      s_opt-dismode = 'N'.
      s_opt-updmode = 'S'.
      s_opt-nobinpt = 'X'.
      s_opt-nobiend = 'X'.

      CALL TRANSACTION 'FI01'
      USING t_bdc
      OPTIONS FROM s_opt
      MESSAGES INTO t_msg.

      PERFORM z_write.

    ENDIF.

  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  Z_PREENCHE_BDC
*&---------------------------------------------------------------------*
FORM z_preenche_bdc  USING    dynbegin
                              name
                              value.
  IF dynbegin = abap_true.
    MOVE: name     TO s_bdc-program,
          value    TO s_bdc-dynpro,
          dynbegin TO s_bdc-dynbegin.

    APPEND s_bdc TO t_bdc.
    CLEAR s_bdc.
  ELSE.
    MOVE: name TO s_bdc-fnam,
          value TO s_bdc-fval.

    APPEND s_bdc TO t_bdc.
    CLEAR s_bdc.
  ENDIF.

ENDFORM.                    " Z_PREENCHE_BDC

*&---------------------------------------------------------------------*
*&      Form  Z_WRITE
*&---------------------------------------------------------------------*
*      Listagem de status do call transaction
*----------------------------------------------------------------------*
FORM z_write .

  DATA: x      TYPE i, y TYPE i, l TYPE i,
        l_msg  TYPE char100,
        lv_msg TYPE msg.

*-->Cabeçalho
  IF g_ind IS INITIAL.
    g_ind = 'X'.
    WRITE:/ TEXT-004.
    SKIP 3.
  ENDIF.

  LOOP AT t_msg INTO s_msg .

    CALL FUNCTION 'FORMAT_MESSAGE'
      EXPORTING
        id        = s_msg-msgid
        lang      = '-D'
        no        = s_msg-msgnr
        v1        = s_msg-msgv1
        v2        = s_msg-msgv2
        v3        = s_msg-msgv3
        v4        = s_msg-msgv4
      IMPORTING
        msg       = lv_msg
      EXCEPTIONS
        not_found = 1
        OTHERS    = 2.
    IF sy-subrc = 0.
      WRITE: / lv_msg.
    ENDIF.
    CLEAR lv_msg.

  ENDLOOP.

*  CLEAR s_msg.
*  READ TABLE t_msg INTO s_msg WITH KEY msgtyp = 'S'.
*  IF sy-subrc IS INITIAL.
*    WRITE:/ TEXT-005, ls_bancos-bankl, TEXT-006. " Banco xxx criado com sucesso.
*  ELSE.
*    CONCATENATE s_msg-msgv1 s_msg-msgv2 s_msg-msgv3 s_msg-msgv4 INTO l_msg SEPARATED BY space.
*    WRITE: / l_msg.
*  ENDIF.

ENDFORM.                    " Z_WRITE

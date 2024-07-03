*&---------------------------------------------------------------------*
*& Report ZFII002_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFII002_04.

TYPES: BEGIN OF y_data,
         banks TYPE bnka-banks,
         bankl TYPE bnka-bankl,
         banka TYPE bnka-banka,
         stras TYPE bnka-stras,
         ort01 TYPE bnka-ort01,
         provz TYPE bnka-provz,
         brnch TYPE bnka-brnch,
       END OF y_data,

       BEGIN OF y_log,
         line TYPE sy-tabix,
         type TYPE sy-msgty,
         msg  TYPE bapi_msg,
       END OF y_log.

DATA: gt_data TYPE TABLE OF y_data,
      gt_log  TYPE TABLE OF y_log.

PARAMETERS: p_file TYPE text250 OBLIGATORY.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  PERFORM f_select_file.

START-OF-SELECTION.

  PERFORM: f_upload,
           f_proc,
           f_show_log.


*&---------------------------------------------------------------------*
*& Form f_select_file
*&---------------------------------------------------------------------*
FORM f_select_file.
  DATA: lt_file TYPE filetable,
        lv_rc   TYPE i.

  cl_gui_frontend_services=>file_open_dialog(
    EXPORTING
      default_extension       = 'TXT'
    CHANGING
      file_table              = lt_file
      rc                      = lv_rc
    EXCEPTIONS
      file_open_dialog_failed = 1
      cntl_error              = 2
      error_no_gui            = 3
      not_supported_by_gui    = 4
      OTHERS                  = 5 ).

  IF sy-subrc EQ 0.
    READ TABLE lt_file INTO DATA(ls_file) INDEX 1.

    IF sy-subrc EQ 0.
      p_file = ls_file-filename.
    ENDIF.
  ELSE.
    MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 DISPLAY LIKE sy-msgty.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_upload
*&---------------------------------------------------------------------*
FORM f_upload.
  DATA: lt_file TYPE TABLE OF string,
        ls_data TYPE y_data.

  REFRESH gt_data.

  cl_gui_frontend_services=>gui_upload(
    EXPORTING
      filename                = CONV #( p_file )
    CHANGING
      data_tab                = lt_file
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
      not_supported_by_gui    = 17
      error_no_gui            = 18
      OTHERS                  = 19 ).

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE 'S' NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 DISPLAY LIKE sy-msgty.
    LEAVE LIST-PROCESSING.
  ENDIF.

  LOOP AT lt_file INTO DATA(ls_file).
    SPLIT ls_file AT ';' INTO ls_data-banks
                              ls_data-bankl
                              ls_data-banka
                              ls_data-stras
                              ls_data-ort01
                              ls_data-provz
                              ls_data-brnch.

    APPEND ls_data TO gt_data.
  ENDLOOP.

  IF gt_data IS INITIAL.
    MESSAGE ID '00' TYPE 'S' NUMBER '000' WITH TEXT-e01 DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_proc
*&---------------------------------------------------------------------*
FORM f_proc.
  DATA: lt_bdcdata TYPE STANDARD TABLE OF bdcdata,
        lt_msg     TYPE STANDARD TABLE OF bdcmsgcoll,
        lc_mode    TYPE c VALUE 'N'.

  REFRESH gt_log.

  LOOP AT gt_data INTO DATA(ls_data).
    DATA(lv_index) = sy-tabix.

    APPEND VALUE #( program = 'SAPMF02B' dynpro = '0100' dynbegin = 'X' ) TO lt_bdcdata.

    APPEND VALUE #( fnam = 'BDC_CURSOR' fval = 'BNKA-BANKL' ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BDC_OKCODE' fval = '/00' ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-BANKS' fval = ls_data-banks ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-BANKL' fval = ls_data-bankl ) TO lt_bdcdata.

    APPEND VALUE #( program = 'SAPMF02B' dynpro = '0110' dynbegin = 'X' ) TO lt_bdcdata.

    APPEND VALUE #( fnam = 'BDC_CURSOR' fval = 'BNKA-BRNCH' ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BDC_OKCODE' fval = '=UPDA' ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-BANKA' fval = ls_data-banka ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-PROVZ' fval = ls_data-provz ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-STRAS' fval = ls_data-stras ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-ORT01' fval = ls_data-ort01 ) TO lt_bdcdata.
    APPEND VALUE #( fnam = 'BNKA-BRNCH' fval = ls_data-brnch ) TO lt_bdcdata.

    CALL TRANSACTION 'FI01' USING lt_bdcdata MODE lc_mode MESSAGES INTO lt_msg.

    LOOP AT lt_msg INTO DATA(ls_msg).
      MESSAGE ID ls_msg-msgid TYPE ls_msg-msgtyp NUMBER ls_msg-msgnr
      WITH ls_msg-msgv1 ls_msg-msgv2 ls_msg-msgv3 ls_msg-msgv4 INTO DATA(lv_message).

      APPEND VALUE #( line = lv_index type = ls_msg-msgtyp msg = lv_message ) TO gt_log.
    ENDLOOP.

    REFRESH: lt_bdcdata, lt_msg.
  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form f_show_log
*&---------------------------------------------------------------------*
FORM f_show_log.

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table   = DATA(lo_alv)
        CHANGING
          t_table        = gt_log ).

      lo_alv->get_functions( )->set_all( ).
      lo_alv->get_columns( )->set_optimize( ).
      lo_alv->display( ).

    CATCH cx_salv_msg.

  ENDTRY.
ENDFORM.

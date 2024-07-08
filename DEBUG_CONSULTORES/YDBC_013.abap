*&---------------------------------------------------------------------*
*& Report YDBC_013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_013.

START-OF-SELECTION.
  PERFORM form_1.
  WRITE: / 'Bye'.


FORM form_1.

  DATA(lv_f1) = '1'.

  WRITE: / 'Olá 1'.

  PERFORM form_1_1.

ENDFORM.

FORM form_1_1.

  DATA(lv_f1_1) = '1.1'.

  WRITE: / 'Olá 1.1'.

  PERFORM form_1_1_1.

ENDFORM.

FORM form_1_1_1.

  DATA(lv_f1_1_1) = '1.1.1'.

  WRITE: / 'Olá 1.1.1'.

ENDFORM.

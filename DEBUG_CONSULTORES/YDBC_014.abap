*&---------------------------------------------------------------------*
*& Report YDBC_014
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydbc_014.

DO 100 TIMES.
  WRITE: / sy-index.

  IF
  sy-index = 90.
    DATA(lv_test) = 1.
  ELSE.
    lv_test = 0.
  ENDIF.

ENDDO.

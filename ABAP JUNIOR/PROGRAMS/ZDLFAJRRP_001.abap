*&---------------------------------------------------------------------*
*& Report ZDLFAJRRP_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDLFAJRRP_001.

WRITE: 'Primeiro Programa'.

DATA(lv_string) = 'Hello World'.
DATA(lv_int)    = '2'.
DATA(lv_float)  = '2.0'.
DATA(lv_dats)   = sy-datum.
DATA(lv_uzei)   = sy-uzeit.

MESSAGE 'Olá!' TYPE 'S'.

WRITE: / lv_string.
WRITE: / lv_int.
WRITE: / lv_float.
WRITE: / lv_dats.
WRITE: / lv_uzei.
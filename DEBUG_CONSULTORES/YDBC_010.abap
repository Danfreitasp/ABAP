*&---------------------------------------------------------------------*
*& Report YDBC_010
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_010.

INITIALIZATION.
  DATA(lo_email) = NEW zcl_email( ).
  lo_email->assunto       = 'Notificação de Compra'.
  lo_email->destinatario  = 'carlos@hotmail.com'.
  lo_email->remetente     = 'sap@sap.com'.
  lo_email->send_email( ).

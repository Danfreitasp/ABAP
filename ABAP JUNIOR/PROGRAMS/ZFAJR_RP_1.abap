*&---------------------------------------------------------------------*
*& Report ZFAJR_RP_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zfajr_rp_1.

" ZFAJR_3 - Cabeçalho de vendas
" ZFAJR_4 - Itens das vendas
DATA: ls_header_old TYPE zfajr_003,
      lt_items_old TYPE TABLE OF zfajr_004,
      ls_items_old TYPE zfajr_004.

"Adicionar Cabeçalho
ls_header_old-id       = 1.
ls_header_old-username = sy-uname.
ls_header_old-data     = sy-datum.
ls_header_old-hora     = sy-uzeit.
MODIFY zfajr_003 FROM ls_header_old.

"Adicionar Itens
ls_items_old-id          = 1.
ls_items_old-item        = 1.
ls_items_old-produto     = 1.
ls_items_old-quantidade  = 2.
APPEND ls_items_old TO lt_items_old.

ls_items_old-id          = 1.
ls_items_old-item        = 2.
ls_items_old-produto     = 3.
ls_items_old-quantidade  = 1.
APPEND ls_items_old TO lt_items_old.

ls_items_old-id          = 1.
ls_items_old-item        = 3.
ls_items_old-produto     = 5.
ls_items_old-quantidade  = 1.
APPEND ls_items_old TO lt_items_old.

MODIFY zfajr_004 FROM TABLE lt_items_old.

"Modo moderno
DATA(ls_header) = VALUE zfajr_003(
  id        = 2
  username  = sy-uname
  data      = sy-datum
  hora      = sy-uzeit
).
MODIFY zfajr_003 FROM ls_header.

TYPES: tt_itens TYPE TABLE OF zfajr_004 WITH DEFAULT KEY.

DATA(lt_items) = VALUE tt_itens(
  ( id = 2 item = 3 produto = 5 quantidade = 1 )
  ( id = 2 item = 2 produto = 3 quantidade = 1 )
).
MODIFY zfajr_004 FROM TABLE lt_items.
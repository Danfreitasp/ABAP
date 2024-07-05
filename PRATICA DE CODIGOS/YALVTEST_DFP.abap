
REPORT YALVTEST_DFP.

TYPES:

BEGIN OF ls_generic,
  cor TYPE CHAR10,
  rank TYPE i,
  tamanho TYPE I,
END OF ls_generic.

PARAMETERS:
COR1 TYPE CHAR10,
COR2 TYPE CHAR10,
COR3 TYPE CHAR10,
RANK1 TYPE i,
RANK2 TYPE i,
RANK3 TYPE i,
TAMANHO1 TYPE i,
TAMANHO2 TYPE i,
TAMANHO3 TYPE i.

DATA: lt_generic TYPE TABLE OF ls_generic,
      ls_generic_entry TYPE ls_generic.

APPEND VALUE #( cor = COR1 rank = RANK1 tamanho = TAMANHO1 ) TO lt_generic.
APPEND VALUE #( cor = COR2 rank = RANK2 tamanho = TAMANHO2 ) TO lt_generic.
APPEND VALUE #( cor = COR3 rank = RANK3 tamanho = TAMANHO3 ) TO lt_generic.

DATA: lo_alv TYPE REF TO cl_salv_table.

TRY.
    cl_salv_table=>factory(

      IMPORTING
        r_salv_table = lo_alv
      CHANGING
        t_table      = lt_generic ).

    lo_alv->display( ).
    lo_alv->get_columns( ).
  CATCH cx_salv_msg INTO DATA(lx_msg).
    MESSAGE lx_msg->get_text( ) TYPE 'S'.
ENDTRY.
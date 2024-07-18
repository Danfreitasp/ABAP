*&---------------------------------------------------------------------*
*& Report ydfp_100
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydfp_100.

INCLUDE: ydfp100_global_view.

CLASS lcl_main DEFINITION CREATE PRIVATE INHERITING FROM global_view_alv.

  PUBLIC SECTION.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    METHODS run.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_main IMPLEMENTATION.

  METHOD create.
    CREATE OBJECT r_result.
  ENDMETHOD.

  METHOD run.

    SELECT *
    UP TO 10 ROWS
    FROM sflight
    INTO TABLE @DATA(lt_voos).

    me->display_data( CHANGING _data = lt_voos ).
    alv->display(  ).

  ENDMETHOD.

ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).

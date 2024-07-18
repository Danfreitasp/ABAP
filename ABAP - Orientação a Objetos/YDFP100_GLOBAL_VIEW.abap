CLASS global_view_alv DEFINITION.


  PUBLIC SECTION.

    DATA: alv TYPE REF TO cl_salv_table.

    METHODS: display_data CHANGING _data TYPE ANY TABLE.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS global_view_alv IMPLEMENTATION.

  METHOD display_data.

    cl_salv_table=>factory(
      IMPORTING
        r_salv_table   = alv
      CHANGING
        t_table        = _data[]
    ).

  ENDMETHOD.

ENDCLASS.

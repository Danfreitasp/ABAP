*&---------------------------------------------------------------------*
*& Report ydbc_012
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydbc_012.

* Variáveis
DATA: lv_nome TYPE string.
lv_nome = 'Daniel'.

DATA(lv_nome_inline) = 'Daniel'.

" Estruturas
TYPES: BEGIN OF ty_cliente,
        nome  TYPE string,
        email TYPE string,
       END OF ty_cliente,
       tt_cliente TYPE TABLE OF ty_cliente WITH DEFAULT KEY.

DATA: ls_cliente TYPE ty_cliente.
ls_cliente-nome  = 'Daniel'.
ls_cliente-email = 'Danielfreitaspinto@gmail.com'.

DATA(ls_cliente_inline) = VALUE ty_cliente( nome = 'Daniel'
                                            email = 'Danielfreitaspinto@gmail.com' ).

" Tabelas
DATA: lt_cli TYPE TABLE OF ty_cliente,
      ls_cli TYPE ty_cliente.

ls_cli-nome  = 'Daniel'.
ls_cli-email = 'Danielfreitaspinto@gmail.com'.
APPEND ls_cli TO lt_cli.

ls_cli-nome  = 'Alex'.
ls_cli-email = 'alex@gmail.com'.
APPEND ls_cli TO lt_cli.

" Forma 1
DATA(lt_cli_inline) = VALUE tt_cliente(
  ( nome = 'Daniel' email = 'Danielfreitaspinto@gmail.com' )
  ( nome = 'Fulano'    email = 'Fulano@gmail.com' )
).

" Forma 2
APPEND VALUE ty_cliente( nome = 'Ciclano'
                         email = 'Ciclano@gmail.com' ) TO lt_cli_inline.

*&---------------------------------------------------------------------*
*& Report YDBC_005
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_005.

" YDBCT_001
TYPES: tt_mes TYPE TABLE OF ydbct_001 with DEFAULT KEY.

" Forma tradicional de Inserir na tabela
DATA: ls_mes TYPE YDBCT_001.

ls_mes-mes = 1.
ls_mes-descricao = 'Janeiro'.
MODIFY ydbct_001 FROM ls_mes.

" Forma inline de inserir na tabela
DATA(ls_mes_inline) = VALUE ydbct_001(
mes = 1 descricao  = 'Janeiro'
).
MODIFY ydbct_001 FROM ls_mes_inline.

" Forma tradicional de Inserir por tabela interna

DATA: lt_mes TYPE TABLE OF ydbct_001.

ls_mes-mes = 1.
ls_mes-descricao = 'Janeiro'.
APPEND ls_mes TO lt_mes.

ls_mes-mes = 2.
ls_mes-descricao = 'Fevereiro'.
APPEND ls_mes TO lt_mes.

MODIFY ydbct_001 FROM TABLE lt_mes.

"Forma Inline de inserir por tabela interna
DATA(lt_mes_inline) = VALUE tt_mes(
  ( mes = 1   descricao = 'Janeiro' )
  ( mes = 2   descricao = 'Fevereiro' )
  ( mes = 3   descricao = 'Março' )
  ( mes = 4   descricao = 'Abril' )
  ( mes = 5   descricao = 'Maio' )
  ( mes = 6   descricao = 'Junho' )
  ( mes = 7   descricao = 'Julho' )
  ( mes = 8   descricao = 'Agosto' )
  ( mes = 9   descricao = 'Setembro' )
  ( mes = 10  descricao = 'Outubro' )
  ( mes = 11  descricao = 'Novembro' )
  ( mes = 12  descricao = 'Dezembro' )
).
MODIFY ydbct_001 FROM TABLE lt_mes_inline.

" 1 Forma Clássica de Select
SELECT mandt, mes, descricao
  FROM YDBCT_001
  INTO TABLE @lt_mes.

" 2 Forma Clássica de Select
SELECT mes, descricao
  FROM YDBCT_001
  INTO CORRESPONDING FIELDS OF TABLE @lt_mes.

" 3 Forma Clássica de Select
SELECT *
  FROM YDBCT_001
  INTO TABLE @lt_mes.

" 4 Forma Clássica de Select
SELECT *
  FROM YDBCT_001
  INTO TABLE @lt_mes
  WHERE mes = 1.

" 5 Forma Clássica de Select
SELECT *
  FROM YDBCT_001
  INTO TABLE @lt_mes
  WHERE mes BETWEEN 1 AND 7.

" 6 Forma Clássica de Select
SELECT *
  FROM YDBCT_001
  INTO TABLE @lt_mes
  WHERE mes > 1
    AND mes <= 7.
" > , < , >=, <=, <>, =
" GT, LT, GE, LE, NE, EQ

" 7 Forma Inline de Select
SELECT *
  FROM YDBCT_001
  INTO TABLE @DATA(lt_mes_inlines).

LOOP AT lt_mes_inlines INTO DATA(ls_mes_inlines).
  WRITE: / ls_mes_inlines-mes, ls_mes_inlines-descricao.
ENDLOOP.

READ TABLE lt_mes_inline
  INTO DATA(ls_read_mes)
  WITH KEY mes = 1.
WRITE: / 'Selecionando Linha: ', ls_read_mes-descricao.

WRITE: / 'Selecionando Linha Index: ', lt_mes_inline[ 4 ]-descricao.

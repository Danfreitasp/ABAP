*&---------------------------------------------------------------------*
*& Report YDBC_008
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT YDBC_008.


PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.

START-OF-SELECTION.
  PERFORM soma.
  PERFORM subtracao.
  PERFORM multiplicacao.
  PERFORM divisao.


FORM soma.

  DATA(lv_return_soma) = p_num1 + p_num2.
  WRITE: / 'Resultado Soma: ', lv_return_soma.

ENDFORM.

FORM subtracao.

  DATA(lv_return_subtracao) = p_num1 - p_num2.
  WRITE: / 'Resultado Subtração: ', lv_return_subtracao.

ENDFORM.

FORM multiplicacao.

  DATA(lv_return_multiplicacao) = p_num1 * p_num2.
  WRITE: / 'Resultado Multiplicação: ', lv_return_multiplicacao.

ENDFORM.

FORM divisao.

  DATA(lv_return_divisao) = p_num1 / p_num2.
  WRITE: / 'Resultado divisão: ', lv_return_divisao.

ENDFORM.

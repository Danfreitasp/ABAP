REPORT zdfp_teste.

INITIALIZATION.

PARAMETERS: numero1  TYPE i,
            numero2  TYPE i,
            operacao TYPE c.

DATA: valor TYPE i,
      oper_valida TYPE abap_bool.

START-OF-SELECTION.

  IF operacao = '+' OR operacao = '-' OR operacao = '/' OR operacao = '*'.
    oper_valida = abap_true.
    IF operacao = '+'.
      valor = numero1 + numero2.
    ELSEIF operacao = '-'.
      valor = numero1 - numero2.
    ELSEIF operacao = '/'.
      IF numero2 <> 0.
        valor = numero1 / numero2.
      ELSE.
        oper_valida = abap_false.
        WRITE: 'Divisão por zero não é permitida.'.
      ENDIF.
    ELSEIF operacao = '*'.
      valor = numero1 * numero2.
    ENDIF.
  ELSE.
    WRITE: 'Escolha alguma operação entre +, -, / ou *.'.
    oper_valida = abap_false.
  ENDIF.


  IF oper_valida = abap_true.
    WRITE: 'O resultado é ', valor.
  ENDIF.

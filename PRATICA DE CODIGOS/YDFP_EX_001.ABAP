*&---------------------------------------------------------------------*
*& Report YDFP_EX_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydfp_ex_001.

**Desafio 1:
*
*PARAMETERS:
*NUMERO1 TYPE I.
*
*IF NUMERO1 > 0.
*  WRITE: 'O numero é positivo'.
*ELSE.
*  WRITE: 'O numero é negativo'.
*ENDIF.

**Desafio 2:
*
*DATA:
*  soma  TYPE i,
*  media TYPE p DECIMALS 2.
*
*PARAMETERS:
*  num1 TYPE i,
*  num2 TYPE i,
*  num3 TYPE i.
*
*soma = num1 + num2 + num3.
*
*IF soma > 0.
*  media = soma / 3.
*  WRITE: 'A média é: ', media.
*
*ELSE.
*  WRITE: 'O resultado é menor que zero'.
*
*ENDIF.

**Desafio 3:
*
*PARAMETERS:
*NUM1 TYPE I,
*NUM2 TYPE I.
*
*IF NUM1 > NUM2.
*  WRITE: 'O primeiro número é maior que o segundo.'.
*ELSE.
*  WRITE: 'O segundo número é maior que o primeiro.'.
*ENDIF.

**Desafio 4:
*
*PARAMETERS:
*  P_TEMP TYPE P DECIMALS 1,
*  P_ESC TYPE C.
*
*DATA:
*  P_RES TYPE P DECIMALS 1,
*  P_DIV TYPE F.
*  P_DIV = '1.8'.
*
*IF P_ESC = 'F' OR P_ESC = 'C'.
*  IF P_ESC = 'F'.
*    P_RES = ( P_TEMP - 32 ) / P_DIV .
*    WRITE: 'A temperatura em Celsius é: ', P_RES.
*  ELSEIF P_ESC = 'C'.
*    P_RES = ( P_TEMP * P_DIV ) + 32.
*    WRITE: 'A temperatura em Fahrenheit é: ', P_RES.
*  ENDIF.
*ENDIF.

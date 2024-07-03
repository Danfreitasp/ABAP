*&---------------------------------------------------------------------*
*& Report YDBC_003
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydbc_003.

DATA: lv_altura TYPE p DECIMALS 2,
      lv_genero TYPE string.

* Regra:
* Se altura menor que 1.60 = Mostrar na tela texto = Baixo
* Se altura entre 1.61 - 1.80 = Mostrar texto = Médio
* Se altura Maior/Igual 1.81 = Mostrar texto = Alto

lv_altura = '1.50'.

*IF lv_altura < '1.60'.
*  WRITE: '-> Baixo.'.
*ENDIF.
*
*IF lv_altura >= '1.60' AND lv_altura <= '1.80'.
*  WRITE: '-> Médio.'.
*ENDIF.
*
*IF lv_altura >= '1.81'.
*  WRITE: '-> Alto.'.
*ENDIF.

IF lv_altura < '1.60'.
  WRITE: '-> Baixo'.
ELSEIF lv_altura >= '1.60' AND lv_altura <= '1.80'.
  WRITE: '-> Médio'.
ELSE.
  WRITE: '-> Alto'.
ENDIF.

lv_genero = 'F'. " M - Masculino | F - Feminino

CASE lv_genero.
  WHEN 'M'.
    WRITE: / '-> Masculino'.
  WHEN 'F'.
    WRITE: / '-> Feminino'.
  WHEN OTHERS.
    WRITE: / '-> Outro'.
ENDCASE.

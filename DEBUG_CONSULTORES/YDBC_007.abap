REPORT YDBC_007.

" Calculadora
INCLUDE YDBC_007_SCR. " Tela De Seleção
*INCLUDE YDBC_007_TOP. " Declarações Globais
*INCLUDE YDBC_007_PBO. " Eventos Antes de Exibir a Tela de Seleção
INCLUDE YDBC_007_PAI. " Eventos Depois de Exibir a Tela de Seleção

*INCLUDE YDBC_007_SCR.
*PARAMETERS: p_num1 TYPE i,
*            p_num2 TYPE i.
*
*INCLUDE YDBC_007_PAI.
*START-OF-SELECTION.
*   DATA(lv_soma) = p_num1 + p_num2.
*   WRITE: 'Soma: ', lv_soma.

*&---------------------------------------------------------------------*
*& Report ZDLFAJRRP_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDLFAJRRP_004.

*Tabela Status ZDLFAJRT_001
DATA: ls_status TYPE zdlfajrt_001,
      lt_status TYPE TABLE OF zdlfajrt_001.

ls_status-status = 'A'.
ls_status-descricao = 'Teste 3'.
MODIFY zdlfajrt_001 FROM ls_status.

ls_status-status = 'V'.
ls_status-descricao = 'Teste 2'.
MODIFY zdlfajrt_001 FROM ls_status.

*Seleciona dados da tabela do Banco
SELECT *
  FROM zdlfajrt_001
  INTO TABLE lt_status.

*SELECT status descricao
*  FROM zdlfajrt_001
*  INTO TABLE lt_status.
*
*SELECT descricao status
*  FROM zdlfajrt_001
*  INTO CORRESPONDING FIELDS OF TABLE lt_status.

*Percorre o conteudo do Banco e Printa na tela.
LOOP AT lt_status INTO ls_status.
  WRITE: / ls_status-status, ' - ', ls_status-descricao.
ENDLOOP.

*DELETE FROM zdlfajrt_001 WHERE STATUS = 'A'.
*DELETE FROM zdlfajrt_001 WHERE DESCRICAO = 'Teste'.
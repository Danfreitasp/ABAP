*&---------------------------------------------------------------------*
*& Report ZDLFAJRRP_006
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDLFAJRRP_006.

TABLES: zdlfajrt_002.

"Objetivo - Criar um relatório da ZDLFAJRT_002 (ATIVIDADES)

" Inputs
" - Entradas dos usuários!
"   - Filtros
"   - Ações pré exibição
" (ID Atividade, Descrição Atividade, Status Atividade, Modificações)

PARAMETERS:     p_id   TYPE zdlfajrel_002.        "Filtrar uma opção
SELECT-OPTIONS: s_stat FOR zdlfajrt_002-status.   "Filtrar várias opções

" Processamentos
" - Processamento dos Inputs
" - Preparação do Output
" - Montagem do Output
" - Logica de Programação
" - Regras de Negócio

START-OF-SELECTION.
  SELECT *
    FROM ZDLFAJRT_002
    INTO TABLE @DATA(lt_atividades)
    WHERE status IN @s_stat.
   .

"Outputs
" - Saídas do Programa
"   - Informações Finais
"   - O que o Usuário Vê
"   - Grid (Visual)
"   - ALV
END-OF-SELECTION.
LOOP AT lt_atividades INTO DATA(ls_atividades).
    WRITE: / 'ID: ', ls_atividades-atividade, ' - Descrição: ', ls_atividades-descricao.
ENDLOOP.
*&---------------------------------------------------------------------*
*& Report ZDLFAJRRP_007
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZDLFAJRRP_007.

" DEFINITION - Definição da Classe
"IMPLEMENTATION - Implementação da Classe

INCLUDE ZDLFAJRRP_007_I.

INITIALIZATION.
DATA(go_atividades) = NEW zdlfajrcl_001( ).
DATA(lo_atividades) = NEW lcl_007( ).
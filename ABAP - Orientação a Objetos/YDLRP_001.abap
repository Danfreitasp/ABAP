*&---------------------------------------------------------------------*
*& Report YDLRP_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydlrp_001.

*Definir comportamento da classe
CLASS lcl_first DEFINITION.

*Public - Pode ser acessado de fora da classe.
  PUBLIC SECTION.
    DATA: nome_pub TYPE string VALUE 'Nome Publico'.

    METHODS: write_nome_pro,
      write_nome_pri.

*Protected - Só pode ser herdado e utilizado dentro da classe.
  PROTECTED SECTION.

    DATA: nome_pro TYPE string VALUE 'Nome Protected'.

*Private - Não pode ser usado de fora da classe e nem ser herdado
  PRIVATE SECTION.

    DATA: nome_pri TYPE string VALUE 'Nome Private'.


ENDCLASS.

*Implementação dos métodos
CLASS lcl_first IMPLEMENTATION.

  METHOD write_nome_pro.
    WRITE: / 'Nome Protegido: ', me->nome_pro.
  ENDMETHOD.

  METHOD write_nome_pri.
    WRITE: / 'Nome Privado: ', me->nome_pri.
  ENDMETHOD.


ENDCLASS.

INITIALIZATION.

  DATA(lo_first) = NEW lcl_first( ).

  WRITE: / 'Nome Publico: ', lo_first->nome_pub.

  lo_first->write_nome_pri( ).
  lo_first->write_nome_pro( ).
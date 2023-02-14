#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'


/*/{Protheus.doc} User Function ConsultaProdutoSQL
  Rotina para exemplificar como funciona uma consulta ao banco de dados utilizando o padrão de consulta SQL
  @type  Function
  @author Muriel Zounar
  @since 13/02/2023
  /*/
User Function BusProdSQL()
  Local aArea   := GetArea()
  Local cAlias  := GetNextAlias()
  Local cQuery  := ''
  Local cCodigo := '1'
  Local cDescri := ''

  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

  cQuery := 'SELECT B1_DESC' + CRLF
  cQuery += 'FROM ' + RetSqlName('SB1') + ' SB1'  + CRLF
  cQuery += "WHERE B1_COD = '" + cCodigo + "'"  + CRLF

  TCQUERY cQuery ALIAS &(cAlias) NEW

  &(cAlias)->(DbGoTop())

  while &(cAlias)->(!EOF())
    cDescri := &(cAlias)->(B1_DESC)
    &(cAlias)->(DbSkip())
  end

  FwAlertInfo('Código: ' + cCodigo + CRLF + 'Descrição: ' + cDescri, 'Dados do Produto')

  &(cAlias)->(DbCloseArea())
  RestArea(aArea)
Return 

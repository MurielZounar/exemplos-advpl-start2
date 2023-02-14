#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'


/*/{Protheus.doc} User Function ShowCliSQL
  Função de exemplo de consulta a todos os clientes cadastrados utilizando consulta SQL
  @type  Function
  @author Muriel Zounar
  @since 14/02/2023
  /*/
User Function ShowCliSQL()
  Local aArea  := GetArea()
  Local cAlias := GetNextAlias()
  Local cQuery := ''
  Local cCod   := ''
  Local cNome  := ''
  Local cFant  := ''
  Local cMsg   := ''
  Local nCont  := 0
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA1' MODULO 'COM'

  cQuery := 'SELECT A1_COD, A1_NOME, A1_NREDUZ' + CRLF
  cQuery += 'FROM ' + RetSqlName('SA1') + ' SA1' + CRLF
  cQuery += "WHERE D_E_L_E_T_ = ' '"

  TCQUERY cQuery ALIAS &(cAlias) NEW

  &(cAlias)->(DbGoTop())

  while &(cAlias)->(!EOF())
    cCod  := &(cAlias)->(A1_COD)
    cNome := &(cAlias)->(A1_NOME)
    cFant := &(cAlias)->(A1_NREDUZ)

    cMsg += 'Código: ' + cCod + CRLF + 'Nome: ' + cNome + CRLF + 'Nome Fantasia: ' + cFant + CRLF
    cMsg += '------------------------------' + CRLF + CRLF

    nCont++

    if nCont == 10
      FwAlertInfo(cMsg, 'Dados dos Clientes')
      nCont := 0
      cMsg  := ''    
    endif

    &(cAlias)->(DbSkip())
  end

  if nCont > 0
    FwAlertInfo(cMsg, 'Dados dos Clientes')
  endif

  &(cAlias)->(DbCloseArea())
  
  RestArea(aArea)
Return

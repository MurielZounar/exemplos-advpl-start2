#INCLUDE 'TOTVS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function ShowCliGen
  Função de exemplo de consulta a todos os clientes cadastrados utilizando funções genéricas
  @type  Function
  @author Muriel Zounar
  @since 14/02/2023
  /*/
User Function ShowCliGen()
  Local aArea  := GetArea()
  Local cCod   := ''
  Local cNome  := ''
  Local cFant  := ''
  Local cMsg   := ''
  Local nCont  := 0
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA1' MODULO 'COM'

  DbSelectArea('SA1')
  DbSetOrder(1)
  DbGoTop()
  
  while !EOF()
    cCod  := SA1->A1_COD
    cNome := SA1->A1_NOME
    cFant := SA1->A1_NREDUZ

    cMsg += 'Código: ' + cCod + CRLF + 'Nome: ' + cNome + CRLF + 'Nome Fantasia: ' + cFant + CRLF
    cMsg += '------------------------------' + CRLF + CRLF

    nCont++

    if nCont == 10
      FwAlertInfo(cMsg, 'Dados dos Clientes')
      nCont := 0
      cMsg  := ''    
    endif

    DbSkip()
  end

  if nCont > 0
    FwAlertInfo(cMsg, 'Dados dos Clientes')
  endif

  DbCloseArea()
  RestArea(aArea)
Return

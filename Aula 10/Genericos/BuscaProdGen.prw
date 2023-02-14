#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function BuscaGenerica
  Busca um produto utilizando as fun��es de consultas gen�ricas
  @type  Function
  @author Muriel Zounar
  @since 14/02/2023
  /*/
User Function BusProdGen()
  Local aArea   := GetArea()
  Local cCodigo := '1'
  Local cDescri := ''

  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SB1' MODULO 'COM'

  DbSelectArea('SB1')
  DbSetOrder(1)
  DbSeek(xFilial('SB1') + '1')
  
  cDescri := SB1->B1_DESC

  FwAlertInfo('C�digo: ' + cCodigo + CRLF + 'Descri��o: ' + cDescri, 'Dados do Produto')

  DbCloseArea()
  RestArea(aArea)
Return

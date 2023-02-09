#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Matematicos
  Fun��o desenvolvida pra exemplificar o uso dos operadores matem�ticos
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function Matematicos()
  Local nValor1 := 4
  Local nValor2 := 10
  Local nAdic   := 0
  Local nSub    := 0
  Local nMult   := 0
  Local nDiv    := 0
  Local nExpo   := 0
  Local nMod    := 0

  nAdic := nValor1 + nValor2
  nSub  := nValor2 - nValor1
  nMult := nValor1 * nValor2
  nDiv  := nValor2 / nValor1
  nExpo := nValor1 ** nValor2
  nMod  := nValor2 % nValor1

  FwAlertSuccess('Adi��o: ' + STR(nAdic) + CRLF +;
                 'Subtra��o: ' + STR(nSub) + CRLF +;
                 'Multiplica��o: ' + STR(nMult) + CRLF +;
                 'Divis�o: ' + STR(nDiv) + CRLF +;
                 'Exponencia��o: ' + STR(nExpo) + CRLF +;
                 'M�dulo (Resto da Divis�o): ' + STR(nMod), 'Operadores Matem�ticos')
Return

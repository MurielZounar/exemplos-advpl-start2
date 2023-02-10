#INCLUDE 'TOTVS.CH'

#DEFINE nQtdNotas 3 //? Contante om a quantidade total de notas

User Function ExemploWhile()
  Local cNome  := ''
  Local cNota  := ''
  Local nMedia := 0
  Local nCont  := 1

  cNome := FwInputBox('Digite o Nome:', cNome)

  while nCont <= nQtdNotas
    cNota := FwInputBox('Digite a ' + cValToChar(nCont) + '� nota:', cNota)
    nMedia += VAL(cNota) //* nMedia recebe a nota digitada pelo usu�rio e soma com o valor anterior
    cNota := ''
    nCont++ //* Incremento da vari�vel nCont.
  enddo

  nMedia /= nQtdNotas //* Calculo da m�dia, dividindo o valor de nMedia pela quantidade total de notas (definido na constante no in�cio do programa).

  if nMedia > 6
    FwAlertSuccess('Aprovado!' + CRLF + 'M�dia: ' + cValToChar(nMedia), 'Parab�ns, ' + cNome + '!')
  else
    FwAlertError('Reprovado!' + CRLF + 'M�dia: ' + cValToChar(nMedia), 'Que pena, ' + cNome + '!')
  endif
Return

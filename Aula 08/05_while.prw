#INCLUDE 'TOTVS.CH'

#DEFINE nQtdNotas 3 //? Contante om a quantidade total de notas

User Function ExemploWhile()
  Local cNome  := ''
  Local cNota  := ''
  Local nMedia := 0
  Local nCont  := 1

  cNome := FwInputBox('Digite o Nome:', cNome)

  while nCont <= nQtdNotas
    cNota := FwInputBox('Digite a ' + cValToChar(nCont) + 'ª nota:', cNota)
    nMedia += VAL(cNota) //* nMedia recebe a nota digitada pelo usuário e soma com o valor anterior
    cNota := ''
    nCont++ //* Incremento da variável nCont.
  enddo

  nMedia /= nQtdNotas //* Calculo da média, dividindo o valor de nMedia pela quantidade total de notas (definido na constante no início do programa).

  if nMedia > 6
    FwAlertSuccess('Aprovado!' + CRLF + 'Média: ' + cValToChar(nMedia), 'Parabéns, ' + cNome + '!')
  else
    FwAlertError('Reprovado!' + CRLF + 'Média: ' + cValToChar(nMedia), 'Que pena, ' + cNome + '!')
  endif
Return

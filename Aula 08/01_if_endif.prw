#INCLUDE 'TOTVS.CH'

User Function Exemplo01()
  Local cNome  := ''
  Local cNota  := ''
  Local nNota1 := 0
  Local nNota2 := 0
  Local nNota3 := 0
  Local nMedia := 0

  cNome := FwInputBox('Digite seu nome: ', cNome)

  cNota := FwInputBox('Digite a 1ª nota: ', cNota) //* Função que solicita ao usuário que digite um texto. Obs: O retorno da função FwInputBox sempre é um dado do tipo Character
  nNota1 := VAL(cNota) //* A função VAL() converte um dado do tipo Character para o tipo Numeric.
  cNota := ''

  cNota := FwInputBox('Digite a 2ª nota: ', cNota)
  nNota2 := VAL(cNota)
  cNota := ''
  
  cNota := FwInputBox('Digite a 3ª nota: ', cNota)
  nNota3 := VAL(cNota)

  nMedia := (nNota1 + nNota2 + nNota3) / 3 //* Aqui é realizado o cálculo da média.

  if nMedia >= 6
    FwAlertSuccess('Você foi aprovado!' + CRLF + 'Sua média foi: ' + CValToChar(nMedia), 'Parabéns, ' + cNome)
  else
    FwAlertError('Você foi reprovado!' + CRLF + 'Sua média foi: ' + CValToChar(nMedia), 'Que Pena, ' + cNome)
  endif
Return

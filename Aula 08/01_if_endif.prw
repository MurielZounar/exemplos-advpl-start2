#INCLUDE 'TOTVS.CH'

User Function Exemplo01()
  Local cNome  := ''
  Local cNota  := ''
  Local nNota1 := 0
  Local nNota2 := 0
  Local nNota3 := 0
  Local nMedia := 0

  cNome := FwInputBox('Digite seu nome: ', cNome)

  cNota := FwInputBox('Digite a 1� nota: ', cNota) //* Fun��o que solicita ao usu�rio que digite um texto. Obs: O retorno da fun��o FwInputBox sempre � um dado do tipo Character
  nNota1 := VAL(cNota) //* A fun��o VAL() converte um dado do tipo Character para o tipo Numeric.
  cNota := ''

  cNota := FwInputBox('Digite a 2� nota: ', cNota)
  nNota2 := VAL(cNota)
  cNota := ''
  
  cNota := FwInputBox('Digite a 3� nota: ', cNota)
  nNota3 := VAL(cNota)

  nMedia := (nNota1 + nNota2 + nNota3) / 3 //* Aqui � realizado o c�lculo da m�dia.

  if nMedia >= 6
    FwAlertSuccess('Voc� foi aprovado!' + CRLF + 'Sua m�dia foi: ' + CValToChar(nMedia), 'Parab�ns, ' + cNome)
  else
    FwAlertError('Voc� foi reprovado!' + CRLF + 'Sua m�dia foi: ' + CValToChar(nMedia), 'Que Pena, ' + cNome)
  endif
Return

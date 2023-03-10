#INCLUDE 'TOTVS.CH'

User Function BoasVindas()
  Local nOp   := PARAMIXB // Recebe o n�mero da opera��o que foi passado pelo ExecBlock no PE
  Local cForn := SA2->A2_NOME // Guardando o nome do fornecedor na vari�vel cForn

  if INCLUI // Se a opera��o for inclus�o
    FwAlertSuccess('Seja bem vindo(a) ao cadastro de Fornecedores!', 'Ol�!')
  elseif ALTERA // Se a opera��o for altera��o
    FwAlertInfo('Voc� est� prestes a alterar o cadastro do fornecedor <b>' + cForn + '</b>!', 'Aten��o!')
  elseif nOp == 5 // Se a opera��o for exclus�o
    FwAlertError('Voc� est� prestes a Excluir o cadastro do fornecedor <b>' + cForn + '</b>!', 'Cuidado!')
  endif
Return

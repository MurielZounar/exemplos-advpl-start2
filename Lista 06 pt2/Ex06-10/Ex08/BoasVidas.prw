#INCLUDE 'TOTVS.CH'

User Function BoasVindas()
  Local nOp   := PARAMIXB // Recebe o número da operação que foi passado pelo ExecBlock no PE
  Local cForn := SA2->A2_NOME // Guardando o nome do fornecedor na variável cForn

  if INCLUI // Se a operação for inclusão
    FwAlertSuccess('Seja bem vindo(a) ao cadastro de Fornecedores!', 'Olá!')
  elseif ALTERA // Se a operação for alteração
    FwAlertInfo('Você está prestes a alterar o cadastro do fornecedor <b>' + cForn + '</b>!', 'Atenção!')
  elseif nOp == 5 // Se a operação for exclusão
    FwAlertError('Você está prestes a Excluir o cadastro do fornecedor <b>' + cForn + '</b>!', 'Cuidado!')
  endif
Return

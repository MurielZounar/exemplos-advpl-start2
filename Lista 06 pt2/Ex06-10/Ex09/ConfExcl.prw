#INCLUDE 'TOTVS.CH'

User Function ConfExcl()
  Local lResposta := MsgYesNo('Confirma a exclusão do cadastro?') // Pergunta se o usuário confirma a excluisão.

  Help(NIL, NIL, 'Exclusão Cancelada pelo usuário!', NIL, 'Exclusão cancelada', 1, 0, NIL, NIL, NIL, NIL, NIL, {''})
Return lResposta

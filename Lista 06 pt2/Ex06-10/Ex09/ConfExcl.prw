#INCLUDE 'TOTVS.CH'

User Function ConfExcl()
  Local lResposta := MsgYesNo('Confirma a exclus�o do cadastro?') // Pergunta se o usu�rio confirma a excluis�o.

  Help(NIL, NIL, 'Exclus�o Cancelada pelo usu�rio!', NIL, 'Exclus�o cancelada', 1, 0, NIL, NIL, NIL, NIL, NIL, {''})
Return lResposta

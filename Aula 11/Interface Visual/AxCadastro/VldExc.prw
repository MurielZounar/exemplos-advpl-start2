#INCLUDE 'TOTVS.CH'

User Function VldExc()
  Local cMsg := 'Confirma a exclus�o do fornecedor?'
  Local lRet := .F.

  lRet := MsgYesNo(cMsg, 'Tem certeza?')
Return lRet

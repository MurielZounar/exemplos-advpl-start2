#INCLUDE 'TOTVS.CH'

User Function M410STTS()
  Local nOp  := PARAMIXB[1]
  Local cPed := SC5->C5_NUM

  if nOp == 3 .OR. nOp == 4 // Se a opera��o for Inclus�o (3) ou Altera��o (4) 
    if ExistBlock('MudaProd')
      ExecBlock('MudaProd', .F., .F., cPed) // a vari�vel cPed est� sendo passada como par�metro para a fun�ao MudaProd.
    endif
  endif
Return

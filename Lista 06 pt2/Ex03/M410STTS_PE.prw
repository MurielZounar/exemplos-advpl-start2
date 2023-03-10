#INCLUDE 'TOTVS.CH'

User Function M410STTS()
  Local nOp  := PARAMIXB[1]
  Local cPed := SC5->C5_NUM

  if nOp == 3 .OR. nOp == 4 // Se a operação for Inclusão (3) ou Alteração (4) 
    if ExistBlock('MudaProd')
      ExecBlock('MudaProd', .F., .F., cPed) // a variável cPed está sendo passada como parâmetro para a funçao MudaProd.
    endif
  endif
Return

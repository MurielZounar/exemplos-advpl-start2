#INCLUDE 'TOTVS.CH'

User Function CUSTOMERVENDOR()
  Local aParam   := PARAMIXB
  Local cIdPonto := ''
  Local cIdModel := ''
  Local oObj     := NIL
  Local xRet     := .T.

  if aParam != NIL
    oObj     := aParam[1] // Objeto do Browse
    cIdPonto := aParam[2] // Ponto de Execu��o
    cIdModel := aParam[3] // Modelo de Dados
    
    if cIdPonto == 'MODELVLDACTIVE' // Ao clicar em algum bot�o, esse � o 1� Ponto executado. Antes da abaretura da tela. 
      if ExistBlock('BoasVindas') // Exerc�cio 08
        ExecBlock('BoasVindas', .F., .F., oObj:nOperation) // oObj:nOperation - Recebe o n�mero da opera��o, ou seja, qual bot�o foi clicado (inclus�o, altera��o, exclus�o...). Est� sendo passado como par�metro.
      endif
    elseif cIdPonto == 'BUTTONBAR' .AND. INCLUI // �ltimo ponto executado antes da abertura da tela referente a op��o selecionada (inclus�o, altera��o, exclus�o...)
        if ExistBlock('CarregLoja') // Exerc�cio 07
          ExecBlock('CarregLoja', .F., .F., oObj) // Passando o objeto oObj como par�metro
        endif

        if ExistBlock('CarregCad') // Exerc�cio 10
          xRet := ExecBlock('CarregCad', .F., .F.) // xRet recebe o Array com o(s) bot�o(�es) criados.
        endif
    elseif cIdPonto == 'MODELPOS' // �ltimo Ponto de entrada executado antes de iniciar o processo de grava��o / altera��o / exclus�o no BD. Caso receba um valor .T., a execu��o continuar�, caso contr�rio, nada ser� feito
      if ExistBlock('ValidaCNPJ') // Exerc�cio 06
        xRet := ExecBlock('ValidaCNPJ', .F., .F.) // xRet recebe um valor l�gico (.T. / .F.), confirmando se o cadastro est� ok.
      endif

      if oObj:nOperation == 5 // Verifica se a opera��o selecionada � Exclus�o.
        if ExistBlock('ConfExcl') // Exerc�cio 09 
          xRet := ExecBlock('ConfExcl', .F., .F.)
        endif
      endif
    endif
  endif
Return xRet // Retorna o valor da vari�vel para a rotina padr�o.

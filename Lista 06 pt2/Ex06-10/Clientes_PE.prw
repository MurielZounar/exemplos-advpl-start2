#INCLUDE 'TOTVS.CH'

User Function CUSTOMERVENDOR()
  Local aParam   := PARAMIXB
  Local cIdPonto := ''
  Local cIdModel := ''
  Local oObj     := NIL
  Local xRet     := .T.

  if aParam != NIL
    oObj     := aParam[1] // Objeto do Browse
    cIdPonto := aParam[2] // Ponto de Execução
    cIdModel := aParam[3] // Modelo de Dados
    
    if cIdPonto == 'MODELVLDACTIVE' // Ao clicar em algum botão, esse é o 1º Ponto executado. Antes da abaretura da tela. 
      if ExistBlock('BoasVindas') // Exercício 08
        ExecBlock('BoasVindas', .F., .F., oObj:nOperation) // oObj:nOperation - Recebe o número da operação, ou seja, qual botão foi clicado (inclusão, alteração, exclusão...). Está sendo passado como parâmetro.
      endif
    elseif cIdPonto == 'BUTTONBAR' .AND. INCLUI // Último ponto executado antes da abertura da tela referente a opção selecionada (inclusão, alteração, exclusão...)
        if ExistBlock('CarregLoja') // Exercício 07
          ExecBlock('CarregLoja', .F., .F., oObj) // Passando o objeto oObj como parâmetro
        endif

        if ExistBlock('CarregCad') // Exercício 10
          xRet := ExecBlock('CarregCad', .F., .F.) // xRet recebe o Array com o(s) botão(ões) criados.
        endif
    elseif cIdPonto == 'MODELPOS' // Último Ponto de entrada executado antes de iniciar o processo de gravação / alteração / exclusão no BD. Caso receba um valor .T., a execução continuará, caso contrário, nada será feito
      if ExistBlock('ValidaCNPJ') // Exercício 06
        xRet := ExecBlock('ValidaCNPJ', .F., .F.) // xRet recebe um valor lógico (.T. / .F.), confirmando se o cadastro está ok.
      endif

      if oObj:nOperation == 5 // Verifica se a operação selecionada é Exclusão.
        if ExistBlock('ConfExcl') // Exercício 09 
          xRet := ExecBlock('ConfExcl', .F., .F.)
        endif
      endif
    endif
  endif
Return xRet // Retorna o valor da variável para a rotina padrão.

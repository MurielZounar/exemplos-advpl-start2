#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Relacionais
  Função desenvolvida pra exemplificar o uso dos operadores relacionais
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function Relacionais()
  Local nValor1 := 10
  Local nValor2 := 20
  Local cTexto1 := 'Macaco'
  Local cTexto2 := 'Maca'

    //? Menor
  if nValor1 < nValor2 //* Verdadeiro
    cMensagem := STR(nValor1) + ' é menor que ' + STR(nValor2)
    FwAlertSuccess(cMensagem, 'Operadores Relacionais')
  endif
    //? Maior
  if nValor1 > nValor2 //! Falso
    cMensagem := STR(nValor1) + ' é maior que ' + STR(nValor2)
    FwAlertSuccess(cMensagem, 'Operadores Relacionais')
  endif
    //? Igual
  if cTexto1 = cTexto2 //* Verdadeiro
    cMensagem := cTexto1 + ' - ' + cTexto2
    FwAlertSuccess(cMensagem, 'Operadores Relacionais')
  endif
  
    //? Exatamente Igual
  if cTexto1 == cTexto2 //! Falso
    cMensagem := 'Os valores são Identicos'
    FwAlertSuccess(cMensagem, 'Operadores Relacionais')
  endif
  
    //? Diferente
  if nValor1 != nValor2 //* Verdadeiro
    cMensagem := STR(nValor1) + ' é diferente de ' + STR(nValor2)
    FwAlertSuccess(cMensagem, 'Operadores Relacionais')
  endif
Return

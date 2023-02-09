#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Logicos
  Função desenvolvida pra exemplificar o uso dos operadores lógicos
  @type  Function
  @author Muriel Zounar
  @since 09/02/2023
  /*/
User Function Logicos()
  Local nValor1   := 5
  Local nValor2   := 10
  Local cMensagem := ''

  //? Verdadeiro    E    Verdadeiro
  if nValor1 >= 5 .AND. nValor2 <= 20 //* Operador "E"
    cMensagem := 'As duas expressões são verdadeiras!'
    FwAlertSuccess(cMensagem, 'Operadores Lógicos')
  endif

      //? Falso     OU   Verdadeiro
  if nValor1 == 10 .OR. nValor2 >= 10 //* Operador "OU"
    cMensagem := 'Ao menos uma das expressões é verdadeira!'
    FwAlertSuccess(cMensagem, 'Operadores Lógicos')
  endif

    //? (Falso         E    Falso) (Negado pelo "!")
  if !(nValor1 == 10 .AND. nValor2 == 5) //* Operador "E" com Negação (.NOT. / !)
    cMensagem := 'As duas expressões são falsas, mas o valor foi negado!'
    FwAlertSuccess(cMensagem, 'Operadores Lógicos')
  endif
Return

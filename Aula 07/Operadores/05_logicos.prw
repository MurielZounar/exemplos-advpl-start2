#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Logicos
  Fun��o desenvolvida pra exemplificar o uso dos operadores l�gicos
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
    cMensagem := 'As duas express�es s�o verdadeiras!'
    FwAlertSuccess(cMensagem, 'Operadores L�gicos')
  endif

      //? Falso     OU   Verdadeiro
  if nValor1 == 10 .OR. nValor2 >= 10 //* Operador "OU"
    cMensagem := 'Ao menos uma das express�es � verdadeira!'
    FwAlertSuccess(cMensagem, 'Operadores L�gicos')
  endif

    //? (Falso         E    Falso) (Negado pelo "!")
  if !(nValor1 == 10 .AND. nValor2 == 5) //* Operador "E" com Nega��o (.NOT. / !)
    cMensagem := 'As duas express�es s�o falsas, mas o valor foi negado!'
    FwAlertSuccess(cMensagem, 'Operadores L�gicos')
  endif
Return

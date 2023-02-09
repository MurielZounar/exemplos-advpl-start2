#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MacroSubs
  Fun��o com o objetivo de exemplificar os operadores dispon�veis no ADVPL
  @type  Function
  @author Muriel Zounar
  @since 08/02/2023
  /*/
User Function MacroSubs()
  Local nValor1 := 10
  local nMaisUm := 'nValor1 + 1'
  Local nValor2 := &nMaisUm

  FwAlertSuccess(STR(nValor2), 'Macro Substitui��o')
Return

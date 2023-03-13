#INCLUDE'TOTVS.CH'

/*/{Protheus.doc} User Function Starters
  Calcular valor de uma viagem de taxi
  @type  Function
  @author Muriel Zounar
  @since 12/01/2023
  @version version
  @param cExample, Character, Exemplo
  @return nRet, Numeric, Exemplo de Retorno numérico
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function VouDeTaxi(nPar1, nPar2)
  Local nRet := 0

  // Verifica se é bandeira 1 = 6h às 22h 
  if (nPar1 >= 6 .AND. nPar1 <= 22)
    nRet := (nPar2 * 2) // Preço da bandeira 1 é R$2,00
  // Bandeira 2 = 22:01 às 05:59
  else
    nRet := (nPar2 * 4) // Preço da bandeira 2 é R$4,00
  endif
Return nRet

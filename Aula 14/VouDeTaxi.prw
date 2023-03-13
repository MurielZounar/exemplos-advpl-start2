#INCLUDE'TOTVS.CH'

/*/{Protheus.doc} User Function Starters
  Calcular valor de uma viagem de taxi
  @type  Function
  @author Muriel Zounar
  @since 12/01/2023
  @version version
  @param cExample, Character, Exemplo
  @return nRet, Numeric, Exemplo de Retorno num�rico
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function VouDeTaxi(nPar1, nPar2)
  Local nRet := 0

  // Verifica se � bandeira 1 = 6h �s 22h 
  if (nPar1 >= 6 .AND. nPar1 <= 22)
    nRet := (nPar2 * 2) // Pre�o da bandeira 1 � R$2,00
  // Bandeira 2 = 22:01 �s 05:59
  else
    nRet := (nPar2 * 4) // Pre�o da bandeira 2 � R$4,00
  endif
Return nRet

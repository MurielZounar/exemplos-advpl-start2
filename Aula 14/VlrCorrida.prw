#INCLUDE'TOTVS.CH'

#DEFINE VALOR_BANDEIRA_1 2
#DEFINE VALOR_BANDEIRA_2 4
#DEFINE HR_INI_BANDEIRA_1 6
#DEFINE HR_FIM_BANDEIRA_1 22

/*/{Protheus.doc} User Function VlrCorrida
  Calcular o valor de uma corrida de taxi
  @type  Function
  @author Muriel Zounar
  @since 12/01/2023
  @param nHorario, Numérico, Hora de início da Corrida
  @param nDistancia, Numérico, Distância percorrida
  @return nValor, Numérico, Valor da corrida
  /*/
User Function VlrViagem(nHorario, nDistancia)
  Local nValor := 0

  // Verifica se é bandeira 1 (6h às 22h) 
  if nHorario >= HR_INI_BANDEIRA_1 .AND. nHorario <= HR_FIM_BANDEIRA_1
    nValor := (nDistancia * VALOR_BANDEIRA_1)
  // Bandeira 2 (22:01 às 05:59)
  else
    nValor := nDistancia * VALOR_BANDEIRA_2
  endif
Return nValor

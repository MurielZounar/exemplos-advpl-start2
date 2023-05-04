#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function IncAuto
  Inclusão por rotina automática
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/
User Function IncAuto()
  Local aVetor := {}
  Local nOper  := 3
  Private lMsErroAuto := .F.
  
  //? Abre Ambiente (não deve ser utilizado caso utilize interface ou seja chamado de uma outra rotina que já inicializou o ambiente)
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  //? Adicionando dados ao Array
  Aadd(aVetor, {'B1_FILIAL', xFilial('SB1'), NIL})
  Aadd(aVetor, {'B1_COD', '995566', NIL})
  Aadd(aVetor, {'B1_DESC' , 'EXEC AUTO - TESTE', NIL})
  Aadd(aVetor, {'B1_TIPO' ,'PA', NIL})
  Aadd(aVetor, {'B1_UM' ,'UN', NIL})
  Aadd(aVetor, {'B1_LOCPAD', '1', NIL})
  
  //? Executa a rotina automática  
  MSExecAuto({|x, y| MATA010(x, y)}, aVetor, nOper) //? nOper = 3 - Operação de Inclusão
  
  //? Se houver algum erro
  if lMsErroAuto
    //? Apresenta o erro
    MostraErro()
  endif
Return

#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function IncAuto
  Inclus�o por rotina autom�tica
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/
User Function IncAuto()
  Local aVetor := {}
  Local nOper  := 3
  Private lMsErroAuto := .F.
  
  //? Abre Ambiente (n�o deve ser utilizado caso utilize interface ou seja chamado de uma outra rotina que j� inicializou o ambiente)
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  //? Adicionando dados ao Array
  Aadd(aVetor, {'B1_FILIAL', xFilial('SB1'), NIL})
  Aadd(aVetor, {'B1_COD', '995566', NIL})
  Aadd(aVetor, {'B1_DESC' , 'EXEC AUTO - TESTE', NIL})
  Aadd(aVetor, {'B1_TIPO' ,'PA', NIL})
  Aadd(aVetor, {'B1_UM' ,'UN', NIL})
  Aadd(aVetor, {'B1_LOCPAD', '1', NIL})
  
  //? Executa a rotina autom�tica  
  MSExecAuto({|x, y| MATA010(x, y)}, aVetor, nOper) //? nOper = 3 - Opera��o de Inclus�o
  
  //? Se houver algum erro
  if lMsErroAuto
    //? Apresenta o erro
    MostraErro()
  endif
Return

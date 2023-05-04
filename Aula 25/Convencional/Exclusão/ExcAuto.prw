#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'

/*/{Protheus.doc} User Function ExcAuto
  Exclus�o por rotina autom�tica
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/
User Function ExcAuto()
  Local aVetor := {}
  Local nOper  := 5
  Private lMsErroAuto := .F.
  
  //? Abre Ambiente (n�o deve ser utilizado caso utilize interface ou seja chamado de uma outra rotina que j� inicializou o ambiente)
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  //? Adicionando dados ao Array
  Aadd(aVetor, {'B1_COD', '995566', NIL})
  Aadd(aVetor, {'B1_DESC', 'EXCLUIDO - EXEC AUTO - TESTE', NIL})
  
  //? Executa a rotina autom�tica
  MSExecAuto({|x, y| MATA010(x, y)}, aVetor, nOper) //? nOper = 5 - Opera��o de Exclus�o
  
  //? Se houver algum erro
  if lMsErroAuto
    //? Apresenta o erro
    MostraErro()
  endif
Return
  
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'FWMVCDEF.CH'
 
/*/{Protheus.doc} User Function ExcRAMVC
  Exclusão por rotina automática
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/
User Function ExcRAMVC()
  Local aDados := {}
  
  Private oModel      := NIL
  Private lMsErroAuto := .F.
  Private aRotina     := {}
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  //? Pegando modelo de Dados (Cadastro de Produtos)
  oModel := FwLoadModel ('MATA010')
  
  //? Adicionando os dados do ExecAuto
  aAdd(aDados, {'B1_FILIAL', FwFilial('SB1'), NIL})
  aAdd(aDados, {'B1_COD'   , '001002003'    , NIL})
  
  //? Chamando a exclusão
  FWMVCRotAuto(oModel, 'SB1', MODEL_OPERATION_DELETE, {{'SB1MASTER', aDados}},, .T.)
  
  //? Se houve erro no ExecAuto
  if lMsErroAuto
    //? Mostra mensagem de erro
    MostraErro()
  endif
Return

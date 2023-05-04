#INCLUDE 'RWMAKE.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function IncAutMVC
  Inclusão por rotina automática MODELO 1
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/ 
User Function IncAutMVC()
  Local aDados := {}
  
  Private oModel      := NIL
  Private lMsErroAuto := .F.
  Private aRotina     := {}
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  //? Pegando modelo de Dados (Cadastro de Produtos)
  oModel := FwLoadModel ('MATA010')
  
  //? Adicionando os dados do ExecAuto
  aAdd(aDados, {'B1_FILIAL' ,  FwFilial('SB1') , NIL})
  aAdd(aDados, {'B1_COD'    , '001TSTRA'       , NIL})
  aAdd(aDados, {'B1_DESC'   , 'TESTE - ROTAUTO', NIL})
  aAdd(aDados, {'B1_TIPO'   , 'PA'             , NIL})
  aAdd(aDados, {'B1_UM'     , 'UN'             , NIL})
  aAdd(aDados, {'B1_LOCPAD' , '1'             , NIL})
  
  lMsErroAuto := .F.

  //? Chamando a inclusão - Modelo 1
  FWMVCRotAuto(oModel, 'SB1', MODEL_OPERATION_INSERT, {{'SB1MASTER', aDados}})
  
  //? Se houve erro no ExecAuto
  if lMsErroAuto
    //? Mostra mensagem de erro
    MostraErro()
  endif
Return
 
//------------------------------------------------------------------------
/*
EXEMPLO DE INCLUSÃO MODELO 2 (Utilizando a função FwMvcRotAuto apenas em caráter didático)
*/
//------------------------------------------------------------------------

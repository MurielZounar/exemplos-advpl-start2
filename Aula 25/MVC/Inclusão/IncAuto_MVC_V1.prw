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
  Local oModel := NIL
  Private lMsErroAuto := .F.
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  oModel := FwLoadModel ('MATA010')
  oModel:SetOperation(MODEL_OPERATION_INSERT)
  oModel:Activate()
  oModel:SetValue('SB1MASTER','B1_FILIAL' , xFilial('SB1'))
  oModel:SetValue('SB1MASTER','B1_COD'    , '001AUT')
  oModel:SetValue('SB1MASTER','B1_DESC'   , 'EXEC AUTO MVC - TESTE 00')
  oModel:SetValue('SB1MASTER','B1_TIPO'   , 'PA')
  oModel:SetValue('SB1MASTER','B1_UM'     , 'UN')
  oModel:SetValue('SB1MASTER','B1_LOCPAD' , '1')
  
  if oModel:VldData()
    oModel:CommitData()
    MsgInfo('Processo concluído!', 'INCLUIDO')
  else
    VarInfo('', oModel:GetErrorMessage())
  endif       
      
  oModel:DeActivate()
  oModel:Destroy()
  
  oModel := NIL
Return

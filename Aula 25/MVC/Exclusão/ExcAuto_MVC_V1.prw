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
  Local oModel := NIL
  Private aRotina := {}
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  SB1->(DbSetOrder(1))
  
  //? Posicionando em um registro existente no BD
  If SB1->(DbSeek(xFilial('SB1') + '001AUT'))
    //? Pegando modelo de Dados (Cadastro de Produtos)
    oModel := FwLoadModel('MATA010')

    //? Setando a operação de exclusão
    oModel:SetOperation(MODEL_OPERATION_DELETE)
    oModel:Activate()
    
    //? Validando os dados
    if oModel:VldData()
      //? Enviando os dados no o BD
      oModel:CommitData()
      MsgInfo('Processo concluído!', 'EXLUÍDO')
    else
      VarInfo('', oModel:GetErrorMessage())
    endif
      
    oModel:DeActivate()
  else
    MsgInfo('REGISTRO NÃO ENCONTRADO!', 'Atenção')
  endif
Return

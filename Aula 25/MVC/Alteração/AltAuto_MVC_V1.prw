#INCLUDE 'RWMAKE.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function AltRAMVC
  Altera��o por rotina autom�tica
  @type  Function
  @author Muriel Zounar
  @since 04/05/2023
  /*/
User Function AltRAMVC()
  Local oModel := NIL
  Private lMsErroAuto := .F.
  
  PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' MODULO 'COM'
  
  //? Posicionando em um registro existente no BD
  SB1->(DbSetOrder(1))
  
  if SB1->(DbSeek(xFilial('SB1') + '001TSTRA'))
    //? Pegando modelo de Dados (Cadastro de Produtos)
    oModel := FwLoadModel('MATA010')

    //? Setando a opera��o de altera��o
    oModel:SetOperation(MODEL_OPERATION_UPDATE)

    oModel:Activate()

    //? Setando o novo valor do campo "B1_DESC" 
    oModel:SetValue('SB1MASTER', 'B1_DESC', 'TESTE - ALTERADO POR ROT. AUTO')
    
    //? Validando os dados
    if oModel:VldData()
      //? Enviando os dados no o BD
      oModel:CommitData()
      MsgInfo('Processo conclu�do!', 'ALTERADO')
    else
      VarInfo('', oModel:GetErrorMessage())
    endif
      
    oModel:DeActivate()
  else
    MsgInfo('REGISTRO N�O ENCONTRADO!', 'Aten��o')
  endif 
Return

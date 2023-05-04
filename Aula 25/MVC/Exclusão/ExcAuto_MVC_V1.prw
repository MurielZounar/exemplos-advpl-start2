#INCLUDE 'RWMAKE.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function ExcRAMVC
  Exclus�o por rotina autom�tica
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

    //? Setando a opera��o de exclus�o
    oModel:SetOperation(MODEL_OPERATION_DELETE)
    oModel:Activate()
    
    //? Validando os dados
    if oModel:VldData()
      //? Enviando os dados no o BD
      oModel:CommitData()
      MsgInfo('Processo conclu�do!', 'EXLU�DO')
    else
      VarInfo('', oModel:GetErrorMessage())
    endif
      
    oModel:DeActivate()
  else
    MsgInfo('REGISTRO N�O ENCONTRADO!', 'Aten��o')
  endif
Return

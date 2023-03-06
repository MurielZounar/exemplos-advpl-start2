//Bibliotecas
#INCLUDE 'TOTVS.CH'
 
/*/{Protheus.doc} User Function MATA010
    Rotina para exemplificar o uso de Pontos de Entrada utilizando MVC
    @type  Function
    @author Muriel Zounar
    @since 14/02/2023
    /*/
User Function Item()
    Local aParam   := PARAMIXB
    Local xRet     := .T.
    Local oObj     := NIL
    Local cIdPonto := ''
    Local cIdModel := ''
    Local nOper    := 0
    Local cCampo   := ''
    Local cTipo    := ''
 
    //Se tiver parâmetros
    If aParam <> NIL
        //Pega informações dos parâmetros
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
         
        //Valida a abertura da tela
        If cIdPonto == 'MODELVLDACTIVE'
            nOper := oObj:nOperation

            FwAlertInfo('Entrei no <b>MODELVLDACTIVE</b>', 'MODELVLDACTIVE')
             
            //Se for Exclusão, não permite abrir a tela
            If nOper == 5
                FwAlertError('Não é permitido excluir!', 'Não autorizado!')
                xRet := .F.
            EndIf
         
        //Pré configurações do Modelo de Dados
        ElseIf cIdPonto == 'MODELPRE'
            FwAlertInfo('Entrei no <b>MODELPRE</b>', 'MODELPRE')
            xRet := .T.
         
        //Pré configurações do Formulário de Dados
        ElseIf cIdPonto == 'FORMPRE'
            nOper  := oObj:GetModel(cIdPonto):nOperation
            cTipo  := aParam[4]
            cCampo := aParam[5]

            FwAlertInfo('Entrei no <b>FORMPRE</b>', 'FORMPRE')
             
            //Se for Alteração
            If nOper == 4
                FwAlertInfo('Vamos para a alteração...', 'Alteração')
            EndIf
         
        //Adição de opções no Ações Relacionadas dentro da tela
        ElseIf cIdPonto == 'BUTTONBAR'
            FwAlertInfo('Agora vamos criar alguns <b>Botões</b>', 'BUTTONBAR')

            xRet := {}
            aAdd(xRet, {'Novo Botão 1', '', {|| Alert('Botão 1')}, 'Teste do botão 1'})
            aAdd(xRet, {'Novo Botão 2', '', {|| Alert('Botão 2')}, 'Teste do botão 2'})
            aAdd(xRet, {'Novo Botão 3', '', {|| Alert('Botão 3')}, 'Teste do botão 3'})
         
        //Pós configurações do Formulário
        ElseIf cIdPonto == 'FORMPOS'
            FwAlertInfo('Entrei no <b>FORMPOS</b>', 'FORMPOS')

            xRet := .T.
         
        //Validação ao clicar no Botão Confirmar
        ElseIf cIdPonto == 'MODELPOS'
            FwAlertInfo('Entrei no <b>MODELPOS</b>', 'MODELPOS')
         
        //Pré validações do Commit
        ElseIf cIdPonto == 'FORMCOMMITTTSPRE'
            FwAlertInfo('Entrei no <b>FORMCOMMITTTSPRE</b>', 'FORMCOMMITTTSPRE')
         
        //Pós validações do Commit
        ElseIf cIdPonto == 'FORMCOMMITTTSPOS'
            FwAlertInfo('Entrei no <b>FORMCOMMITTTSPOS</b>', 'FORMCOMMITTTSPOS')
             
        //Commit das operações (antes da gravação)
        ElseIf cIdPonto == 'MODELCOMMITTTS'
            FwAlertInfo('Entrei no <b>MODELCOMMITTTS</b>', 'MODELCOMMITTTS')
             
        //Commit das operações (após a gravação)
        ElseIf cIdPonto == 'MODELCOMMITNTTS'
            nOper := oObj:nOperation
            
            FwAlertInfo('Entrei no <b>MODELCOMMITNTTS</b>', 'MODELCOMMITNTTS')
        EndIf
    EndIf
Return xRet

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
 
    //Se tiver par�metros
    If aParam <> NIL
        //Pega informa��es dos par�metros
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
         
        //Valida a abertura da tela
        If cIdPonto == 'MODELVLDACTIVE'
            nOper := oObj:nOperation

            FwAlertInfo('Entrei no <b>MODELVLDACTIVE</b>', 'MODELVLDACTIVE')
             
            //Se for Exclus�o, n�o permite abrir a tela
            If nOper == 5
                FwAlertError('N�o � permitido excluir!', 'N�o autorizado!')
                xRet := .F.
            EndIf
         
        //Pr� configura��es do Modelo de Dados
        ElseIf cIdPonto == 'MODELPRE'
            FwAlertInfo('Entrei no <b>MODELPRE</b>', 'MODELPRE')
            xRet := .T.
         
        //Pr� configura��es do Formul�rio de Dados
        ElseIf cIdPonto == 'FORMPRE'
            nOper  := oObj:GetModel(cIdPonto):nOperation
            cTipo  := aParam[4]
            cCampo := aParam[5]

            FwAlertInfo('Entrei no <b>FORMPRE</b>', 'FORMPRE')
             
            //Se for Altera��o
            If nOper == 4
                FwAlertInfo('Vamos para a altera��o...', 'Altera��o')
            EndIf
         
        //Adi��o de op��es no A��es Relacionadas dentro da tela
        ElseIf cIdPonto == 'BUTTONBAR'
            FwAlertInfo('Agora vamos criar alguns <b>Bot�es</b>', 'BUTTONBAR')

            xRet := {}
            aAdd(xRet, {'Novo Bot�o 1', '', {|| Alert('Bot�o 1')}, 'Teste do bot�o 1'})
            aAdd(xRet, {'Novo Bot�o 2', '', {|| Alert('Bot�o 2')}, 'Teste do bot�o 2'})
            aAdd(xRet, {'Novo Bot�o 3', '', {|| Alert('Bot�o 3')}, 'Teste do bot�o 3'})
         
        //P�s configura��es do Formul�rio
        ElseIf cIdPonto == 'FORMPOS'
            FwAlertInfo('Entrei no <b>FORMPOS</b>', 'FORMPOS')

            xRet := .T.
         
        //Valida��o ao clicar no Bot�o Confirmar
        ElseIf cIdPonto == 'MODELPOS'
            FwAlertInfo('Entrei no <b>MODELPOS</b>', 'MODELPOS')
         
        //Pr� valida��es do Commit
        ElseIf cIdPonto == 'FORMCOMMITTTSPRE'
            FwAlertInfo('Entrei no <b>FORMCOMMITTTSPRE</b>', 'FORMCOMMITTTSPRE')
         
        //P�s valida��es do Commit
        ElseIf cIdPonto == 'FORMCOMMITTTSPOS'
            FwAlertInfo('Entrei no <b>FORMCOMMITTTSPOS</b>', 'FORMCOMMITTTSPOS')
             
        //Commit das opera��es (antes da grava��o)
        ElseIf cIdPonto == 'MODELCOMMITTTS'
            FwAlertInfo('Entrei no <b>MODELCOMMITTTS</b>', 'MODELCOMMITTTS')
             
        //Commit das opera��es (ap�s a grava��o)
        ElseIf cIdPonto == 'MODELCOMMITNTTS'
            nOper := oObj:nOperation
            
            FwAlertInfo('Entrei no <b>MODELCOMMITNTTS</b>', 'MODELCOMMITNTTS')
        EndIf
    EndIf
Return xRet

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
    Local lRet     := .T.
    Local oObj     := Nil
    Local cIdPonto := ''
    Local cIdModel := ''
 
    //Se tiver parâmetros
    If aParam <> NIL
        //Pega informações dos parâmetros
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]
         
        if cIdPonto == 'MODELPOS'
            if ExistBlock('ConfirmaCadastro')
                lRet := ExecBlock('ConfirmaCadastro', .F., .F.)
            else
                FwAlertError('Função não encontrada!', 'Erro!')
            endif
        endif
    EndIf
Return lRet

#INCLUDE 'TOTVS.CH'

User Function Escopo()
  Local cNome        := 'Muriel'
  Static cNomeMeio   := 'Zounar'
  Private cSobrenome := 'Santana'

  Alert('Nome: ' + cNome + ' ' + cNomeMeio + ' ' + cSobrenome)
  
  TestaVariaveis()
Return

Static Function TestaVariaveis()
  //TODO: S� criar a pr�xima linha depois de executar sem ela.
  // Local cNome := 'Muriel' //* Essa variável deve ser criada para que o nome apareça na mensagem, pois no escopo dessa função não existe nenhuma variável chamada "cNome"

  //TODO: S� criar a pr�xima linha depois de executar sem ela.
  // Local cNomeMeio := 'Silva' //! Se essa vari�vel for criada, ir� sobrescrever o conte�do da vari�vel est�tica criada na fun��o anterior. 

  //TODO: S� criar a pr�xima linha depois de executar sem ela.
  // Local cSobrenome := 'Oliveira' //! Se essa vari�vel for criada, ir� sobrescrever o conte�do da vari�vel privada criada na fun��o anterior.

  Alert('Nome: ' + cNome + ' ' + cNomeMeio + ' ' + cSobrenome)
Return

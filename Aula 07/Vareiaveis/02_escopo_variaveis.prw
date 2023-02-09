#INCLUDE 'TOTVS.CH'

User Function Escopo()
  Local cNome        := 'Muriel'
  Static cNomeMeio   := 'Zounar'
  Private cSobrenome := 'Santana'

  Alert('Nome: ' + cNome + ' ' + cNomeMeio + ' ' + cSobrenome)
  
  TestaVariaveis()
Return

Static Function TestaVariaveis()
  //TODO: Só criar a próxima linha depois de executar sem ela.
  // Local cNome := 'Muriel' //* Essa variÃ¡vel deve ser criada para que o nome apareÃ§a na mensagem, pois no escopo dessa funÃ§Ã£o nÃ£o existe nenhuma variÃ¡vel chamada "cNome"

  //TODO: Só criar a próxima linha depois de executar sem ela.
  // Local cNomeMeio := 'Silva' //! Se essa variável for criada, irá sobrescrever o conteúdo da variável estática criada na função anterior. 

  //TODO: Só criar a próxima linha depois de executar sem ela.
  // Local cSobrenome := 'Oliveira' //! Se essa variável for criada, irá sobrescrever o conteúdo da variável privada criada na função anterior.

  Alert('Nome: ' + cNome + ' ' + cNomeMeio + ' ' + cSobrenome)
Return

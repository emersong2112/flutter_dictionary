# Dicionário de palavras em Flutter

Projeto realizado utilizando uma API pessoal com a listagem de palavras em inglês e a WordsAPI.
É possível navegar entre as palavras, ver detalhes, consultar histórico e salvar favoritos.

# Tecnologias

- Flutter
- Plugin shared_preferences (para gerenciamento de Cache)
- Plugin dio (para gerenciamento de conexão entre as APIs)
- Plugin animations (para navegação mais flúida entre as páginas)

# Instalação

Após clonar o repositório (git clone [url do repositório]), basta rodar o comando:

 - flutter pub get

Este comando irá instalar todas as dependências necessárias para o correto funcionamento do projeto.

Caso esteja utilizando MacOs com XCode e testando em IOS, pode ser necessária alguma configuração extra
Obs. Esse projeto foi testado apenas em Windows e build para Android (Versão 13)

O grandle está configurado para SDK mínimo 19, pois é necessário para o correto funcionamento de alguns plugins.

Para rodar, basta utilizar o comando "flutter run".

É altamente recomendado utilizar o VS Code com as devidas extensões de relacionadas ao Dart e Flutter, pois facilitam esse processo, nesse caso, basta pressionar F5 e selecionar o dispositivo de destino.




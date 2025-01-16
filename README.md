# Exercício de Backend 

- documentar e explicar as tomadas de decisões
- usar graphql

## Expectativas

- Deve ser código pronto para produção
  - O código nos mostrará como você entrega coisas para produção e será um reflexo do seu trabalho.
- Você tem 5 dias para entregar o código. Além disso, se houver algo que você teve que deixar incompleto ou se há uma melhor solução que você implementaria, mas não pôde devido a limitações de tempo pessoais, por favor, tente nos guiar através do seu processo de pensamento ou de quaisquer partes faltantes, utilizando a seção "Detalhes da Implementação" abaixo.

## O que você vai construir

Um aplicativo Phoenix com 2 endpoints para gerenciar câmeras.

Não esperamos que você implemente autenticação e autorização, mas sua solução final deve assumir que será implantada em produção e que os dados serão consumidos por uma Single Page Application que roda nos navegadores dos clientes.

## Requisitos

- Devemos armazenar usuários e câmeras em um banco de dados PostgreSQL.
- Cada usuário tem um nome e pode ter múltiplas câmeras.
- Cada câmeras deve ter uma marca.
- Todos os campos acima definidos devem ser obrigatórios.
- Cada usuário deve ter pelo menos 1 câmera ativa em um dado momento.
- Todos os endpoints devem retornar JSON.
- Um arquivo readme com instruções sobre como executar o aplicativo.

### Tarefas

1. Implementar um endpoint para fornecer uma lista de usuários e suas câmeras
   - Cada usuário deve retornar seu nome e suas câmeras ativas.
   - Alguns usuários podem ter sido desligados (a funcionalidade de desligamento deve ser considerada fora do escopo deste exercício), então só nesse caso é possível que todas as câmeras pertencentes a um usuário estejam inativas. Nestes casos, o endpoint deve retornar a data em que o usuário foi desligado.
   - Este endpoint deve suportar filtragem por parte do nome da câmera e ordenação pelo nome da camera.
   - Endpoint: GET /cameras

2. Implementar um endpoint que envia um e-mail para cada usuário com uma câmera da marca Hikvision;
   - ⚠️ O app não precisa enviar email de fato, então você não precisa necessariamente de acesso à internet para trabalhar no seu desafio.
   - Você pode usar o modo "dev/mailbox" que já vem no phoenix.
   - Endpoint: POST /notify-users

### Quando terminar

- Você pode usar a seção "Detalhes da Implementação" para explicar algumas decisões/limitações da sua implementação.
- Envie o link do repositório para [lucas@octos.ai](mailto:lucas@octos.ai).
- Você também pode enviar algum feedback sobre este exercício.

---

## Detalhes da Implementação

Essa seção é para você preencher com quaisquer decisões que tomou que podem ser relevantes. Você também pode mudar esse README para atender suas necessidades.# octos

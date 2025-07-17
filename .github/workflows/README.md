# GitHub Actions Workflow - Docker Hub

Este workflow automatiza o build e push da imagem Docker para o Docker Hub.

## Configuração dos Secrets

Para que o workflow funcione, você precisa configurar os seguintes secrets no seu repositório GitHub:

### 1. Acesse as configurações do repositório:
- Vá para `Settings` > `Secrets and variables` > `Actions`

### 2. Adicione os seguintes secrets:

#### `DOCKER_USERNAME`
- Seu nome de usuário do Docker Hub
- Exemplo: `meuusuario`
- **Importante:** Este será usado para criar a imagem: `docker.io/meuusuario/cliente-pet`

#### `DOCKER_PASSWORD`
- Sua senha do Docker Hub ou um Access Token
- **Recomendado:** Use um Access Token em vez da senha
- Para criar um Access Token:
  1. Acesse https://hub.docker.com/settings/security
  2. Clique em "New Access Token"
  3. Dê um nome (ex: "GitHub Actions")
  4. Copie o token gerado

## Como funciona o workflow

### Triggers:
- **Pull Requests** para branch `develop`

### Ações:
1. **Checkout** do código
2. **Setup** do Docker Buildx
3. **Login** no Docker Hub
4. **Extração** de metadados para tags
5. **Build e Push** da imagem Docker

### Tags geradas automaticamente:
- `pr-123` (número do Pull Request)
- `pr-d7517b1` (pr- + commit hash)

## Exemplo de uso

### Para fazer deploy:
```bash
# Criar uma branch feature
git checkout -b feature/nova-funcionalidade

# Fazer commits
git add .
git commit -m "Adiciona nova funcionalidade"

# Push da branch
git push origin feature/nova-funcionalidade

# Criar Pull Request para develop no GitHub
# O workflow será executado automaticamente
```

### Para testar localmente:
```bash
# Build da imagem
docker build -t cliente-pet-api .

# Executar container
docker run -p 8080:8080 cliente-pet-api
```

## Estrutura do projeto

```
cliente-pet/
├── .github/
│   └── workflows/
│       ├── build.yml
│       └── README.md
├── src/
├── Dockerfile
├── pom.xml
└── ...
``` 
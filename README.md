# 🤖 Project AI Template

Template base para projetos de IA utilizando Python, LangChain e PostgreSQL. Configurado com Docker, Poetry e ferramentas de qualidade de código.

## 📋 Características

- **Python 3.12+**: Versão moderna do Python
- **LangChain**: Framework para desenvolvimento de aplicações com LLMs
- **PostgreSQL**: Banco de dados relacional robusto
- **Poetry**: Gerenciamento de dependências e ambiente virtual
- **Docker & Docker Compose**: Ambiente containerizado e reproduzível
- **Ruff**: Linter e formatter ultrarrápido
- **Taskipy**: Automação de tarefas
- **Pytest**: Framework de testes

## 🏗️ Estrutura do Projeto

```explore

project_ai_template/
├── src/
│   └── project_ai_template/
│       ├── agent/           # Módulos de agentes IA
│       ├── db/              # Configuração e modelos do banco
│       │   ├── crud.py
│       │   ├── database.py
│       │   ├── models.py
│       │   └── schema.py
│       ├── task/            # Tarefas e processamentos
│       └── tool/            # Ferramentas e utilidades
│           ├── config.py
│           └── main.py
├── test/                    # Testes automatizados
├── .dockerignore
├── .envexample
├── .gitignore
├── docker-compose.yml
├── DOCKERFILE
├── poetry.lock
├── pyproject.toml
└── README.md
```

## 🚀 Como Usar Este Template

### 1. Criando um Novo Projeto

#### Opção A: Via GitHub (Recomendado)

```bash
# Use este repositório como template no GitHub
# Clique em "Use this template" > "Create a new repository"
```

#### Opção B: Clone Manual

```bash
git clone https://github.com/seu-usuario/project_ai_template.git meu-novo-projeto
cd meu-novo-projeto
rm -rf .git
git init
```

### 2. Personalização Inicial

#### 1. Renomeie o projeto em `pyproject.toml`

```toml
[tool.poetry]
name = "meu-novo-projeto"
version = "0.1.0"
description = "Descrição do seu projeto"
authors = ["Seu Nome <seu.email@example.com>"]
```

#### 2. Renomeie a pasta do pacote

```bash
mv src/project_ai_template src/meu_novo_projeto
```

#### 3. Atualize a referência em `pyproject.toml`

```toml
packages = [{ include = "meu_novo_projeto", from = "src" }]
```

#### 4. Configure as variáveis de ambiente

```bash
cp .envexample .env
# Edite o arquivo .env com suas configurações
```

### 3. Configuração do Ambiente

#### Opção A: Com Docker (Recomendado para produção e consistência)

O Docker já instala automaticamente todas as dependências durante o build:

```bash
# Iniciar os serviços (primeira vez faz build automático)
docker compose up -d

# Verificar logs
docker compose logs -f app

# Acessar o container da aplicação para executar comandos
docker compose exec app bash

# Dentro do container, o ambiente já está pronto!
# Você pode executar comandos diretamente:
poetry run python -m src.project_ai_template.tool.main
```

**Importante**: Com Docker, o `.venv` é criado dentro do container durante o build. Você não precisa executar `poetry install` manualmente.

#### Opção B: Sem Docker (Desenvolvimento Local)

Para trabalhar diretamente na sua máquina:

```bash
# 1. Instalar Poetry (se necessário)
curl -sSL https://install.python-poetry.org | python3 -

# 2. Criar ambiente virtual e instalar dependências
poetry install --with dev

# 3. Ativar ambiente virtual
poetry shell

# Agora você está dentro da .venv e pode executar:
python -m src.project_ai_template.tool.main
```

**Nota**: O Poetry criará automaticamente a pasta `.venv` no diretório do projeto (configurado no `pyproject.toml`).

#### Qual opção escolher?

- **Docker**: Ideal para garantir que o ambiente é idêntico em dev/produção. Útil se você trabalha em equipe.
- **Local**: Mais rápido para desenvolvimento e debugging, melhor integração com IDEs.

## 🔧 Variáveis de Ambiente

Copie `.envexample` para `.env` e configure:

```env
# PostgreSQL
POSTGRES_USER=seu_usuario
POSTGRES_PASSWORD=sua_senha_segura
POSTGRES_DB=seu_database
POSTGRES_HOST=db
POSTGRES_PORT=5432
POSTGRES_TAG=16

# API Keys (adicione conforme necessário)
OPENAI_API_KEY=sua_chave_aqui
ANTHROPIC_API_KEY=sua_chave_aqui
```

## 📦 Gerenciamento de Dependências

### Com Docker

```bash
# Adicionar nova dependência
# 1. Adicione no seu ambiente local (fora do container)
poetry add nome-do-pacote

# 2. Rebuild o container para aplicar as mudanças
docker compose up -d --build

# OU execute dentro do container
docker compose exec app poetry add nome-do-pacote
```

### Sem Docker (ambiente local)

```bash
# Adicionar nova dependência
poetry add nome-do-pacote

# Adicionar dependência de desenvolvimento
poetry add --group dev nome-do-pacote

# Remover dependência
poetry remove nome-do-pacote

# Atualizar dependências
poetry update

# Reinstalar todas as dependências (limpar e instalar)
poetry install --with dev
```

**Dica**: Após adicionar dependências, sempre commite os arquivos `pyproject.toml` e `poetry.lock` para manter o ambiente consistente na equipe.

## 🧪 Qualidade de Código

O projeto usa Ruff para linting e formatação, com comandos automatizados via Taskipy:

### Executando com Docker

```bash
# Verificar problemas de código
docker compose exec app poetry run task lint

# Corrigir problemas automaticamente
docker compose exec app poetry run task format

# Corrigir tudo (lint + format)
docker compose exec app poetry run task fix_all

# Executar testes
docker compose exec app poetry run task test
```

### Sem Docker (com .venv ativado)

```bash
# Ative o ambiente primeiro
poetry shell

# Verificar problemas de código
task lint

# Corrigir problemas automaticamente
task format

# Corrigir tudo (lint + format)
task fix_all

# Executar testes
task test

# OU use diretamente com poetry run
poetry run task lint
poetry run task fix_all
```

## 🧩 Estrutura dos Módulos

### Agent

Módulo para implementação de agentes de IA usando LangChain.

### DB

- `database.py`: Configuração da conexão com PostgreSQL
- `models.py`: Modelos SQLAlchemy/ORM
- `schema.py`: Schemas Pydantic para validação
- `crud.py`: Operações de CRUD

### Task

Módulo para implementação de tarefas e processamentos assíncronos.

### Tool

- `config.py`: Configurações usando Pydantic Settings
- `main.py`: Ponto de entrada da aplicação

## 🐳 Comandos Docker Úteis

```bash
# Iniciar serviços
docker compose up -d

# Parar serviços
docker compose down

# Rebuild containers
docker compose up -d --build

# Ver logs
docker compose logs -f [app|db]

# Executar comando no container
docker compose exec app poetry run python -m src.project_ai_template.tool.main

# Acessar PostgreSQL
docker compose exec db psql -U $POSTGRES_USER -d $POSTGRES_DB
```

## 📝 Exemplos de Uso

### Executando a Aplicação

#### Usando Docker

```bash
# Opção 1: Executar comando diretamente (sem entrar no container)
docker compose exec app poetry run python -m src.project_ai_template.tool.main

# Opção 2: Entrar no container e executar
docker compose exec app bash
# Agora você está dentro do container com o ambiente já configurado
poetry run python -m src.project_ai_template.tool.main
```

#### Sem Docker (com .venv local)

```bash
# Certifique-se de estar com o ambiente ativado
poetry shell

# Execute sua aplicação
python -m src.project_ai_template.tool.main

# Ou diretamente sem ativar o shell
poetry run python -m src.project_ai_template.tool.main
```

## 🔒 Boas Práticas

1. **Nunca commite** o arquivo `.env` (já está no `.gitignore`)
2. **Use type hints** em todo o código Python
3. **Escreva testes** para funcionalidades críticas
4. **Execute** `task fix_all` antes de cada commit
5. **Mantenha** as dependências atualizadas regularmente
6. **Documente** funções e classes complexas

## 🤝 Contribuindo

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é um template de código aberto. Sinta-se livre para usá-lo e modificá-lo conforme suas necessidades.

## 🆘 Troubleshooting

### Problema: Container não inicia

```bash
# Verificar logs
docker compose logs app

# Rebuild completo
docker compose down -v
docker compose up -d --build
```

### Problema: Erro de conexão com PostgreSQL

```bash
# Verificar se o DB está saudável
docker compose ps

# Verificar variáveis de ambiente
docker compose exec app env | grep POSTGRES

# Acessar logs do banco
docker compose logs db
```

### Problema: Poetry não encontra pacotes (ambiente local)

```bash
# Limpar cache e reinstalar
poetry cache clear pypi --all
poetry install --with dev

# Se necessário, remova a .venv e recrie
rm -rf .venv
poetry install --with dev
```

### Problema: .venv não é criado no local esperado

```bash
# Verificar configuração do Poetry
poetry config virtualenvs.in-project

# Deve retornar 'true'. Se não:
poetry config virtualenvs.in-project true

# Remover .venv antiga e recriar
rm -rf .venv
poetry install --with dev
```

### Problema: Mudanças no código não refletem no container

```bash
# O volume está mapeado, mas pode ser necessário:
docker compose restart app

# Ou se mudou dependências, rebuild:
docker compose up -d --build
```

### Problema: Permissões negadas ao criar arquivos no container

```bash
# O container usa UID/GID 1000 por padrão
# Se seu usuário local tem UID diferente, ajuste no docker-compose.yml:
services:
  app:
    build:
      context: .
      args:
        UID: ${UID:-1000}
        GID: ${GID:-1000}
```

## 📚 Recursos Adicionais

- [Documentação LangChain](https://python.langchain.com/)
- [Documentação Poetry](https://python-poetry.org/docs/)
- [Documentação Ruff](https://docs.astral.sh/ruff/)
- [Documentação PostgreSQL](https://www.postgresql.org/docs/)

---

### Template desenvolvido por Rogerio Campos

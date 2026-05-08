# Shop4u

## Objetivo

Criar uma experiência de compra móvel simples, personalizada e eficiente, com recomendações por IA.

## Visão geral

Shop4u é um protótipo de aplicativo mobile de e-commerce. O repositório contém documentação, scripts de fluxo de trabalho e um módulo inicial de busca (`src/search.js`). Outras funcionalidades (recomendações, checkout, notificações) estão no escopo do MVP e documentadas, mas não implementadas neste repositório.

## Funcionalidades (status)

- Busca de produtos por nome: Implementado (módulo simples em `src/search.js`)
- Filtro por categoria: Planejado
- Carrinho de compras: Planejado
- Checkout com autenticação: Planejado
- Recomendações personalizadas com IA: Planejado
- Notificações de pedido: Planejado

> Observação: o README reflete o estado atual do repositório — não documenta funcionalidades não implementadas como existentes.

## Estrutura de pastas

```text
.
├── .github/                # Configurações e instruções para automações
├── docs/                   # Documentação e templates
├── scripts/                # Scripts de fluxo (start_issue, open_pr, etc.)
├── src/                    # Código fonte (ex.: search.js)
├── CONTRIBUTING.md
└── README.md
```

## Como executar localmente

Requer: `node` (v14+) para executar o módulo de busca demonstrativo e `gh`/`git` para os scripts de fluxo.

Exemplo rápido — testar o módulo de busca:

```bash
node -e "const search=require('./src/search'); const products=[{name:'Camisa'}, {name:'Calça'}]; console.log(search(products,'camisa'))"
```

## Scripts disponíveis

### Iniciar trabalho em uma Issue

Este script lista issues abertas e cria a branch seguindo o padrão do repositório.

```bash
./scripts/start_issue.sh
```

Requisitos: `gh` autenticado e repositório Git configurado.

### Abrir Pull Request

Cria um PR a partir da branch atual usando `gh`.

```bash
./scripts/open_pr.sh
```

O script faz `git push` e chama `gh pr create`.

## Fluxo de desenvolvimento

1. Escolher uma Issue (use labels `[EPIC]`, `[STORY]`, `[DOCS]` conforme convenção).
2. Executar `./scripts/start_issue.sh` para criar a branch local.
3. Implementar a alteração e criar commits seguindo Conventional Commits.
4. Executar `./scripts/open_pr.sh` para abrir o Pull Request.
5. Revisar e mesclar após aprovação.

## Convenção de commits

Use Conventional Commits:

```text
feat: implementa funcionalidade
fix: corrige comportamento
docs: atualiza documentação
chore: ajusta configuração
test: adiciona testes
refactor: refatora implementação
```

## Issues e backlog

- Use `[EPIC]`, `[STORY]`, `[DOCS]` no título das issues.
- Para Stories, inclua `Parent Epic: #ID` e as seções `## User Story`, `## Critérios de aceitação — BDD` e `## Checklist técnico`.

## Documentação adicional

Consulte a pasta `docs/` para templates e notas do produto.


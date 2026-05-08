# Guia de contribuição

Este documento descreve o fluxo de contribuição, convenções e uso dos scripts presentes no repositório.

## Fluxo de contribuição

1. Escolha uma Issue aberta no repositório.
2. Inicie a branch de trabalho com `./scripts/start_issue.sh`.
3. Implemente a alteração localmente.
4. Faça commits usando Conventional Commits.
5. Abra o Pull Request com `./scripts/open_pr.sh`.
6. Após revisão e aprovação, mescle e apague a branch.

## Como iniciar uma Issue

O script interativo lista issues abertas e cria a branch com o padrão do repositório:

```bash
./scripts/start_issue.sh
```

Requisitos: `gh` CLI autenticado e repositório Git inicializado.

## Como fazer commit

Exemplo de uso:

```bash
git add .
git commit -m "feat: descricao da alteracao"
```

## Como abrir Pull Request

O script empurra a branch atual e cria um PR usando `gh`:

```bash
./scripts/open_pr.sh
```

O script espera que a branch siga o padrão `type/<issue-id>-descricao` para extrair o número da Issue.

## Padrão de branches

```text
feature/<issue-id>-descricao
docs/<issue-id>-descricao
fix/<issue-id>-descricao
```

## Padrão de commits

Use Conventional Commits:

```text
feat: nova funcionalidade
fix: correção
docs: documentação
chore: configuração
test: testes
refactor: refatoração
```

## Checklist antes do merge

- [ ] A Issue relacionada está correta.
- [ ] O PR contém `Closes #ID` quando aplicável.
- [ ] A User Story foi considerada.
- [ ] Os critérios BDD foram atendidos.
- [ ] O código foi testado quando aplicável.
- [ ] A documentação foi atualizada quando necessário.

## Boas práticas de revisão

- Comente mudanças de design e riscos potenciais no PR.
- Peça revisão de um colega para mudanças de produção.
- Verifique a compatibilidade com as convenções do repositório.

## Observações sobre os scripts

- `start_issue.sh` assume que o repositório está inicializado com Git e o `gh` está disponível.
- `open_pr.sh` faz `git push` e usa `gh pr create` para abrir o Pull Request.
- Não execute os scripts sem verificar que `gh` está autenticado e que você está no repositório correto.



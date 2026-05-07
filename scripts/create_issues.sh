#!/usr/bin/env bash
set -euo pipefail

# Script para criar 6 GitHub Issues (1 Epic, 4 Stories, 1 Docs)
# Não executa automaticamente — revise antes de rodar.

TMP_DIR=$(mktemp -d)
cleanup() { rm -rf "$TMP_DIR"; }
trap cleanup EXIT

EPIC_BODY_FILE="$TMP_DIR/epic.md"
STORY1_BODY_FILE="$TMP_DIR/story1.md"
STORY2_BODY_FILE="$TMP_DIR/story2.md"
STORY3_BODY_FILE="$TMP_DIR/story3.md"
STORY4_BODY_FILE="$TMP_DIR/story4.md"
DOCS_BODY_FILE="$TMP_DIR/docs.md"

cat > "$EPIC_BODY_FILE" <<'EOF'
[EPIC] Plataforma Shop4u — MVP mobile

Visão: Entregar a plataforma móvel Shop4u com busca, carrinho, checkout autenticado, recomendações com IA e notificações de pedido, permitindo um MVP funcional.

Escopo do Epic:
- Implementar funcionalidades essenciais para o fluxo de compra mobile.
- Priorizar autenticação, pagamento seguro e recomendações iniciais por IA.

Labels: epic, priority:high
EOF

cat > "$STORY1_BODY_FILE" <<'EOF'
[STORY] Busca de produtos (nome e categoria)

Parent Epic: #ID_DA_EPIC

## User Story
Como usuário do app Shop4u
Quero buscar produtos por nome e filtrar por categoria
Para encontrar rapidamente itens relevantes e iniciar a compra

## Critérios de aceitação — BDD
Dado que existe um catálogo de produtos
Quando eu pesquisar por um termo ou selecionar uma categoria
Então o sistema deve retornar uma lista paginada de produtos que correspondam ao termo ou à categoria

## Checklist técnico
- Implementar endpoint de busca com suporte a termo e filtro por categoria
- Indexar campos relevantes (nome, descrição, categoria) no banco de dados
- Implementar paginação e ordenação por relevância/preço
- Adicionar validação de input e limites de taxa
EOF

cat > "$STORY2_BODY_FILE" <<'EOF'
[STORY] Carrinho e Checkout com autenticação

Parent Epic: #ID_DA_EPIC

## User Story
Como comprador autenticado
Quero adicionar itens ao carrinho, revisar o pedido e finalizar o pagamento
Para completar a compra de forma segura

## Critérios de aceitação — BDD
Dado que eu esteja autenticado
Quando eu finalizar a compra e o pagamento for aprovado
Então o pedido deve ser criada e o usuário receberá confirmação

Dado que o pagamento seja recusado
Quando eu tentar finalizar a compra
Então o carrinho deve permanecer ativo e o pedido não deve ser criado

## Checklist técnico
- Implementar modelo de carrinho persistente por usuário
- Integrar gateway de pagamento (simulado para MVP) e webhook de confirmação
- Verificar autenticação obrigatória antes do checkout
- Garantir transação atômica: criar pedido somente após pagamento confirmado
- Tratar erros de pagamento mantendo o estado do carrinho
EOF

cat > "$STORY3_BODY_FILE" <<'EOF'
[STORY] Recomendações personalizadas com IA

Parent Epic: #ID_DA_EPIC

## User Story
Como usuário do Shop4u
Quero receber recomendações personalizadas baseadas no meu histórico
Para descobrir produtos relevantes sem procurar manualmente

## Critérios de aceitação — BDD
Dado que o usuário tenha histórico de navegação/compras
Quando ele acessar a tela inicial ou a página de produto
Então o sistema deve exibir recomendações personalizadas baseadas no histórico

Dado que o usuário não tenha histórico
Quando ele acessar o app
Então o sistema deve exibir produtos populares

## Checklist técnico
- Definir telemetria mínima para histórico de navegação (visualizações, cliques)
- Implementar serviço de recomendação simples (modelo heurístico ou microserviço IA)
- Criar fallback que retorna produtos populares para novos usuários
- Garantir respeito à privacidade e opção de desativar recomendações
EOF

cat > "$STORY4_BODY_FILE" <<'EOF'
[STORY] Notificações de pedido

Parent Epic: #ID_DA_EPIC

## User Story
Como usuário que realizou um pedido
Quero receber notificações sobre o status do pedido
Para acompanhar o andamento da entrega e o sucesso do pagamento

## Critérios de aceitação — BDD
Dado que um pedido tenha seu status alterado (pago, em preparo, enviado, entregue)
Quando a mudança ocorrer
Então o usuário deve receber uma notificação (push/in-app) com o novo status

## Checklist técnico
- Implementar evento de mudança de status de pedido
- Integrar serviço de notificações push (simulado para MVP)
- Garantir que notificações só sejam enviadas para usuários autenticados
- Registrar histórico de notificações por pedido
EOF

cat > "$DOCS_BODY_FILE" <<'EOF'
[DOCS] Documentação inicial: arquitetura, convenções e uso de IA

Descrição: Documentar visão geral do projeto, arquitetura do MVP, contratos de API principais, convenções de desenvolvimento (branching, PR, linting) e como a equipe usará IA para acelerar backlog, docs e PRs.

## Conteúdo mínimo
- Visão do sistema e escopo do MVP
- Endpoints principais (busca, carrinho, checkout, recomendações, notificações)
- Convenções de desenvolvimento e checklist de PR
- Guia rápido para rodar localmente e simular pagamentos/notifications
- Plano de coleta mínima de dados para recomendações por IA e considerações de privacidade

Labels: docs, priority:medium
EOF

echo "Criando Epic..."
EPIC_URL=$(gh issue create --title "[EPIC] Plataforma Shop4u — MVP mobile" --body-file "$EPIC_BODY_FILE" --label epic --label "priority:high")
echo "Epic criada: $EPIC_URL"

EPIC_NUMBER=$(echo "$EPIC_URL" | sed -E 's#.*/([0-9]+)$#\1#')
echo "Número do Epic: $EPIC_NUMBER"

# Substitui placeholder do Parent Epic nos arquivos de story
for f in "$STORY1_BODY_FILE" "$STORY2_BODY_FILE" "$STORY3_BODY_FILE" "$STORY4_BODY_FILE"; do
  sed -i "s/#ID_DA_EPIC/#$EPIC_NUMBER/g" "$f"
done

echo "Criando Story 1 (Busca)..."
STORY1_URL=$(gh issue create --title "[STORY] Busca de produtos (nome e categoria)" --body-file "$STORY1_BODY_FILE" --label story --label frontend --label backend --label "priority:high")
echo "Story 1: $STORY1_URL"

echo "Criando Story 2 (Carrinho e Checkout)..."
STORY2_URL=$(gh issue create --title "[STORY] Carrinho e Checkout com autenticação" --body-file "$STORY2_BODY_FILE" --label story --label backend --label frontend --label "priority:high")
echo "Story 2: $STORY2_URL"

echo "Criando Story 3 (Recomendações IA)..."
STORY3_URL=$(gh issue create --title "[STORY] Recomendações personalizadas com IA" --body-file "$STORY3_BODY_FILE" --label story --label ai --label backend --label "priority:medium")
echo "Story 3: $STORY3_URL"

echo "Criando Story 4 (Notificações)..."
STORY4_URL=$(gh issue create --title "[STORY] Notificações de pedido" --body-file "$STORY4_BODY_FILE" --label story --label backend --label frontend --label "priority:medium")
echo "Story 4: $STORY4_URL"

echo "Criando Docs..."
DOCS_URL=$(gh issue create --title "[DOCS] Documentação inicial: arquitetura, convenções e uso de IA" --body-file "$DOCS_BODY_FILE" --label docs --label "priority:medium")
echo "Docs: $DOCS_URL"

echo "Resumo:"
echo "EPIC: $EPIC_URL"
echo "STORY 1: $STORY1_URL"
echo "STORY 2: $STORY2_URL"
echo "STORY 3: $STORY3_URL"
echo "STORY 4: $STORY4_URL"
echo "DOCS: $DOCS_URL"

echo "Script finalizado. Revise as issues no GitHub." 

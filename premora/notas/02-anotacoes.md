# Premora — Anotações do Eduardo (parte 2)

> Nesta leva vieram de novo, iguais à parte 1: Destaque e Potencial, Status Pro Fase 1, Sistema de
> Classificação (2×), Comparador, Simulador, Comparador + Renda, Motor de Aluguel e Avaliação Inteligente
> Parte 1 (2×). Já estão em `01-anotacoes.md` e não foram duplicados. Abaixo, só o conteúdo NOVO.

---

## I. Parte 2 — Cálculo do Valor do Aluguel

Depende da Parte 1 (score 0–10, classificação, estrutura). Gera valor **recomendado (não obrigatório)**.

**Comparáveis de mercado:** mesma localização; mesmo tipo (casa ≠ apto, nunca misturar); metragem **±20%**;
quartos **±1**. Calcular média, **mediana** e nº de amostras. **Mínimo 5 comparáveis**; abaixo disso → aviso de baixa confiabilidade.

**Valor base:** média aluguel/m² × metragem; ou (preferível com dados suficientes) média direta dos comparáveis.

**Ajustes em cadeia:**
1. Fator score: 0–3 → **0,7** · 4–6 → **1,0** · 7–8 → **1,2** · 9–10 → **1,5**
2. Fator extras (ajuste fino, extras já pesam no score): **1,00 a 1,15**
3. Micro-localização (rua melhor/pior): **0,95 a 1,05**

**Faixa:** mínimo −10% · ideal · máximo +10%.
**Coerência:** > **+50%** da média → alerta; < **−30%** → alerta de subvalorização.
**Por tipo:** casa pesa mais metragem, terreno, extras externos; apto pesa localização, condomínio, padrão interno.
**Fluxo:** dados → comparáveis → média → base → score → extras → localização → valor → faixa → coerência.
**Saída:** valor recomendado, faixa, base de comparação, explicação, alertas.

---

## J. Avaliação de Imóvel Construído e em Uso (extensão da Parte 1)

Novos inputs:
- **Conservação** (obrigatório): Ruim / Regular / Bom / Muito bom / Excelente → fator **0,8 / 0,9 / 1,0 / 1,05 / 1,1**
  (também listado score base 2/4/6/8/10).
- **Idade:** 0–5 anos **1,1** · 6–15 **1,0** · 16–30 **0,9** · +30 **0,8**
- **Reforma recente:** sim → **×1,1**; não → ×1,0

Fotos agora detectam: pintura desgastada, rachaduras, mofo, móveis antigos, sinais de abandono.

**Fórmula:** `Score = (Fotos×0,45 + Loc×0,25 + Estr×0,15 + Extras×0,15) × conservação × idade × reforma`, limitado a 0–10.

**Validação IA × usuário:** conservação divergente (usuário "excelente", IA "ruim") → reduz fator automaticamente;
extras não vistos → reduz peso; luxo em bairro simples → penalização leve; simples em bairro nobre → ajuste moderado.
**Não bloqueia, só ajusta e alerta.** Explicação deve citar impacto de conservação, idade, reforma e extras.

**Caso de uso — botão "Ver valor estimado" no anúncio:** pré-preenche localização, m², quartos; usuário informa
conservação, extras, reforma; IA processa e mostra.

---

## K. Painel de Oportunidades Selecionadas (Pro)

Curadoria automática ("olheiros"). Diferente de "Imóveis em Destaque" (1–2 características) — aqui é análise completa e rigorosa.

**Abrangência:** Cidade · Estado · Nacional.

**Índice de Oportunidade Premora (0–100)** — cada indicador 0–100:
| Indicador | Peso |
|---|---|
| Preço vs média da região | 20% |
| Potencial de valorização | 20% |
| Retorno estimado com aluguel | 15% |
| Liquidez | 15% |
| Crescimento da região | 10% |
| Demanda de aluguel | 10% |
| Localização estratégica (escola, hospital, mercado, transporte…) | 5% |
| Estado/padrão do imóvel | 5% |

Exemplo: 95/90/88/82/85/91/80/78 → ≈ 88,3.

**Entrada obrigatória (as duas):** Índice **≥ 85** **e** nenhum crítico **< 65** (críticos: preço vs média,
valorização, retorno, liquidez).

**Classes:** 85–89 🟢 Oportunidade Selecionada · 90–94 🔥 Alta Oportunidade · 95–100 💎 Elite (deve ser raro).

Ranking decrescente; quantidade limitada (não mostrar todos ≥85). Mostrar funil: "1.247 analisados → 183 bons →
57 nos critérios → 23 selecionados". Card: foto, preço, local, índice, classe, indicadores, pontos positivos e de
atenção. **Transparência:** abrir e ver nota de cada indicador. Reaproveita todas as outras ferramentas.
**Princípio:** não vender o imóvel; encontrar pelos dados. "A Premora encontra as melhores oportunidades para você."

---

## L. "Encontre uma Estratégia para Mim" (Pro)

### Parte 1 — Oportunidade e estimativa de reforma
Busca imóveis com **potencial de transformação** (comprar pior, reformar, ganhar margem). Sempre estimativa, nunca promessa.

**Filtros do usuário:** região/cidade/estado/raio, valor máx., tipo, finalidade, reforma leve/média/pesada, investimento total máx.

Preço baixo sozinho não é oportunidade; checar se o desconto é explicado pelos problemas.

**Conservação:** Excelente → Bom → Regular → Ruim → Muito ruim (anunciante + fotos + IA + idade); declaração do usuário não é verdade absoluta.

**Problemas (seleção por categoria) e peso relativo de complexidade (não é R$):**
Pintura 1 · Piso/revestimento 2 · Portas e janelas 2 · Fachada 2 · Banheiro 3 · Cozinha 3 ·
Elétrica 4 · Hidráulica 4 · Telhado 4 · Estrutura 5.
Considerar quantidade/dimensão (nº banheiros, área de piso/pintura, portas, janelas…) — 70 m² ≠ 250 m².

**Fotos:** 2ª camada (infiltração, pisos, fachada, sinais estruturais). Sem conclusão confiável → "requer verificação profissional".
Combinar usuário + IA; sinalizar divergências.

**Custo regional:** mão de obra/materiais da região; sem dados → referência ampla + menor confiança. Nunca preço fixo nacional.

**Saída:** **faixa** (ex.: R$55–70 mil), nunca valor exato. Nível leve/média/pesada. Cenários Econômico / Padrão / Premium.
**Confiança** (ex.: 87%) conforme dados, fotos, dados regionais, consistência.
**Investimento inicial** = compra + reforma (depois: documentação, impostos, financiamento).
Só avança se houver potencial de margem.

### Parte 2 — Valor pós-reforma, margem e seleção
- **Investimento total:** compra + reforma + aquisição/documentação/impostos/financiamento (faixas).
- **Valor pós-reforma** por **comparáveis em bom estado**, não "compra + reforma". Cenários conservador / **provável** (referência) / otimista.
- **Margem** = valor provável − investimento total (R$ e %), % sobre o **investimento total**.
- **Margem mínima configurável**; abaixo → não seleciona.
- **Riscos:** baixa liquidez/demanda, localização ruim, reforma complexa, poucos comparáveis, baixa confiança,
  problema estrutural, excesso de oferta, reforma cara, dependência de valorização incerta.
- **Estratégias:** Reformar → Vender · Reformar → Alugar (aluguel, renda anual, retorno, payback, valorização) · Reformar → Manter.
  Tabela comparativa + estratégia recomendada com justificativa (sem dizer que é a melhor para todos).
- **Score 0–100** (margem, preço, reforma, valorização, liquidez, demanda, localização, confiança, risco, aluguel; financeiro e risco pesam mais).
  0–64 Não selecionada · 65–84 Moderada · 85–89 Selecionada · 90–94 Alta · 95–100 Elite.
  Seleção: **≥85** e nenhum crítico **<65**.
- Abrangência Regional / Estadual / Nacional.
- Card: score, preço, reforma, investimento, valor provável, margem, estratégia, confiança, "por que foi selecionado",
  pontos positivos/atenção. Fluxo visual: Imóvel → Problema → Solução → Investimento → Resultado.
- Confiança por resultado (reforma 87%, pós-reforma 82%, aluguel 91%); baixa confiança nunca vira recomendação agressiva.
- Recalcular quando o mercado mudar.
- Lema: "Não procure apenas um imóvel. Deixe a Premora procurar uma oportunidade."

---

## M. Painel do Proprietário e Gestão de Imóveis

Estrutura: **Proprietário → Prédio → Apartamento → Morador → Aluguel → Pagamento.**

- Cadastro de imóveis agrupados por prédio/condomínio; **cada prédio tem uma comunidade**.
- **Cadastro manual de morador:** nome, CPF, unidade, valor do aluguel, vencimento. Vínculo só ativa após o
  **morador confirmar** ("Você realmente deseja se registrar neste imóvel?"). Um CPF pode ter vários imóveis.
- **Comunicação:** morador individual · prédio · vários prédios · todos.
- **Condições especiais** (ex.: 10% desconto) para morador/apto/prédio/vários/todos; respeitar contrato.
- **Cobrança:** avisos de vencimento; status 🟢 Pago · 🟡 Pendente · 🔴 Em atraso; pagamento quando o sistema existir.
- **Cobrança manual** (multa, desconto, ajuste) com **motivo obrigatório** (valor original, novo valor, motivo).
- **Histórico financeiro:** original, cobrado, motivo, data, vencimento, status, atraso. Permissões de acesso.
- **Desvincular morador** sem apagar histórico.
- Categorias futuras: Proprietário · Multi-imóveis (≥2 ativos) · Gestor imobiliário.
- Visão geral: nº aptos/alugados/disponíveis, moradores ativos, pagos/pendentes/atraso, comunidades.
- Objetivo: a Premora continua útil depois que o imóvel foi alugado.

---

## N. Avaliações de Imóveis/Anúncios

- 1–5 estrelas; média automática + nº de avaliações (ex.: ⭐ 4,6 | 22 avaliações).
- **Comentário obrigatório, mín. 5 caracteres, sem máximo.** Fotos opcionais, com moderação automática.
- **Só avalia quem teve interação real** (ex.: pagamento de aluguel confirmado abre janela).
- **Janelas não acumulam** (expira se não usar). Várias avaliações ao longo do tempo são permitidas e contam na média.
- Votos "👍 útil" (só contagem, não vira nota).
- **Direito de resposta** público do anunciante; anunciante não apaga avaliação negativa.
- **Denúncia** (falsa, ofensiva, ameaça, obscena, dados pessoais, manipulação, fora de contexto) — não apaga automaticamente; análise.
- Moderação automática como 1ª camada.
- Selo **⚡ Responde rapidamente**: média de resposta **≤ 10 min** em período recente; perde se passar.
- **Negócios concluídos** como informação complementar.
- Nesta fase só avaliação do **anúncio**; avaliação de pessoa é sistema separado.

---

## O. Reputação do Usuário

### Parte 1 — Perfil e cálculo
Reputação automática por comportamento real (não nota manual). Perfil: foto, nome, bio, nota, nº avaliações,
negócios concluídos, indicadores, selo, imóveis anunciados, alertas. Telefone opcional; **CPF interno, nunca público**.

**Proprietário/anunciante:**
| Critério | Peso |
|---|---|
| Média das avaliações dos anúncios | 40% |
| Pagamentos recebidos em dia | 20% |
| Responde rapidamente | 15% |
| Negócios/contratos concluídos | 10% |
| Denúncias válidas | 10% |
| Confiabilidade do cadastro/histórico | 5% |

**Inquilino:**
| Critério | Peso |
|---|---|
| Pagamentos em dia | 45% |
| Contratos concluídos corretamente | 20% |
| Regularidade dos pagamentos | 15% |
| Denúncias válidas | 10% |
| Histórico de contratos | 10% |

Usuário novo: "Novo usuário — histórico insuficiente" (não começa com 5 estrelas). Nota dinâmica, evolução gradual.
Separar avaliação do anúncio × reputação da pessoa.

### Parte 2 — Denúncias
- ID interno + CPF único (evita contas duplicadas).
- Denúncia exige **motivo + justificativa ≥ 15 caracteres**.
- IA faz triagem (coerência, relação com o motivo, não é texto aleatório); casos complexos → análise posterior.
- **5 denúncias válidas do mesmo motivo = 1 ocorrência validada** (regra oculta).
- **Janela móvel de 30 dias.**
- **A cada 3 ocorrências válidas: −0,10 na nota** (linear); nota com piso mínimo.
- Alertas públicos (últimos 30 dias): 0–6 nenhum · 7–13 amarelo · 14–20 laranja · 21+ forte. Linguagem neutra; denúncia ≠ culpa.
- Reincidência grave: restringe **novos anúncios**, sem bloquear conta (continua gerindo contratos, recebendo, conversando).
- Detectar padrões anormais (denúncias combinadas).

---

## P. Notificações Inteligentes

Regra: só interromper quando for realmente útil. "Melhor deixar de enviar do que incomodar."

- Analisa relevância, perfil, salvos, buscas, faixa de preço, local, quartos, tipo, comportamento, frequência recente.
- **Novo imóvel compatível:** índice de compatibilidade **≥ 80%** (ajustável).
- **Busca personalizada:** "Encontramos 3 imóveis que podem interessar a você."
- **Oportunidade detectada:** usa os sistemas de oportunidade; com moderação.
- **Preço de imóvel salvo** alterado significativamente (limite mínimo); indisponível/disponível de novo; condições alteradas.
- **Aluguel:** só **7 dias antes** e **1 dia antes**. Lembrete extra só manual pelo proprietário.
- **Interações no anúncio:** agrupadas, janela mínima **~3 dias**, só se relevante.
- **Nova avaliação:** prioridade alta, agrupar se muitas.
- Prioridades: Alta (aluguel, mudança importante em salvo, oportunidade relevante, avaliação, críticas de contrato) ·
  Média (compatível, busca personalizada, oportunidade interessante) · Baixa (movimentação, visualizações, salvamentos).
- **Antispam:** não acumular, não repetir, agrupar, intervalos mínimos; vencimento de aluguel não é bloqueado pelo limite.
- Mensagem personalizada e curta ("o que aconteceu + por que interessa"). Toque leva direto à ação.
- Meta: "Quando a Premora me manda notificação, vale a pena conferir."

# Premora — Anotações do Eduardo (parte 1)

> Registro fiel das anotações enviadas. Removidos apenas trechos de conversa com chatbot
> ("me fala qual você quer", notas tipo "9.8/10") e a repetição da "Parte 1 — Avaliação
> Inteligente", que veio colada 3 vezes (mantida uma vez). Nenhuma regra ou número foi alterado.

---

## A. Ideias de impacto (pitch / edital)

1. **Aluguel aprovado em 5 minutos** — sem fiador, sem papelada, análise automática. "Entrou → aprovou → alugou".
2. **Match inteligente (estilo Uber)** — usuário informa quanto pode pagar + localização; o app mostra as melhores opções automaticamente. "Não é você que procura, o app acha pra você."
3. **Contrato automático e simplificado** — tudo digital, sem cartório, dentro do app.
4. **Foco em público ignorado** — jovens 18–25, pessoas sem renda comprovada, interior (ex.: ES, cidades pequenas).
5. **Garantia alternativa** — sem fiador, sem caução alta; assinatura mensal tipo seguro; análise de comportamento.
6. **Aluguel imediato (tipo iFood)** — casa disponível agora, entra hoje, paga depois.

---

## B. Sistema de Destaque e Potencial

**Objetivo:** destacar automaticamente os imóveis mais relevantes, com transparência.
**Conceito:** "A Premora não mostra todos os imóveis. Mostra apenas os que realmente valem a sua atenção."

**Critérios:** (1) preço vs média da região (%); (2) potencial de valorização.

**Preço vs média:**
- 🟢 "X% abaixo da média da região" / 🔴 "X% acima da média da região"
- Margem de destaque: **≥17% abaixo** → destaque positivo; **≥17% acima** → destaque negativo.

**Status de potencial:** 🚀 Alto · 📈 Bom · ➖ Estável · ⚠️ Baixo · ❌ Sem potencial.

**Regras da aba "Imóveis em Destaque":**
| Caso | Condição | Exibe |
|---|---|---|
| 🔥 Imóvel estrela | Alto potencial **e** preço abaixo da média | os 2 pontos positivos |
| 👍 Um destaque | **ou** preço abaixo **ou** alto potencial | só o fator mais relevante (resto ao clicar) |
| ⚠️ Extremo negativo | Preço acima **e** baixo potencial | os 2 pontos negativos |
| ❌ Não entra | Preço na média, potencial estável, ou conflito (preço bom + potencial ruim) | — |

A IA decide se merece destaque, qual informação é mais relevante e quantas mostrar.

---

## C. Premora Pro — Painel do Investidor (assinatura)

- Público: investidor / corretor. Plano mensal **R$29–R$79**, teste grátis **7 dias**.
- Separação: usuário comum → simplicidade; investidor → profundidade.
- Regra: "mais dados **relevantes**", não "mais dados". **Não incluir:** clima, temperatura, relevo.

**Blocos do painel:**
1. Análise de investimento — retorno estimado (aluguel), valorização projetada (3–5 anos), tempo médio de retorno.
2. Score inteligente — Nota Premora (ex.: 8,9/10).
3. Análise da região — crescimento, novos empreendimentos, valorização histórica.
4. Riscos — desvalorização, baixa liquidez, região saturada (diferencial de confiança).
5. Estratégias sugeridas — "Ideal para aluguel de longo prazo", "Bom para revenda", "Não recomendado".

**Status da Fase 1 (definições):**
- 💰 **Retorno estimado (aluguel)** — valor do imóvel × aluguel médio da região. Ex.: "0,7% ao mês (8,4% ao ano)".
- 📈 **Valorização projetada** — histórico, crescimento urbano, demanda. Ex.: "+18% em 5 anos".
- ⏱️ **Tempo médio de retorno** — aluguel + valorização. Ex.: "9 anos".
- 📊 **Liquidez** — demanda, tipo de imóvel, histórico de vendas. Ex.: "Alta liquidez".
- 🏙️ **Crescimento da região** — comércios, construções, expansão. Ex.: "Crescimento acelerado".
- 💸 **Preço vs média (versão investidor)** — ex.: "17% abaixo da média".
- 🎯 **Score geral** — ex.: "Nota Premora 8,6/10".

---

## D. Sistema de Classificação (Score de investimento 0–10)

**Pesos:** Retorno 25% · Valorização 25% · Crescimento da região 20% · Liquidez 15% · Preço vs média 15%.

**Tabelas de nota (0–10):**
- Retorno anual: >10% → 10 · 8–10% → 8 · 6–8% → 6 · 4–6% → 4 · <4% → 2
- Valorização 5 anos: >25% → 10 · 15–25% → 8 · 10–15% → 6 · 5–10% → 4 · <5% → 2
- Região: alto crescimento 10 · moderado 7 · estável 5 · fraco 3 · em queda 1
- Liquidez: muito alta 10 · alta 8 · média 5 · baixa 3 · muito baixa 1
- Preço vs média: ≥20% abaixo 10 · 10–20% abaixo 8 · na média 5 · 10–20% acima 3 · ≥20% acima 1

**Fórmula:** `Score = R×0,25 + V×0,25 + Reg×0,20 + L×0,15 + P×0,15`

**Classificação:** 9–10 🚀 Alto potencial · 7,5–8,9 Bom · 5,5–7,4 Estável · 3,5–5,4 Baixo · 0–3,4 Sem potencial.

**Exemplo:** R8, V7, Reg9, L6, P8 → 2,0+1,75+1,8+0,9+1,2 = **7,65 → Bom potencial**.

---

## E. Comparador de Imóveis (investidor)

- Topo: Imóvel A (esq.) e B (dir.) com foto, preço, localização.
- Tabela: `Critério | A | Diferença | B` — vencedor (+), perdedor (−).
- **Pesos do comparador:** Retorno 25% · Valorização 25% · Região 20% · Liquidez 15% · Preço vs média **10%** · **Risco 5%**.
- Cálculo: diferença por critério × peso, soma → ex.: A +0,90 / B −0,90 → 🥇 A.
- **Insights da IA** dão contexto: ex.: "B tem melhor infraestrutura (escolas, comércio), pode ser melhor para moradia/família".

**Camada 2 — "Comparar renda estimada" (botão, 1 clique):**
- Simulação automática nos dois imóveis com **cenário padrão** (entrada fixa, parâmetros médios).
- Dados automáticos: valor, localização, aluguel médio da região, valorização.
- Complementares (se faltar): quartos, vagas (futuro: metragem, padrão).
- Saída: renda mensal de cada um, diferença ("+R$500/mês a favor de A"), projeção (ex.: 5 anos), frase da IA.
- Diferença p/ simulador completo: rápido/automático vs detalhado/configurável.

**Ideia dita em áudio (complemento ao comparador):** considerar distância/proximidade de comércio, escola,
hospital etc. como ponto positivo; usuário escolhe se prefere algo **mais afastado ou mais perto do centro**;
no final a IA julga qual é melhor para aquela pessoa.

---

## F. Simulador de Investimento

**Inputs:** valor do imóvel, entrada; financiamento opcional (juros anual %, prazo anos) — se desligado, à vista;
complementares editáveis/automáticos: aluguel mensal, valorização anual %, condomínio, IPTU, manutenção (opcional).

**Cálculos:**
- Valor financiado = imóvel − entrada
- Parcela = PRICE ou SAC (decisão técnica)
- Custo mensal = parcela + condomínio + IPTU + manutenção
- Fluxo mensal = aluguel − custos; retorno anual = fluxo × 12
- Valor futuro = valor × (1 + taxa)^anos
- Retorno total = aluguéis acumulados + valorização
- Payback = tempo p/ recuperar o investido (principalmente a entrada); regra de incluir valorização a definir

**Saídas:** fluxo mensal, retorno anual, retorno acumulado; marcos 1/5/10 anos (ou personalizável); payback;
gráfico de linha (patrimônio + lucro acumulado); resumo da IA ("fluxo positivo", "retorno no médio prazo"...).

**Comportamento:** tempo real, sliders, recálculo automático; não travar usuário; validar (entrada ≤ valor); com/sem financiamento.

---

## G. Motor de Estimativa de Aluguel

- Sempre parte do **aluguel médio por m² da região**, separado por tipo (**casa ≠ apartamento**, nunca misturar).
- Inputs (imóvel a construir): bairro/cidade, m², quartos, banheiros, vagas, **padrão** (econômico/médio/alto/luxo).
- Etapas: base/m² × m² → ajustes (quartos ↑, banheiros ↑ leve, garagem ↑ relevante) → multiplicador de padrão:
  econômico **−10%** · médio **0%** · alto **+15%** · luxo **+30%**.
- Ajustes IA: proximidade de pontos importantes, valorização, demanda.
- Saída: valor estimado (ex.: R$2.400), **faixa** (R$2.200–2.600), explicação simples.
- Futuro (imóvel existente): conservação, idade, acabamento real. Permitir ajuste manual.
- Alimenta: simulador, comparador, comparação de renda.

---

## H. Parte 1 — Avaliação Inteligente do Imóvel (padrão do imóvel)

**Objetivo:** avaliar padrão (econômico → luxo), score 0–10, validar contra o que o usuário informou, base para o aluguel (Parte 2).

**Inputs:** fotos (mín. recomendado 5: fachada, sala, cozinha, quartos, banheiro, área externa); localização
(cidade, bairro, coordenadas opcional); estrutura (m², quartos, banheiros, vagas); extras (checkbox + quantidade, sem texto livre).

**Fórmula:** `Score = Fotos×0,45 + Localização×0,25 + Estrutura×0,15 + Extras×0,15`

- **Fotos (45%)** — acabamento 20%, modernidade 10%, conservação 10%, percepção visual 5%.
  Observar piso, paredes, materiais; banheiro (box, revestimento); cozinha (planejada, ilha); quartos; área externa/lazer.
- **Localização (25%)** — padrão do bairro 15%, valorização 5%, coerência com o imóvel 5% (luxo em área simples → penalização leve).
- **Estrutura (15%)** — metragem 5%, quartos 4%, banheiros 3%, vagas 3% (não define luxo sozinha).
- **Extras (15%)**:
  | Extra | Peso base | Multiplicador |
  |---|---|---|
  | Piscina | +2,0 | +0,5 por unidade |
  | Hidromassagem | +1,5 | +0,3 |
  | Área gourmet | +1,5 | fixo |
  | Churrasqueira | +1,0 | +0,2 |
  | Quadra de tênis | +3,0 | fixo |
  | Academia | +2,0 | fixo |
  | Cinema | +2,5 | fixo |
  - Teto 10, normalizar para 0–10.
  - Extra confirmado nas fotos → peso total; não confirmado → **−40%**.
  - Multiplicador por bairro: simples 0,8× · médio 1,0× · nobre 1,2×.

**Consistência IA × usuário:** concordância → segue; pequena divergência → sugere ("aparenta médio-alto");
grande → alerta ("padrão inferior ao informado, deseja ajustar?"). **Usuário sempre pode manter a escolha.**

**Classificação:** 0–3 Econômico · 4–6 Médio · 7–8 Alto padrão · 9–10 Luxo.

**Explicabilidade obrigatória:** ex.: "Classificado como médio com base no acabamento das fotos e na média da região."

**Saída:** score, classificação, comparação com input, justificativa.

---
_Aguardando próximas partes (ex.: Parte 2 — cálculo do aluguel conectado à avaliação)._

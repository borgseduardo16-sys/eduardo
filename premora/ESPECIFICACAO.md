# Premora — Especificação v1 (documento mestre)

> **Fonte única da verdade para construir a Premora.**
> Ordem de prioridade quando algo conflitar: `DECISOES.md` > **este documento** > relatórios > `notas/`.
> Itens marcados **[PENDENTE]** ainda precisam de decisão do Eduardo. Itens marcados **[PROPOSTA]** são
> sugestões técnicas que valem até alguém mudar.

---

## 1. O que é a Premora

Marketplace de **aluguel residencial** (casas e apartamentos) com inteligência para decidir melhor e
**segurança como marca**. Três públicos, um app:

| Público | O que faz na Premora | Por que paga |
|---|---|---|
| **Inquilino** | Busca, compara, visita, aluga, paga, avalia | Taxa de 2% no aluguel; Premium opcional |
| **Proprietário** | Anuncia, encontra e cadastra moradores, cobra, acompanha | Taxa de 2% no recebimento; **anúncios patrocinados** (principal receita); Premium |
| **Investidor** | Analisa imóveis, simula, encontra oportunidades | Painel do Investidor (avulso R$ 69,90 ou no Premium) |

**Posicionamento:** "Na Premora você só paga de verdade quando tiver as chaves na mão. Todo anunciante é
verificado." Nunca dizer "100% seguro" (decisão #12).

**Princípios de produto**
1. **Simples para usar:** poucas opções por tela; quem não quer profundidade nunca a vê.
2. **Transparente:** mostra o lado bom e o ruim; toda nota tem explicação ao tocar.
3. **Seletivo:** mostra o que vale a atenção; notificação só quando importa.
4. **Honesto com dinheiro pago:** anúncio pago é identificado e nunca bagunça a busca.

**Fora do escopo:** espaços (garagem, vaga, galpão, balcão) — decisão #1. Feed de vídeos.

**Lançamento:** Colatina e região (decisão #20).

---

## 2. Regras técnicas inegociáveis (herdadas do MyPlace)

1. Dinheiro sempre em **centavos inteiros**; nunca `float`.
2. **O navegador nunca envia preço.** Envia o id; o servidor calcula; o banco confere com `CHECK`.
3. **Nada finge funcionar.** Sem credencial real, a função mostra erro claro. Nunca dado de exemplo que pareça real.
4. **Autorização na camada de dados**, não só na tela/middleware.
5. Segredo nunca vai para o navegador.
6. **Endereço exato é privado** até a locação estar ativa. Fotos têm o GPS (EXIF) removido.
7. **Regra de negócio importante vira trava no banco** (constraint/gatilho).
8. **Configurações de negócio** (taxas, mínimos, prazos, pesos) ficam em `platform_settings`: mudar = um comando,
   sem reprogramar; toda mudança é auditada.
9. **[PROPOSTA]** Toda nota/estimativa da IA tem **nível de confiança**; abaixo do mínimo, mostra
   "dados insuficientes nesta região" em vez de inventar.

**Stack** (do MyPlace, decisão #18): Next.js + Supabase (Postgres + PostGIS, Auth, Storage) + Drizzle +
Asaas (pagamentos) + Resend (e-mail) + Twilio Verify (SMS) + Web Push + MapLibre + Claude (IA) + Sentry +
Upstash (limites) + Vercel. App web instalável (PWA) primeiro; lojas Apple/Google depois.

---

## 3. Contas, perfis e verificação

- **Uma pessoa (CPF) pode ter várias contas** (e-mails diferentes), cada uma com seu Premium (decisão #17).
- Banimento por golpe vale para **todas** as contas do CPF. Avaliações/locações entre contas do mesmo CPF
  (ou ligadas por telefone, aparelho ou conta bancária) **não contam** para reputação.
- Login por e-mail ou Google; verificação em duas etapas disponível; aviso de acesso em aparelho novo.
- **Verificação obrigatória:**

| Quem | Quando | O quê |
|---|---|---|
| Todos | Para conversar/propor | E-mail + telefone (SMS) |
| Anunciante | Antes de publicar | Documento com foto + **selfie com prova de vida** + CPF conferido com o nome |
| Anunciante | Por imóvel | **Prova de que pode alugar:** matrícula, IPTU ou conta de consumo no nome; corretor com CRECI; administrador com procuração |
| Inquilino | Antes de pagar | Documento + selfie |

- **Trocar a conta de recebimento** exige nova selfie + espera de 48 h + aviso por e-mail e SMS.
- **Perfil público:** nome de exibição, foto, bio, membro desde, **sinais de confiança** (seção 15),
  imóveis anunciados. Nunca CPF, telefone, e-mail ou contagem de denúncias.

---

## 4. Dinheiro: taxas, Premium e anúncios

### 4.1 Taxas do aluguel (decisão #2)
- **2% do inquilino** (somado ao aluguel) + **2% do proprietário** (descontado do repasse).
- Exemplo R$ 1.500: inquilino paga R$ 1.530; proprietário recebe R$ 1.470; Premora R$ 60 (menos tarifa do Pix).
- Taxa **congelada no contrato**; mudança de taxa da plataforma não afeta contrato vigente.
- Premium: **50% de desconto na taxa de quem assina** (2% → 1%) — decisão #13. A taxa **segue o Premium**
  (perdeu → volta a 2% nas próximas mensalidades).
  **[PENDENTE]** confirmar que vale também para o inquilino Premium (a simulação assumiu que sim).
- **Pix e Pix Automático** são o padrão, sem acréscimo (decisão #15).
- **Cartão com acréscimo** para cobrir o custo (Lei 13.455/2017) — sem isso, Premium + cartão dá prejuízo
  (ver `SIMULACAO-PREMIUM.md`). **[PENDENTE]** percentual do acréscimo.
- **A Premora só ganha no 1º pagamento quando ele é liberado ao proprietário** (seção 11). Se houver problema,
  o inquilino recebe **100% de volta, taxas incluídas** (decisão #11).
- ⚖️ Levar ao advogado: taxa cobrada do inquilino (Lei do Inquilinato, art. 22, VII).

### 4.2 Premium — R$ 119,90/mês (decisões #10, #13, #17)
| Para quem | Benefício |
|---|---|
| Proprietário/investidor | **Painel do Investidor** + **R$ 50/mês em créditos de anúncio** (bancados pela plataforma) + 50% na taxa |
| Inquilino | **Painel comparador de imóveis** (completo) + 50% na taxa **[PENDENTE confirmar]** |
| Todos | Selo discreto "Membro Premium" (benefício comercial, não sinal de confiança) |

Regras (do MyPlace):
- Premium = **ciclo pago cobrindo agora**. Cancelar = não renovar; vale até o fim do período pago, sem reembolso proporcional.
- Tolerância de renovação: 24 h; recorrência cancelada após 3 dias sem pagamento.
- Benefícios (créditos e desconto) só liberam após o pagamento **compensado** (carência no cartão) — trava contra estorno.
- Créditos-bônus: **gastos antes** do saldo pago, **expiram no fim do ciclo**, **nunca** viram dinheiro.
- Painel do Investidor também vendido **avulso por R$ 69,90/mês**.
- Estrutura flexível: benefícios novos entram por configuração.

### 4.3 Anúncios patrocinados — principal receita (decisões #4–#9, #14)
- **Créditos pré-pagos:** recarga mínima **R$ 10**, taxa de **2% sobre a recarga**, pagamento por Pix (cartão com acréscimo).
- O proprietário cria **campanhas** por imóvel e distribui o saldo; define **orçamento diário (mín. R$ 5)** e,
  se quiser, data de fim.
- **Cobrança por clique** (pessoa que abriu o anúncio). Orçamento diário é o **máximo**, não cobrança fixa.
- **Leilão [PROPOSTA]:** posição = **lance × relevância** (compatibilidade com quem vê + qualidade do anúncio);
  **2º preço** (paga um centavo a mais que o próximo); **lance mínimo** configurável; gasto **espalhado no dia**.
- **Região:** o anúncio disputa na **cidade do imóvel + vizinhas** (**[PROPOSTA]** raio de 50 km, configurável);
  quem vê é definido pela **cidade que está buscando**, não só pelo GPS.
- **Cliques válidos:** 1 por pessoa por anúncio por dia; só usuário logado; dono não conta; filtro de robôs.
- **Para sozinho quando:** saldo acaba, data de fim, anúncio pausado/removido, ou **imóvel lotado**
  (opção ligada por padrão; o proprietário pode desligar para formar lista de espera). Explicado com clareza.
- **Painel do anúncio:** visualizações, cliques, mensagens, salvos, visitas agendadas, gasto, **custo por contato**, saldo.
  Sugestão de aumentar o orçamento **só quando for verdade** (ex.: "seu orçamento acabou às 14h").
- Selo **"Patrocinado"** sempre visível (CDC).
- Destaque/Turbo de pacote fixo **não existem mais**.

---

## 5. Anúncio do imóvel

**Campos:** tipo (casa, apartamento, kitnet/studio, sobrado, cobertura **[PROPOSTA]**), título, descrição,
aluguel, condomínio, IPTU, m², quartos, suítes, banheiros, vagas, andar/elevador (apto), mobiliado, aceita pet,
**número de unidades** (casa = 1; prédio/kitnets = várias), endereço (privado), bairro, cidade, CEP, coordenadas,
extras em checkbox + quantidade (piscina, área gourmet, churrasqueira, academia, quadra, portaria 24h, lazer…),
idade aproximada, conservação, reforma recente.

**Fotos:** mínimo recomendado 5 (fachada, sala, cozinha, quartos, banheiro, área externa); GPS removido;
**fotos tiradas pelo app ganham selo**; detector de foto copiada (outros anúncios + internet).

**Vídeo de verificação:** gravado **pelo app** dentro do imóvel, com localização conferida com o endereço.

**Publicação:** passa por checagens automáticas (preço muito abaixo da média → revisão humana;
conta nova → revisão nas primeiras semanas).

**Localização pública:** bairro + cidade + ponto aproximado (deslocado). Rua e número só após locação ativa.

---

## 6. Nota do Imóvel (padrão e qualidade) — [PROPOSTA] unificada

Escala interna **0–100**; na tela, rótulo + explicação.

```
Base = Fotos×0,45 + Localização×0,25 + Estrutura×0,15 + Extras×0,15      (cada pilar 0–100)
Nota = mín(100, Base × fator_idade)
```

- **Fotos (IA de visão):** acabamento 20, modernidade 10, **conservação** 10, percepção visual 5 (pesos internos
  normalizados para 0–100). Detecta pintura gasta, rachadura, mofo, infiltração. A conservação informada pelo
  usuário é comparada com a da IA (conta **só aqui**, não vira multiplicador extra).
- **Localização:** padrão do bairro 15, valorização 5, coerência com o imóvel 5.
- **Estrutura:** m² 5, quartos 4, banheiros 3, vagas 3.
- **Extras:** soma dos pesos (piscina 2,0 +0,5/un.; hidro 1,5 +0,3; gourmet 1,5; churrasqueira 1,0 +0,2;
  quadra 3,0; academia 2,0; cinema 2,5) → normaliza com teto; extra **não visto nas fotos vale 60%**;
  multiplicador do bairro: simples 0,8 · médio 1,0 · nobre 1,2.
- **fator_idade:** 0–5 anos 1,1 · 6–15 1,0 · 16–30 0,9 · +30 0,8. **Reforma recente** eleva o fator para 1,0 se for menor.
- **Classes:** < 35 Econômico · 35–64 Médio · 65–84 Alto padrão · ≥ 85 Luxo.
- **Consistência IA × usuário:** concordância segue; pequena diferença sugere ("aparenta médio-alto");
  grande diferença alerta. **O usuário sempre pode manter a escolha.**
- **Explicação obrigatória** citando o que mais pesou (fotos, idade, extras, bairro).

---

## 7. Estimativa de aluguel — [PROPOSTA] unificada

1. **Comparáveis:** mesmo tipo (**casa ≠ apartamento, nunca misturar**), mesmo bairro (se faltar, cidade),
   m² ±20%, quartos ±1. Usar **mediana**. **Mínimo 5**; abaixo disso usa R$/m² mediano × m² e baixa a confiança.
2. **Ajuste por padrão** (relativo à média dos comparáveis): Econômico 0,85 · Médio 1,00 · Alto 1,15 · Luxo 1,30.
3. **Micro-localização:** 0,95 a 1,05.
4. **Saída:** valor ideal + faixa (−10% / +10%) + base de comparação ("12 imóveis parecidos no bairro") +
   explicação + confiança.
5. **Alertas:** valor pedido > +50% da média ou < −30%.
6. Casa pesa mais terreno/área externa; apto pesa mais localização/condomínio.
7. Botão **"Ver valor estimado"** no anúncio e **"Quanto vale o aluguel do meu imóvel?"** grátis para proprietários.

> Extras **não** aplicam fator extra no aluguel: já estão na Nota do Imóvel (evita contar duas vezes).

---

## 8. Selos de preço e potencial ("Selo Premora")

Selos automáticos no card do imóvel (nome antigo "Imóveis em Destaque" da IA; renomeado para não confundir
com anúncio pago):

- **Preço vs média:** "🟢 X% abaixo da média da região" / "🔴 X% acima". Vira selo a partir de **17%**.
- **Potencial de valorização** (só valorização + crescimento da região, **sem** preço):
  🚀 Alto · 📈 Bom · ➖ Estável · ⚠️ Baixo · ❌ Sem potencial.
- **Regras de exibição:** estrela (alto potencial + abaixo da média) → 2 selos positivos; um ponto forte → 1 selo;
  extremo negativo (acima + baixo potencial) → 2 selos negativos; médio ou conflito → nenhum selo.
- Só aparece com confiança mínima nos dados.

---

## 9. Descoberta: home, busca, mapa, recomendações

**Home (layout final depois — decisão #7):** fileiras horizontais (Casas, Apartamentos, Perto de você,
Recomendados…), cada uma com "Ver mais"; **2 anúncios patrocinados no começo de cada fileira**.

**"Recomendações selecionadas pela Premora":** ordenadas **só por compatibilidade**; pagamento não influencia
(selo "Patrocinado" pode aparecer, mas não muda a ordem).

**Perfil "o que você procura" [PROPOSTA]:** 3 perguntas no primeiro acesso — quanto pode pagar; onde trabalha/estuda;
prefere centro ou lugar tranquilo. Depois, o perfil se ajusta pelo comportamento (vistos, salvos, buscas).

**Compatibilidade "X% compatível"** (fórmula do MyPlace, critérios residenciais): só conta o que a pessoa informou;
100% só se tudo bate; explicação por critério ("não consta no anúncio" ≠ "não tem").
Critérios: localização 30 · preço 20 · tipo 15 · quartos 15 · características 10 · vagas 5 · área 5 **[PROPOSTA]**.

**Busca:** por GPS ("perto de mim"), CEP, cidade, bairro, texto. **Filtros:** tipo, preço total (aluguel +
condomínio + IPTU), quartos, banheiros, vagas, m², mobiliado, pet, características, distância.
**Ordenação:** relevância, mais próximos, menor/maior preço, mais recentes. **Mapa** (MapLibre) com marcadores
aproximados. Estados de vazio, carregando e erro.

**Página do imóvel:** galeria, dados, **custo mensal real** (aluguel + condomínio + IPTU + estimativa de contas),
selos, Nota do Imóvel, valor estimado, localização aproximada + **o que tem perto** (escola, hospital, mercado,
transporte), anunciante com sinais de confiança, avaliações, favoritar, compartilhar, **agendar visita**, conversar.

**Alertas de busca** e **favoritos com aviso de preço** (do MyPlace).

---

## 10. Comparador

Um comparador, **dois modos**:

| Modo | Compara |
|---|---|
| **Para morar** | Custo mensal real, tempo até o trabalho/faculdade, distância de escola/hospital/mercado/transporte, Nota do Imóvel, segurança do anúncio (verificações), perfil centro × tranquilo |
| **Para investir** | Retorno, valorização, crescimento da região, liquidez, preço vs média, risco (mesmos indicadores da Nota Premora) + botão **"Comparar renda estimada"** (simulação automática com cenário padrão) |

- Tabela lado a lado com diferença (+/−) e **veredito da IA conforme o perfil** da pessoa, com ressalvas
  ("A ganha no custo; B fica 10 min mais perto do seu trabalho").
- **[PENDENTE]** O que é grátis e o que é Premium. Sugestão: **2 imóveis no modo "Para morar" grátis**;
  painel completo (mais imóveis, comparações salvas, modo investir, veredito detalhado) no Premium.

---

## 11. Locação (do pedido ao contrato)

```
Proposta → Aceite (24 h) → Contrato digital assinado → Pagamento retido → Entrega das chaves
→ Janela de 72 h → Liberação → Meses seguintes (Pix Automático, split)
```

- **Visita agendada pelo app antes de qualquer pagamento** (recomendada sempre; destacada se a outra parte
  não tem histórico ou está em revisão). A Premora **nunca** pede sinal.
- **Contrato digital** com assinatura eletrônica (parceiro): prazo (padrão 30 meses), valor, reajuste anual
  (IGP-M/IPCA), multa proporcional por saída antecipada, aviso prévio de 30 dias, quem paga condomínio/IPTU.
- **Pagamento retido** (decisão #11, fluxo em `ANUNCIOS-E-SEGURANCA.md` Parte 3):
  - pode pagar antecipado para reservar; dinheiro fica retido até a entrada;
  - proprietário marca "Chaves entregues"; inquilino tem **72 h**: ✅ tudo certo (libera) / ⚠️ tenho um problema
    (fica retido, análise com provas) / sem resposta → **libera ao proprietário** (avisos em 24 h e 2 h).
    **[PENDENTE]** revisar esta regra mais à frente (decisão #16);
  - problema confirmado → 100% devolvido, taxas incluídas.
- **[PENDENTE]** Política de cancelamento de reserva antes da entrada.
- **Vistoria digital** de entrada e saída (fotos com data, assinadas pelos dois).
- **Meses seguintes:** cobrança recorrente com split; Pix Automático por padrão; reajuste aplicado no aniversário.
- **Garantia locatícia:** **[PENDENTE]** seguro-fiança via parceiro (recomendado) × caução (até 3 meses, em poupança,
  uma garantia só por contrato — art. 37/38).
- ⚖️ Advogado: pagamento antecipado (art. 20) — aqui o dinheiro fica retido e não vai ao locador antes da entrada.

---

## 12. Painel do Proprietário

Estrutura: **Proprietário → Prédio/Condomínio → Unidade → Morador → Aluguel → Pagamento.**

- Cadastro de imóveis agrupados por prédio; visão geral (unidades, ocupadas, livres; pagos/pendentes/atrasados).
- **Moradores que já existem fora do app:** proprietário cadastra (nome, CPF, unidade, valor, vencimento);
  morador **confirma** o vínculo ("Você deseja se registrar neste imóvel?"). Alavanca de crescimento.
- **Avisos** para um morador, um prédio, vários prédios ou todos (comunidades de prédio: depois).
- **Condições especiais** (ex.: 10% de desconto) por morador/unidade/prédio, respeitando o contrato.
- **Cobrança:** status 🟢 Pago · 🟡 Pendente · 🔴 Atrasado; **cobrança manual com motivo obrigatório**
  (valor original, novo valor, motivo); histórico financeiro imutável; desvincular morador sem apagar histórico.
- **Chamados de manutenção** com foto **[PROPOSTA]**.
- **Campanhas de anúncio** e créditos (seção 4.3).

---

## 13. Avaliações de anúncio

- 1–5 estrelas + **comentário obrigatório (mín. 5 caracteres, sem máximo)** + fotos opcionais (moderadas).
- Só com **experiência real**: cada pagamento confirmado abre **uma janela** de avaliação; janelas **não acumulam**.
- Avaliações ao longo do contrato são permitidas, mas a **média conta só a mais recente de cada pessoa**
  ("4,6 · 22 avaliações de 6 moradores"); histórico completo visível.
- Avaliação final dos dois lados ao encerrar a locação (do MyPlace).
- Votos "👍 útil" (só contagem). **Direito de resposta** público do anunciante; ele não apaga avaliação.
- Denúncia de avaliação → análise (não apaga automaticamente).

---

## 14. Notificações

- **Governador anti-spam** (do MyPlace): não acumula, agrupa num aviso só, intervalos mínimos, categorias que a
  pessoa desliga, push + e-mail + no app. "Melhor deixar de enviar do que incomodar."
- **Aluguel:** só **7 dias antes** e **1 dia antes** (+ lembrete manual do proprietário). Não é bloqueado pelo limite.
- **Imóvel compatível:** compatibilidade **≥ 80%**; vários juntos → "Encontramos 3 imóveis para você".
- **Imóvel salvo:** queda relevante de preço, ficou indisponível/disponível.
- **Oportunidade detectada** (Pro): com moderação.
- **Interações no anúncio:** resumo a cada ~3 dias, só se relevante.
- **Nova avaliação:** prioridade alta, agrupada se muitas.
- **Campanha:** saldo acabando, campanha parada (lotou, saldo zero).
- Toda notificação **leva direto à ação**.

---

## 15. Confiança, reputação e denúncias (modelo MyPlace + Premora)

**Sinais de confiança** (cada um explica o que significa ao tocar): e-mail verificado · telefone verificado ·
identidade verificada · propriedade verificada (por imóvel) · imóvel verificado por vídeo · ★ nota · N locações
concluídas · membro desde · "responde X% das solicitações · costuma responder em …" (a partir de 3 respostas).
Sem nota sintética de pessoa; ausência de histórico não é ponto negativo ("Novo na Premora").

**Denúncia:** motivo (lista) + **justificativa ≥ 15 caracteres**; IA faz triagem de denúncia vazia/abusiva;
gravidade calculada no servidor; evidência congelada; bloqueio mútuo; detecção de denúncias combinadas.
**Contagem nunca é pública.**

**Reincidência (procedentes):**
- **3** → revisão; "visite antes de fechar" ganha destaque no anúncio (texto neutro).
- **5** → **suspensão de novos anúncios e novas locações**, mantendo acesso para gerir contratos existentes,
  receber e conversar.
- **Golpe confirmado** → banimento de todas as contas do CPF.

**Chat:** detector de contato/pagamento por fora e de pedido de Pix/sinal; aviso, não bloqueio.

---

## 16. Premora Pro — Painel do Investidor (Fase 3)

**Nota Premora de Investimento (0–100)** — mesma para painel, comparador e oportunidades:

| Indicador | Peso |
|---|---|
| Preço vs média da região | 20% |
| Potencial de valorização | 20% |
| Retorno estimado com aluguel | 15% |
| Liquidez | 15% |
| Crescimento da região | 10% |
| Demanda de aluguel | 10% |
| Localização estratégica | 5% |
| Estado/padrão (Nota do Imóvel) | 5% |

- Cada indicador vira nota 0–100 por **interpolação linear** (sem degraus nem buracos). **[PROPOSTA]** âncoras:
  retorno anual 4% → 20, 10% → 100; valorização 5 anos 5% → 20, 25% → 100; preço 20% acima → 10, na média → 50,
  20% abaixo → 100.
- **Painel:** retorno estimado, valorização projetada, tempo de retorno, liquidez, crescimento da região, preço vs
  média, nota, **riscos**, estratégia sugerida ("aluguel de longo prazo", "revenda", "não recomendado").
- **Simulador de investimento** (grátis, Fase 1): valor, entrada, financiamento opcional (juros, prazo, PRICE **[PROPOSTA]**),
  aluguel, valorização, condomínio, IPTU, manutenção → fluxo mensal, retorno anual, patrimônio em 1/5/10 anos,
  payback (só com fluxo de caixa **[PROPOSTA]**), gráfico, resumo; sliders, tempo real, valida entrada ≤ valor.
- **Oportunidades Selecionadas:** abrangência cidade/estado/nacional; entra com **nota ≥ 85 e nenhum crítico
  (preço, valorização, retorno, liquidez) < 65**; 85–89 🟢 Selecionada · 90–94 🔥 Alta · 95–100 💎 Elite (rara);
  quantidade limitada; funil ("1.247 analisados → 23 selecionados"); nota aberta por indicador.
  Só liga quando houver volume de imóveis.
- **Encontre uma Estratégia para Mim** (Fase 4): reforma por categorias (pesos 1–5) × dimensão × custo regional
  (SINAPI/CUB) → faixas Econômico/Padrão/Premium + confiança; valor pós-reforma por comparáveis em bom estado
  (conservador/provável/otimista); margem sobre investimento total; margem mínima configurável; riscos;
  estratégias vender/alugar/manter; mesmas regras de seleção (≥ 85, críticos ≥ 65).
- **Tudo é estimativa:** nunca garantir lucro, valorização, custo ou prazo.

---

## 17. Painel administrativo

Fila de moderação (anúncios, fotos, denúncias, avaliações, disputas de chaves), verificação manual quando
necessário, gestão de usuários (suspender, banir CPF), configurações (`platform_settings`) com auditoria,
relatórios de receita (taxas, anúncios, Premium).

---

## 18. Dados de mercado

| Dado | Fonte inicial |
|---|---|
| Preço/aluguel médio | Anúncios e locações da própria Premora (cresce com o uso) |
| Custo de reforma/construção | SINAPI (Caixa), CUB (Sinduscon) |
| Renda e perfil do bairro | IBGE (Censo por setor) |
| O que tem perto | OpenStreetMap / Google Places |
| Transações | ITBI de prefeituras, quando publicado |

**Não** copiar dados de portais concorrentes. Sem dados suficientes → "dados insuficientes".

---

## 19. Fases de construção

| Fase | Conteúdo |
|---|---|
| **0 — Base** | Repositório novo a partir do MyPlace; remover tudo de espaço; renomear para Premora; esquema residencial; regras do `CLAUDE.md` |
| **1 — Lançamento (Colatina e região)** | Contas + verificação; anúncio residencial com verificação de identidade/propriedade, fotos e vídeo pelo app; Nota do Imóvel; estimativa de aluguel; busca/mapa/filtros; página do imóvel; favoritos e alertas; chat com detector; visita agendada; home em fileiras + recomendações; comparador "para morar" básico; simulador; **anúncios patrocinados com créditos** |
| **2 — Locação e dinheiro** | Contrato digital; pagamento retido + chaves + 72 h; split 2%+2%; Pix Automático; acréscimo no cartão; vistoria; reajuste; Painel do Proprietário com moradores existentes; avaliações; notificações completas; **Premium** |
| **3 — Premora Pro** | Nota Premora, Painel do Investidor (avulso e no Premium), comparador "para investir" + renda, selos de potencial, Oportunidades Selecionadas |
| **4 — Parcerias e avançado** | Seguro-fiança / aluguel sem fiador / aprovação rápida; Garantia Premora formalizada; Encontre uma Estratégia |

---

## 20. Contas e serviços que o Eduardo vai precisar criar (no momento certo)

GitHub (repositório `premora`), Supabase, Vercel, Asaas (sandbox primeiro), mapas/geocodificação, API da Anthropic,
Resend, Twilio, provedor de verificação de identidade, provedor de assinatura eletrônica, Sentry, Upstash.
Cada um será pedido com o aviso **"PRECISO DA SUA AÇÃO"**, com passo a passo e custo, na fase em que for necessário.

---

## 21. Pendências

| # | Assunto |
|---|---|
| P1 | Desconto de 50% vale para o inquilino Premium também? |
| P2 | Comparador: o que é grátis e o que é Premium |
| P3 | Percentual de acréscimo no cartão |
| P4 | Política de cancelamento de reserva antes da entrada |
| P5 | Regra final do inquilino que não confirma (hoje: silêncio libera em 72 h) |
| P6 | Garantia locatícia: seguro-fiança via parceiro × caução |
| P7 | Raio da "região" dos anúncios (proposta: 50 km) e lance mínimo por clique |
| P8 | Validação jurídica: taxa do inquilino (art. 22), pagamento antecipado (art. 20), créditos não reembolsáveis, nome "Garantia Premora", LGPD |

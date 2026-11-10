# Premora — Relatório de Análise das Anotações

Base: `notas/01`, `02`, `03` + pasta do Drive (14 docs; todos repetem o que já veio no chat, nada novo).

---

## 1. Visão geral — o que a Premora é hoje no papel

As anotações descrevem **4 produtos dentro de um**:

| # | Produto | Público | Seções |
|---|---|---|---|
| 1 | Marketplace de aluguel residencial (buscar, comparar, alugar) | Morador / inquilino | A, B, E, G, N, P, R |
| 2 | Premora Pro — ferramentas de investimento | Investidor / corretor | C, D, E, F, K, L |
| 3 | Gestão de imóveis alugados (moradores, cobrança, avisos) | Proprietário | M, O, S |
| 4 | Marketplace de **espaços** (vaga, garagem, galpão, sala) | Quem precisa guardar algo | T (Parte 3) |

Os 3 primeiros se encaixam bem: o morador gera os dados, o proprietário gera a oferta e os pagamentos, e o investidor paga pelas análises.
**O 4º não pertence a esse conjunto.** Parece vir de outro projeto/prompt (tem "Partes 1 e 2" que não são as da Premora e modelo de 3%+3%).
O que vale aproveitar dele são as **regras de qualidade** (sem dados falsos, "PRECISO DA SUA AÇÃO", privacidade de localização, testes, relatório no fim) e a **estrutura de busca + mapa + perto de mim**, adaptadas para imóveis.

---

## 2. O que está muito bom (manter)

1. **Transparência como marca** — mostrar ponto negativo também ("20% acima da média", "pontos de atenção", "riscos"). Quase ninguém faz isso; gera confiança.
2. **Seletividade** — "não mostra todos, mostra os que valem a pena"; Elite raro; notificações com antispam. Isso é posicionamento de produto, não só feature.
3. **Comparador com recomendação da IA**, incluindo a sua ideia de proximidade (escola, hospital, mercado) + preferência "perto do centro × mais tranquilo". É a feature mais fácil de explicar e de mostrar num pitch.
4. **Separar usuário comum de investidor** — simples para quem mora, profundo para quem investe.
5. **Fórmulas explicáveis** em vez de "caixa-preta" — dá para implementar, testar e explicar.
6. **Faixas + nível de confiança** em toda estimativa, e nunca prometer lucro. Correto e protege juridicamente.
7. **Avaliação só com experiência real** (liberada por pagamento) + direito de resposta. Muito melhor que avaliação aberta.
8. **Painel do proprietário** — faz a Premora continuar útil depois do aluguel (retenção).
9. **Recomendações imparciais separadas da vitrine paga** — honesto com o usuário e ainda monetiza.

---

## 3. O maior risco: DADOS (não é código)

Quase tudo depende de dados de mercado que um app novo **não tem** no começo:
preço médio da região, valorização histórica, liquidez, demanda de aluguel, crescimento da região,
custo de reforma regional, 5+ imóveis comparáveis.

Em Colatina ou outras cidades pequenas, nos primeiros meses, não vão existir 5 comparáveis por tipo/bairro/metragem.

**O que fazer:**
- **Fontes públicas que dá para usar desde o início:**
  - **SINAPI (Caixa)** — custo de construção/reforma por estado (público) → base da estimativa de reforma.
  - **CUB (Sinduscon)** — custo por m² por padrão (econômico/médio/alto) → bate com seu sistema de padrão.
  - **IBGE (Censo por setor)** — renda e população por região → "padrão do bairro".
  - **OpenStreetMap / Google Places** — escolas, hospitais, mercados, transporte → "localização estratégica" e o comparador.
  - **ITBI das prefeituras** — algumas publicam valores de transações (varia por cidade).
- **Dados próprios:** cada anúncio, cada aluguel fechado e cada pagamento na Premora vira dado.
- **Não copiar dados de portais concorrentes** (raspagem viola termos de uso e dá problema jurídico).
- **Regra de ouro:** se não houver dados suficientes, o app mostra "dados insuficientes nesta região"
  em vez de inventar nota. Suas anotações já preveem nível de confiança — é só aplicar como trava.

Consequência prática: as funções de investidor (score, oportunidades, estratégia) **só ficam boas depois** que houver volume de imóveis. Por isso elas vêm depois na ordem de construção.

---

## 4. Contradições e furos nas regras (precisam de decisão)

### 4.1 Negócio
| # | Conflito | Sugestão |
|---|---|---|
| 1 | Cobrança: Taxa de Serviço com 50% Premium × "sem comissão nesta fase" × 3% locatário + 3% proprietário | Escolher **um**. Sugestão: começar **sem taxa** no aluguel (ganhar usuário) e monetizar com Destaque/Turbo + Pro; ativar taxa quando o pagamento pelo app existir |
| 2 | Exemplo: taxa de R$20 num aluguel de R$1.500 (1,3%) × regra de 3% (R$45) | Definir % ou valor fixo |
| 3 | Painel do Investidor: R$29–79 × R$69,90 | R$69,90 parece ok; definir preço do Premium (precisa ser ≥ R$69,90, já que inclui o painel) |
| 4 | Premium mistura públicos: inquilino quer desconto de R$10 na taxa; investidor quer o painel | Separar: **Premora Pro** (investidor) e, se quiser, um plano do **proprietário** (desconto na taxa + impulsos). Inquilino não paga assinatura |
| 5 | Escopo: casa/apto × espaços (garagem, galpão) | Decidir (ver perguntas no fim) |

### 4.2 Regras e fórmulas
| # | Problema | Sugestão |
|---|---|---|
| 6 | "Imóveis em Destaque" dá nome a duas coisas: badge da IA (preço/potencial) e vitrine paga (Turbo/Destaque) | Vitrine paga = "Em destaque"; badges da IA = "Selo Premora" (ex.: 🟢 18% abaixo da média) |
| 7 | "Potencial de valorização" (Alto/Bom/Estável…) sai do score que **inclui o preço**; depois o Destaque junta preço + potencial de novo → preço conta 2× | Potencial = só valorização + crescimento da região. A nota geral vira "Nota Premora" |
| 8 | Três escalas: 0–10 (padrão do imóvel), 0–10 (investimento), 0–100 (oportunidades) | Tudo 0–100 por dentro; na tela, rótulos simples |
| 9 | Tabelas com buracos: 0–3/4–6/7–8/9–10 (e 3,5? 6,7?); preço "na média" 5 e "10–20% abaixo" 8, mas 0–10% abaixo não tem nota | Usar **interpolação linear** (nota contínua) em vez de degraus. Mais simples e sem buracos |
| 10 | Padrão no aluguel definido 2×: −10%/0/+15%/+30% (motor) × 0,7/1,0/1,2/1,5 (Parte 2) | Ficar com um só (sugiro o da Parte 2, mais suave: 0,85/1,0/1,15/1,3) |
| 11 | Conservação conta 2×: nas fotos (10%) e de novo como multiplicador; × idade × reforma pode passar de 10 (10 × 1,1 × 1,1 × 1,1 = 13,3) | Tirar conservação das fotos ou do multiplicador; limitar o produto dos fatores |
| 12 | Extras: soma "normalizada para 0–10" sem dizer como | Definir teto (ex.: soma ÷ 8 × 10, máx. 10) |
| 13 | Comparador: pesos 25/25/20/15/10/5 (com risco) × Score: 25/25/20/15/15 (sem risco) | Um único conjunto de pesos |

### 4.3 Reputação, avaliações e denúncias
| # | Problema | Sugestão |
|---|---|---|
| 14 | Janela de avaliação a cada pagamento → 1 morador de 2 anos = 24 avaliações | Média conta só a **última** avaliação de cada pessoa; histórico fica visível ("22 avaliações de 6 moradores") |
| 15 | Reputação do **proprietário** com 20% em "pagamentos recebidos em dia" — isso mede o inquilino, não ele | Trocar por "resolve chamados", "cancela pouco", "anúncio fiel à realidade" |
| 16 | 5 denúncias = 1 ocorrência; 3 ocorrências = −0,1 → 15 denúncias para perder 0,1 estrela. Descrito como "peso muito alto", mas o efeito é mínimo | Revisar a intensidade |
| 17 | Alertas "7–13 denúncias": denúncias ou ocorrências? Se forem ocorrências, são 35+ denúncias em 30 dias | Definir |
| 18 | Alerta público de denúncia | Risco de difamação/LGPD. Começar mostrando só para a equipe Premora; público só depois, com moderação humana |
| 19 | Nota automática do inquilino mostrada a proprietários = decisão automatizada (LGPD art. 20) | Dar ao usuário explicação da nota e direito de contestar |
| 20 | Selo "responde em até 10 min" | Muito difícil para proprietário comum; sugiro 1 h |
| 21 | Aviso de vencimento: 10 dias (painel) × 7 dias (notificações) | Ficar com 7 dias + 1 dia |

---

## 5. Riscos jurídicos / regulatórios (precisam de parceiro, não de código)

| Ideia | Risco | Caminho |
|---|---|---|
| Aprovação em 5 min / sem fiador | Precisa de análise de crédito (birôs como Serasa/Boa Vista, com custo) | Parceria com **garantidora de aluguel / seguro-fiança** que já faz a análise via API |
| Garantia alternativa "tipo seguro" | Vender seguro exige autorização da **SUSEP** | Revender produto de seguradora/garantidora parceira |
| "Entra hoje, paga depois" | É crédito; se o inquilino não pagar, quem perde é a Premora | Cortar ou só com parceiro que assume o risco |
| Contrato digital sem cartório | **Viável.** Contrato de aluguel não exige cartório; assinatura eletrônica tem validade legal | Integrar serviço de assinatura eletrônica (Clicksign, ZapSign, D4Sign…) |
| Cobrança / repasse / split | Guardar dinheiro de terceiros exige instituição de pagamento | Gateway com **split** (Asaas, Pagar.me, Mercado Pago…) |
| Estratégias e projeções para investidor | Expectativa de lucro → reclamação de consumidor | Avisos claros de "estimativa"; nunca "recomendado comprar" sem ressalva (suas notas já pedem isso) |
| CPF, localização, reputação | **LGPD** | Política de privacidade, consentimento, CPF nunca público, endereço exato só após aceite |

---

## 6. O que sugiro cortar, juntar ou adiar

**Juntar (fica mais simples para o usuário):**
- **3 comparadores → 1 comparador com dois modos:** *"Para morar"* (distância do trabalho/faculdade, escola, mercado, hospital, custo mensal total, perfil centro × tranquilo) e *"Para investir"* (retorno, valorização, liquidez + botão "comparar renda").
- **3 notas → sistema único:** Nota do Imóvel (padrão/qualidade) + Nota Premora de Investimento (0–100). Os selos de destaque saem dessas duas.
- **Avaliação de imóvel novo + construído** → um só formulário; os campos de idade/conservação/reforma aparecem só se for imóvel existente.

**Adiar (bom, mas não para a 1ª versão):**
- "Encontre uma Estratégia" (reforma + pós-reforma): a ideia mais sofisticada, mas a que mais depende de dados. Fase Pro avançada.
- Oportunidades Selecionadas: só faz sentido com centenas de imóveis por cidade.
- Estimativa para imóvel "a ser construído": nicho.
- Comunidades dos prédios: começar com "Avisos aos moradores" (mesma utilidade, bem menos complexo).
- Categorias de proprietário (multi-imóveis, gestor): cosmético.
- Alertas públicos de denúncia (ver 4.3).

**Cortar ou só com parceiro:**
- "Aluguel imediato — entra hoje, paga depois".
- Garantia própria tipo seguro (só via parceria).

---

## 7. O que sugiro acrescentar

1. **"Anúncio verificado" (antigolpe)** — golpe de aluguel é muito comum em OLX/Facebook/grupos. Verificar documento do proprietário + vídeo/visita ao imóvel. Talvez o diferencial de confiança mais forte para o público jovem.
2. **Perfil "o que você procura" em 3 perguntas** no primeiro acesso (quanto pode pagar, onde trabalha/estuda, centro ou tranquilo). Alimenta o match estilo Uber, o comparador e as notificações desde o dia 1, sem esperar o histórico de cliques.
3. **Tempo até o trabalho/faculdade** — para quem aluga, isso pesa mais que valorização. Entra no comparador "para morar".
4. **Custo mensal real** — aluguel + condomínio + IPTU + estimativa de luz/água. "Quanto vou gastar de verdade por mês".
5. **Vistoria digital de entrada e saída** (fotos com data no app) — evita briga por caução; combina com o painel do proprietário.
6. **Chamados de manutenção** — o morador abre pedido com foto; alimenta as avaliações e a reputação do proprietário com dado real.
7. **Estimativa de aluguel grátis para o proprietário** ("quanto vale o aluguel do meu imóvel?") — isca para atrair proprietários; usa o motor que você já desenhou.
8. **Filtros que o público jovem usa:** aceita pet, mobiliado, perto de faculdade, divide com amigos (república).

---

## 8. Plano de construção sugerido

### Fase 1 — MVP para lançar e atrair usuários
- Conta (e-mail/Google), perfil, CPF guardado com segurança
- Anunciar imóvel (fotos, dados, extras em checkbox) + **estimativa de aluguel simples** para o proprietário
- Busca + mapa + "perto de mim" + filtros + ordenação (estrutura da Parte 3, adaptada a imóveis), com localização aproximada (privacidade)
- Página do imóvel, favoritos, compartilhar, contato com o anunciante
- Perfil de preferências em 3 perguntas + "Recomendações selecionadas pela Premora"
- **Comparador "para morar"** com proximidade de escola/hospital/mercado e veredito da IA conforme o perfil
- Selo "X% abaixo/acima da média" **só onde houver dados suficientes**
- **Simulador de investimento** (é só matemática, não depende de dados de mercado — dá para lançar cedo)

### Fase 2 — Proprietário e dinheiro
- Painel do proprietário: imóveis, moradores com confirmação, cobrança, status pago/pendente/atraso, cobrança manual com motivo, histórico
- Pagamento pelo app (Pix/boleto com split) + taxa definida
- Destaque e Turbo (preços já definidos)
- Avaliações de anúncio liberadas por pagamento, resposta do anunciante, denúncia
- Notificações inteligentes (7d/1d, imóvel compatível, preço caiu)
- Anúncio verificado, vistoria digital

### Fase 3 — Premora Pro (investidor)
- Nota Premora, comparador "para investir" + comparar renda
- Avaliação de padrão por fotos (IA de visão)
- Painel do investidor com riscos e estratégias
- Oportunidades Selecionadas (quando houver volume)
- Reputação automática do usuário

### Fase 4 — Parcerias
- Garantia sem fiador / aprovação rápida (garantidora)
- Contrato digital (assinatura eletrônica)
- "Encontre uma Estratégia" (reforma + margem) com SINAPI/CUB

---

## 9. Tecnologia sugerida

- **App web responsivo / PWA primeiro** (instala no celular como app, abre por link, aparece no Google). Loja da Apple/Google depois, reaproveitando o código.
- **Next.js** (frontend + páginas de imóvel com SEO) hospedado na **Vercel**.
- **Supabase** (Postgres + PostGIS para busca por distância + login + armazenamento de fotos + regras de segurança no banco). Já existe um `supabase-setup.sql` neste repositório, do outro projeto.
- **Mapa:** MapLibre + provedor de mapas/geocodificação (Google Maps Platform ou MapTiler). Precisa de conta e chave → aviso "PRECISO DA SUA AÇÃO" na hora.
- **IA:** API do Claude para análise de fotos, moderação de texto/imagem, triagem de denúncias e textos explicativos do comparador.
- **Depois:** gateway de pagamento com split, assinatura eletrônica, garantidora.

---

## 10. Decisões que preciso de você antes de começar

1. **Escopo:** só casa/apartamento? Ou espaços (garagem, vaga, galpão) também, como categoria extra?
2. **Cobrança na 1ª fase:** sem taxa (só Destaque/Turbo + Pro) ou já com taxa? Qual %?
3. **Começar pela Fase 1 como proposta acima?**
4. **Cidade-piloto:** Colatina/ES? (ajuda a focar dados, divulgação e edital)
5. **Onde fica o código:** pasta `premora/` aqui neste repositório ou repositório novo só da Premora (recomendado).

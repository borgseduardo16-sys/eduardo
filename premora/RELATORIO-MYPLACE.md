# O que levar do MyPlace para a Premora

Base: pacote `pacote-myplace-para-aluguel-de-casas.zip` (178 arquivos: guia de reaproveitamento, resumo das regras,
9 documentos originais, código de referência em 11 áreas, 38 migrações SQL e 8 scripts de teste).
Lido com o filtro da decisão #1: **nada de espaços** — só o que serve para casa/apartamento.

---

## 1. Conclusão principal

**O MyPlace resolve exatamente a parte que a Premora não tinha:** a "infraestrutura chata" de um marketplace de aluguel.
Pagamento com split, taxas, Premium, Destaque/Turbo, chat, notificações, segurança, painel admin, mapa, regras no banco.
Isso foram 23 fases + Etapa 2 de trabalho, já com testes contra banco real.

A Premora, por outro lado, tem o que o MyPlace não tem: **a inteligência** (comparador, notas, estimativas,
painel do investidor, oportunidades, gestão de moradores).

👉 **Recomendação: construir a Premora em cima da base técnica do MyPlace** (mesma stack, mesmas regras,
mesmo mecanismo de pagamento), trocando "espaço" por "imóvel residencial" e somando as funções da Premora.
Ganha meses de trabalho e começa já com segurança de nível de produto real.

> O pacote traz só partes do código (`04-codigo-de-referencia`). O código completo está no repositório
> `borgseduardo16-sys/eduardoo` (branch `claude/marketplace-espacos-ociosos-ncm1oh`). Para usar como base,
> preciso de acesso a ele nesta sessão.

---

## 2. Levar como está 🟢

| Peça do MyPlace | Por que serve | Onde encaixa na Premora |
|---|---|---|
| **8 regras inegociáveis** (dinheiro em centavos, navegador nunca manda preço, nada finge funcionar, autorização na camada de dados, segredo nunca público, endereço exato privado, regra importante vira trava no banco, toda mudança de taxa auditada) | É o que torna um app de dinheiro confiável | Vira o `CLAUDE.md` da Premora |
| **Stack** (Next.js + Supabase/PostGIS + Asaas + Resend + Twilio + MapLibre + Claude + Sentry + Vercel) | Já testada e documentada passo a passo (`SETUP.md`) | Igual |
| **Asaas com split por valor fixo**, subconta por proprietário, webhook idempotente, livro-razão que não aceita apagar | Proprietário recebe o valor exato; dinheiro rastreável | Cobrança de aluguel do Painel do Proprietário (seção M) |
| **Configurações sem deploy** (`platform_settings`) com auditoria | Mudar taxa/preço = um comando, sem reprogramar | Taxas 2%+2%, preços de Destaque/Turbo, Premium |
| **Taxa congelada no contrato**: mudança de taxa da plataforma não afeta contrato vigente | Justo e juridicamente mais seguro | Igual |
| **Fórmula de compatibilidade "X% compatível"** (só conta o que a pessoa informou; 100% só se tudo bate; explica cada critério; nunca reordena a busca principal) | É exatamente o "match estilo Uber" e as "Recomendações selecionadas" da Premora, já resolvido | Seções R e P (trocando critérios por quartos, banheiros, vagas, m², pet, mobiliado) |
| **Alertas de busca**, favoritos com aviso de "o preço mudou", histórico de preço, "semelhantes" | Bate com as notificações da Premora | Seção P |
| **Governador de notificações** (anti-spam, resumo em um aviso só, categorias que o usuário desliga) + push no celular + e-mail | Implementa o "só interrompe quando vale a pena" | Seção P |
| **Impulsionamento nunca passa por cima da busca** (só desempata) | Mantém a busca honesta; casa com "Recomendações imparciais" | Seções R e S |
| **Destaque/Turbo**: estados reais, um ativo por anúncio, só ativa após pagamento confirmado | Mecanismo pronto | Seção S |
| **Endereço exato privado** até a locação estar ativa + **remoção do GPS das fotos** (EXIF entregava o endereço!) | Em casa é ainda mais importante | Tudo |
| **Detector de contato no chat** (avisa quando tentam levar o pagamento para fora) | Com taxa em reais, a tentação de "fechar por fora" cresce | Chat |
| **Visita antes de fechar** + checklist de visita | Em casa, na prática é obrigatória | Página do imóvel |
| **Sinais de confiança em vez de "nível"**: e-mail verificado, telefone verificado (SMS), N locações concluídas, ★ nota, membro desde, "responde X% · costuma responder em…" | Cada selo tem explicação; ausência de histórico não vira ponto negativo | Substitui parte da seção O |
| **Denúncia**: 18 motivos, gravidade calculada no servidor, evidência congelada, bloqueio mútuo, 3 procedentes = revisão, 5 = suspensão; **contagem nunca pública** | Mais seguro que os alertas públicos da Premora (risco de difamação) | Substitui seção O.2 |
| **IA de padrão por foto** (Claude analisa fotos) + **sugestão de valor por comparáveis** (conta, sem IA) | É a seção H/I da Premora já implementada para espaços | Trocar critérios para residencial |
| **Chat com áudio**, painéis financeiros, relatório mensal, **painel administrativo** com fila de moderação | Infraestrutura que a Premora vai precisar de qualquer jeito | Tudo |
| **Testes contra banco real + dublê do Asaas**, inclusive cliques simultâneos | Modelo de qualidade | Tudo |

---

## 3. Adaptar 🟡

### 3.1 Taxas — decisão 2% + 2%
Mecanismo do MyPlace serve inteiro, só muda o número.

| Aluguel | Inquilino paga | Proprietário recebe | Premora no Pix (−R$1,99) | Premora no cartão (−2,99% −R$0,49) |
|---:|---:|---:|---:|---:|
| R$ 1.000 | R$ 1.020 | R$ 980 | **R$ 38,01** | R$ 9,01 |
| R$ 1.500 | R$ 1.530 | R$ 1.470 | **R$ 58,01** | R$ 13,76 |
| R$ 2.000 | R$ 2.040 | R$ 1.960 | **R$ 78,01** | R$ 18,51 |
| R$ 3.000 | R$ 3.060 | R$ 2.940 | **R$ 118,01** | R$ 28,02 |

*(tarifas públicas do Asaas citadas no MyPlace; confirmar na conta)*

- **Com 2%+2%, o cartão come ~75% da margem.** Pix e **Pix Automático** (débito mensal autorizado uma vez,
  sem cartão, sem chargeback) precisam ser o padrão. Para contrato de 30 meses, o Pix Automático vale ouro.
- Opção: repassar a tarifa do cartão a quem escolhe cartão (ex.: "no cartão a taxa é maior").
- ⚖️ **Alerta jurídico:** a Lei do Inquilinato (art. 22, VII) põe taxa de administração/intermediação como
  obrigação do **locador**. A taxa de 2% do **inquilino** pode ser questionada. Levar ao advogado.
  Alternativas se precisar: (a) 4% só do proprietário (mesma receita); (b) a parte do inquilino vira um
  serviço claramente separado (ex.: garantia/seguro-fiança, contrato digital).
- ⚖️ **Art. 20:** não pode exigir aluguel antecipado na locação residencial comum. O MyPlace cobra o 1º mês
  logo após o aceite — na Premora isso tem que mudar (validar com advogado).

### 3.2 Premium — juntar as duas versões
| | Premora (anotações) | MyPlace | **Proposta para a Premora** |
|---|---|---|---|
| Para quem | Misturado (inquilino + investidor) | Proprietário | **Proprietário e investidor** |
| Preço | Não definido (painel avulso R$69,90) | R$ 119,90 | A definir — precisa ser ≥ R$69,90, já que inclui o painel |
| Desconto na taxa | 50% | 3% → 2% | **2% → 1% do proprietário** (são os "50%" da Premora) |
| Painel do Investidor | Incluso | — | Incluso |
| Destaque/Turbo grátis | — | 2 Destaques + 1 Turbo/mês (não acumulam) | Manter |
| Outros | — | Selo discreto, mais alertas de busca (20 × 2), mapa ampliado | Selo + alertas ampliados |
| Regras | — | Premium = pagamento confirmado; cancelar = não renovar; um Premium por pessoa; taxa segue o Premium | **Manter todas** |

- **A conta do desconto:** 1 ponto percentual de desconto só paga a assinatura para quem recebe
  (preço × 100) por mês. Com Premium de R$ 99,90, isso é R$ 9.990/mês em aluguéis (~5 imóveis).
  Para quem tem 1 imóvel, o argumento é **visibilidade + painel**, não o desconto. O desconto em reais
  ("Economize R$ 15,00 este mês") continua sendo mostrado, como a Premora quer.
- **Não levar** o benefício de R$ 100 no 1º mês do inquilino (desligado, nunca validado, pouco valor numa casa).

### 3.3 Destaque e Turbo
- Mecanismo 🟢. **Preços** (R$ 9,90–27,90) foram feitos para garagem; numa casa de R$ 1.500 o proprietário aceita
  pagar mais. Decidir: manter para ganhar adesão no início ou subir.
- Elegibilidade por características: voltar aos critérios residenciais originais (quartos, vagas, casa/apto, faixa de preço).

### 3.4 Fluxo da locação
- 🟢 Solicitação → aceite → pagamento → renovação, prazos pelo relógio do banco, entrega de "instruções de acesso"
  depois do pagamento (vira **entrega das chaves**).
- 🟡 Tirar "quantidade de vagas": cada anúncio é **uma** unidade.
- 🔴 **Falta e é obrigatório em aluguel de casa:** contrato com assinatura digital, vistoria de entrada/saída com fotos,
  análise do inquilino, prazo (normalmente 30 meses), multa proporcional por rescisão (art. 4º), aviso prévio de 30 dias,
  **reajuste anual** (IGP-M/IPCA), condomínio e IPTU.

### 3.5 Garantia (caução)
- No MyPlace a caução é sempre 1 mês, guardada pela plataforma.
- ⚖️ Na lei: caução até **3 meses**, **em poupança** com rendimento para o inquilino (art. 38), e **uma garantia só**
  por contrato (art. 37): caução **ou** fiador **ou** seguro-fiança **ou** título de capitalização.
- 💡 **Aqui as duas ideias se encontram:** a "garantia alternativa / aluguel sem fiador" da Premora (ideias A1 e A5)
  vira **seguro-fiança via parceiro**, oferecido dentro do app. Resolve a lei, o risco e vira diferencial.

### 3.6 Avaliações
- MyPlace avalia **no fim da locação**, dos dois lados. Premora avalia **ao longo do contrato** (janela a cada pagamento).
- Para contrato de 30 meses, a ideia da Premora faz sentido. **Juntar:** avaliação periódica do imóvel (Premora) +
  avaliação final dos dois lados (MyPlace), com a média contando só a avaliação mais recente de cada pessoa.

### 3.7 Busca e mapa
- 🟢 Busca em camadas (GPS, CEP, cidade, texto), MapLibre, "perto de mim".
- 🟡 Trocar o catálogo de características: quartos, suítes, banheiros, vagas, m², mobiliado, aceita pet, andar,
  elevador, condomínio, portaria, área de lazer etc.
- 🟡 Para casa, endereço **sempre** privado até a locação (sem a exceção de loja/galpão).

---

## 4. Não levar 🔴
- Tudo que é específico de espaço: tipos (vaga, galpão, depósito…), quantidade de vagas, veículo (moto/carro/caminhão).
- Benefício de R$ 100 do Premium.
- Aluguel mínimo de R$ 35 e piso de R$ 50 do Premium.
- Exceção de endereço exato para tipos comerciais.

---

## 5. O que a Premora tem e o MyPlace não (continua sendo o diferencial)
- Comparador com veredito da IA (morar × investir), proximidade de escola/hospital/mercado, perfil centro × tranquilo.
- Selos "X% abaixo/acima da média", estimativa de aluguel com padrão/conservação/idade.
- Simulador de investimento, Nota Premora, Painel do Investidor, Oportunidades Selecionadas, Estratégia com reforma.
- **Painel do Proprietário com cadastro de moradores que já existem** (fora do app). Isso é uma **alavanca de crescimento**:
  o proprietário traz os inquilinos atuais e passa a cobrar pela Premora → a plataforma ganha taxa e dados desde o dia 1,
  sem depender de o imóvel ser alugado pelo app.

---

## 6. Correções nas anotações da Premora que o MyPlace já resolve
| Problema apontado no relatório anterior | Solução do MyPlace |
|---|---|
| Alertas públicos de denúncia (risco de difamação/LGPD) | Contagem nunca pública; 3 procedentes = "visite antes de fechar" ganha destaque, com texto neutro |
| Matemática de denúncias (5 → 1 ocorrência; 3 → −0,1) | 3 procedentes = revisão; 5 = suspensão automática |
| Selo "responde em 10 min" | "Responde X% das solicitações · costuma responder em …", a partir de 3 respostas |
| Nota automática de inquilino (LGPD art. 20) | Sinais reais e explicados, sem nota sintética |
| "Usuário novo" como algo negativo | Ausência de histórico não vira ponto negativo |
| Notificação de imóvel compatível ≥ 80% | Fórmula de compatibilidade pronta + alertas com limite e resumo |

---

## 7. Plano atualizado
1. **Base:** novo repositório da Premora a partir do código do MyPlace, removendo o que é de espaço.
2. **Fase 1 (lançamento):** conta, anúncio de imóvel (características residenciais, IA de padrão, sugestão de valor),
   busca/mapa/perto de mim, página do imóvel, favoritos, alertas, chat, visita, perfil com sinais de confiança,
   comparador "para morar", recomendações por compatibilidade, simulador.
3. **Fase 2 (dinheiro):** Asaas em sandbox → Pix/Pix Automático com split 2%+2%; Painel do Proprietário com moradores
   existentes e cobrança; Destaque/Turbo; Premium; avaliações; contrato digital; vistoria; reajuste anual.
4. **Fase 3:** Premora Pro (investidor).
5. **Fase 4:** seguro-fiança/garantia via parceiro; estratégia com reforma.

---

## 8. Decisões pendentes
1. Usar o código do MyPlace como base da Premora? (preciso de acesso ao repositório `eduardoo`)
2. Manter 2% + 2% mesmo com o alerta do art. 22 (vai consultar advogado?) ou 4% só do proprietário?
3. Premium: para proprietário + investidor? Preço? Desconto de 2% → 1% no proprietário?
4. Destaque/Turbo: manter preços do MyPlace ou subir?
5. Garantia: seguro-fiança via parceiro em vez de caução?
6. (Ainda pendentes do relatório anterior) cidade-piloto e repositório novo.

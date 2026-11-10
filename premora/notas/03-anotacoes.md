# Premora — Anotações do Eduardo (parte 3)

> Repetidos nesta leva (já guardados em 01/02, não duplicados): Parte 2 do aluguel, Avaliação de imóvel construído,
> Oportunidades Selecionadas, Encontre uma Estratégia (P1 e P2), Painel do Proprietário, Avaliações de anúncios,
> Reputação (P1 e P2), Notificações. A "Parte 3 — Busca e Mapa" veio colada 2×; mantida uma vez.

---

## Q. Planos: Premora Comum × Premora Premium

- **Só dois planos.** Estrutura flexível para adicionar benefícios depois sem reconstruir.
- **Comum:** gratuito; paga a **Taxa de Serviço** normal nas operações de aluguel; demais benefícios a definir.
- **Premium (pago):** **Painel do Investidor incluso** (que também é vendido separado por **R$ 69,90/mês**)
  + **50% de desconto na Taxa de Serviço**. Outros benefícios **não definir agora** (não criar benefício artificial).
- Comunicar a economia **em reais**, em verde: "Economize R$ 10,00".
- Exemplo no pagamento: Aluguel R$1.500 · Taxa R$20 · Desconto Premium −R$10 · **Total R$1.510**.
- Chamada: "PREMORA PREMIUM — Tenha 50% de desconto na Taxa de Serviço + Painel do Investidor incluso".

---

## R. Página Inicial — Imóveis em Destaque e Recomendações

Seções em **carrossel horizontal**, cada uma com "Ver mais". Duas seções com lógicas que **não se misturam**:

**1. "Imóveis em destaque"** (pago tem prioridade):
- Ordem: **Turbo → Destaque → Comuns**.
- Turbo: precisa só de **compatibilidade mínima** (algumas características: cidade/região, tipo, quartos,
  faixa de preço, vagas, bairro, área, casa/apto).
- Destaque: mais criterioso, **~4 características em comum**.
- Comuns: também **~4+ características em comum**.

**2. "Recomendações selecionadas pela Premora"** (imparcial):
- Ordem **só por compatibilidade** (nº/relevância de características em comum). Turbo **não** passa na frente.
- Selo "⚡ TURBO"/"DESTAQUE" aparece só como informação, sem mudar a ordem.
- Perfil vem de: visualizados, salvos, curtidos, faixa de preço, cidade, bairro, tipo, quartos, banheiros, vagas,
  área, casa/apto, conservação, frequência de interação.

"Ver mais": Destaques mantém Turbo→Destaque→Comuns; Recomendações lista completa por compatibilidade.
Página limpa, sem lista gigante.

> Obs.: esta "Imóveis em destaque" (Turbo/Destaque pago) tem o mesmo nome da aba "Imóveis em Destaque" da
> seção B (IA: preço vs média + potencial). Ver pontos a confirmar no fim.

---

## S. Destaque e Turbo (impulsionamento pago)

- Fase 1: monetização por **planos mensais + impulsionamento**, **sem comissão sobre aluguel ou venda**.
- Tela **"Turbine seu anúncio"** antes de publicar ("Aumente suas chances de encontrar um interessado"),
  Destaque e Turbo lado a lado, ou publicar normal. Também acessível depois pelo painel do proprietário.

| ⭐ Destaque — "mais visibilidade por alguns dias" | Preço | Selo |
|---|---|---|
| 1 dia | R$ 12,90 | |
| 3 dias | R$ 19,90 | Mais recomendado |
| 5 dias | R$ 24,90 | Melhor custo-benefício |

| ⚡ Turbo — "prioridade máxima por pouco tempo" | Preço | Selo |
|---|---|---|
| 1 hora | R$ 9,90 | |
| 5 horas | R$ 15,90 | |
| 12 horas | R$ 19,90 | Mais recomendado |
| 24 horas | R$ 27,90 | Maior exposição |

- Turbo máx. 24h por compra; encerra sozinho; renovar = nova compra.
- Painel do proprietário: impulsionamentos ativos com contagem regressiva ("Turbo ativo — restam 8h 32min"),
  status "encerrado" automático, botão "Impulsionar novamente".
- Estrutura flexível para novos planos/preços/períodos.

---

## T. ~~Parte 3 — Busca, Mapa, Página do Espaço~~ — ❌ DESCARTADO (outro projeto, ver DECISOES.md #1)

> ⚠️ Este texto fala de um **marketplace de ESPAÇOS** (vaga de carro/moto, garagem, armazenamento, galpão,
> sala, loja, terreno), cita "Partes 1 e 2" de outro projeto e um modelo de **3% locatário + 3% proprietário**.
> Parece vir de outro projeto/prompt. Guardado na íntegra em resumo; a confirmar se entra na Premora.

**Regras gerais do prompt:** banco de dados real, sem dados falsos/mocks, sem inventar APIs; se precisar de
conta/chave/custo → parar e avisar "PRECISO DA SUA AÇÃO"; nunca chave secreta no frontend; não implementar pagamento.

**Fluxo:** O que você precisa? → Onde? → Encontrar espaços → Filtrar → Ver no mapa → Abrir anúncio.

- **Home de busca:** "Encontre um espaço perto de você"; tipos (vaga carro/moto, garagem, armazenamento, galpão,
  sala, loja, terreno, outro); campo "Onde você precisa?" (cidade, bairro, endereço, CEP, referência); botões
  "Encontrar espaços" e "Usar minha localização".
- **Geolocalização real**; se negar, continua funcionando com busca manual; não pedir sem necessidade.
- **Geocodificação** (Google Maps / Mapbox / OSM-Nominatim…) escolhida por custo, limite, uso comercial,
  confiabilidade, crescimento — não só por ser grátis.
- **Resultados:** lista + mapa (lado a lado no desktop; alternar no celular). Card só com dados reais
  (título, distância, R$/mês, tipo, características).
- **Mapa real:** zoom, mover, marcadores clicáveis com resumo → página completa.
- **Privacidade:** não expor endereço exato; bairro/região, marcador deslocado, sem número; detalhe só no fluxo de aluguel.
- **Filtros:** tipo, preço mín/máx, distância (1/3/5/10 km/qualquer), características (coberto, câmera, portão,
  iluminação, 24h, energia, água, banheiro, internet, entrada independente, acesso veículos), disponibilidade
  (não mostrar pausado/removido).
- **Ordenação:** mais próximos (distância real), menor/maior preço, mais recentes.
- **Busca por texto** previsível (vaga, garagem, moto, depósito, galpão…), sem IA complexa agora.
- Estados de **vazio** (sugerir aumentar distância/remover filtros), **loading** (skeleton) e **erro** (mensagem simples; log técnico).
- **Página do espaço:** galeria real (abrir/navegar/ampliar; estado sem foto), título, tipo, descrição,
  características, preço/mês, disponibilidade, localização aproximada ("Centro — Colatina/ES"), perfil público
  do proprietário ("Membro desde…"), sem avaliações falsas.
- **Preço futuro (não cobrar agora):** espaço R$100 → locatário paga R$103, proprietário recebe R$97, plataforma R$6.
- **Favoritos** no banco, por usuário, com permissão; pedir login se não logado.
- **Compartilhar** (nativo no celular) + URL própria `/espaco/{id}`; metadados SEO/redes sociais.
- **CTA "Tenho interesse"/"Solicitar aluguel"** sem fingir reserva (fluxo real na próxima etapa).
- **Design:** moderno e confiável (referências conceituais Neighbor, Airbnb, Zillow, Uber — sem copiar);
  evitar gradientes/sombras/emojis excessivos e "cara de site feito por IA".
- **Responsivo** (celular, tablet, desktop); **performance** (thumbnails, paginação, índices, consultas geográficas;
  PostGIS só se fizer sentido).
- **Banco:** lat/long, cidade, estado, bairro, tipo, preço, características, disponibilidade, status, dono, imagens; índices.
- **Segurança no backend:** só publicados aparecem; dono só edita o seu; sem expor dados/localização privada.
- **Testes:** busca (cidade/bairro/endereço/vazio/filtros), distância, filtros, permissões, favoritos, responsividade.
- **Não fazer ainda:** pagamento, split, cartão, PIX, recorrência, repasse, saque, comissão, aluguel completo,
  reserva, chat, avaliações, Premium, anúncios pagos, destaques, publicidade.
- **Critério de pronto (18 itens):** criar conta → entrar → espaços reais → buscar → local → próximos → lista →
  mapa → filtros → ordenar → abrir → fotos reais → info real → localização aproximada → favoritar → remover
  favorito → compartilhar → funcionar no celular.
- **Relatório final exigido:** Implementado · Configurado · Precisa da minha ação · Bloqueado por serviço externo ·
  Não implementado · Testes realizados · Próxima etapa. Nunca dizer que está pronto se não estiver.

---

## ⚠️ Pontos a confirmar (contradições encontradas — só registro, sem julgamento)

1. **Modelo de cobrança — 3 versões diferentes:**
   (a) "Taxa de Serviço" no aluguel, com 50% off no Premium (seção Q);
   (b) "sem comissão sobre aluguel ou venda nesta fase" (seção S);
   (c) 3% do locatário + 3% do proprietário (seção T).
2. **Preço do Painel do Investidor:** R$ 29–79/mês (seção C) × R$ 69,90/mês (seção Q).
3. **Escopo:** imóveis residenciais (casa/apto) × marketplace de espaços (vaga, garagem, galpão) da seção T.
4. **Nome "Imóveis em Destaque"** usado para duas coisas: aba da IA (B) e vitrine paga Turbo/Destaque (R).
5. **Aviso de aluguel:** 10 dias e 1 dia antes (M) × 7 dias e 1 dia antes (P).

/**
 * Libera automaticamente a pasta do curso no Google Drive para o e-mail
 * de quem comprou na Cakto, e remove o acesso em reembolso/chargeback.
 *
 * Como usar: script.google.com > Novo projeto > cole este código,
 * preencha as 3 constantes abaixo e publique como "App da Web"
 * (passo a passo completo no chat).
 */

const FOLDER_ID = 'COLE_AQUI_O_ID_DA_PASTA_DO_CURSO';          // o código no link da pasta: drive.google.com/drive/folders/ESTE_CODIGO
const CAKTO_SECRET = 'COLE_AQUI_A_CHAVE_SECRETA_DO_WEBHOOK';   // a Cakto mostra essa chave ao criar o webhook
const AVISAR_EMAIL = 'COLE_AQUI_SEU_EMAIL';                    // recebe um aviso quando for preciso liberar manualmente

function doPost(e) {
  let body;
  try {
    body = JSON.parse(e.postData.contents);
  } catch (err) {
    return resposta_('json inválido');
  }

  // garante que a chamada veio mesmo da sua conta Cakto
  if (body.secret !== CAKTO_SECRET) return resposta_('secret inválido');

  const evento = String(body.event || '');
  const cliente = (body.data && body.data.customer) || {};
  const email = String(cliente.email || '').trim().toLowerCase();

  if (!email) {
    avisar_('Venda sem e-mail', 'Recebi um evento "' + evento + '" sem e-mail do cliente.\n\n' + JSON.stringify(body).slice(0, 3000));
    return resposta_('sem email');
  }

  const pasta = DriveApp.getFolderById(FOLDER_ID);

  if (evento === 'purchase_approved') {
    try {
      pasta.addViewer(email);
      console.log('Acesso liberado: ' + email);
    } catch (err) {
      // normalmente acontece quando o e-mail não é uma conta Google
      avisar_('Liberar acesso manualmente',
        'Não consegui liberar a pasta automaticamente para ' + email + ' (' + (cliente.name || 'sem nome') + ').\n' +
        'Provavelmente esse e-mail não é uma conta Google. Fale com o cliente e libere pelo Drive.\n\nErro: ' + err);
    }
  } else if (/refund|chargeback/i.test(evento)) {
    try {
      pasta.removeViewer(email);
      console.log('Acesso removido (' + evento + '): ' + email);
    } catch (err) {
      console.log('Falha ao remover ' + email + ': ' + err);
    }
  }

  return resposta_('ok');
}

/** Rode esta função uma vez pelo editor para testar com um e-mail seu (Gmail). */
function testarLiberacao() {
  const fake = { postData: { contents: JSON.stringify({ secret: CAKTO_SECRET, event: 'purchase_approved', data: { customer: { email: 'COLE_UM_GMAIL_DE_TESTE@gmail.com', name: 'Teste' } } }) } };
  console.log(doPost(fake).getContent());
}

function resposta_(status) {
  return ContentService.createTextOutput(JSON.stringify({ status: status })).setMimeType(ContentService.MimeType.JSON);
}

function avisar_(assunto, texto) {
  if (AVISAR_EMAIL && AVISAR_EMAIL.indexOf('@') > 0) MailApp.sendEmail(AVISAR_EMAIL, '[Curso Renda Extra com IA] ' + assunto, texto);
}

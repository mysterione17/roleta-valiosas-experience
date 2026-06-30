# Como replicar para um novo cliente

Tudo que precisa mudar está marcado com `TODO` no `index.html`, ou listado abaixo. **Não é necessário mexer no bloco "MOTOR DA ROLETA"** (a função autoexecutável no final do arquivo) — ali é só engine, igual para qualquer cliente.

## 1. Duplicar o projeto

Copie a pasta inteira `página da roleta/` com um nome novo (ex: `roleta-cliente-x/`), ou crie um repositório novo a partir dela.

## 2. Configurar prêmios e tracking

No topo do `<head>`, dentro de `window.ROLETA_CONFIG`:

| Campo | O que é |
|---|---|
| `FB_PIXEL_ID` | ID do Meta Pixel do cliente (opcional, deixar `''` se não usar) |
| `GTM_ID` | ID do Google Tag Manager do cliente — formato `'GTM-XXXXXXX'`. **Não confundir com GA4** (ver abaixo); se o cliente mandar um ID assim, ele não funciona aqui. |
| `GA4_ID` | ID do Google Analytics 4 (gtag.js direto, sem passar pelo GTM) — formato `'G-XXXXXXXXXX'`. Use este campo quando o cliente passar um ID começando com `G-`. |
| `TENTATIVAS` | quantas vezes a pessoa pode girar (padrão: 3) |
| `PREMIOS` | objeto com cada prêmio: `label` (texto exibido no gomo e no modal), `peso` (chance relativa — a soma não precisa fechar em 100), `rank` (1 = pior, maior número = melhor; entre várias tentativas, sempre prevalece o de maior rank), `checkout` (link de pagamento, ex: Hotmart/Kiwify/Eduzz, já com o offer code do prêmio) |

**Prêmio com preço diferente por público (ex: aluna/não aluna):** em vez de `checkout`, use `checkoutAluna` e `checkoutNaoAluna` (os nomes são genéricos no motor, só o texto do botão menciona "aluna" — para outro tipo de segmentação, adapte os labels dos botões no `<div class="aluna-choice">` do `index.html`). Quando o prêmio sorteado tiver esses dois campos, o modal pergunta antes de levar ao checkout; se tiver só `checkout`, vai direto.
| `GOMOS` | array com a ordem dos prêmios ao redor da roleta. Mantenha número par, cada prêmio repetido pelo menos 2x e intercalado (não dois iguais seguidos) — isso garante visual equilibrado |

**Regra de ouro:** o `sck`/parâmetro de rastreamento do link de checkout deve ser diferente por prêmio, pra você conseguir medir no Hotmart/Kiwify/etc. qual condição mais converteu.

## 3. Textos

- `<title>` e `<meta name="description">` no `<head>`.
- `.topbar` — nome do cliente/produto na barrinha do topo.
- `.hero h1` e `.hero p` — headline e subtítulo da oferta.
- `.hub b` / `.hub small` — texto pequeno no centro da roleta (ex: logo abreviada).
- `.footnote` — disclaimer dos prêmios.

## 4. Seção do instrutor/responsável

Bloco `<section class="instrutor">`:

- Troque `assets/instrutor-placeholder.svg` pela foto real (recomendado: `.webp` + fallback `.png`, como no original da Elétrica Academy, para performance — mas um único arquivo já funciona).
- Atualize nome, `alt` da imagem e o texto de autoridade.
- Se não fizer sentido pro cliente ter essa seção (ex: marca sem rosto), pode remover o `<section>` inteiro sem quebrar nada — ela não é referenciada pelo JS.

## 5. Cores da marca

No início do `<style>`, dentro de `:root{...}`:

```css
--gold:#D4AF37; --gold-dk:#B8860B; --gold-lt:#E5C45A;
```

Troque essas três variáveis pela paleta do cliente (idealmente um tom principal + uma variação mais escura + uma mais clara, no mesmo espírito de "dourado/destaque"). Todo o resto do CSS usa essas variáveis, então a roleta, botões e modal se atualizam sozinhos.

## 6. Favicon

O `<link rel="icon">` aponta pro placeholder SVG. Troque pelo favicon real do cliente.

## 7. Testar localmente

Abra o `index.html` direto no navegador (duplo clique) ou sirva com:

```bash
python -m http.server 8000
```

Confira:
- Roda os 24 textos (4 prêmios) legíveis nos gomos em mobile e desktop.
- Gira a roleta o número de vezes configurado em `TENTATIVAS`; se for mais de 1, confirma que sempre fica valendo o prêmio de maior `rank` sorteado.
- Para prêmios com `checkout` único, confirma que o botão único aparece e leva ao link certo.
- Para prêmios com `checkoutAluna`/`checkoutNaoAluna`, confirma que aparece a pergunta no modal e que cada botão leva ao link certo, com UTMs da URL preservados.
- Console do navegador sem erros.

## 8. Publicar no GitHub (hospedagem temporária)

```bash
cd roleta-cliente-x
git init
git add .
git commit -m "Roleta - cliente X"
gh repo create roleta-cliente-x --public --source=. --push
```

Depois, em Settings → Pages do repositório, ativar GitHub Pages na branch `main` (pasta raiz). A URL fica em `https://<seu-usuario>.github.io/roleta-cliente-x/`.

Quando o cliente aprovar e quiser domínio próprio, é só apontar o domínio pro GitHub Pages (CNAME) ou subir os mesmos arquivos por FTP onde for definitivo — não há nenhuma dependência de servidor.

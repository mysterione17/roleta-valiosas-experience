# Página da Roleta

Landing page de "roleta de prêmios" — mecânica de gamificação para funil de vendas (girar, ganhar uma condição especial, ir para o checkout). Adaptada da roleta NR-10 da Elétrica Academy (`tools.eletricaacademy/roleta-nr10`) como template reutilizável para outros clientes.

## O que é

Um único arquivo `index.html` autocontido (HTML + CSS + JS inline, zero dependências de build, zero frameworks). Roda em qualquer hospedagem estática — GitHub Pages, FTP, Vercel, etc.

- Roleta desenhada em SVG (não é imagem) — o texto dos prêmios sempre fica nítido em qualquer tamanho de tela.
- Sorteio ponderado: cada prêmio tem um `peso` (chance relativa) e um `rank` (se o usuário girar mais de uma vez, fica valendo o prêmio de maior rank, nunca um pior).
- Passa UTMs da URL do anúncio para o link de checkout, mantendo o parâmetro `sck` específico do prêmio sorteado.
- Tracking opcional via Google Tag Manager e/ou Meta Pixel, disparando 3 eventos: `SpinWheel`, `SpinResult`, `ClaimPrize`.

## Estrutura

```
página da roleta/
├── index.html              # FONTE — a página legível (motor + config + conteúdo), é este arquivo que se edita
├── build.sh                 # gera docs/ a partir do index.html (minifica + ofusca)
├── docs/                    # PUBLICADO — gerado pelo build.sh, é o que o GitHub Pages serve (não editar à mão)
├── assets/
│   └── instrutor-placeholder.svg   # placeholder — trocar pela foto real do cliente
├── README.md                # este arquivo
└── REPLICAR.md               # passo a passo para customizar para um novo cliente
```

## Publicar uma atualização

Depois de editar o `index.html` (fonte), gerar a versão publicada:

```bash
bash build.sh
```

Isso minifica e ofusca o HTML/CSS/JS (nomes de função/variável viram letras soltas, sem espaços/comentários) e copia os assets pra dentro de `docs/`, que é a pasta configurada no GitHub Pages. Sempre commitar `index.html` **e** `docs/` juntos.

Isso é só um dificultador contra cópia casual via "Ver código-fonte"/"Inspecionar elemento" — não existe forma de esconder de verdade código que roda no navegador do visitante. Os dados de configuração (links de checkout, pesos dos prêmios) continuam tecnicamente visíveis no HTML entregue, pois o navegador precisa deles pra rodar a roleta.

## Visualizar localmente

Não precisa de servidor — é só abrir o `index.html` direto no navegador. Se preferir simular um ambiente de produção (paths relativos, etc.):

```bash
python -m http.server 8000
# depois abrir http://localhost:8000
```

## Customizar para um cliente novo

Ver [REPLICAR.md](REPLICAR.md).

## Hospedagem

Por enquanto pensado para subir num repositório GitHub próprio (com GitHub Pages para preview). Quando o cliente aprovar, dá pra portar para o domínio definitivo do jeito que for mais simples (FTP, Pages com domínio customizado, etc.) — a página não tem nenhuma dependência de servidor, então a portabilidade é total.

## Origem

Mecânica original criada para `tools.eletricaacademy/roleta-nr10` (campanha NR-10:2026, instrutor Pablo Guimarães). Este template remove tudo que era específico daquele cliente (textos, prêmios, GTM ID, foto) mantendo o motor (desenho da roleta, sorteio, animação, tracking) intacto.

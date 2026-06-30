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
├── index.html              # a página (motor + config + conteúdo, tudo num arquivo)
├── assets/
│   └── instrutor-placeholder.svg   # placeholder — trocar pela foto real do cliente
├── README.md                # este arquivo
└── REPLICAR.md               # passo a passo para customizar para um novo cliente
```

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

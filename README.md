# Tema Keycloak - Omniveo Metronic

Estrutura pronta para copiar para `/opt/keycloak/themes/omniveo-metronic` e selecionar em Realm Settings → Themes → Login Theme.

- `theme.properties`: herda `keycloak.v2`, aplica `css/style.css` e `js/main.js`.
- `resources/css/style.css`: visual inspirado no Metronic 8 (gradiente, card, botões). Nenhuma dependência externa.
- `resources/js/main.js`: stub para JS opcional (toggle de senha, pequenas interações).

Uso:
1. Copie a pasta `omniveo-metronic` para o diretório `themes/` do Keycloak.
2. Reinicie o Keycloak (ou recarregue o tema).
3. No realm desejado, escolha o login theme `omniveo-metronic`.

Personalização rápida:
- Troque cores em `:root` (variáveis `--kc-metro-*`).
- Logo dinâmico por realm: configure `Realm Settings -> Attributes` com `logoUrl` (URL absoluta da imagem) e, opcionalmente, `brandText` (fallback usa `displayName`/`name`). O tema usa essas chaves no `login.ftl`.
- Se quiser alterar o HTML, adicione templates em `login/` (ex.: `login.ftl`) mantendo os nomes de campos padrão (`username`, `password`).
- White-label dinâmico por tenant/chamador: o `main.js` lê o `redirect_uri`, resolve o `origin` e faz GET `${origin}/app/services/white-label/app` (CORS). Se o endpoint público retornar JSON com `logo_url`, `brand_text`, `primary`, `primary_dark`, `background`, `text_color`, `muted_color`, `border_color`, o tema aplica automaticamente no login. Mantenha defaults se o endpoint falhar.

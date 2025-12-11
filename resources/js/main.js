(() => {
  const params = new URLSearchParams(window.location.search);
  const rawRedirect = params.get('redirect_uri');

  if (!rawRedirect) {
    return;
  }

  let origin;

  try {
    origin = new URL(decodeURIComponent(rawRedirect)).origin;
  } catch (e) {
    return;
  }

  const endpoint = `${origin}/app/services/white-label/app`;

  fetch(endpoint, { mode: 'cors' })
    .then((resp) => (resp.ok ? resp.json() : null))
    .then((data) => {
      if (!data) {
        return;
      }

      const setVar = (key, value) => {
        if (value) {
          document.documentElement.style.setProperty(key, value);
        }
      };

      setVar('--kc-metro-primary', data.primary || data.primary_color);
      setVar('--kc-metro-primary-dark', data.primary_dark || data.primary_dark_color);
      setVar('--kc-metro-bg', data.background || data.background_color);
      setVar('--kc-metro-text', data.text_color);
      setVar('--kc-metro-muted', data.muted_color);
      setVar('--kc-metro-border', data.border_color);

      if (data.logo_url) {
        const img = document.querySelector('.kc-brand__logo-img');
        if (img) {
          img.src = data.logo_url;
        } else {
          const logo = document.querySelector('.kc-brand__logo');
          if (logo) {
            const newImg = document.createElement('img');
            newImg.className = 'kc-brand__logo-img';
            newImg.src = data.logo_url;
            newImg.alt = data.brand_text || '';
            logo.replaceWith(newImg);
          }
        }
      }

      if (data.brand_text) {
        const brandText = document.querySelector('.kc-brand__text');
        if (brandText) {
          brandText.textContent = data.brand_text;
        }
      }
    })
    .catch(() => {});
})();

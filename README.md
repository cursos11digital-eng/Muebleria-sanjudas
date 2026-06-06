# 🛋️ Mueblería San Judas — Guía de Despliegue

Sigue estos pasos en orden y tu tienda estará en línea en ~15 minutos.

---

## PASO 1 — Crear tu base de datos en Supabase (gratis)

1. Ve a **https://supabase.com** y crea una cuenta gratuita.
2. Haz clic en **"New project"**.
   - Nombre: `muebleria-san-judas`
   - Contraseña: elige una segura y guárdala.
   - Región: `South America (São Paulo)` — la más cercana a México.
3. Espera ~2 minutos a que el proyecto inicie.

---

## PASO 2 — Crear la tabla de productos

1. En el menú izquierdo de Supabase, haz clic en **"SQL Editor"**.
2. Haz clic en **"New query"**.
3. Copia todo el contenido de `schema.sql` y pégalo ahí.
4. Haz clic en **"Run"** (o Ctrl+Enter).
   - Verás: `Success. No rows returned` — ¡eso es correcto!

---

## PASO 3 — Crear el bucket de imágenes

1. En el menú izquierdo, ve a **"Storage"**.
2. Haz clic en **"New bucket"**.
   - Nombre: `productos`
   - Activa **"Public bucket"** ✅
3. Haz clic en **"Save"**.
4. Dentro del bucket `productos`, ve a **"Policies"** > **"New policy"** >
   elige **"For full customization"** y pega esto:

```sql
CREATE POLICY "Upload público"
ON storage.objects FOR INSERT
WITH CHECK (bucket_id = 'productos');
```

---

## PASO 4 — Conectar tu tienda a Supabase

1. En Supabase, ve a **Settings** (engrane) > **API**.
2. Copia:
   - **Project URL** → algo como `https://abcxyz.supabase.co`
   - **anon public key** → una clave larga
3. Abre el archivo `js/supabase.js` con cualquier editor de texto.
4. Reemplaza las dos líneas al inicio:

```js
const SUPABASE_URL = "https://TU_PROYECTO.supabase.co";   // ← pega tu URL
const SUPABASE_KEY = "TU_ANON_KEY";                        // ← pega tu clave
```

5. Guarda el archivo.

---

## PASO 5 — Subir a Netlify (opción recomendada, gratis)

### Opción A — Arrastrar y soltar (más fácil, sin cuenta de GitHub)

1. Ve a **https://netlify.com** y crea una cuenta gratuita.
2. En el Dashboard, busca el área que dice **"Drag and drop your site here"**.
3. Selecciona la carpeta **completa** del proyecto (`san-judas/`) y arrástrala ahí.
4. Netlify te dará una URL como `https://nombre-aleatorio.netlify.app`.
5. ¡Listo! Tu tienda está en línea. 🎉

### Opción B — Con GitHub (actualizaciones automáticas)

1. Sube la carpeta a un repositorio en **https://github.com**.
2. En Netlify > **"Add new site"** > **"Import an existing project"**.
3. Conecta tu repositorio de GitHub.
4. Configuración de build:
   - Build command: *(dejar vacío)*
   - Publish directory: `.`
5. Haz clic en **"Deploy site"**.

---

## PASO 6 — Subir a Vercel (alternativa)

1. Ve a **https://vercel.com** y crea una cuenta.
2. Instala Vercel CLI: `npm install -g vercel`
3. Desde la terminal, dentro de la carpeta del proyecto:
   ```bash
   vercel
   ```
4. Sigue las instrucciones en pantalla.
5. Tu tienda estará en `https://tu-proyecto.vercel.app`.

---

## PASO 7 — Dominio personalizado (opcional)

Si quieres usar `www.muebleriasanjudas.mx`:

1. Compra el dominio en **Namecheap**, **GoDaddy**, o **Hostinger**.
2. En Netlify/Vercel > **"Domain settings"** > **"Add custom domain"**.
3. Sigue las instrucciones para apuntar los DNS.

---

## Estructura de archivos

```
san-judas/
├── index.html          ← Página principal de la tienda
├── netlify.toml        ← Configuración para Netlify
├── vercel.json         ← Configuración para Vercel
├── schema.sql          ← Script para crear la tabla en Supabase
├── css/
│   └── styles.css      ← Todos los estilos visuales
└── js/
    ├── supabase.js     ← Conexión a la base de datos ⚠️ edita tus credenciales
    └── app.js          ← Lógica de la tienda (carrito, productos, admin)
```

---

## Preguntas frecuentes

**¿Cuánto cuesta?**
- Supabase: gratis hasta 500 MB de base de datos y 1 GB de imágenes.
- Netlify/Vercel: gratis con dominio `.netlify.app` o `.vercel.app`.
- Dominio `.mx`: ~$200–400 MXN/año.

**¿Mis productos se pierden si cierro el navegador?**
No, ahora se guardan en Supabase (base de datos en la nube).

**¿El carrito se guarda?**
Sí, el carrito se guarda en el navegador del cliente (`localStorage`).

**¿Puedo agregar contraseña al panel de administrador?**
Sí, con Supabase Auth. Es el siguiente paso recomendado si quieres más seguridad.

---

¿Necesitas ayuda? Contacta a tu desarrollador con este archivo. 🙌

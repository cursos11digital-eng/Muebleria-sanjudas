-- ============================================================
--  MUEBLERÍA SAN JUDAS — Schema de Supabase
--  Ejecuta este script en: Supabase > SQL Editor > New query
-- ============================================================

-- 1. Tabla de productos
CREATE TABLE IF NOT EXISTS productos (
  id             BIGSERIAL PRIMARY KEY,
  name           TEXT        NOT NULL,
  category       TEXT        NOT NULL,
  price          NUMERIC     NOT NULL,
  original_price NUMERIC,
  description    TEXT,
  badge          TEXT,
  image_url      TEXT,
  created_at     TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Índice para filtrar por categoría rápidamente
CREATE INDEX IF NOT EXISTS idx_productos_category ON productos(category);

-- 3. Habilitar acceso público de lectura y escritura
--    (puedes restringir después con Row Level Security)
ALTER TABLE productos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Lectura pública" ON productos
  FOR SELECT USING (true);

CREATE POLICY "Escritura pública" ON productos
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Actualización pública" ON productos
  FOR UPDATE USING (true);

CREATE POLICY "Eliminación pública" ON productos
  FOR DELETE USING (true);

-- 4. Bucket de imágenes en Storage
--    Ve a Storage > New Bucket > nombre: "productos" > Public: activado
--    (esto no se puede hacer con SQL, sigue las instrucciones del README)

-- 5. Datos de ejemplo (opcional — borra si no los quieres)
INSERT INTO productos (name, category, price, original_price, description, badge) VALUES
  ('Sofá Chester 3 Plazas',    'Sala',     12500, 15000, 'Sofá de lujo tapizado en tela premium. Patas de madera maciza. Disponible en gris, beige y verde.',            'Oferta'),
  ('Cama King Size Nogal',     'Recámara', 18900, NULL,  'Cama de madera de nogal con cabecera acolchada. Incluye sistema de almacenaje. Colchón no incluido.',          'Nuevo'),
  ('Comedor 6 Personas',       'Comedor',   9800, 11500, 'Mesa de madera maciza con 6 sillas tapizadas. Diseño moderno y resistente. Ideal para familia.',               'Oferta'),
  ('Escritorio Ejecutivo L',   'Oficina',   6500, NULL,  'Escritorio en L con superficie de vidrio y estructura metálica. Espacio amplio y organizador de cables.',      ''),
  ('Sillón Reclinable Oslo',   'Sala',      4200, NULL,  'Sillón reclinable con sistema de masaje lumbar. Tapiz de cuero sintético de alta duración.',                   'Nuevo'),
  ('Librero Minimalista 5N',   'Oficina',   3100, 3800,  'Librero de madera MDF acabado blanco mate. 5 niveles de almacenaje. Fácil armado.',                            '');

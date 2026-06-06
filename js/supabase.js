// ============================================================
//  MUEBLERÍA SAN JUDAS — Conexión Supabase
//  Reemplaza SUPABASE_URL y SUPABASE_ANON_KEY con los tuyos
//  (los encuentras en supabase.com > tu proyecto > Settings > API)
// ============================================================

const SUPABASE_URL  = "https://uroyjelrdwvjufrqctyy.supabase.co";
const SUPABASE_KEY  = "sb_publishable_HYTpqNF_IS8zsKFTeHd8gA_Sl9Qk69N";

const headers = {
  "Content-Type":  "application/json",
  "apikey":        SUPABASE_KEY,
  "Authorization": `Bearer ${SUPABASE_KEY}`,
  "Prefer":        "return=representation",
};

const API = `${SUPABASE_URL}/rest/v1/productos`;

// ── Leer todos los productos ──────────────────────────────────
export async function getProducts() {
  const res = await fetch(`${API}?order=created_at.desc`, { headers });
  if (!res.ok) throw new Error("Error al cargar productos");
  return res.json();
}

// ── Crear producto ────────────────────────────────────────────
export async function createProduct(data) {
  const res = await fetch(API, {
    method:  "POST",
    headers,
    body:    JSON.stringify(data),
  });
  if (!res.ok) throw new Error("Error al crear producto");
  return res.json();
}

// ── Actualizar producto ───────────────────────────────────────
export async function updateProduct(id, data) {
  const res = await fetch(`${API}?id=eq.${id}`, {
    method:  "PATCH",
    headers,
    body:    JSON.stringify(data),
  });
  if (!res.ok) throw new Error("Error al actualizar producto");
  return res.json();
}

// ── Eliminar producto ─────────────────────────────────────────
export async function deleteProduct(id) {
  const res = await fetch(`${API}?id=eq.${id}`, {
    method:  "DELETE",
    headers,
  });
  if (!res.ok) throw new Error("Error al eliminar producto");
  return true;
}

// ── Subir imagen a Supabase Storage ──────────────────────────
export async function uploadImage(file) {
  const fileName  = `${Date.now()}-${file.name.replace(/\s/g, "_")}`;
  const uploadURL = `${SUPABASE_URL}/storage/v1/object/productos/${fileName}`;

  const res = await fetch(uploadURL, {
    method:  "POST",
    headers: {
      "apikey":        SUPABASE_KEY,
      "Authorization": `Bearer ${SUPABASE_KEY}`,
      "Content-Type":  file.type,
    },
    body: file,
  });

  if (!res.ok) throw new Error("Error al subir imagen");

  return `${SUPABASE_URL}/storage/v1/object/public/productos/${fileName}`;
}

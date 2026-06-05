// ============================================================
//  MUEBLERÍA SAN JUDAS — app.js
//  Importa funciones de Supabase y maneja toda la UI
// ============================================================

import {
  getProducts,
  createProduct,
  updateProduct,
  deleteProduct as dbDeleteProduct,
  uploadImage,
} from "./supabase.js";

// ── Estado global ─────────────────────────────────────────────
let products       = [];
let cart           = JSON.parse(localStorage.getItem("sj_cart") || "[]");
let currentFilter  = "Todos";
let editingId      = null;
let selectedFile   = null;

const EMOJIS = {
  Sala:"🛋️", Recámara:"🛏️", Comedor:"🍽️",
  Oficina:"💼", Decoración:"🏺", Exterior:"🌿",
};

// ── Init ──────────────────────────────────────────────────────
(async () => {
  await loadProducts();
  updateCartCount();
})();

// ── Cargar productos desde Supabase ───────────────────────────
async function loadProducts() {
  const loading = document.getElementById("loadingMsg");
  const grid    = document.getElementById("productsGrid");
  try {
    products = await getProducts();
    loading.style.display = "none";
    grid.style.display    = "grid";
    renderProducts();
  } catch (e) {
    loading.textContent = "⚠️ Error al cargar productos. Revisa tu conexión a Supabase.";
    console.error(e);
  }
}

// ── Render ─────────────────────────────────────────────────────
function renderProducts() {
  const grid     = document.getElementById("productsGrid");
  const filtered = currentFilter === "Todos"
    ? products
    : products.filter(p => p.category === currentFilter);

  if (!filtered.length) {
    grid.innerHTML = `<div style="grid-column:1/-1;text-align:center;padding:60px;color:var(--text-light);font-size:16px;">
      No hay productos en esta categoría aún.<br>¡Agrega el primero desde el panel de administrador!
    </div>`;
    return;
  }

  grid.innerHTML = filtered.map(p => `
    <div class="product-card" id="card-${p.id}">
      <div class="product-image" onclick="window.openModal(${p.id})">
        ${p.image_url
          ? `<img src="${p.image_url}" alt="${p.name}" loading="lazy"/>`
          : `<span>${EMOJIS[p.category] || "🪑"}</span>`}
        ${p.badge ? `<div class="product-badge ${p.badge==="Nuevo"?"new":""}">${p.badge}</div>` : ""}
        <div class="product-actions-overlay">
          <button class="btn-quick-view">Ver Detalle</button>
        </div>
      </div>
      <div class="product-info">
        <div class="product-category">${p.category}</div>
        <div class="product-name">${p.name}</div>
        <div class="product-desc">${(p.description||"").substring(0,70)}${(p.description||"").length>70?"...":""}</div>
        <div class="product-bottom">
          <div class="product-price">
            $${Number(p.price).toLocaleString()}
            ${p.original_price ? `<span>$${Number(p.original_price).toLocaleString()}</span>` : ""}
          </div>
          <button class="btn-buy" onclick="window.addToCart(${p.id})">+ Carrito</button>
        </div>
      </div>
      <div class="admin-product-actions">
        <button class="btn-edit"   onclick="window.editProduct(${p.id})">✏️ Editar</button>
        <button class="btn-delete" onclick="window.removeProduct(${p.id})">🗑️ Eliminar</button>
      </div>
    </div>
  `).join("");
}

// ── Filtro ─────────────────────────────────────────────────────
window.filterProducts = function(cat, btn) {
  currentFilter = cat;
  document.querySelectorAll(".filter-btn").forEach(b => b.classList.remove("active"));
  if (btn) btn.classList.add("active");
  renderProducts();
  if (cat !== "Todos") document.getElementById("catalogo").scrollIntoView({ behavior:"smooth" });
};

// ── Admin ──────────────────────────────────────────────────────
window.openAdmin = function() {
  const panel = document.getElementById("adminPanel");
  panel.classList.add("open");
  panel.scrollIntoView({ behavior:"smooth", block:"start" });
};

window.handleImageSelect = function(input) {
  selectedFile = input.files[0];
  if (!selectedFile) return;
  const reader = new FileReader();
  reader.onload = e => {
    document.getElementById("previewImg").src = e.target.result;
    document.getElementById("imagePreview").style.display = "block";
  };
  reader.readAsDataURL(selectedFile);
};

window.submitProduct = async function() {
  const name     = document.getElementById("pName").value.trim();
  const category = document.getElementById("pCategory").value;
  const price    = parseFloat(document.getElementById("pPrice").value);
  const origPrice= parseFloat(document.getElementById("pOrigPrice").value) || null;
  const desc     = document.getElementById("pDesc").value.trim();
  const badge    = document.getElementById("pBadge").value;

  if (!name || !category || !price) {
    showToast("⚠️ Por favor completa nombre, categoría y precio");
    return;
  }

  const btn = document.getElementById("submitBtn");
  btn.textContent = "⏳ Guardando...";
  btn.classList.add("btn-loading");
  btn.disabled = true;

  try {
    let image_url = null;

    // Si hay nueva imagen, subirla primero
    if (selectedFile) {
      image_url = await uploadImage(selectedFile);
    }

    const payload = {
      name,
      category,
      price,
      original_price: origPrice,
      description: desc,
      badge,
      ...(image_url ? { image_url } : {}),
    };

    if (editingId !== null) {
      await updateProduct(editingId, payload);
      showToast("✅ Producto actualizado");
    } else {
      await createProduct(payload);
      showToast("🎉 Producto publicado en la tienda");
    }

    clearForm();
    document.getElementById("adminPanel").classList.remove("open");
    await loadProducts();
    document.getElementById("catalogo").scrollIntoView({ behavior:"smooth" });

  } catch (e) {
    showToast("❌ Error al guardar: " + e.message);
    console.error(e);
  } finally {
    btn.textContent = editingId ? "✓ Guardar Cambios" : "✓ Publicar Producto";
    btn.classList.remove("btn-loading");
    btn.disabled = false;
    editingId = null;
  }
};

window.editProduct = function(id) {
  const p = products.find(x => x.id === id);
  if (!p) return;
  editingId = id;
  document.getElementById("pName").value      = p.name;
  document.getElementById("pCategory").value  = p.category;
  document.getElementById("pPrice").value     = p.price;
  document.getElementById("pOrigPrice").value = p.original_price || "";
  document.getElementById("pDesc").value      = p.description || "";
  document.getElementById("pBadge").value     = p.badge || "";
  if (p.image_url) {
    document.getElementById("previewImg").src   = p.image_url;
    document.getElementById("imagePreview").style.display = "block";
  }
  document.getElementById("submitBtn").textContent = "✓ Guardar Cambios";
  document.getElementById("cancelBtn").style.display = "block";
  document.getElementById("adminTitle").textContent  = "✏️ Editar Producto";
  window.openAdmin();
};

window.cancelEdit = function() {
  editingId = null;
  clearForm();
  document.getElementById("adminPanel").classList.remove("open");
};

window.removeProduct = async function(id) {
  if (!confirm("¿Eliminar este producto?")) return;
  try {
    await dbDeleteProduct(id);
    cart = cart.filter(c => c.id !== id);
    saveCart();
    updateCartUI();
    showToast("🗑️ Producto eliminado");
    await loadProducts();
  } catch (e) {
    showToast("❌ Error al eliminar: " + e.message);
  }
};

function clearForm() {
  ["pName","pPrice","pOrigPrice","pDesc"].forEach(id => document.getElementById(id).value = "");
  document.getElementById("pCategory").value = "";
  document.getElementById("pBadge").value    = "";
  document.getElementById("imagePreview").style.display = "none";
  document.getElementById("pImage").value    = "";
  document.getElementById("cancelBtn").style.display = "none";
  document.getElementById("adminTitle").textContent   = "➕ Agregar Nuevo Producto";
  document.getElementById("submitBtn").textContent    = "✓ Publicar Producto";
  selectedFile = null;
}

// ── Carrito ────────────────────────────────────────────────────
window.addToCart = function(id) {
  const p = products.find(x => x.id === id);
  if (!p) return;
  const existing = cart.find(c => c.id === id);
  if (existing) existing.qty++;
  else cart.push({ id:p.id, name:p.name, price:p.price, image_url:p.image_url, category:p.category, qty:1 });
  saveCart();
  updateCartCount();
  showToast(`✅ ${p.name} agregado al carrito`);
};

window.changeQty = function(id, delta) {
  const item = cart.find(c => c.id === id);
  if (!item) return;
  item.qty += delta;
  if (item.qty <= 0) cart = cart.filter(c => c.id !== id);
  saveCart();
  updateCartUI();
};

window.openCart  = function() {
  document.getElementById("cartOverlay").classList.add("open");
  document.getElementById("cartSidebar").classList.add("open");
  updateCartUI();
};
window.closeCart = function() {
  document.getElementById("cartOverlay").classList.remove("open");
  document.getElementById("cartSidebar").classList.remove("open");
};

function updateCartCount() {
  document.getElementById("cartCount").textContent =
    cart.reduce((s, c) => s + c.qty, 0);
}

function updateCartUI() {
  const itemsEl  = document.getElementById("cartItems");
  const footerEl = document.getElementById("cartFooter");
  updateCartCount();

  if (!cart.length) {
    itemsEl.innerHTML  = `<div class="cart-empty"><span class="cart-empty-icon">🛒</span>Tu carrito está vacío.<br>¡Agrega algunos muebles!</div>`;
    footerEl.style.display = "none";
    return;
  }

  footerEl.style.display = "block";
  itemsEl.innerHTML = cart.map(c => `
    <div class="cart-item">
      <div class="cart-item-img">
        ${c.image_url ? `<img src="${c.image_url}" alt="${c.name}"/>` : (EMOJIS[c.category]||"🪑")}
      </div>
      <div class="cart-item-info">
        <div class="cart-item-name">${c.name}</div>
        <div class="cart-item-price">$${Number(c.price).toLocaleString()}</div>
        <div class="cart-item-qty">
          <button class="qty-btn" onclick="window.changeQty(${c.id},-1)">−</button>
          <span class="qty-num">${c.qty}</span>
          <button class="qty-btn" onclick="window.changeQty(${c.id},1)">+</button>
        </div>
      </div>
    </div>
  `).join("");

  document.getElementById("cartTotal").textContent =
    `$${cart.reduce((s,c) => s + c.price * c.qty, 0).toLocaleString()}`;
}

function saveCart() { localStorage.setItem("sj_cart", JSON.stringify(cart)); }

// ── Modal ──────────────────────────────────────────────────────
window.openModal = function(id) {
  const p = products.find(x => x.id === id);
  if (!p) return;
  document.getElementById("modalCat").textContent   = p.category;
  document.getElementById("modalName").textContent  = p.name;
  document.getElementById("modalPrice").textContent = `$${Number(p.price).toLocaleString()} MXN`;
  document.getElementById("modalDesc").textContent  = p.description || "";
  const imgEl = document.getElementById("modalImg");
  imgEl.innerHTML = p.image_url
    ? `<img src="${p.image_url}" alt="${p.name}"/>`
    : `<span style="font-size:100px">${EMOJIS[p.category]||"🪑"}</span>`;
  document.getElementById("modalBuyBtn").onclick = () => {
    window.addToCart(id);
    window.closeModal();
  };
  document.getElementById("productModal").classList.add("open");
};

window.closeModal = function(e) {
  if (!e || e.target === document.getElementById("productModal")) {
    document.getElementById("productModal").classList.remove("open");
  }
};

// ── Toast ─────────────────────────────────────────────────────
function showToast(msg) {
  const t = document.getElementById("toast");
  t.textContent = msg;
  t.classList.add("show");
  setTimeout(() => t.classList.remove("show"), 3200);
}

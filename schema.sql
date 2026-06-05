<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Mueblería San Judas</title>
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700;900&family=Jost:wght@300;400;500;600&display=swap" rel="stylesheet"/>
  <link rel="stylesheet" href="css/styles.css"/>
</head>
<body>

<div class="announcement">🚚 Envío gratis en compras mayores a $5,000 MXN &nbsp;|&nbsp; 12 meses sin intereses</div>

<nav>
  <div class="nav-inner">
    <div class="logo">
      <span class="logo-main">Mueblería San Judas</span>
      <span class="logo-sub">Calidad & Elegancia</span>
    </div>
    <ul class="nav-links">
      <li><a href="#">Inicio</a></li>
      <li><a href="#catalogo">Catálogo</a></li>
      <li><a href="#categorias">Categorías</a></li>
      <li><a href="#contacto">Contacto</a></li>
    </ul>
    <div class="nav-actions">
      <button class="btn-cart" onclick="openCart()">
        🛒 Carrito <span class="cart-count" id="cartCount">0</span>
      </button>
    </div>
  </div>
</nav>

<!-- Hero -->
<section class="hero">
  <div class="hero-content">
    <span class="hero-tag">✦ Nueva Colección 2025</span>
    <h1>Muebles que <em>transforman</em> tu hogar</h1>
    <p>Diseño, calidad y durabilidad en cada pieza. Encuentra los muebles perfectos para tu espacio.</p>
    <div class="hero-btns">
      <a href="#catalogo" class="btn-primary">Ver Catálogo</a>
      <button class="btn-outline" onclick="openAdmin()">+ Subir Producto</button>
    </div>
  </div>
  <div class="hero-image-side">
    <div class="hero-visual">🛋️</div>
    <div class="hero-stats">
      <div class="stat"><div class="stat-num">200+</div><div class="stat-label">Productos</div></div>
      <div class="stat"><div class="stat-num">15</div><div class="stat-label">Años de exp.</div></div>
      <div class="stat"><div class="stat-num">5k+</div><div class="stat-label">Clientes</div></div>
    </div>
  </div>
</section>

<!-- Categorías -->
<section class="section" id="categorias" style="background:var(--cream)">
  <div class="section-center">
    <div class="section-header">
      <span class="section-tag">Explorar</span>
      <h2 class="section-title">Categorías</h2>
    </div>
    <div class="categories-grid">
      <div class="cat-card" onclick="filterProducts('Sala')"><div class="cat-icon">🛋️</div><div class="cat-info"><div class="cat-name">Sala</div><div class="cat-count">Sofás, sillones, mesas</div></div></div>
      <div class="cat-card" onclick="filterProducts('Recámara')"><div class="cat-icon">🛏️</div><div class="cat-info"><div class="cat-name">Recámara</div><div class="cat-count">Camas, clósets, burós</div></div></div>
      <div class="cat-card" onclick="filterProducts('Comedor')"><div class="cat-icon">🍽️</div><div class="cat-info"><div class="cat-name">Comedor</div><div class="cat-count">Mesas, sillas, vitrinas</div></div></div>
      <div class="cat-card" onclick="filterProducts('Oficina')"><div class="cat-icon">💼</div><div class="cat-info"><div class="cat-name">Oficina</div><div class="cat-count">Escritorios, libreros</div></div></div>
    </div>
  </div>
</section>

<!-- Admin Toggle -->
<div class="admin-toggle-bar">
  <span>🔧 Panel de Administrador</span>
  <button class="toggle-btn" onclick="openAdmin()">+ Agregar Producto</button>
</div>

<!-- Admin Panel -->
<div class="admin-panel" id="adminPanel">
  <h2 id="adminTitle">➕ Agregar Nuevo Producto</h2>
  <div class="form-grid">
    <div class="form-group">
      <label>Nombre del producto *</label>
      <input type="text" id="pName" placeholder="Ej: Sofá Esquinero Moderno"/>
    </div>
    <div class="form-group">
      <label>Categoría *</label>
      <select id="pCategory">
        <option value="">Seleccionar...</option>
        <option>Sala</option><option>Recámara</option>
        <option>Comedor</option><option>Oficina</option>
        <option>Decoración</option><option>Exterior</option>
      </select>
    </div>
    <div class="form-group">
      <label>Precio (MXN) *</label>
      <input type="number" id="pPrice" placeholder="0.00"/>
    </div>
    <div class="form-group">
      <label>Precio original (tachado)</label>
      <input type="number" id="pOrigPrice" placeholder="Opcional"/>
    </div>
    <div class="form-group full">
      <label>Descripción</label>
      <textarea id="pDesc" placeholder="Material, dimensiones, colores..."></textarea>
    </div>
    <div class="form-group">
      <label>Etiqueta</label>
      <select id="pBadge">
        <option value="">Sin etiqueta</option>
        <option>Nuevo</option><option>Oferta</option>
      </select>
    </div>
    <div class="form-group">
      <label>Imagen del producto</label>
      <div class="upload-area" onclick="document.getElementById('pImage').click()">
        <span class="upload-icon">📷</span>
        <div class="upload-text"><strong>Clic para subir imagen</strong><br>PNG, JPG, WebP — máx 10MB</div>
        <input type="file" id="pImage" accept="image/*" style="display:none" onchange="handleImageSelect(this)"/>
      </div>
      <div id="imagePreview" style="margin-top:10px;display:none">
        <img id="previewImg" style="max-height:120px;border-radius:4px;border:1px solid var(--border)" alt="vista previa"/>
      </div>
    </div>
  </div>
  <button class="btn-add-product" id="submitBtn" onclick="submitProduct()">✓ Publicar Producto</button>
  <button class="btn-cancel" onclick="cancelEdit()" id="cancelBtn" style="display:none">✕ Cancelar</button>
</div>

<!-- Catálogo -->
<section class="section" id="catalogo">
  <div class="section-center">
    <div class="products-header">
      <div>
        <span class="section-tag">Catálogo</span>
        <h2 class="section-title">Nuestros Productos</h2>
      </div>
      <div class="filter-row">
        <button class="filter-btn active" onclick="filterProducts('Todos',this)">Todos</button>
        <button class="filter-btn" onclick="filterProducts('Sala',this)">Sala</button>
        <button class="filter-btn" onclick="filterProducts('Recámara',this)">Recámara</button>
        <button class="filter-btn" onclick="filterProducts('Comedor',this)">Comedor</button>
        <button class="filter-btn" onclick="filterProducts('Oficina',this)">Oficina</button>
      </div>
    </div>
    <div id="loadingMsg" style="text-align:center;padding:60px;color:var(--text-light);font-size:16px;">⏳ Cargando productos...</div>
    <div class="products-grid" id="productsGrid" style="display:none"></div>
  </div>
</section>

<!-- Promo -->
<div class="promo-banner" id="contacto">
  <h2>¿Necesitas asesoría?<br><em>Contáctanos</em></h2>
  <p>Nuestros expertos te ayudan a elegir el mueble perfecto.</p>
  <a href="https://wa.me/521TUNUMERO" target="_blank" class="btn-primary">📞 WhatsApp</a>
</div>

<!-- Footer -->
<footer>
  <div class="footer-grid">
    <div class="footer-brand">
      <div class="logo-main">Mueblería San Judas</div>
      <div class="logo-sub">Calidad & Elegancia</div>
      <p>15 años amueblando los hogares de México con calidad y estilo.</p>
    </div>
    <div class="footer-col"><h4>Tienda</h4><ul><li><a href="#">Sala</a></li><li><a href="#">Recámara</a></li><li><a href="#">Comedor</a></li><li><a href="#">Oficina</a></li></ul></div>
    <div class="footer-col"><h4>Ayuda</h4><ul><li><a href="#">Envíos</a></li><li><a href="#">Devoluciones</a></li><li><a href="#">Garantía</a></li><li><a href="#">Financiamiento</a></li></ul></div>
    <div class="footer-col"><h4>Contacto</h4><ul><li><a href="#">📍 Tu ciudad, México</a></li><li><a href="#">📞 (55) 1234-5678</a></li><li><a href="#">✉️ ventas@sanjudas.mx</a></li></ul></div>
  </div>
  <div class="footer-bottom">© 2025 Mueblería San Judas. Todos los derechos reservados.</div>
</footer>

<!-- Cart Sidebar -->
<div class="cart-overlay" id="cartOverlay" onclick="closeCart()"></div>
<div class="cart-sidebar" id="cartSidebar">
  <div class="cart-header">
    <h3>🛒 Tu Carrito</h3>
    <button class="cart-close" onclick="closeCart()">✕</button>
  </div>
  <div class="cart-items" id="cartItems"></div>
  <div class="cart-footer" id="cartFooter" style="display:none">
    <div class="cart-total">
      <span class="cart-total-label">Total</span>
      <span class="cart-total-amount" id="cartTotal">$0</span>
    </div>
    <button class="btn-checkout">Proceder al Pago →</button>
  </div>
</div>

<!-- Modal -->
<div class="modal-overlay" id="productModal" onclick="closeModal(event)">
  <div class="modal-box">
    <div class="modal-img" id="modalImg"></div>
    <div class="modal-content">
      <div class="modal-category" id="modalCat"></div>
      <div class="modal-name" id="modalName"></div>
      <div class="modal-price" id="modalPrice"></div>
      <div class="modal-desc" id="modalDesc"></div>
      <button class="btn-primary" id="modalBuyBtn" style="width:100%">Agregar al Carrito</button>
    </div>
  </div>
</div>

<div class="toast" id="toast"></div>

<script type="module" src="js/app.js"></script>
</body>
</html>

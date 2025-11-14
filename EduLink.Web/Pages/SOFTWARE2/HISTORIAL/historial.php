<?php
// ------------------
// Capturar reserva enviada desde reservar/pago
// ------------------
$pendiente = null;

if (isset($_GET["servicio"]) && isset($_GET["fecha"]) && isset($_GET["precio"])) {
    $pendiente = [
        "servicio" => $_GET["servicio"],
        "fecha" => $_GET["fecha"],
        "precio" => $_GET["precio"]
    ];
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EduLink - Historial de Compras</title>
  <link rel="stylesheet" href="CSS/historial.css">
</head>
<body>

<header>
  <div class="logo">
    <img src="Imagenes/Logo.png" alt="EduLink Logo">
  </div>

  <input type="text" id="buscarInput" placeholder="Buscar cursos...">

  <div class="icons">
    <a href="pago.php" title="Ir al carrito" class="cart">🛒</a>

    <div class="profile-menu">
      <div class="user" id="userIcon">SG</div>

      <div class="dropdown" id="dropdownMenu">
          <a href="#">Mi perfil</a>
          <a href="login.php">Cerrar sesión</a>
      </div>
    </div>
  </div>
</header>

<div class="container">
  <div class="sidebar">
    <button class="filter-btn active" data-filter="all">📚<br>Todos</button>
    <button class="filter-btn" data-filter="cancelado">❌<br>Cancelados</button>
    <button class="filter-btn" data-filter="pendiente">⏳<br>Pendientes</button>
  </div>

  <div class="content">
    <h1>HISTORIAL DE COMPRAS</h1>

    <!-- ========================================= -->
    <!-- 1) AGREGAR DINÁMICAMENTE EL CURSO PENDIENTE -->
    <!-- ========================================= -->

    <?php if ($pendiente): ?>
      <div class="card" data-status="pendiente">
        <div class="card-left">
          <img src="https://cdn-icons-png.flaticon.com/512/711/711284.png" alt="">
          <div>
            <h4><?= htmlspecialchars($pendiente["servicio"]) ?></h4>
            <p>Fecha seleccionada: <?= htmlspecialchars($pendiente["fecha"]) ?></p>
            <p>Valor: $<?= htmlspecialchars($pendiente["precio"]) ?></p>
            <p><strong>Estado: Pendiente de pago</strong></p>

            <form action="pago.php" method="GET">
                <input type="hidden" name="servicio" value="<?= htmlspecialchars($pendiente["servicio"]) ?>">
                <input type="hidden" name="fecha" value="<?= htmlspecialchars($pendiente["fecha"]) ?>">
                <input type="hidden" name="precio" value="<?= htmlspecialchars($pendiente["precio"]) ?>">
                <button type="submit" class="pay-btn">Pagar ahora</button>
            </form>
          </div>
        </div>
        <div class="card-right">
          <div class="stars">★★★★★</div>
        </div>
      </div>
    <?php endif; ?>


    <!-- ========================================= -->
    <!-- TUS CURSOS FIJOS (YA ESTABAN) -->
    <!-- ========================================= -->

    <div class="card" data-status="pagado">
      <div class="card-left">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="">
        <div>
          <h4>Programación web nivel básico</h4>
          <p>Valor: $14.99</p>
          <p>Estado: Pagado</p>
        </div>
      </div>
      <div class="card-right">
        <div class="stars">★★★★★</div>
      </div>
    </div>

    <div class="card" data-status="cancelado">
      <div class="card-left">
        <img src="https://cdn-icons-png.flaticon.com/512/1055/1055646.png" alt="">
        <div>
          <h4>Sistemas Operativo nivel básico</h4>
          <p>Valor: $12.99</p>
          <p>Estado: Cancelado</p>
        </div>
      </div>
      <div class="card-right">
        <div class="stars">★★★★☆</div>
      </div>
    </div>

    <div class="card" data-status="pendiente">
      <div class="card-left">
        <img src="https://cdn-icons-png.flaticon.com/512/711/711284.png" alt="">
        <div>
          <h4>Power BI nivel básico</h4>
          <p>Valor: $15.99</p>
          <p>Estado: Pendiente de pago</p>

          <form action="pago.php" method="POST">
            <input type="hidden" name="curso" value="Power BI nivel básico">
            <input type="hidden" name="precio" value="15.99">
            <button type="submit" class="pay-btn">Pagar ahora</button>
          </form>
        </div>
      </div>
      <div class="card-right">
        <div class="stars">★★★★★</div>
      </div>
    </div>

  </div>
</div>

<!-- ========== SCRIPTS ========== -->
<script>
  // Búsqueda dinámica
  const buscarInput = document.getElementById('buscarInput');
  const cards = document.querySelectorAll('.card');

  buscarInput.addEventListener('input', () => {
    const query = buscarInput.value.toLowerCase();
    cards.forEach(card => {
      const title = card.querySelector('h4').textContent.toLowerCase();
      card.style.display = title.includes(query) ? 'flex' : 'none';
    });
  });

  // Filtros
  const filterButtons = document.querySelectorAll('.filter-btn');

  filterButtons.forEach(btn => {
    btn.addEventListener('click', () => {
      const filter = btn.getAttribute('data-filter');
      filterButtons.forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      cards.forEach(card => {
        const status = card.getAttribute('data-status');
        card.style.display = (filter === 'all' || status === filter) ? 'flex' : 'none';
      });
    });
  });

  // Menú del perfil
  const userIcon = document.getElementById('userIcon');
  const dropdownMenu = document.getElementById('dropdownMenu');

  userIcon.addEventListener('click', () => {
    dropdownMenu.classList.toggle('show');
  });

  window.addEventListener('click', (e) => {
    if (!userIcon.contains(e.target) && !dropdownMenu.contains(e.target)) {
      dropdownMenu.classList.remove('show');
    }
  });
</script>

</body>
</html>

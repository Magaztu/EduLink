<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explorar Servicios - EduLink</title>
    <link rel="stylesheet" href="CSS/dashboard.css">
</head>
<body>

<!-- NAV SUPERIOR -->
<header class="top-nav">
    <div class="logo">
        <img src="Imagenes/Logo.png" alt="">
        <span>EduLink</span>
    </div>

    <div class="search-bar">
        <input type="text" placeholder="Buscar servicios...">
        <button>🔍</button>
    </div>

    <div class="profile-icon">
        <a href="historial.php">🛒</a>
        <a href="#"><span class="user-icon">👤</span></a>
    </div>
</header>

<!-- CONTENIDO PRINCIPAL -->
<div class="container">

    <div class="title-bar">
        <h2>Explorar Servicios</h2>

        <div class="right-buttons">
            <button class="nofilter">Sin filtros</button>
            <button class="available">Disponibles</button>
        </div>
    </div>

    <!-- FILTROS -->
    <div class="filters">
        <button>Precio</button>
        <button>Ubicación</button>
        <button>Modalidad</button>
        <button>Fecha Disponible</button>
    </div>

    <div class="card-list">

        <!-- CARD 1 -->
        <div class="card">
            <div class="img-placeholder"></div>

            <div class="info">
                <h3>Servicios IOT</h3>
                <p class="price">$20</p>
                <p class="mode">Online</p>

                <div class="rating">⭐ 4.8</div>
                <button class="reserve-btn" onclick="window.location.href='reservar.php?servicio=1'">Reservar</button>

            </div>
        </div>

        <!-- CARD 2 -->
        <div class="card">
            <div class="img-placeholder"></div>

            <div class="info">
                <h3>Software 2</h3>
                <p class="price">$30</p>
                <p class="mode">Presencial</p>

                <div class="rating">⭐ 4.9</div>
                <button class="reserve-btn" onclick="window.location.href='reservar.php?servicio=2'">Reservar</button>

            </div>
        </div>

    </div>

</div>

</body>
</html>
